Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C11C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2725F21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMYClMx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfGSH7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:59:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfGSH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:59:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so23952244wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2g1oW2O4/Y2MDAYw/ieUv2Y7XyEA8DlEcwQeTSjYL8E=;
        b=fMYClMx0ivNpXEExhxPGrj+mU9NTw55/wz4x01IIeZ1Yew+7VsC7ogFZDY4R9OiEG0
         mHx7pCQyF/th8dUEWNDD7JyDpxaC+lj+kb9TANFkmB1TfDapD2tzC8EXmn91AnNs/btF
         v9+OtNKXMf53urQX/WDJdrY/QjAXwyS9th+Qx3NqzDhEz0KD4GwkGbwJ0wVLfcWXbldo
         ak6GMzzwnMqmYKdzdoz0SStbFhBpGxi5g7qYTnBU3fsAQqGiJLQVqj58gsHx6BsPqJb/
         EKFOu22KWJIY46fVy3RTYylz7BmPV2Uhrccc1pBkQHD+O/q14615fb3fR0m6ttrmyD+V
         opIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2g1oW2O4/Y2MDAYw/ieUv2Y7XyEA8DlEcwQeTSjYL8E=;
        b=UdTcPWmwr9q+Ul/+DegiYuYVMmR68yZMN1Q/78VdACOqbs2+XDX36CWVJOPvmUq1ug
         qnV2NB0LwllLIlpcegKwkzhMjPl4SEXWEOZkhbWBM9UOcaCpiip5eT8V71lyzeC00Rwl
         w9Ed2Ol7d1FVR/3n3sRzlIBU81d2VkJ5qEkILhsuvx/qPVE96TVwBHzzvu2LBC2SUgXH
         EmfG6fKp3SKqY6sUyrEHr1koniUjSS4D+1ZPyCKS67M6ONWYqqUvu0n0/mb0nFUss7fr
         fMTaXAntz170Sns6HdcuSY1JlbITLTMqqOrpWriLxkX4y8zegizSNPj3Mqc8YIIMYnxt
         BBDQ==
X-Gm-Message-State: APjAAAUTCWS8cGwWSnABSxGU/mlK426+n9JgQqPZH173gJaapz/cb8VC
        4MIFkPlaJsCudaRLaO0Rd+08gZBf0Es=
X-Google-Smtp-Source: APXvYqxUALvCwQdY7DjQMJA0xipwktJDWNGJldADyYLCfXqX6rUx1RJsLrtjvC6MJcQ+1e9O7P/VOw==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr48253558wma.90.1563523139161;
        Fri, 19 Jul 2019 00:58:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:484b:32fe:1cf4:f69b])
        by smtp.gmail.com with ESMTPSA id c1sm58673826wrh.1.2019.07.19.00.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 00:58:58 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, pauld@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/5] sched/fair: evenly spread tasks when not overloaded
Date:   Fri, 19 Jul 2019 09:58:25 +0200
Message-Id: <1563523105-24673-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is only 1 cpu per group, using the idle cpus to evenly spread
tasks doesn't make sense and nr_running is a better metrics.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c221713..a60ddef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8353,7 +8353,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		env->src_grp_type = migrate_task;
 		imbalance = max_t(long, 0, (local->idle_cpus - busiest->idle_cpus) >> 1);
 
-		if (sds->prefer_sibling)
+		if (sds->prefer_sibling || busiest->group_weight == 1)
 			/*
 			 * When prefer sibling, evenly spread running tasks on
 			 * groups.
@@ -8531,18 +8531,34 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
-	if (busiest->group_type != group_overloaded &&
-	     (env->idle == CPU_NOT_IDLE ||
-	      local->idle_cpus <= (busiest->idle_cpus + 1)))
-		/*
-		 * If the busiest group is not overloaded
-		 * and there is no imbalance between this and busiest group
-		 * wrt idle CPUs, it is balanced. The imbalance
-		 * becomes significant if the diff is greater than 1 otherwise
-		 * we might end up to just move the imbalance on another
-		 * group.
-		 */
-		goto out_balanced;
+	if (busiest->group_type != group_overloaded) {
+		if (env->idle == CPU_NOT_IDLE)
+			/*
+			 * If the busiest group is not overloaded (and as a
+			 * result the local one too) but this cpu is already
+			 * busy, let another idle cpu try to pull task.
+			 */
+			goto out_balanced;
+
+		if (busiest->group_weight > 1 &&
+		    local->idle_cpus <= (busiest->idle_cpus + 1))
+			/*
+			 * If the busiest group is not overloaded
+			 * and there is no imbalance between this and busiest
+			 * group wrt idle CPUs, it is balanced. The imbalance
+			 * becomes significant if the diff is greater than 1
+			 * otherwise we might end up to just move the imbalance
+			 * on another group. Of course this applies only if
+			 * there is more than 1 CPU per group.
+			 */
+			goto out_balanced;
+
+		if (busiest->sum_nr_running == 1)
+			/*
+			 * busiest doesn't have any tasks waiting to run
+			 */
+			goto out_balanced;
+	}
 
 force_balance:
 	/* Looks like there is an imbalance. Compute it */
-- 
2.7.4

