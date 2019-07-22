Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA52C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057BA21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGVReB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:01 -0400
Received: from shelob.surriel.com ([96.67.55.147]:37644 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGVReB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:01 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hpcC7-0003HL-TG; Mon, 22 Jul 2019 13:33:51 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org
Subject: [PATCH RFC v3 0/14] sched,fair: flatten CPU controller runqueues
Date:   Mon, 22 Jul 2019 13:33:34 -0400
Message-Id: <20190722173348.9241-1-riel@surriel.com>
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

My main TODO items for the next period of time are likely going to
be testing, testing, and testing. I hope to find and flush out any
corner case I can find, and make sure performance does not regress
with any workloads, and hopefully improves some.

Other TODO items:
- More code cleanups.
- Remove some more now unused code.
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


Changes from v2:
- fixed the web server performance regression, in a way vaguely similar
  to what Josef Bacik suggested (blame me for the implementation)
- removed some code duplication so the diffstat is redder than before
- propagate sum_exec_runtime up the tree, in preparation for CFS_BANDWIDTH
- small cleanups left and right

Changes from v1:
- use task_se_h_weight instead of task_se_h_load in calc_delta_fair
  and sched_slice, this seems to improve performance a little, but
  I still have some remaining regression to chase with our web server
  workload
- implement a number of the changes suggested by Dietmar Eggemann
  (still holding out for a better name for group_cfs_rq_of_parent)

This series applies on top of 5.2

 include/linux/sched.h |    7 
 kernel/sched/core.c   |    3 
 kernel/sched/debug.c  |   17 -
 kernel/sched/fair.c   |  780 ++++++++++++++++++++------------------------------
 kernel/sched/pelt.c   |   69 ++--
 kernel/sched/pelt.h   |    3 
 kernel/sched/sched.h  |   11 
 7 files changed, 372 insertions(+), 518 deletions(-)


