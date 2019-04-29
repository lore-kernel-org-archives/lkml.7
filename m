Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8640620656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfD2OpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:45:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:1324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfD2OpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:45:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 07:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="154739482"
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2019 07:45:17 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, tj@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/4] Optimize cgroup context switch
Date:   Mon, 29 Apr 2019 07:44:01 -0700
Message-Id: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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


Here is test with 6 cgroups running.
Each cgroup has a specjbb benchmark running.
The perf command is as below.
   perf stat -e cycles,instructions -e cycles,instructions
   -e cycles,instructions -e cycles,instructions 
   -e cycles,instructions -e cycles,instructions
   -G cgroup1,cgroup1,cgroup2,cgroup2,cgroup3,cgroup3
   -G cgroup4,cgroup4,cgroup5,cgroup5,cgroup6,cgroup6
   -a -e cycles,instructions -I 1000

The average RT (Response Time) reported from specjbb is
used as key performance metrics. (The lower the better)

                                        RT(us)              Overhead
Baseline (no perf stat):                4286.9
Use cgroup perf, no patches:            4483.6                4.6%
Use cgroup perf, apply patch 1:         4369.2                1.9%
Use cgroup perf, apple all patches:     4335.3                1.1%

Kan Liang (4):
  perf: Fix system-wide events miscounting during cgroup monitoring
  perf: Add filter_match() as a parameter for pinned/flexible_sched_in()
  perf cgroup: Add cgroup ID as a key of RB tree
  perf cgroup: Add fast path for cgroup switch

 include/linux/perf_event.h |   7 ++
 kernel/events/core.c       | 171 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.7.4

