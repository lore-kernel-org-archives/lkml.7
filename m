Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC4BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D02073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKOSNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:13:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44258 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:13:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVg5i-00051Z-Vj; Fri, 15 Nov 2019 19:13:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D3661C18CD;
        Fri, 15 Nov 2019 19:13:06 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:13:06 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/uclamp: Fix overzealous type replacement
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>, Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        patrick.bellasi@matbug.net, qperret@google.com, surenb@google.com,
        tj@kernel.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191113165334.14291-1-valentin.schneider@arm.com>
References: <20191113165334.14291-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157384158660.12247.7949310118741537963.tip-bot2@tip-bot2>
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

Commit-ID:     16d6bbe7982e99f7f326ec6f088c0aaf85efa69d
Gitweb:        https://git.kernel.org/tip/16d6bbe7982e99f7f326ec6f088c0aaf85efa69d
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 13 Nov 2019 16:53:34 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 11:02:19 +01:00

sched/uclamp: Fix overzealous type replacement

Some uclamp helpers had their return type changed from 'unsigned int' to
'enum uclamp_id' by commit:

  0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")

but it happens that some *actually* do return an unsigned int value. Those
are the helpers that return a utilization value: uclamp_rq_max_value() and
uclamp_eff_value(). Fix those up.

Note that this doesn't lead to any obj diff using a relatively recent
aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
already figures out that the return value is 11 bits (bits_per(1024)) and
doesn't seem to do anything funny. I'm still marking this as fixing the
above commit to be on the safe side.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: patrick.bellasi@matbug.net
Cc: qperret@google.com
Cc: surenb@google.com
Cc: tj@kernel.org
Cc: vincent.guittot@linaro.org
Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
Link: https://lkml.kernel.org/r/20191113165334.14291-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4..a4f76d3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 }
 
 static inline
-enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
+unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 				   unsigned int clamp_value)
 {
 	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
@@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8870c5..49ed949 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2309,7 +2309,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
-enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
+unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
 unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
