Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2024215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfFLTcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:32:41 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50378 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:32:40 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hb8z1-0001BN-Pi; Wed, 12 Jun 2019 15:32:31 -0400
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
Subject: [RFC] sched,cfs: flatten CPU controller runqueues
Date:   Wed, 12 Jun 2019 15:32:19 -0400
Message-Id: <20190612193227.993-1-riel@surriel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the CPU controller uses hierarchical
runqueues, where on wakeup a task is enqueued on its group's runqueue,
the group is enqueued on the runqueue of the group above it, etc.

This increases a fairly large amount of overhead for workloads that
do a lot of wakeups a second, especially given that the default systemd
hierarchy is 2 or 3 levels deep.

This patch series is an attempt at reducing that overhead, by placing
all the tasks on the same runqueue, and scaling the task priority by
the priority of the group, which is calculated periodically.

This patch series still has a number of TODO items:
- Clean up the code, and fix compilation without CONFIG_FAIR_GROUP_SCHED.
- Remove some more now unused code.
- Figure out a regression with schbench, where the p99 latency goes up
  before the system is fully overloaded. I suspect wakeup_preempt_entity()
  and wakeup_gran() because they now use the task_h_load instead of the
  unscaled load to figure out whether a task should be preempted.
- Reimplement CONFIG_CFS_BANDWIDTH.

Plan for the CONFIG_CFS_BANDWIDTH reimplementation:
- When a cgroup gets throttled, mark the cgroup and its children
  as throttled.
- When pick_next_entity finds a task that is on a throttled cgroup,
  stash it on the cgroup runqueue (which is not used for runnable
  tasks any more). Leave the vruntime unchanged, and adjust that
  runqueue's vruntime to be that of the left-most task.
- When a cgroup gets unthrottled, and has tasks on it, place it on
  a vruntime ordered heap separate from the main runqueue.
- Have pick_next_task_fair grab one task off that heap every time it
  is called, and the min vruntime of that heap is lower than the
  vruntime of the CPU's cfs_rq (or the CPU has no other runnable tasks).
- Place that selected task on the CPU's cfs_rq, renormalizing its
  vruntime with the GENTLE_FAIR_SLEEPERS logic. That should help
  interleave the already runnable tasks with the recently unthrottled
  group, and prevent thundering herd issues.
- If the group gets throttled again before all of its task had a chance
  to run, vruntime sorting ensures all the tasks in the throttled cgroup
  get a chance to run over time.

This patch applies on top of what was Linus's current tree when I last
rebased it:
2c1212de6f97 ("Merge tag 'spdx-5.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core")

 include/linux/sched.h |    5 
 kernel/sched/core.c   |    2 
 kernel/sched/debug.c  |   12 
 kernel/sched/fair.c   |  744 +++++++++++++++++++++-----------------------------
 kernel/sched/pelt.c   |   55 +--
 kernel/sched/pelt.h   |    2 
 kernel/sched/sched.h  |    9 
 7 files changed, 346 insertions(+), 483 deletions(-)


