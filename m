Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA98DC33C9C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8820672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKUQsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32913 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKUQsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcl-0000Yu-UU; Thu, 21 Nov 2019 17:48:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 860781C1A3C;
        Thu, 21 Nov 2019 17:48:07 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:07 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rackmeter: Use vtime aware kcpustat accessor
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-7-frederic@kernel.org>
References: <20191121024430.19938-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488743.21853.7693299705375133100.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8392853e964c025b0616bd54c0cdf9cbc3c9a769
Gitweb:        https://git.kernel.org/tip/8392853e964c025b0616bd54c0cdf9cbc3c9a769
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:59:00 +01:00

rackmeter: Use vtime aware kcpustat accessor

Now that we have a vtime safe kcpustat accessor, use it to fetch
CPUTIME_NICE and fix frozen kcpustat values on nohz_full CPUs.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-7-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/macintosh/rack-meter.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 4134e58..60311e8 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -81,13 +81,14 @@ static int rackmeter_ignore_nice;
  */
 static inline u64 get_cpu_idle_time(unsigned int cpu)
 {
+	struct kernel_cpustat *kcpustat = &kcpustat_cpu(cpu);
 	u64 retval;
 
-	retval = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE] +
-		 kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
+	retval = kcpustat->cpustat[CPUTIME_IDLE] +
+		 kcpustat->cpustat[CPUTIME_IOWAIT];
 
 	if (rackmeter_ignore_nice)
-		retval += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
+		retval += kcpustat_field(kcpustat, CPUTIME_NICE, cpu);
 
 	return retval;
 }
