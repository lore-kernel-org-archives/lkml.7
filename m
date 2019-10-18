Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C4FCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C861E222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awr1kDiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439202AbfJRN1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:27:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410333AbfJRN1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:27:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id o15so5843108wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/1EXP59iD2tSSDxQFHqr6RgR861BrswyMXiJ6kbQ8A=;
        b=awr1kDiwCy9ZAcOnBjuEJIflo+CIkuihpEYfhcMLLrMyJoP11CB0U3qlXJ/49XTNEd
         Z8uBraX991qplCmKIWdripBXmIPizYl9pPYMhMqMK3Yeemr6Fnkg2RcgfXct37PHHLrF
         9pPTEYsCdKguRHaEjs3eXNTbdWnnzxO0B6kuLAjhywYonAYaFf4rlvfm9ZthekjCabiG
         G7zNYo5niBXc1G0zYbT1xyZfqIjBLozVhUzdnzICJsFF2A5jV5BwHc317kAyv5qjQ/pJ
         u5BOQtoFnqCloxfpx/tF4Lnawlp7alDFKCIsNugb4q5VgYlx9SNnJe7me4WxPJgJgad3
         zKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/1EXP59iD2tSSDxQFHqr6RgR861BrswyMXiJ6kbQ8A=;
        b=a2J/buDtiFbQ2TTCJdeJvqSEbZBk7T+XnciGAWjUixsQnh4U3/i+vtjrEc8kQA5v3Z
         PG+RYFs62A1PvoSPz1kjt9nb5P0V92gZoZiKaOXAS3DzFf5WSgRZe+jETiMe/7fDVo9u
         amdG9RcKuubjU/zAjKJ07tGM9FhnwejMEu7lR4o6R2F81zDxJ3ELt5XXGM/ryFdJN4sQ
         lXTOniyGgMUwesVJPMJroIT0NYKi4Led0HW/1w95ashFWDnI8P8rHjscDNUI6behAB5u
         kbC+z+AZt+FeMlHjtKEle6sNvDE3UQmkLZ5EQguK3/Cv+hEXVSVtufUaXoVvnHZQLetn
         OHfg==
X-Gm-Message-State: APjAAAX840PCpsIEERZhzJmCEi8pD1xDYvAQNoOEcBO9GvuWihMNavLe
        pe0rjhIDp3ka2OcbmKqseM9HJukb4sI=
X-Google-Smtp-Source: APXvYqys/uW/bllAaLIsOUwUt2PgqykF2FKd4PkxhUrxJ8z2z5VCUNkPL4eLzhflysidJ0YArUrumA==
X-Received: by 2002:adf:8123:: with SMTP id 32mr8255555wrm.300.1571405220321;
        Fri, 18 Oct 2019 06:27:00 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id p15sm5870123wrs.94.2019.10.18.06.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 06:26:59 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 09/11] sched/fair: use load instead of runnable load in wakeup path
Date:   Fri, 18 Oct 2019 15:26:36 +0200
Message-Id: <1571405198-27570-10-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

runnable load has been introduced to take into account the case where
blocked load biases the wake up path which may end to select an overloaded
CPU with a large number of runnable tasks instead of an underutilized
CPU with a huge blocked load.

Tha wake up path now starts to looks for idle CPUs before comparing
runnable load and it's worth aligning the wake up path with the
load_balance.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 670856d..6203e71 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1475,7 +1475,12 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	       group_faults_cpu(ng, src_nid) * group_faults(p, dst_nid) * 4;
 }
 
-static unsigned long cpu_runnable_load(struct rq *rq);
+static inline unsigned long cfs_rq_runnable_load_avg(struct cfs_rq *cfs_rq);
+
+static unsigned long cpu_runnable_load(struct rq *rq)
+{
+	return cfs_rq_runnable_load_avg(&rq->cfs);
+}
 
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
@@ -5380,11 +5385,6 @@ static int sched_idle_cpu(int cpu)
 			rq->nr_running);
 }
 
-static unsigned long cpu_runnable_load(struct rq *rq)
-{
-	return cfs_rq_runnable_load_avg(&rq->cfs);
-}
-
 static unsigned long cpu_load(struct rq *rq)
 {
 	return cfs_rq_load_avg(&rq->cfs);
@@ -5485,7 +5485,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	s64 this_eff_load, prev_eff_load;
 	unsigned long task_load;
 
-	this_eff_load = cpu_runnable_load(cpu_rq(this_cpu));
+	this_eff_load = cpu_load(cpu_rq(this_cpu));
 
 	if (sync) {
 		unsigned long current_load = task_h_load(current);
@@ -5503,7 +5503,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		this_eff_load *= 100;
 	this_eff_load *= capacity_of(prev_cpu);
 
-	prev_eff_load = cpu_runnable_load(cpu_rq(prev_cpu));
+	prev_eff_load = cpu_load(cpu_rq(prev_cpu));
 	prev_eff_load -= task_load;
 	if (sched_feat(WA_BIAS))
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
@@ -5591,7 +5591,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
 		max_spare_cap = 0;
 
 		for_each_cpu(i, sched_group_span(group)) {
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			runnable_load += load;
 
 			avg_load += cfs_rq_load_avg(&cpu_rq(i)->cfs);
@@ -5732,7 +5732,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 				continue;
 			}
 
-			load = cpu_runnable_load(cpu_rq(i));
+			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
 				least_loaded_cpu = i;
-- 
2.7.4

