Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C522B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfLKQof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:44:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfLKQoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:44:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE56A30E;
        Wed, 11 Dec 2019 08:44:33 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0A9F3F52E;
        Wed, 11 Dec 2019 08:44:32 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 0/7] sched: Streamline select_task_rq() & select_task_rq_fair()
Date:   Wed, 11 Dec 2019 16:43:54 +0000
Message-Id: <20191211164401.5013-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been staring at select_task_rq_fair() for some time now, and have
come to "hate" the usage of the sd_flag parameter. It is used as both an
indicator of the wakeup type (ttwu/fork/exec) and as a domain walk search
target. CFS is the only class doing this, the other classes just need the
wakeup type but get passed a domain flag instead.

This series gets rid of select_task_rq()'s sd_flag parameter and also
tries to optimize select_task_rq_fair().

There's a few ugly things in there that could be improved with some extra
lawnmowing, hence me sending this as an RFC.

This is based on v5.5-rc1.

Patches
=======

Patches 1-2 involve getting rid of the sd_flag parameter for select_task_rq().

Patches 3-4 are extra cleanups in the select_task_rq_fair() region.

Patches 5-7 split the want_affine vs !want_affine paths of
select_task_rq_fair(), which unearths a domain walk that can be cached.
Patches 6 & 7 should be considered as a single patch, they are only split
to hopefully ease reviewing.

Discussion points
=================

The use of SD_LOAD_BALANCE forced me to do a few ugly things.

Patch 5 is only required because the domain walk in select_task_rq_fair()
is ceiled by the presence of SD_LOAD_BALANCE. Thing is (I also ramble about
this in the changelog of patch 7) AFAIK this flag is set unconditionally in
sd_init() and the only way to clear it is via the sched_domain sysctl,
which is a SCHED_DEBUG interface. I haven't found anything with cpusets
that would clear it; AFAICT cpusets can end up attaching the NULL domain to
some CPUs (with sched_load_balance=0) but that's as far as this goes:

  $ git grep SD_LOAD_BALANCE
  include/linux/sched/topology.h:#define SD_LOAD_BALANCE          0x0001  /* Do load balancing on this domain. */
  kernel/sched/fair.c:            if (!(tmp->flags & SD_LOAD_BALANCE))
  kernel/sched/fair.c:            if ((sd->flags & SD_LOAD_BALANCE) &&
  kernel/sched/fair.c:            if (!(sd->flags & SD_LOAD_BALANCE))
  kernel/sched/fair.c:            if (!(sd->flags & SD_LOAD_BALANCE))
  kernel/sched/topology.c:        if (!(sd->flags & SD_LOAD_BALANCE)) {
  kernel/sched/topology.c:                        printk(KERN_ERR "ERROR: !SD_LOAD_BALANCE domain has parent");
  kernel/sched/topology.c:        if (sd->flags & (SD_LOAD_BALANCE |
  kernel/sched/topology.c:                pflags &= ~(SD_LOAD_BALANCE |
  kernel/sched/topology.c:                .flags                  = 1*SD_LOAD_BALANCE

On top of this, the sysctl interface can break the SD pointers cached in
update_top_cache_domain() (again, see patch 7).

In short, we should:
- Fix the stale sched_domain cached pointer issue by either making the
  sysctl sd->flags entry read-only, or have it cause a cached pointer
  update

- Remove SD_LOAD_BALANCE (or at the very least its usage sites). IMO, not
  doing load balance translates to not having a sched_domain.

I'll be happy to do either of these, but I wanted to gather opinions before
that.

Testing
=======

Performance has been rather annoying to measure. I used to have
some improvements on Juno (between 1% to 2%) and just noise on Xeon with my
previous base - some tip/sched/core around 5.4-rc7. This has somehow changed
with v5.5-rc1. The baseline also got about 2% worse (on Juno), I'll go and try
to bisect this but I've been sitting on this for a while so I wanted to toss it
out.

Juno r0
-------

SD levels are {MC, DIE}.
500 iterations of $(hackbench):

  |       |   -PATCH |   +PATCH | DELTA (%) |
  |-------+----------+----------+-----------|
  | count |      500 |      500 |           |
  | mean  | 0.630625 | 0.628632 |    -0.316 |
  | std   | 0.022276 | 0.024253 |    +8.875 |
  | min   | 0.584000 | 0.580000 |    -0.685 |
  | 50%   | 0.629000 | 0.625000 |    -0.636 |
  | 95%   | 0.666000 | 0.674000 |    +1.201 |
  | 99%   | 0.703000 | 0.699000 |    -0.569 |
  | max   | 0.748000 | 0.722000 |    -3.476 |

I also tried pinning that to a single type of CPUs to reduce the 'noise'
of asymmetric scheduling, this is 500 iterations of
$(taskset -c 0,3-5 hackbench) (IOW LITTLEs only):

  |       |   -PATCH |   +PATCH | DELTA (%) |
  |-------+----------+----------+-----------|
  | count |      500 |      500 |           |
  | mean  | 1.092194 | 1.084328 |    -0.720 |
  | std   | 0.046710 | 0.049637 |    +6.266 |
  | min   | 1.017000 | 1.004000 |    -1.278 |
  | 50%   | 1.079000 | 1.072000 |    -0.649 |
  | 95%   | 1.177100 | 1.173300 |    -0.323 |
  | 99%   | 1.273060 | 1.261130 |    -0.937 |
  | max   | 1.342000 | 1.305000 |    -2.757 |

Dual-socket Xeon E5
-------------------

That is 10 cores w/ SMT2 per socket. SD levels are {SMT, MC, NUMA}.
500 iterations of $(hackbench -l 1000):

  |       |   -PATCH |   +PATCH | DELTA (%) |
  |-------+----------+----------+-----------|
  | count |      500 |      500 |           |
  | mean  | 0.949278 | 0.946502 |    -0.292 |
  | std   | 0.006402 | 0.006784 |    +5.967 |
  | min   | 0.924000 | 0.921000 |    -0.325 |
  | 50%   | 0.950000 | 0.947000 |    -0.316 |
  | 95%   | 0.959000 | 0.957000 |    -0.209 |
  | 99%   | 0.963000 | 0.960010 |    -0.310 |
  | max   | 0.966000 | 0.963000 |    -0.311 |

Notes
=====

One thing of note is that we are considering getting rid of SD_BALANCE_WAKE
for asymmetric systems, which are the last remaining (upstream) users of
that flag. This would lower the usefulness of this series; nevertheless I
think the cleanup (or at least part of it) is worth it.


Valentin Schneider (7):
  sched: Add WF_TTWU, WF_EXEC wakeup flags
  sched: Kill select_task_rq()'s sd_flag parameter
  sched/fair: find_idlest_group(): Remove unused sd_flag parameter
  sched/fair: Dissociate wakeup decisions from SD flag value
  sched/topology: Make {lowest/highest}_flag_domain() work with > 1
    flags
  sched/fair: Split select_task_rq_fair want_affine logic
  sched/topology: Define and use shortcut pointers for wakeup sd_flag
    scan

 kernel/sched/core.c      | 10 +++----
 kernel/sched/deadline.c  |  4 +--
 kernel/sched/fair.c      | 61 +++++++++++++++++++++++++---------------
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 +--
 kernel/sched/sched.h     | 36 ++++++++++++++++--------
 kernel/sched/stop_task.c |  2 +-
 kernel/sched/topology.c  | 20 ++++++++++---
 8 files changed, 91 insertions(+), 48 deletions(-)

--
2.24.0

