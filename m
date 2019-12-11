Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7779CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5064124653
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfLKQoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:44:55 -0500
Received: from foss.arm.com ([217.140.110.172]:38688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbfLKQol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D616211B3;
        Wed, 11 Dec 2019 08:44:40 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1ED33F52E;
        Wed, 11 Dec 2019 08:44:39 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH 6/7] sched/fair: Split select_task_rq_fair want_affine logic
Date:   Wed, 11 Dec 2019 16:44:00 +0000
Message-Id: <20191211164401.5013-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain loop within select_task_rq_fair() depends on a few bits of
input, namely the SD flag we're looking for and whether we want_affine.

For !want_affine, the domain loop will walk up the hierarchy to reach the
highest domain with both SD_LOAD_BALANCE and the requested sd_flag
(SD_BALANCE_{WAKE, FORK, EXEC}) set.
In other words, that's a call to highest_flags_domain() for these two
flags. Note that this is a static information wrt a given SD hierarchy,
so we can cache that - but that comes in a later patch to ease reviewing.

For want_affine, we'll walk up the hierarchy to reach the first domain
with SD_LOAD_BALANCE, SD_WAKE_AFFINE, and that spans the tasks's prev_cpu.
We still save a pointer to the last visited domain that had the requested
sd_flag set (and SD_LOAD_BALANCE), which means that if we fail to go
through the affine condition (e.g. no domain had SD_WAKE_AFFINE) we'll use
the same SD as we would have found if we had !want_affine.

Split the domain loop in !want_affine and want_affine paths. As it is,
this leads to two domain walks instead of a single one, but stay tuned for
the next patch.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 30e8d357a24f..ea875c7c82d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6370,29 +6370,36 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 
 	rcu_read_lock();
+
+	sd = highest_flags_domain(cpu, sd_flag | SD_LOAD_BALANCE);
+
+	/*
+	 * If !want_affine, we just look for the highest domain where
+	 * sd_flag is set.
+	 */
+	if (!want_affine)
+		goto scan;
+
+	/*
+	 * Otherwise we look for the lowest domain with SD_WAKE_AFFINE and that
+	 * spans both 'cpu' and 'prev_cpu'.
+	 */
 	for_each_domain(cpu, tmp) {
 		if (!(tmp->flags & SD_LOAD_BALANCE))
 			break;
 
-		/*
-		 * If both 'cpu' and 'prev_cpu' are part of this domain,
-		 * cpu is a valid SD_WAKE_AFFINE target.
-		 */
-		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
+		if ((tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
 				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
 
-			sd = NULL; /* Prefer wake_affine over balance flags */
+			/* Prefer wake_affine over SD lookup */
+			sd = NULL;
 			break;
 		}
-
-		if (tmp->flags & sd_flag)
-			sd = tmp;
-		else if (!want_affine)
-			break;
 	}
 
+scan:
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-- 
2.24.0

