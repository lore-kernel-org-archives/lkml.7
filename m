Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13986C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BF8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfH1KTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:19:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1KQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v01-0000BX-5N; Wed, 28 Aug 2019 12:16:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C79DE1C07D2;
        Wed, 28 Aug 2019 12:16:20 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:20 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] itimers: Use quick sample function
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.689713638@linutronix.de>
References: <20190821192919.689713638@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698738074.5699.15444340345912474204.tip-bot2@tip-bot2>
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

Commit-ID:     a34360d42434bbf28c0f375444c52c154ae3e6cf
Gitweb:        https://git.kernel.org/tip/a34360d42434bbf28c0f375444c52c154ae3e6cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:26 +02:00

itimers: Use quick sample function

get_itimer() locks sighand lock and checks whether the timer is already
expired. If it is not expired then the thread group cputime accounting is
already enabled. Use the sampling function not the one which is meant for
starting a timer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.689713638@linutronix.de

---
 kernel/time/itimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 9d26fd4..ae04bc2 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -58,7 +58,7 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 		struct task_cputime cputime;
 		u64 t;
 
-		thread_group_cputimer(tsk, &cputime);
+		thread_group_sample_cputime(tsk, &cputime);
 		if (clock_id == CPUCLOCK_PROF)
 			t = cputime.utime + cputime.stime;
 		else
