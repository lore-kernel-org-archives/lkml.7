Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA16C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8722189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfH1KRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46480 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfH1KQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:44 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v09-0000E0-AX; Wed, 28 Aug 2019 12:16:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0917D1C0DE3;
        Wed, 28 Aug 2019 12:16:24 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:23 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove pointless return value check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192920.339725769@linutronix.de>
References: <20190821192920.339725769@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738395.5720.15487838071767605987.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5405d0051f7ca820d1781d87baf4d730ff58f208
Gitweb:        https://git.kernel.org/tip/5405d0051f7ca820d1781d87baf4d730ff58f208
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:30 +02:00

posix-cpu-timers: Remove pointless return value check

set_process_cpu_timer() checks already whether the clock id is valid. No
point in checking the return value of the sample function. That allows to
simplify the sample function later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192920.339725769@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index aff7e3b..5944b74 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1190,14 +1190,13 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 			   u64 *newval, u64 *oldval)
 {
 	u64 now;
-	int ret;
 
 	if (WARN_ON_ONCE(clock_idx >= CPUCLOCK_SCHED))
 		return;
 
-	ret = cpu_clock_sample_group(clock_idx, tsk, &now, true);
+	cpu_clock_sample_group(clock_idx, tsk, &now, true);
 
-	if (oldval && ret != -EINVAL) {
+	if (oldval) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update
