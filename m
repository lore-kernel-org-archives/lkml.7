Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D3C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 23:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF2A20869
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 23:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfEZX4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 19:56:16 -0400
Received: from foss.arm.com ([217.140.101.70]:51938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfEZX4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 19:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D353A374;
        Sun, 26 May 2019 16:56:15 -0700 (PDT)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE0893F5AF;
        Sun, 26 May 2019 16:56:14 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: fix variable "done" set but not used
To:     Qian Cai <cai@lca.pw>, peterz@infradead.org, mingo@kernel.org
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20190525161821.1025-1-cai@lca.pw>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <0dd5f59e-bd7e-69d8-e3e8-dbc73820b110@arm.com>
Date:   Mon, 27 May 2019 00:56:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190525161821.1025-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/2019 17:18, Qian Cai wrote:
> The commit f643ea220701 ("sched/nohz: Stop NOHZ stats when decayed")
> introduced a compilation warning if CONFIG_NO_HZ_COMMON=n,
> 
> kernel/sched/fair.c: In function 'update_blocked_averages':
> kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
> [-Wunused-but-set-variable]
> 

For some reason I can't get this warning to fire on my end (arm64 defconfig
+ all the NO_HZ stuff set to nope + GCC 8.1). However I do think there are
things we could improve here.

cfs_rq_has_blocked() is only used here and in a CONFIG_NO_HZ_COMMON block
within the !CONFIG_FAIR_GROUP_SCHED update_blocked_averages(). Same goes for
others_have_blocked(), so maybe these two should only be defined for
CONFIG_NO_HZ_COMMON, so we get an obvious splat when they end up in
!CONFIG_NO_HZ_COMMON paths. 

Otherwise we can have them defined as straight up false, in which case we
may be able to save ourselves some inline ifdeffery with something like the
following. It's barely compile-tested, but the objdump seems okay.

----->8-----
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f5e528..d3d6a36316f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7695,6 +7695,7 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
@@ -7705,7 +7706,11 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 
 	return false;
 }
+#else
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
+#endif
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool others_have_blocked(struct rq *rq)
 {
 	if (READ_ONCE(rq->avg_rt.util_avg))
@@ -7721,6 +7726,9 @@ static inline bool others_have_blocked(struct rq *rq)
 
 	return false;
 }
+#else
+static inline bool others_have_blocked(struct rq *rq) { return false; }
+#endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
@@ -7741,6 +7749,18 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	return true;
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+
+	if (!has_blocked)
+		rq->has_blocked_load = 0;
+}
+#else
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
+#endif
+
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7787,11 +7807,7 @@ static void update_blocked_averages(int cpu)
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
 
-----8<-----
[...]
