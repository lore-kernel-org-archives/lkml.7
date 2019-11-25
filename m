Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6BCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF7320740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfKYL23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:28:29 -0500
Received: from foss.arm.com ([217.140.110.172]:49090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfKYL2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:28:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52F1D31B;
        Mon, 25 Nov 2019 03:28:21 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 531133F52E;
        Mon, 25 Nov 2019 03:28:20 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] firmware: psci: Replace cpu_up/down with device_online/offline
Date:   Mon, 25 Nov 2019 11:27:51 +0000
Message-Id: <20191125112754.25223-12-qais.yousef@arm.com>
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
CC: Mark Rutland <mark.rutland@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 drivers/firmware/psci/psci_checker.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 6a445397771c..9e4b1bade659 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -83,8 +83,9 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 	cpumask_clear(offlined_cpus);
 
 	/* Try to power down all CPUs in the mask. */
+	lock_device_hotplug();
 	for_each_cpu(cpu, cpus) {
-		int ret = cpu_down(cpu);
+		int ret = device_offline(get_cpu_device(cpu));
 
 		/*
 		 * cpu_down() checks the number of online CPUs before the TOS
@@ -116,7 +117,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 
 	/* Try to power up all the CPUs that have been offlined. */
 	for_each_cpu(cpu, offlined_cpus) {
-		int ret = cpu_up(cpu);
+		int ret = device_online(get_cpu_device(cpu));
 
 		if (ret != 0) {
 			pr_err("Error occurred (%d) while trying "
@@ -126,6 +127,7 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 			cpumask_clear_cpu(cpu, offlined_cpus);
 		}
 	}
+	unlock_device_hotplug();
 
 	/*
 	 * Something went bad at some point and some CPUs could not be turned
-- 
2.17.1

