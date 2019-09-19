Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4345BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2F221D79
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gU4R5hVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbfISHeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:34:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34669 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387987AbfISHeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:34:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so6509467wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yv6OJ+qJWSUveYSQClIlpg+HtWhIHflpjhPTFDhhWg0=;
        b=gU4R5hVlKT8S03ABoMXLVq+a9wpdo+RCX13F8JEMTiQCW4ZMjIarL6SaDV5qypH8Wd
         zrhAtU8SDUaELT1tecX1Y+0WNzvBdsPuE47xctMS/zIE7nFrHD/p1uUrkacLbZpXhzHW
         +JucRgZEomQeGAL/YxQ97GN6gme3eA6WRV0Eo4f1moUCNZCX5cOwE9LBorAbVx0Hp2ft
         qMX+ngNiNZq4axL611v3eSJ8TU3IH5VowNhLYFmI67gfZOfMdIOPnnLMj0JeTz1i3LJ0
         vstNT2HEMmP+Gr/UiNHaAbcvNanVGVCwu6njib1D/bUj4iFie06Q2gULbB0db4t3MpPw
         fh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yv6OJ+qJWSUveYSQClIlpg+HtWhIHflpjhPTFDhhWg0=;
        b=g4KBgyq0uQo0xLDXlMRroZRVSmvLbd/X/BFLc2pFZBcSTV/toha5Lu1iFevI2a5Rg8
         Zgu24xopwEJ7r8QHjrvOY0AiBfCBUClf2tCM75Zgba0stL9LLpn3XLBFegoYM3x2QgKT
         Plr+K6m4Ia4slL6bOOXuQb1Eg24/bhSJOcQPzvCKDyUyjMJ/m5DVtR9J1gqsR6dhgpij
         TzIlbQ0Nrveu3lkCpSPaooxUEqlPVsD7rCJzLdMU0SVpJgE5QQSyhuxQTGPbPhmQpCTk
         kDbeMOJzyYsnw5KAWR1wVRpsUOvhzj2k+nUXwsNMgx1lF6zearA5zVHfHr1VfgWPxQCO
         V2RA==
X-Gm-Message-State: APjAAAW8t0XeBWWhGXeRS8GyJaiJBEOXNXLjeqOXwIzAbBaUospYZk7r
        lCzpl3miSEKXf9wU5K7YQ86qWxF4ASY=
X-Google-Smtp-Source: APXvYqxhqaWdjrzKAYufJ/XJSXAr9h728vFg1+Ztfcr3KE2hDJEFvNRXROpkiOwnRZw5Eu2IVNtgqQ==
X-Received: by 2002:a1c:f209:: with SMTP id s9mr1614438wmc.60.1568878437850;
        Thu, 19 Sep 2019 00:33:57 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d555:8fca:a19c:222c])
        by smtp.gmail.com with ESMTPSA id s12sm13300250wra.82.2019.09.19.00.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 00:33:56 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 01/10] sched/fair: clean up asym packing
Date:   Thu, 19 Sep 2019 09:33:32 +0200
Message-Id: <1568878421-12301-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up asym packing to follow the default load balance behavior:
- classify the group by creating a group_asym_packing field.
- calculate the imbalance in calculate_imbalance() instead of bypassing it.

We don't need to test twice same conditions anymore to detect asym packing
and we consolidate the calculation of imbalance in calculate_imbalance().

There is no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1054d2c..3175fea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7685,6 +7685,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8139,9 +8140,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
+		sgs->group_asym_packing = 1;
 		if (!sds->busiest)
 			return true;
 
@@ -8283,51 +8292,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8411,6 +8375,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
+	if (busiest->group_asym_packing) {
+		env->imbalance = busiest->group_load;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -8515,8 +8484,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	busiest = &sds.busiest_stat;
 
 	/* ASYM feature bypasses nice load balance check */
-	if (check_asym_packing(env, &sds))
-		return sds.busiest;
+	if (busiest->group_asym_packing)
+		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
 	if (!sds.busiest || busiest->sum_nr_running == 0)
-- 
2.7.4

