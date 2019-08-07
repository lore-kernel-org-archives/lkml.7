Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97750C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D3021E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfHGRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:41:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbfHGRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:41:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F50528;
        Wed,  7 Aug 2019 10:41:11 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 583813F575;
        Wed,  7 Aug 2019 10:41:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH 0/3] sched/fair: Active balancer RT/DL preemption fix
Date:   Wed,  7 Aug 2019 18:40:23 +0100
Message-Id: <20190807174026.31242-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent's load balance rework [1] got me thinking about how and where we
use rq.nr_running vs rq.cfs.h_nr_running checks, and this lead me to
stare intently at the active load balancer.

I haven't seen it happen (yet), but from reading the code it really looks
like we can have some scenarios where the cpu_stopper ends up preempting
a > CFS class task.

- Patch 1 is a preparatory code move
- Patch 2 is the actual fix
- Patch 3 is a related fix for the cpu_stopper function

This is based on top of today's tip/sched/core:
  a1dc0446d649 ("sched/core: Silence a warning in sched_init()")

@Vincent: I don't think this should conflict too badly with your rework,
but if you have any issues I'll try to give you a version rebased on top
of the rework.

[1]: https://lore.kernel.org/lkml/1564670424-26023-1-git-send-email-vincent.guittot@linaro.org/

Valentin Schneider (3):
  sched/fair: Move active balance logic to its own function
  sched/fair: Prevent active LB from preempting higher sched classes
  sched/fair: Check for CFS tasks in active_load_balance_cpu_stop()

 kernel/sched/fair.c | 130 +++++++++++++++++++++++++++-----------------
 1 file changed, 79 insertions(+), 51 deletions(-)

--
2.22.0

