Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FDCC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC01320644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfHOOvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:51:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOOvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:51:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 515E1344;
        Thu, 15 Aug 2019 07:51:51 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E13F3F706;
        Thu, 15 Aug 2019 07:51:50 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com
Subject: [PATCH v2 0/4] sched/fair: Active balancer RT/DL preemption fix
Date:   Thu, 15 Aug 2019 15:51:03 +0100
Message-Id: <20190815145107.5318-1-valentin.schneider@arm.com>
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
a > CFS class task, since we never actually look at what's the remote rq's
running task.

This series shuffles things around the CFS active load balancer to prevent
this from happening.

- Patch 1 is a freebie cleanup
- Patch 2 is a preparatory code move
- Patch 3 adds h_nr_running checks
- Patch 4 adds a sched class check + detach_one_task() to the active balance

This is based on top of today's tip/sched/core:
  a46d14eca7b7 ("sched/fair: Use rq_lock/unlock in online_fair_sched_group")

v1 -> v2:
  - (new patch) Added need_active_balance() cleanup

  - Tweaked active balance code move to respect existing
    sd->nr_balance_failed modifications
  - Added explicit checks of active_load_balance()'s return value
  
  - Added an h_nr_running < 1 check before kicking the cpu_stopper

  - Added a detach_one_task() call in active_load_balance() when the remote
    rq's running task is > CFS

[1]: https://lore.kernel.org/lkml/1564670424-26023-1-git-send-email-vincent.guittot@linaro.org/

Valentin Schneider (4):
  sched/fair: Make need_active_balance() return bools
  sched/fair: Move active balance logic to its own function
  sched/fair: Check for CFS tasks before detach_one_task()
  sched/fair: Prevent active LB from preempting higher sched classes

 kernel/sched/fair.c | 151 ++++++++++++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 56 deletions(-)

--
2.22.0

