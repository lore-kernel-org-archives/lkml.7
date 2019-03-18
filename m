Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FAF2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCRVoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:44:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:57586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfCRVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:44:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="308301764"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:44:08 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/22] perf: Add Icelake support
Date:   Mon, 18 Mar 2019 14:41:22 -0700
Message-Id: <20190318214144.4639-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The patch series intends to add Icelake support for Linux perf.

PATCH 1-18: Kernel patches to support Icelake.
 - 1-4: Support adaptive PEBS feature
 - 5-6: Enable core support with some new features, e.g. 8 generic
   counters, new event constraints, a new fixed counter.
 - 7-10: Enable cstate, rapl, msr and uncore support on Icelake
 - 11-17: Support hardware Metrics counters and SLOT fixed counter for
   Topdown events.
 - 18: Support CPUID 10.ECX to disable fixed counters

PATCH 19-22: Perf tool patches to support XMM, Topdown and event list.

Andi Kleen (13):
  perf/core: Support outputting registers from a separate array
  perf/x86/intel: Extract memory code PEBS parser for reuse
  perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them
  perf/x86: Support constraint ranges
  perf/core: Support a REMOVE transaction
  perf/x86/intel: Basic support for metrics counters
  perf/x86/intel: Support overflows on SLOTS
  perf/x86/intel: Set correct weight for topdown subevent counters
  perf/x86/intel: Export new top down events for Icelake
  perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
  perf, tools: Add support for recording and printing XMM registers
  perf, tools, stat: Support new per thread TopDown
  perf, tools: Add documentation for topdown metrics

Kan Liang (9):
  perf/x86/intel: Support adaptive PEBSv4
  perf/x86/intel: Add Icelake support
  perf/x86/intel/cstate: Add Icelake support
  perf/x86/intel/rapl: Add Icelake support
  perf/x86/msr: Add Icelake support
  perf/x86/intel/uncore: Add Intel Icelake uncore support
  perf/x86/intel: Support hardware TopDown metrics
  perf/x86/intel: Disable sampling read slots and topdown
  perf vendor events intel: Add JSON files for Icelake

 arch/arm/kernel/perf_regs.c                   |   2 +-
 arch/arm64/kernel/perf_regs.c                 |   2 +-
 arch/powerpc/perf/perf_regs.c                 |   2 +-
 arch/s390/kernel/perf_regs.c                  |   2 +-
 arch/x86/events/core.c                        |  71 +-
 arch/x86/events/intel/core.c                  | 421 ++++++++-
 arch/x86/events/intel/cstate.c                |   2 +
 arch/x86/events/intel/ds.c                    | 382 +++++++-
 arch/x86/events/intel/lbr.c                   |  35 +-
 arch/x86/events/intel/rapl.c                  |   2 +
 arch/x86/events/intel/uncore.c                |   6 +
 arch/x86/events/intel/uncore.h                |   1 +
 arch/x86/events/intel/uncore_snb.c            |  91 ++
 arch/x86/events/msr.c                         |   1 +
 arch/x86/events/perf_event.h                  |  88 ++
 arch/x86/include/asm/intel_ds.h               |   2 +-
 arch/x86/include/asm/msr-index.h              |   4 +
 arch/x86/include/asm/perf_event.h             |  74 +-
 arch/x86/include/uapi/asm/perf_regs.h         |  25 +-
 arch/x86/kernel/perf_regs.c                   |  17 +-
 include/linux/perf_event.h                    |   9 +
 include/linux/perf_regs.h                     |   4 +-
 kernel/events/core.c                          |  12 +-
 tools/arch/x86/include/uapi/asm/perf_regs.h   |  19 +
 tools/perf/Documentation/perf-stat.txt        |   9 +-
 tools/perf/Documentation/topdown.txt          | 223 +++++
 tools/perf/arch/x86/include/perf_regs.h       |  27 +-
 tools/perf/arch/x86/util/perf_regs.c          |  16 +
 tools/perf/builtin-stat.c                     |  24 +
 .../pmu-events/arch/x86/icelake/cache.json    | 552 +++++++++++
 .../arch/x86/icelake/floating-point.json      |  90 ++
 .../pmu-events/arch/x86/icelake/frontend.json | 424 +++++++++
 .../pmu-events/arch/x86/icelake/memory.json   | 410 ++++++++
 .../pmu-events/arch/x86/icelake/other.json    | 133 +++
 .../pmu-events/arch/x86/icelake/pipeline.json | 892 ++++++++++++++++++
 .../arch/x86/icelake/virtual-memory.json      | 236 +++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 tools/perf/util/perf_regs.h                   |   1 +
 tools/perf/util/stat-shadow.c                 |  89 ++
 tools/perf/util/stat.c                        |   4 +
 tools/perf/util/stat.h                        |   8 +
 41 files changed, 4311 insertions(+), 102 deletions(-)
 create mode 100644 tools/perf/Documentation/topdown.txt
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json

-- 
2.17.1

