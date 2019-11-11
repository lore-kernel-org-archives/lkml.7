Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD14C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E4E21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKKVyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:54:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:47573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfKKVyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:54:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 13:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="229058774"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.25])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2019 13:54:39 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix inaccurate period in context switch for auto-reload
Date:   Mon, 11 Nov 2019 13:54:00 -0800
Message-Id: <20191111215400.32747-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf doesn't take the left period into account when auto-reload is
enabled with fixed period sampling mode in context switch.
Here is the ftrace when recording PEBS event with fixed period.

    #perf record -e cycles:p -c 2000000 -- ./triad_loop

      //Task is scheduled out
      triad_loop-17222 [000] d... 861765.878032: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0  //Disable global counter
      triad_loop-17222 [000] d... 861765.878033: write_msr:
MSR_IA32_PEBS_ENABLE(3f1), value 0       //Disable PEBS
      triad_loop-17222 [000] d... 861765.878033: write_msr:
MSR_P6_EVNTSEL0(186), value 40003003c    //Disable the counter
      triad_loop-17222 [000] d... 861765.878033: rdpmc: 0, value
fffffff82840                             //Read value of the counter
      triad_loop-17222 [000] d... 861765.878034: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 1000f000000ff  //Re-enable global
counter

      //Task is scheduled in again
      triad_loop-17222 [000] d... 861765.878221: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0  //Disable global counter
      triad_loop-17222 [000] d... 861765.878222: write_msr:
MSR_IA32_PMC0(4c1), value ffffffe17b80   //write the value to the
counter; The value is wrong. When the task switch in again, the counter
should starts from previous left. However, it starts from the fixed
period -2000000 again.
      triad_loop-17222 [000] d... 861765.878223: write_msr:
MSR_P6_EVNTSEL0(186), value 40043003c    //enable the counter
      triad_loop-17222 [000] d... 861765.878223: write_msr:
MSR_IA32_PEBS_ENABLE(3f1), value 1       //enable PEBS
      triad_loop-17222 [000] d... 861765.878223: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 1000f000000ff  //Re-enable global
counter

A special variant of intel_pmu_save_and_restart() is used for
auto-reload, which doesn't update the hwc->period_left.
When the monitored task scheduled in again, perf doesn't know the left
period. The user defined fixed period is used, which is inaccurate.

With auto-reload, the counter always has a negative counter value. So
the left period is -value. Update the period_left in
intel_pmu_save_and_restart_reload().

With the patch,
      //Task is scheduled out
      triad_loop-3068  [000] d...   153.680459: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      triad_loop-3068  [000] d...   153.680459: write_msr:
MSR_IA32_PEBS_ENABLE(3f1), value 0
      triad_loop-3068  [000] d...   153.680459: write_msr:
MSR_P6_EVNTSEL0(186), value 40003003c
      triad_loop-3068  [000] d...   153.680459: rdpmc: 0, value
ffffffe25cbc
      triad_loop-3068  [000] d...   153.680460: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

      //Task is scheduled in again
      triad_loop-3068  [000] d...   153.680644: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      triad_loop-3068  [000] d...   153.680646: write_msr:
MSR_IA32_PMC0(4c1), value ffffffe25cbc     //The left value is written
into the counter.
      triad_loop-3068  [000] d...   153.680646: write_msr:
MSR_P6_EVNTSEL0(186), value 40043003c
      triad_loop-3068  [000] d...   153.680646: write_msr:
MSR_IA32_PEBS_ENABLE(3f1), value 1
      triad_loop-3068  [000] d...   153.680647: write_msr:
MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

Fixes: d31fc13fdcb2 ("perf/x86/intel: Fix event update for auto-reload")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce83950036c5..e5ad97a82342 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1713,6 +1713,8 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	old = ((s64)(prev_raw_count << shift) >> shift);
 	local64_add(new - old + count * period, &event->count);
 
+	local64_set(&hwc->period_left, -new);
+
 	perf_event_update_userpage(event);
 
 	return 0;
-- 
2.17.1

