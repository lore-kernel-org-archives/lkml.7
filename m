Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B31C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A282084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfDJIqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:46:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfDJIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:46:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3A8k59W699772
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 01:46:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3A8k5Rt699769;
        Wed, 10 Apr 2019 01:46:05 -0700
Date:   Wed, 10 Apr 2019 01:46:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-d8743230c9f4e92f370ecd2a90c680ddcede6ae5@git.kernel.org>
Cc:     hpa@zytor.com, valentin.schneider@arm.com, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, valentin.schneider@arm.com,
          hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20190409173546.4747-3-valentin.schneider@arm.com>
References: <20190409173546.4747-3-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Fix build_sched_groups() comment
Git-Commit-ID: d8743230c9f4e92f370ecd2a90c680ddcede6ae5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d8743230c9f4e92f370ecd2a90c680ddcede6ae5
Gitweb:     https://git.kernel.org/tip/d8743230c9f4e92f370ecd2a90c680ddcede6ae5
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Tue, 9 Apr 2019 18:35:46 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 09:41:34 +0200

sched/topology: Fix build_sched_groups() comment

The comment was introduced (pre 2.6.12) by:

  8a7a2318dc07 ("[PATCH] sched: consolidate sched domains")

and referred to sched_group->cpu_power. This was folded into
sched_group->sched_group_power in

  commit 9c3f75cbd144 ("sched: Break out cpu_power from the sched_group structure")

The comment was then updated in:

  ced549fa5fc1 ("sched: Remove remaining dubious usage of "power"")

but should have replaced "sg->cpu_capacity" with
"sg->sched_group_capacity". Do that now.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: morten.rasmussen@arm.com
Cc: qais.yousef@arm.com
Link: http://lkml.kernel.org/r/20190409173546.4747-3-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 64bec54ded3e..90e1a870fb0d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1087,8 +1087,8 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 
 /*
  * build_sched_groups will build a circular linked list of the groups
- * covered by the given span, and will set each group's ->cpumask correctly,
- * and ->cpu_capacity to 0.
+ * covered by the given span, will set each group's ->cpumask correctly,
+ * and will initialize their ->sgc.
  *
  * Assumes the sched_domain tree is fully constructed
  */
