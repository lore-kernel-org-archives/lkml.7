Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E10C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED0216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE0GVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:21:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56088 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE0GVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 711F7374;
        Sun, 26 May 2019 23:21:32 -0700 (PDT)
Received: from e107985-lin.cambridge.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F4813F59C;
        Sun, 26 May 2019 23:21:30 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] sched: Remove per rq load array
Date:   Mon, 27 May 2019 07:21:09 +0100
Message-Id: <20190527062116.11512-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fdf5f315d5cf "sched/fair: Disable LB_BIAS by default"
(v4.20) the scheduler feature LB_BIAS is disabled, i.e. the scheduler
has been only using rq->cpu_load[0] for the cpu load values since then.

Tests back then (result are listed in the header of the patch mentioned
above) haven't shown any regressions and people haven't complained about
any related problems in the meantime (v4.20 - v5.1).

The following patches remove all the functionality which is not needed
anymore:

(1) Per rq load array update code
(2) CFS' source_load() and target_load() used for conservative load
    balancing which can be directly replaced by weighted_cpuload()
(3) Per rq load array (rq->cpu_load[])
(4) Sched domain per rq load indexes (sd->*_idx) since there is no
    other user for it
(5) sum_weighted_load of sched group load balance stats
    because it's now identical with the actual sched group load

Dietmar Eggemann (7):
  sched: Remove rq->cpu_load[] update code
  sched/fair: Replace source_load() & target_load() w/
    weighted_cpuload()
  sched/debug: Remove sd->*_idx range on sysctl
  sched: Remove rq->cpu_load[]
  sched: Remove sd->*_idx
  sched/fair: Remove sgs->sum_weighted_load
  sched/fair: Rename weighted_cpuload() to cpu_load()

 include/linux/sched/nohz.h     |   8 -
 include/linux/sched/topology.h |   5 -
 kernel/sched/core.c            |   7 +-
 kernel/sched/debug.c           |  41 +---
 kernel/sched/fair.c            | 385 ++-------------------------------
 kernel/sched/features.h        |   1 -
 kernel/sched/sched.h           |   8 -
 kernel/sched/topology.c        |  10 -
 kernel/time/tick-sched.c       |   2 -
 9 files changed, 33 insertions(+), 434 deletions(-)

-- 
2.17.1

