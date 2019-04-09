Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D23C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADE820883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIRhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:37:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfDIRg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:36:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7383E15BE;
        Tue,  9 Apr 2019 10:36:57 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14A1A3F59C;
        Tue,  9 Apr 2019 10:36:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com, qais.yousef@arm.com
Subject: [PATCH 2/2] sched/topology: Fix build_sched_groups() comment
Date:   Tue,  9 Apr 2019 18:35:46 +0100
Message-Id: <20190409173546.4747-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409173546.4747-1-valentin.schneider@arm.com>
References: <20190409173546.4747-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment was introduced (pre 2.6.12) by

  commit 8a7a2318dc07 ("[PATCH] sched: consolidate sched domains")

and referred to sched_group->cpu_power. This was folded into
sched_group->sched_group_power in

  commit 9c3f75cbd144 ("sched: Break out cpu_power from the sched_group structure")

The comment was then updated in

  commit ced549fa5fc1 ("sched: Remove remaining dubious usage of "power"")

but should have replaced "sg->cpu_capacity" with
"sg->sched_group_capacity". Do that now.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6c0b7326f66e..c65b31e9458b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1093,8 +1093,8 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 
 /*
  * build_sched_groups will build a circular linked list of the groups
- * covered by the given span, and will set each group's ->cpumask correctly,
- * and ->cpu_capacity to 0.
+ * covered by the given span, will set each group's ->cpumask correctly,
+ * and will initialize their ->sgc.
  *
  * Assumes the sched_domain tree is fully constructed
  */
-- 
2.20.1

