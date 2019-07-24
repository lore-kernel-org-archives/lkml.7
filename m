Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D59C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E2C20840
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGXR1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:27:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:32492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfGXR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:27:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 10:18:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368859086"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.84])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 10:18:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/8] TopDown metrics support for Icelake
Date:   Wed, 24 Jul 2019 10:17:45 -0700
Message-Id: <20190724171753.8087-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Icelake has support for measuring the level 1 TopDown metrics
directly in hardware. This is implemented by an additional METRICS
register, and a new Fixed Counter 3 that measures pipeline SLOTS.

Four TopDown metric events as separate perf events, which map to
internal METRICS register, are exposed. They are topdown-retiring,
topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
Those events do not exist in hardware, but can be allocated by the
scheduler. The value of TopDown metric events can be calculated by
multiplying the METRICS (percentage) register with SLOTS fixed counter.

New in Icelake
- Do not require generic counters. This allows to collect TopDown always
  in addition to other events.
- Measuring TopDown per thread/process instead of only per core

Limitation
- To get accurate result and avoid reading the METRICS register multiple
  times, the TopDown metrics events and SLOTS event have to be in the
  same group.
- METRICS and SLOTS registers have to be cleared after each read by SW.
  That is to prevent the lose of precision and a known side effect of
  METRICS register.
- Cannot do sampling read SLOTS and TopDown metric events

Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
TopDown metrics.

Changes since V2:
- Rebase on top of v5.3-rc1

Key changes since V1:
- Remove variables for reg_idx and enabled_events[] array.
  The reg_idx can be calculated by idx in runtime.
  Using existing active_mask to replace enabled_events.
- Choose value 47 for the fixed index of BTS.
- Support OVF_PERF_METRICS overflow bit in PMI handler
- Drops the caching mechanism and related variables
  New mechanism is to update all active slots/metrics events for the
  first slots/metrics events in a group. For each group reading, it
  still only read the slots/perf_metrics MSR once
- Disable PMU for read of topdown events to avoid the NMI issue
- Move RDPMC support to a separate patch
- Using event=0x00,umask=0x1X for topdown metrics events
- Drop the patch which add REMOVE transaction
  We can indicate x86_pmu_stop() by checking
  (event && !test_bit(event->hw.idx, cpuc->active_mask)),
  which is a good place to save the slots/metrics MSR value

Andi Kleen (2):
  perf, tools, stat: Support new per thread TopDown metrics
  perf, tools: Add documentation for topdown metrics

Kan Liang (6):
  perf/x86/intel: Set correct mask for TOPDOWN.SLOTS
  perf/x86/intel: Basic support for metrics counters
  perf/x86/intel: Support hardware TopDown metrics
  perf/x86/intel: Support per thread RDPMC TopDown metrics
  perf/x86/intel: Export TopDown events for Icelake
  perf/x86/intel: Disable sampling read slots and topdown

 arch/x86/events/core.c                 |  35 ++-
 arch/x86/events/intel/core.c           | 362 ++++++++++++++++++++++++-
 arch/x86/events/perf_event.h           |  33 +++
 arch/x86/include/asm/msr-index.h       |   3 +
 arch/x86/include/asm/perf_event.h      |  54 +++-
 include/linux/perf_event.h             |   3 +
 tools/perf/Documentation/perf-stat.txt |   9 +-
 tools/perf/Documentation/topdown.txt   | 223 +++++++++++++++
 tools/perf/builtin-stat.c              |  24 ++
 tools/perf/util/stat-shadow.c          |  89 ++++++
 tools/perf/util/stat.c                 |   4 +
 tools/perf/util/stat.h                 |   8 +
 12 files changed, 827 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/Documentation/topdown.txt

-- 
2.17.1

