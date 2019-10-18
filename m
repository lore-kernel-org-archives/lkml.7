Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11286CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD524222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYFQYDZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410312AbfJRN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:26:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54991 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410303AbfJRN0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:26:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so6192727wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACgHRAYDPePD5iyvNwVwA2/U+1dhCaKONZj4VM6vt/4=;
        b=DYFQYDZvBUzF7NyIwx1hcaaajr/pskthAizC7tbjYaD3UxnadPZvspq6RYLl5JDuQV
         lEKI6PkORzSPdHHl36BLJS1oBce2zZRRSuXXLSBZjx6XW4AJUgpDve/Kv6JFayHEN0jw
         XQNRSq+JsGYsfTLa5Fj2czaP7Vyqdmt4+bXOhYWdLe4Cs7TXEWqfq6kliKchFPHDPb7v
         R13iliv+7RV44FvjcF3/GVZ+aFGIiQyN/t+BuAED+EJZIFPUTR8sTrxqlwJmb5JhDyGd
         2hITiLWee/Ztfvq41wfS0NSoBlallPH6QnLMIozQ+HyxHqmYFE/5IYKI91fn2sYsdNIE
         MoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ACgHRAYDPePD5iyvNwVwA2/U+1dhCaKONZj4VM6vt/4=;
        b=PkRAW0jdRNZn1vVubR0wUmtUEQEtTtxyKZ6nHLABRBh4fKKmFQKxkE7Ugy0dAhIqR8
         9S2gxtiaLduomyuBylkxZmaKryfMjiBI3rxzNfj09nMKseZI5tJSXyr7SBzBG2f3mhol
         d+7wjMcGMfJdZwA2ZcaVSSU5/EkCv6/lgs8nEqVtW76Br+r6/RCfExc7T9UkmHT77M65
         FZMB8LqqZi6idsIIYI8vu/eHGeRMtfmOSQw+2CWSWWIbHt4uC8UQnFSDqGoZaYt6OJ+t
         oeA+cNKIutS8ubswjvbbtdd1fnLtCHIwCf2HLyg7NEpTu8vR711ZbXzn5EeoiUvBfQ6m
         p9FQ==
X-Gm-Message-State: APjAAAWiAfvdLFSn3w6fBe9AE/KgrJBO+GeiyTHzfBLFTrKvjw4vbmAL
        BrO+jAI7nKBvLeTMYAn2D/l1K8DMbX8=
X-Google-Smtp-Source: APXvYqzESC/n80lvoVdrfOo3cYR8plQbatVZ2tDZg6bXqjFUrbcZnxTYOpuTub2kcm0x+IeLoczF1g==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr8035064wmb.88.1571405212870;
        Fri, 18 Oct 2019 06:26:52 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:51 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 05/11] sched/fair: use rq->nr_running when balancing load
Date:   Fri, 18 Oct 2019 15:26:32 +0200
Message-Id: <1571405198-27570-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs load_balance only takes care of CFS tasks whereas CPUs can be used by
other scheduling class. Typically, a CFS task preempted by a RT or deadline
task will not get a chance to be pulled on another CPU because the
load_balance doesn't take into account tasks from other classes.
Add sum of nr_running in the statistics and use it to detect such
situation.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ae5281..e09fe12b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7704,6 +7704,7 @@ struct sg_lb_stats {
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
+	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
@@ -7938,7 +7939,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running < sgs->group_weight)
+	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7959,7 +7960,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_h_nr_running <= sgs->group_weight)
+	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8063,6 +8064,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
+		sgs->sum_nr_running += nr_running;
+
 		if (nr_running > 1)
 			*sg_status |= SG_OVERLOAD;
 
@@ -8420,13 +8423,13 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
-			unsigned int nr_diff = busiest->sum_h_nr_running;
+			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
 			 * When prefer sibling, evenly spread running tasks on
 			 * groups.
 			 */
 			env->migration_type = migrate_task;
-			lsub_positive(&nr_diff, local->sum_h_nr_running);
+			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff >> 1;
 			return;
 		}
@@ -8590,7 +8593,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 
 	/* Try to move all excess tasks to child's sibling domain */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_h_nr_running > local->sum_h_nr_running + 1)
+	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded &&
-- 
2.7.4

