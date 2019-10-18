Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE72CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B821925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QM1sCHgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408406AbfJRN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:26:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38919 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfJRN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so6097004wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hfv3JPEuhHlwsh1NcK/qqJPBcbuf8k3CcNDkmEcfSbA=;
        b=QM1sCHgNLaKlYdW+aYM3bL2RnkBeA9SsMgSa9URgCI267/vOddN1HT25EfE1ia+8hb
         4Fh2qI48WM4jrPhf+O3U2YUn80ZwjuOEEQd2i+FLy9PrcLjWuXEYnoZR38bWm69CCDlv
         CrHIuX73DPZLNKoSm82alLSod/V6IODGnHkCq09RomYY+B8GgESJje+yfwJEe1IBiWCe
         UPw4lkfmW/hXS5TJMg0rhH6yaKtgQ7h/e7MNDoyxdMB7tfQuhWuiS1o7c79+u7zX9utj
         okDDrQ3+rSEJDCepPaLvzbJaUp9rvowo+exNU26IKYlDYOwLuEhz5HUIi/WK3nstJLDz
         /GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hfv3JPEuhHlwsh1NcK/qqJPBcbuf8k3CcNDkmEcfSbA=;
        b=ipxr3tAyESBCXT3BMaB0q84fowyA2WNM6wmiHlDyJuW6FfPOE67nFu5LDjbymyJdX3
         QVp8LKjRZi3X5BG5dxxKbc0f+3iYVc0Zr63X+sKuL+yo02lNhoQAKTKjBLw9CQF/SGYF
         TIfsu8M7uYJ+daWgdapT24FHBdKYE+cl+XcpRNIQ1IxTPEZMA/J28aidjWrxMl7EZawv
         NODIRSb9kS5tqVwUcyEo+L8inaobborvjBDXMDQSnhbVetO9pEpJGWB5GysFIP9dkThN
         otwMHjvj4CoKqseelXhTPagStJTtBHbbMHuabBG/DaSaSnFY58jMWOILsDfaLQQQG51w
         AfMw==
X-Gm-Message-State: APjAAAXKR+7EKFrxCUF6cEd7bxEjr7AsPu7P9d03DgBkke2p3UCCr4N/
        WoSmTCJ3KKDHPMrn3AsrSlYsKbfHzYY=
X-Google-Smtp-Source: APXvYqzmRkpUU8vM+JVJyaOiJUSeK1/wBSqINWeyu3P2tqTsu5vR2X4mQHQz/wVlT1tSTFDrb1ChjA==
X-Received: by 2002:a05:600c:23cc:: with SMTP id p12mr3591536wmb.163.1571405205387;
        Fri, 18 Oct 2019 06:26:45 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:44 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 01/11] sched/fair: clean up asym packing
Date:   Fri, 18 Oct 2019 15:26:28 +0200
Message-Id: <1571405198-27570-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
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
Acked-by: Rik van Riel <riel@surriel.com>
---
 kernel/sched/fair.c | 63 ++++++++++++++---------------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f0a5e1..617145c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7675,6 +7675,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	int group_no_capacity;
+	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -8129,9 +8130,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
 
@@ -8273,51 +8282,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -8401,6 +8365,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
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
@@ -8505,8 +8474,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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

