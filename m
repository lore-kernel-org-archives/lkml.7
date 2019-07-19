Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68654C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ADD20651
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vznvEbUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfGSH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:59:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGSH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:58:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so31282590wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QHdcaXLFj8hmuPKGO9zvPjkzsCCROieoZsTLr0egxPg=;
        b=vznvEbUxNcH663vJhzhl4z0PMqD//u2+kSJ24N5/XjxaE1ugq0im0no7sO+8r0FiUj
         QgUxS6oi+Wcjnc4XHwIkaLxEL4fIhDg2k5TqG4vd7gN/Q88WE4XHYmyrqt4vNwDeA9ol
         c0nj3ccsoFRp5qF7VgoLUP9DziZwlEHRHyQfltTNC9Wcn/L/46bbfwolRfj0GMb46qUb
         gjhi2dUUcM721Jt7xbVtUeHeqbG5SUpXiZclpSIglJKTOcSSQYYBRQedOYm2IwEqKDDB
         COxISo/3RJFkncXD8yVLqr9VAhvq1sSPAFR4IJSCoDi1Fs6/tPg6yFTfYItjXyE5fZoj
         2z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QHdcaXLFj8hmuPKGO9zvPjkzsCCROieoZsTLr0egxPg=;
        b=YEd/laQ1rWPNaxmPYiSQOzOXsB+dlcQXAD8+wkVm2E6dWhj28V+cOEr3wqWbIKm/Su
         7bYx2/KradU8JchwhpTQTAYASqS3c/sVRAxX5wFiCevRrFZZbnlRinG5EKYUkiVdOoJw
         iuPi7vGyEx4iWcgChhylVsqa6upRknG7imt4ujlBJPpVwJVvBzN0uNzD72dsvv6KpPFK
         ekgF9DlOaFCpcE2o+bkrKeIgJ+hQRGKy3gFtlgxne/GIaAFhIAimKR1S5VCn9k75kRwl
         5H/yT10RjllgSNGLZLoy4ORjT0mCmIsSWBdtBaS4KGKT6TGDLW+3e0K5loT68HNdS3Lm
         ir+Q==
X-Gm-Message-State: APjAAAVnUD2rXQOsbX5tNPoj0GxUmX4q7Eoai/XNo6zMMGB7L5o88S4c
        9PQaNhNP+ewgSpbnRdG/c8mWDTZ3NRU=
X-Google-Smtp-Source: APXvYqyqAkC7X6vPgsVRgnrllgRRzYxNCIUi23MfZ8NFpuu3VbXv1Db64TWCXD1dO9R/lq3ydgFl7Q==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr21972112wrl.281.1563523135353;
        Fri, 19 Jul 2019 00:58:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/5] sched/fair: clean up asym packing
Date:   Fri, 19 Jul 2019 09:58:21 +0200
Message-Id: <1563523105-24673-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
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

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fff5632..7a530fd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7654,6 +7654,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	int group_asym_capacity;
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8110,9 +8111,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
 
@@ -8254,51 +8263,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8382,6 +8346,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8486,8 +8455,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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

