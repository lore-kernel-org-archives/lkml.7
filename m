Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5872C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B0222B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfLKQoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:44:39 -0500
Received: from foss.arm.com ([217.140.110.172]:38656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbfLKQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A4881007;
        Wed, 11 Dec 2019 08:44:37 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A64C63F52E;
        Wed, 11 Dec 2019 08:44:36 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH 3/7] sched/fair: find_idlest_group(): Remove unused sd_flag parameter
Date:   Wed, 11 Dec 2019 16:43:57 +0000
Message-Id: <20191211164401.5013-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last use of that parameter was removed by commit

  57abff067a08 ("sched/fair: Rework find_idlest_group()")

Get rid of the parameter.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a614e4794024..f0b2b403bebb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5575,8 +5575,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5665,7 +5664,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu, sd_flag);
+		group = find_idlest_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8382,8 +8381,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
-- 
2.24.0

