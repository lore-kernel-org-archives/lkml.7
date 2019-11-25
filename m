Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014C920740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfKYL2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:28:30 -0500
Received: from foss.arm.com ([217.140.110.172]:49098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfKYL2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:28:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86B1B1045;
        Mon, 25 Nov 2019 03:28:22 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 869DC3F52E;
        Mon, 25 Nov 2019 03:28:21 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] torture: Replace cpu_up/down with device_online/offline
Date:   Mon, 25 Nov 2019 11:27:52 +0000
Message-Id: <20191125112754.25223-13-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191125112754.25223-1-qais.yousef@arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core device API performs extra housekeeping bits that are missing
from directly calling cpu_up/down.

See commit a6717c01ddc2 ("powerpc/rtas: use device model APIs and
serialization during LPM") for an example description of what might go
wrong.

This also prepares to make cpu_up/down a private interface for anything
but the cpu subsystem.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/torture.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7c13f5558b71..12115024feb2 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -97,7 +97,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_offl_attempts)++;
-	ret = cpu_down(cpu);
+	lock_device_hotplug();
+	ret = device_offline(get_cpu_device(cpu));
+	unlock_device_hotplug();
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -148,7 +150,9 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 			 torture_type, cpu);
 	starttime = jiffies;
 	(*n_onl_attempts)++;
-	ret = cpu_up(cpu);
+	lock_device_hotplug();
+	ret = device_online(get_cpu_device(cpu));
+	unlock_device_hotplug();
 	if (ret) {
 		if (verbose)
 			pr_alert("%s" TORTURE_FLAG
@@ -192,17 +196,20 @@ torture_onoff(void *arg)
 	for_each_online_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
-	if (!IS_MODULE(CONFIG_TORTURE_TEST))
+	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
+		lock_device_hotplug();
 		for_each_possible_cpu(cpu) {
 			if (cpu_online(cpu))
 				continue;
-			ret = cpu_up(cpu);
+			ret = device_online(get_cpu_device(cpu));
 			if (ret && verbose) {
 				pr_alert("%s" TORTURE_FLAG
 					 "%s: Initial online %d: errno %d\n",
 					 __func__, torture_type, cpu, ret);
 			}
 		}
+		unlock_device_hotplug();
+	}
 
 	if (maxcpu == 0) {
 		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
-- 
2.17.1

