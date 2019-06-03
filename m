Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2E0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4C127ABC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pkgHp6xW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfFCOLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:11:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfFCOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:11:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so3237165wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=66AnuJKIE6eCswxLQ/J3IyokZqKV8slWZjpmmxjw1RQ=;
        b=pkgHp6xWiK272viodj9nkEwwgWpucEtI+Mu+QznUbZgTv8NL+uB+Cb9l/DBP1rf1wo
         MBTrTTKVRS5sUoV4AFk8UNw71wjwjtqOwIq/OtIH89gBkBc+couhdqZ7bcTDpwhGzNuL
         4IO9j8erDie66wW+VbGlfxE6nWeZLNmDs+2hF1o/gSZjdet3JeqXzmp2p2Y8/E7r15ND
         1QpeCkpseBkveeFwzv1eeFosN7pd1rTtR/4mfpxsWsA/UqtiGXANJKpsevQkIVWKIM8S
         OW4hkk4stItvESG8nTFX6fxyxi/JQFlcYmTdux8J+6HQAzyQvBwi9VT/w9scr+4c23lv
         nqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=66AnuJKIE6eCswxLQ/J3IyokZqKV8slWZjpmmxjw1RQ=;
        b=ofb0wBd8l0hGGdtheChmo4XzA/aMsS/gEGlxXEoZo/KKqILpGu0I7jS17JwUzQNupF
         hlCBCgdTpYBXXwuJncLi0lXEs8CXstF7OIjO7j/Sf5MfMJ0FJBUYvp7jPXnla0DD8pUc
         LizEos9bs3f+lJPPG6GKzb66xM9vEbUaBtkdVehNffeIq8ooQbel0g+D50p5Xzqsz3PD
         Aytub4XoohwRmigPr//PJmWafT1iq8sZ58hTrRQix8cjGH++rxdtSPikIiE0V2/9twmt
         8yMRXpFnIU8Wnvibspa/7dtDe/Xun72mPeygsvEFNeHHZawFyoeVaDR/M8VgQKcaV8Cj
         V9dA==
X-Gm-Message-State: APjAAAVLf0E+2GvzW/1quA+jrnYUChjcL2PCD+Vlb9wvDD28rZAWQ9G2
        tagKuJQuafeyYmZApus733hfMw==
X-Google-Smtp-Source: APXvYqzLp+2TvMyVJo3XJdZdVTcx6uU5/Hha7+qVX2LLTt0qUBQModiGLD6N69VjvMWwjEi4cNcAGw==
X-Received: by 2002:adf:8385:: with SMTP id 5mr2667418wre.194.1559571067116;
        Mon, 03 Jun 2019 07:11:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8816:b980:b875:4d47])
        by smtp.gmail.com with ESMTPSA id v11sm7054176wmh.28.2019.06.03.07.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 07:11:06 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
X-Google-Original-From: Vincent Guittot <vincent.guitto@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guitto@linaro.org>
Subject: [PATCH] sched/fair: clean up asym packing
Date:   Mon,  3 Jun 2019 16:11:04 +0200
Message-Id: <1559571064-28087-1-git-send-email-vincent.guitto@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up asym packing to follow the default load balance behavior:
- classify the group by creating a group_asym_capacity field.
- calculate the imbalance in calculate_imbalance() instead of bypassing it.

We don't need to test twice same conditions anymore to detect asym packing
and we consolidate the calculation of imbalance in calculate_imbalance().

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guitto@linaro.org>
---

This is a simple cleanup to gather all imbalance calculations in calculate_imbalance()
before a deeper rework of the load_balance.

 kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..93c2447 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7888,6 +7888,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	int group_asym_capacity;
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8382,9 +8383,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * ASYM_PACKING needs to move all the work to the highest
 	 * prority CPUs in the group, therefore mark all groups
 	 * of lower priority than ourself as busy.
+	 *
+	 * This is primarily intended to used at the sibling level.  Some
+	 * cores like POWER7 prefer to use lower numbered SMT threads.  In the
+	 * case of POWER7, it can move to lower SMT modes only when higher
+	 * threads are idle.  When in lower SMT modes, the threads will
+	 * perform better since they share less core resources.  Hence when we
+	 * have idle threads, we want them to be the higher ones.
 	 */
 	if (sgs->sum_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
+		sgs->group_asym_capacity = 1;
 		if (!sds->busiest)
 			return true;
 
@@ -8522,51 +8531,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 }
 
 /**
- * check_asym_packing - Check to see if the group is packed into the
- *			sched domain.
- *
- * This is primarily intended to used at the sibling level.  Some
- * cores like POWER7 prefer to use lower numbered SMT threads.  In the
- * case of POWER7, it can move to lower SMT modes only when higher
- * threads are idle.  When in lower SMT modes, the threads will
- * perform better since they share less core resources.  Hence when we
- * have idle threads, we want them to be the higher ones.
- *
- * This packing function is run on idle threads.  It checks to see if
- * the busiest CPU in this domain (core in the P7 case) has a higher
- * CPU number than the packing function is being run on.  Here we are
- * assuming lower CPU number will be equivalent to lower a SMT thread
- * number.
- *
- * Return: 1 when packing is required and a task should be moved to
- * this CPU.  The amount of the imbalance is returned in env->imbalance.
- *
- * @env: The load balancing environment.
- * @sds: Statistics of the sched_domain which is to be packed
- */
-static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
-{
-	int busiest_cpu;
-
-	if (!(env->sd->flags & SD_ASYM_PACKING))
-		return 0;
-
-	if (env->idle == CPU_NOT_IDLE)
-		return 0;
-
-	if (!sds->busiest)
-		return 0;
-
-	busiest_cpu = sds->busiest->asym_prefer_cpu;
-	if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
-		return 0;
-
-	env->imbalance = sds->busiest_stat.group_load;
-
-	return 1;
-}
-
-/**
  * fix_small_imbalance - Calculate the minor imbalance that exists
  *			amongst the groups of a sched_domain, during
  *			load balancing.
@@ -8650,6 +8614,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	if (busiest->group_asym_capacity) {
+		env->imbalance = busiest->group_load;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -8754,8 +8723,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	busiest = &sds.busiest_stat;
 
 	/* ASYM feature bypasses nice load balance check */
-	if (check_asym_packing(env, &sds))
-		return sds.busiest;
+	if (busiest->group_asym_capacity)
+		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest || busiest->sum_nr_running == 0)
-- 
2.7.4

