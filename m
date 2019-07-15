Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FCB20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfGOIIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:08:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:47144 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbfGOIIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:08:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 01:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208,223";a="168885579"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2019 01:08:14 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <jhladky@redhat.com>,
        <lvenanci@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
References: <20190624025604.30896-1-ying.huang@intel.com>
        <20190624140950.GF2947@suse.de>
        <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
        <20190703091747.GA13484@suse.de> <87ef3663nd.fsf@yhuang-dev.intel.com>
        <20190712082710.GH13484@suse.de> <87d0ifwmu2.fsf@yhuang-dev.intel.com>
        <20190712125047.GL13484@suse.de>
Date:   Mon, 15 Jul 2019 16:08:13 +0800
In-Reply-To: <20190712125047.GL13484@suse.de> (Mel Gorman's message of "Fri,
        12 Jul 2019 13:50:47 +0100")
Message-ID: <87v9w3vhxu.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Fri, Jul 12, 2019 at 06:48:05PM +0800, Huang, Ying wrote:
>> > Ordinarily I would hope that the patch was motivated by observed
>> > behaviour so you have a metric for goodness. However, for NUMA balancing
>> > I would typically run basic workloads first -- dbench, tbench, netperf,
>> > hackbench and pipetest. The objective would be to measure the degree
>> > automatic NUMA balancing is interfering with a basic workload to see if
>> > they patch reduces the number of minor faults incurred even though there
>> > is no NUMA balancing to be worried about. This measures the general
>> > overhead of a patch. If your reasoning is correct, you'd expect lower
>> > overhead.
>> >
>> > For balancing itself, I usually look at Andrea's original autonuma
>> > benchmark, NAS Parallel Benchmark (D class usually although C class for
>> > much older or smaller machines) and spec JBB 2005 and 2015. Of the JBB
>> > benchmarks, 2005 is usually more reasonable for evaluating NUMA balancing
>> > than 2015 is (which can be unstable for a variety of reasons). In this
>> > case, I would be looking at whether the overhead is reduced, whether the
>> > ratio of local hits is the same or improved and the primary metric of
>> > each (time to completion for Andrea's and NAS, throughput for JBB).
>> >
>> > Even if there is no change to locality and the primary metric but there
>> > is less scanning and overhead overall, it would still be an improvement.
>> 
>> Thanks a lot for your detailed guidance.
>> 
>
> No problem.
>
>> > If you have trouble doing such an evaluation, I'll queue tests if they
>> > are based on a patch that addresses the specific point of concern (scan
>> > period not updated) as it's still not obvious why flipping the logic of
>> > whether shared or private is considered was necessary.
>> 
>> I can do the evaluation, but it will take quite some time for me to
>> setup and run all these benchmarks.  So if these benchmarks have already
>> been setup in your environment, so that your extra effort is minimal, it
>> will be great if you can queue tests for the patch.  Feel free to reject
>> me for any inconvenience.
>> 
>
> They're not setup as such, but my testing infrastructure is heavily
> automated so it's easy to do and I think it's worth looking at. If you
> update your patch to target just the scan period aspects, I'll queue it
> up and get back to you. It usually takes a few days for the automation
> to finish whatever it's doing and pick up a patch for evaluation.

Thanks a lot for your help!  The updated patch is as follows.  It
targets only the scan period aspects.

Best Regards,
Huang, Ying

----------------------8<----------------------------
From 910a52cbf5a521c1562a573904c9507d0367bb0f Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Sat, 22 Jun 2019 17:36:29 +0800
Subject: [PATCH] autonuma: Fix scan period updating

From the commit log and comments of commit 37ec97deb3a8 ("sched/numa:
Slow down scan rate if shared faults dominate"), the autonuma scan
period should be increased (scanning is slowed down) if the majority
of the page accesses are shared with other processes.  But in current
code, the scan period will be decreased (scanning is speeded up) in
that situation.

The commit log and comments make more sense.  So this patch fixes the
code to make it match the commit log and comments.  And this has been
verified via tracing the scan period changing and /proc/vmstat
numa_pte_updates counter when running a multi-threaded memory
accessing program (most memory areas are accessed by multiple
threads).

Fixes: 37ec97deb3a8 ("sched/numa: Slow down scan rate if shared faults dominate")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: jhladky@redhat.com
Cc: lvenanci@redhat.com
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..468a1c5038b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1940,7 +1940,7 @@ static void update_task_scan_period(struct task_struct *p,
 			unsigned long shared, unsigned long private)
 {
 	unsigned int period_slot;
-	int lr_ratio, ps_ratio;
+	int lr_ratio, sp_ratio;
 	int diff;
 
 	unsigned long remote = p->numa_faults_locality[0];
@@ -1971,22 +1971,22 @@ static void update_task_scan_period(struct task_struct *p,
 	 */
 	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
 	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
-	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
+	sp_ratio = (shared * NUMA_PERIOD_SLOTS) / (private + shared);
 
-	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
+	if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
-		 * Most memory accesses are local. There is no need to
-		 * do fast NUMA scanning, since memory is already local.
+		 * Most memory accesses are shared with other tasks.
+		 * There is no point in continuing fast NUMA scanning,
+		 * since other tasks may just move the memory elsewhere.
 		 */
-		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
+		int slot = sp_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
 			slot = 1;
 		diff = slot * period_slot;
 	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
-		 * Most memory accesses are shared with other tasks.
-		 * There is no point in continuing fast NUMA scanning,
-		 * since other tasks may just move the memory elsewhere.
+		 * Most memory accesses are local. There is no need to
+		 * do fast NUMA scanning, since memory is already local.
 		 */
 		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
@@ -1998,7 +1998,7 @@ static void update_task_scan_period(struct task_struct *p,
 		 * yet they are not on the local NUMA node. Speed up
 		 * NUMA scanning to get the memory moved over.
 		 */
-		int ratio = max(lr_ratio, ps_ratio);
+		int ratio = max(lr_ratio, sp_ratio);
 		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
 	}
 
-- 
2.20.1

