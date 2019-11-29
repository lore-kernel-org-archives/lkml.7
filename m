Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3772C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE90D2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfK2J72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:59:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48463 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfK2J72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:59:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iad3K-0002Qp-P6; Fri, 29 Nov 2019 10:59:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 449691C2116;
        Fri, 29 Nov 2019 10:59:06 +0100 (CET)
Date:   Fri, 29 Nov 2019 09:59:06 -0000
From:   "tip-bot2 for Zhenzhong Duan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/clock: Use static_branch_likely() with
 sched_clock_running
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Message-ID: <157502154611.21853.4555592493571232440.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c5105d764e0214bcc4c6d40d7ba231d01b2e9dda
Gitweb:        https://git.kernel.org/tip/c5105d764e0214bcc4c6d40d7ba231d01b2e9dda
Author:        Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate:    Wed, 27 Nov 2019 16:37:28 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 29 Nov 2019 08:10:54 +01:00

sched/clock: Use static_branch_likely() with sched_clock_running

sched_clock_running is enabled early at bootup stage and never
disabled. So hint that to the compiler by using static_branch_likely()
rather than static_branch_unlikely().

The branch probability mis-annotation was introduced in the original
commit that converted the plain sched_clock_running flag to a static key:

  46457ea464f5 ("sched/clock: Use static key for sched_clock_running")

Steve further notes:

  | Looks like the confusion was the moving of the "!":
  |
  | -       if (unlikely(!sched_clock_running))
  | +       if (!static_branch_unlikely(&sched_clock_running))
  |
  | Where, it was unlikely that !sched_clock_running would be true, but
  | because the "!" was moved outside the "unlikely()" it makes the test
  | "likely()". That is, if we added an intermediate step, it would have
  | been:
  |
  |         if (!likely(sched_clock_running))
  |
  | which would have prevented the mistake that this patch fixes.

  [ mingo: Edited the changelog. ]

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bsegall@google.com
Cc: dietmar.eggemann@arm.com
Cc: juri.lelli@redhat.com
Cc: mgorman@suse.de
Cc: vincent.guittot@linaro.org
Link: https://lkml.kernel.org/r/1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 1152259..12bca64 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -370,7 +370,7 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return sched_clock();
 
 	preempt_disable_notrace();
@@ -393,7 +393,7 @@ void sched_clock_tick(void)
 	if (sched_clock_stable())
 		return;
 
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -460,7 +460,7 @@ void __init sched_clock_init(void)
 
 u64 sched_clock_cpu(int cpu)
 {
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return 0;
 
 	return sched_clock();
