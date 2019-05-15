Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14423C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9F120818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEOVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:02:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:15270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEOVCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:02:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 14:02:02 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 14:02:02 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, mark.rutland@arm.com,
        irogers@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/4] Optimize cgroup context switch
Date:   Wed, 15 May 2019 14:01:28 -0700
Message-Id: <1557954092-67275-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Add new event_type to indicate cgroup only switch
  Add cgrp_event_type to track event type of a cgroup
  Extend ctx_pinned/flexible_sched_in and struct sched_in_data to pass
  the event_type
- If the new cgroup has pinned events, schedule out all flexible events
  before sched in all events.
- Add macro and helper function to replace duplicated content in patch 1
- Add new RB tree keys, cgrp_id and cgrp_group_index, for cgroup.
  Now, cgrp_id is the same as css subsys-unique ID.
- Add per-cpu pinned/flexible_event in perf_cgroup to track the left most
  event for a cgroup.
- Add per-cpu rotated_event in perf_cgroup to handle multiplexing.
  Disable fast path for multiplexing.
- Support hierarchies
- Update test result. Test with different hierarchy.


On systems with very high context switch rates between cgroups,
there are high overhead using cgroup perf.

Current codes have two issues.
- System-wide events are mistakenly switched in cgroup
  context switch. It causes system-wide events miscounting,
  and brings avoidable overhead.
  Patch 1 fixes the issue.
- The cgroup context switch sched_in is low efficient.
  All cgroup events share the same per-cpu pinned/flexible groups.
  The RB trees for pinned/flexible groups don't understand cgroup.
  Current code has to traverse all events, and use event_filter_match()
  to filter the events for specific cgroup.
  Patch 2-4 adds a fast path for cgroup context switch sched_in by
  training the RB tree to understand cgroup. The extra filtering
  can be avoided.


Here is test with 6 child cgroups (sibling cgroups), 1 parent cgroup
and system-wide events.
A specjbb benchmark is running in each child cgroup.
The perf command is as below.
   perf stat -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions
   -G cgroup1,cgroup1,cgroup2,cgroup2,cgroup3,cgroup3
   -G cgroup4,cgroup4,cgroup5,cgroup5,cgroup6,cgroup6
   -G cgroup_parent,cgroup_parent
   -a -e cycles,instructions -I 1000

The average RT (Response Time) reported from specjbb is
used as key performance metrics. (The lower the better)

                                        RT(us)              Overhead
Baseline (no perf stat):                4286.9
Use cgroup perf, no patches:            4537.1                5.84%
Use cgroup perf, apply patch 1:         4440.7                3.59%
Use cgroup perf, apple all patches:     4403.5                2.72%

Kan Liang (4):
  perf: Fix system-wide events miscounting during cgroup monitoring
  perf: Add filter_match() as a parameter for pinned/flexible_sched_in()
  perf cgroup: Add new RB tree keys for cgroup
  perf cgroup: Add fast path for cgroup switch

 include/linux/perf_event.h |   6 +
 kernel/events/core.c       | 427 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 394 insertions(+), 39 deletions(-)

-- 
2.7.4

