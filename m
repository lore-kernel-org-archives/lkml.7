Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9B5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F642086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfF1Ut2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:49:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38398 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1Ut1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:49:27 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgxo6-0007TL-CP; Fri, 28 Jun 2019 16:49:18 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org
Subject: [PATCH RFC v2 0/10] sched,fair: flatten CPU controller runqueues
Date:   Fri, 28 Jun 2019 16:49:03 -0400
Message-Id: <20190628204913.10287-1-riel@surriel.com>
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
- Figure out a performance regression with our web server workload.
  I have fixed the schbench issue, now I need to find the less obvious
  stuff causing an increased number of involuntary preemptions...
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

Changes from v1:
- use task_se_h_weight instead of task_se_h_load in calc_delta_fair
  and sched_slice, this seems to improve performance a little, but
  I still have some remaining regression to chase with our web server
  workload
- implement a number of the changes suggested by Dietmar Eggemann
  (still holding out for a better name for group_cfs_rq_of_parent)

This series applies on top of 5.2-rc6.

 include/linux/sched.h |    6 
 kernel/sched/core.c   |    2 
 kernel/sched/debug.c  |   15 -
 kernel/sched/fair.c   |  746 +++++++++++++++++++++-----------------------------
 kernel/sched/pelt.c   |   53 +--
 kernel/sched/pelt.h   |    2 
 kernel/sched/sched.h  |   10 
 7 files changed, 346 insertions(+), 488 deletions(-)


