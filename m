Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0782DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDC42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLYKjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40598 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfLYKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44D-0008A7-Af; Wed, 25 Dec 2019 11:39:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F18B1C2B1E;
        Wed, 25 Dec 2019 11:39:01 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:00 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Remove uclamp_util()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211113851.24241-2-valentin.schneider@arm.com>
References: <20191211113851.24241-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157727034091.30329.12510821407304586516.tip-bot2@tip-bot2>
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

Commit-ID:     59fe675248ffc37d4167e9ec6920a2f3d5ec67bb
Gitweb:        https://git.kernel.org/tip/59fe675248ffc37d4167e9ec6920a2f3d5ec67bb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 11 Dec 2019 11:38:47 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:07 +01:00

sched/uclamp: Remove uclamp_util()

The sole user of uclamp_util(), schedutil_cpu_util(), was made to use
uclamp_util_with() instead in commit:

  af24bde8df20 ("sched/uclamp: Add uclamp support to energy_compute()")

>From then on, uclamp_util() has remained unused. Being a simple wrapper
around uclamp_util_with(), we can get rid of it and win back a few lines.

Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191211113851.24241-2-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c7..d9b2451 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2324,21 +2324,12 @@ unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 
 	return clamp(util, min_util, max_util);
 }
-
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
-{
-	return uclamp_util_with(rq, util, NULL);
-}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 					    struct task_struct *p)
 {
 	return util;
 }
-static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
-{
-	return util;
-}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef arch_scale_freq_capacity
