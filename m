Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02CC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23152084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KRx6FU+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfFQOVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:21:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:21:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEKleY3453336
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:20:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEKleY3453336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781248;
        bh=Kon8YY8C2gXkI/lKg/2EcMLOnFpvs8glImKpDZ/3SF4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KRx6FU+UWqwuTfPZbJdbdgbvvQeeAaYUYi0ITfrr4CrqZeSXNkA5eGG8OVxlsjDIn
         mpwO7ZICEmLySrEG78LpNIJjLzvNmjI5HisuI2gB82w+YmVC2c5IcMK6kq3UFf4MEQ
         M9HkZXP3XtjoGtZhnteVBrMVDtVAP+k/DlF4Ows6MHnQRwmeuspohu/7IixPJ3kQsM
         2bnCedTdeRvJVUeTF5NBTYjzpZ1v+NSjqFN5nR5ViusmrDUr9Db68H5X3xkksSxEfr
         ppuqfLmCpxyHCIsMDFfleutbbLivLRIkJl21SHSkHfm3thag7QRyVvMp/OWHx4Baq8
         15tZ+H7fzZHQQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEKlPV3453333;
        Mon, 17 Jun 2019 07:20:47 -0700
Date:   Mon, 17 Jun 2019 07:20:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-b0c792244138d3ef099e7fce978675dc4acae570@git.kernel.org>
Cc:     hpa@zytor.com, valentin.schneider@arm.com, cai@lca.pw,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
          cai@lca.pw, valentin.schneider@arm.com,
          torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20190603115424.7951-1-valentin.schneider@arm.com>
References: <20190603115424.7951-1-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Clean up definition of NOHZ blocked
 load functions
Git-Commit-ID: b0c792244138d3ef099e7fce978675dc4acae570
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b0c792244138d3ef099e7fce978675dc4acae570
Gitweb:     https://git.kernel.org/tip/b0c792244138d3ef099e7fce978675dc4acae570
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Mon, 3 Jun 2019 12:54:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:15:57 +0200

sched/fair: Clean up definition of NOHZ blocked load functions

cfs_rq_has_blocked() and others_have_blocked() are only used within
update_blocked_averages(). The !CONFIG_FAIR_GROUP_SCHED version of the
latter calls them within a #define CONFIG_NO_HZ_COMMON block, whereas
the CONFIG_FAIR_GROUP_SCHED one calls them unconditionnally.

As reported by Qian, the above leads to this warning in
!CONFIG_NO_HZ_COMMON configs:

  kernel/sched/fair.c: In function 'update_blocked_averages':
  kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used [-Wunused-but-set-variable]

It wouldn't be wrong to keep cfs_rq_has_blocked() and
others_have_blocked() as they are, but since their only current use is
to figure out when we can stop calling update_blocked_averages() on
fully decayed NOHZ idle CPUs, we can give them a new definition for
!CONFIG_NO_HZ_COMMON.

Change the definition of cfs_rq_has_blocked() and
others_have_blocked() for !CONFIG_NO_HZ_COMMON so that the
NOHZ-specific blocks of update_blocked_averages() become no-ops and
the 'done' variable gets optimised out.

While at it, remove the CONFIG_NO_HZ_COMMON block from the
!CONFIG_FAIR_GROUP_SCHED definition of update_blocked_averages() by
using the newly-introduced update_blocked_load_status() helper.

No change in functionality intended.

[ Additions by Peter Zijlstra. ]

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190603115424.7951-1-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f8d477f90fe..4c8f45ed093c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7393,6 +7393,7 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
@@ -7420,6 +7421,19 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+
+	if (!has_blocked)
+		rq->has_blocked_load = 0;
+}
+#else
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
+static inline bool others_have_blocked(struct rq *rq) { return false; }
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7485,11 +7499,7 @@ static void update_blocked_averages(int cpu)
 	if (others_have_blocked(rq))
 		done = false;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (done)
-		rq->has_blocked_load = 0;
-#endif
+	update_blocked_load_status(rq, !done);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7555,11 +7565,7 @@ static inline void update_blocked_averages(int cpu)
 	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
-		rq->has_blocked_load = 0;
-#endif
+	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
 	rq_unlock_irqrestore(rq, &rf);
 }
 
