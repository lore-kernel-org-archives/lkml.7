Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDB7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C0120857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIRg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:36:58 -0400
Received: from foss.arm.com ([217.140.101.70]:42152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfDIRgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:36:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287D41682;
        Tue,  9 Apr 2019 10:36:55 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C654F3F59C;
        Tue,  9 Apr 2019 10:36:53 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com, qais.yousef@arm.com
Subject: [PATCH 1/2] sched/topology: build_sched_groups: Skip duplicate group rewrites
Date:   Tue,  9 Apr 2019 18:35:45 +0100
Message-Id: <20190409173546.4747-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409173546.4747-1-valentin.schneider@arm.com>
References: <20190409173546.4747-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While staring at build_sched_domains(), I realized that get_group()
does several duplicate (thus useless) writes.

If you take the Arm Juno r0 (LITTLEs = [0, 3, 4, 5], bigs = [1, 2]), the
sched_group build flow would look like this:

('MC[cpu]->sg' means 'per_cpu_ptr(&tl->data->sg, cpu)' with 'tl == MC')

build_sched_groups(MC[CPU0]->sd, CPU0)
  get_group(0) -> MC[CPU0]->sg
  get_group(3) -> MC[CPU3]->sg
  get_group(4) -> MC[CPU4]->sg
  get_group(5) -> MC[CPU5]->sg

build_sched_groups(DIE[CPU0]->sd, CPU0)
  get_group(0) -> DIE[CPU0]->sg
  get_group(1) -> DIE[CPU1]->sg <-----------------+
						  |
build_sched_groups(MC[CPU1]->sd, CPU1)            |
  get_group(1) -> MC[CPU1]->sg                    |
  get_group(2) -> MC[CPU2]->sg                    |
						  |
build_sched_groups(DIE[CPU1]->sd, CPU1)           ^
  get_group(1) -> DIE[CPU1]->sg  } We've set up these two up here!
  get_group(3) -> DIE[CPU0]->sg  }

From this point on, we will only use sched_groups that have been
previously visited & initialized. The only new operation will
be which group pointer we affect to sd->groups.

On the Juno r0 we get 32 get_group() calls, every single one of them
writing to a sched_group->cpumask. However, all of the data structures
we need are set up after 8 visits (see above).

Return early from get_group() if we've already visited (and thus
initialized) the sched_group we're looking at. Overlapping domains
are not affected as they do not use build_sched_groups().

Tested on a Juno and a 2 * (Xeon E5-2690) system.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
FWIW I initially checked the refs for both sg && sg->sgc, but figured if
they weren't both 0 or > 1 then something must have gone wrong, so I
threw in a WARN_ON().
---
 kernel/sched/topology.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64bec54ded3e..6c0b7326f66e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1059,6 +1059,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
 	struct sched_domain *child = sd->child;
 	struct sched_group *sg;
+	bool already_visited;
 
 	if (child)
 		cpu = cpumask_first(sched_domain_span(child));
@@ -1066,9 +1067,14 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	sg = *per_cpu_ptr(sdd->sg, cpu);
 	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
 
-	/* For claim_allocations: */
-	atomic_inc(&sg->ref);
-	atomic_inc(&sg->sgc->ref);
+	/* Increase refcounts for claim_allocations: */
+	already_visited = atomic_inc_return(&sg->ref) > 1;
+	/* sgc visits should follow a similar trend as sg */
+	WARN_ON(already_visited != (atomic_inc_return(&sg->sgc->ref) > 1));
+
+	/* If we have already visited that group, it's already initialized. */
+	if (already_visited)
+		return sg;
 
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
--
2.20.1

