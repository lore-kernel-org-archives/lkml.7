Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D22C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7C823428
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWPK/tet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfFCJio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:38:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFCJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=shEpussJVK4kX0zFx2OSf3bsUQCE4F+0YW8EjyKgTz8=; b=qWPK/tet4S8sC5cqnRMYBTJ5q
        jEHiSuKDDlLZ49yBB8bOJq+taYehgZ/Fsj8PyZjHusDs3ScdvXeBQsoOq7dHfuHeBEO5/JqaT33ox
        h0b70rfgNafYfnspTqp1UoxFHM31AritXis0qEG5IIbTbd0x9kiLAdq1wbl/issBotUU9X2X5dXp3
        lghtDtNK3N3O+vZEuAuQ9ve8uyh3WhiWowlPp9EnSqWqOKIHDgWVlvETxjaD25cSsKk6habsOteEw
        Pw2Z5XYxDJt46DseZBso5CmroPTiaNOJLY4R1w+K6hNmpLQQtmweTrdfgK3ZrqXWGat9AvXadZhRa
        rbOZSf9IA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXjQM-00023d-CK; Mon, 03 Jun 2019 09:38:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDC9C2025D9C8; Mon,  3 Jun 2019 11:38:35 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:38:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] sched/fair: Cleanup definition of NOHZ blocked load
 functions
Message-ID: <20190603093835.GF3436@hirez.programming.kicks-ass.net>
References: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
 <20190602164110.23231-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190602164110.23231-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 05:41:10PM +0100, Valentin Schneider wrote:
> cfs_rq_has_blocked() and others_have_blocked() are only used within
> update_blocked_averages(). The !CONFIG_FAIR_GROUP_SCHED version of the
> latter calls them within a #define CONFIG_NO_HZ_COMMON block, whereas
> the CONFIG_FAIR_GROUP_SCHED one calls them unconditionnally.
> 
> As reported by Qian, the above leads to this warning in
> !CONFIG_NO_HZ_COMMON configs:
> 
>   kernel/sched/fair.c: In function 'update_blocked_averages':
>   kernel/sched/fair.c:7750:7: warning: variable 'done' set but not used
>   [-Wunused-but-set-variable]
> 
> It wouldn't be wrong to keep cfs_rq_has_blocked() and
> others_have_blocked() as they are, but since their only current use is
> to figure out when we can stop calling update_blocked_averages() on
> fully decayed NOHZ idle CPUs, we can give them a new definition for
> !CONFIG_NO_HZ_COMMON.
> 
> Change the definition of cfs_rq_has_blocked() and
> others_have_blocked() for !CONFIG_NO_HZ_COMMON so that the
> NOHZ-specific blocks of update_blocked_averages() become no-ops and
> the 'done' variable gets optimised out.
> 
> No change in functionality intended.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

I'm thinking the below can go on top to further clean up?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7722,9 +7722,18 @@ static inline bool others_have_blocked(s
 
 	return false;
 }
+
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+
+	if (!has_blocked)
+		rq->has_blocked_load = 0;
+}
 #else
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -7746,18 +7755,6 @@ static inline bool cfs_rq_is_decayed(str
 	return true;
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
-{
-	rq->last_blocked_load_update_tick = jiffies;
-
-	if (!has_blocked)
-		rq->has_blocked_load = 0;
-}
-#else
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
-#endif
-
 static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7870,11 +7867,7 @@ static inline void update_blocked_averag
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
 
