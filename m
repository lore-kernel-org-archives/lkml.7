Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C5C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D97D21D71
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfI3Ms0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:48:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:64485 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfI3Ms0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:48:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 05:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,567,1559545200"; 
   d="scan'208";a="220640459"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2019 05:48:25 -0700
Received: from [10.251.2.197] (kliang2-mobl.ccr.corp.intel.com [10.251.2.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4A9E35803FA;
        Mon, 30 Sep 2019 05:48:24 -0700 (PDT)
Subject: Re: [PATCH V4 00/14] TopDown metrics support for Icelake
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190916134128.18120-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <89a2f460-a7ec-6455-b153-f94b7f3f87d0@linux.intel.com>
Date:   Mon, 30 Sep 2019 08:48:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916134128.18120-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you please take a look at the patch set?

Thanks,
Kan

On 9/16/2019 9:41 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Icelake has support for measuring the level 1 TopDown metrics
> directly in hardware. This is implemented by an additional METRICS
> register, and a new Fixed Counter 3 that measures pipeline SLOTS.
> 
> For the Ice Lake implementation of performance metrics, software
> should start both PERF_METRICS and fixed counter 3 from zero.
> Additionally, for certain scenarios that involve counting metrics at
> high rates, software is recommended to periodically clear both in
> order to maintain accurate measurements.
> 
> IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
> it indicates that some PERF_METRICS-related counter has overflowed and
> a PMI is triggered. It is recommended to clear PERF_METRICS as well as
> fixed counter 3 in such case. However, an overflow of fixed counter 3
> should normally happen first. If this bit is clear, no such overflow has
> occurred.
> 
> New in Icelake
> - Do not require generic counters. This allows to collect TopDown always
>    in addition to other events.
> - Measuring TopDown per thread/process instead of only per core
> 
> Limitation
> - To get accurate result and avoid reading the METRICS register multiple
>    times, the TopDown metrics events and SLOTS event have to be in the
>    same group.
> - METRICS and SLOTS registers have to be cleared after each read by SW.
>    That is to prevent the lose of precision.
> - Cannot do sampling read SLOTS and TopDown metric events
> 
> Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
> TopDown metrics.
> 
> Changes since V3:
> - Separate fixed counter3 definition patch
> - Separate BTS index patch
> - Apply Peter's cleanup patch
> - Fix the name of perf capabilities for perf METRICS
> - Apply patch for mul_u64_u32_div() x86_64 implementation
> - Fix unconditionally allows collecting 4 extra events
> - Add patch to clean up NMI handler by naming global status bit
> - Add patch to reuse event_base_rdpmc for RDPMC userspace support
> 
> Changes since V2:
> - Rebase on top of v5.3-rc1
> 
> Key changes since V1:
> - Remove variables for reg_idx and enabled_events[] array.
>    The reg_idx can be calculated by idx in runtime.
>    Using existing active_mask to replace enabled_events.
> - Choose value 47 for the fixed index of BTS.
> - Support OVF_PERF_METRICS overflow bit in PMI handler
> - Drops the caching mechanism and related variables
>    New mechanism is to update all active slots/metrics events for the
>    first slots/metrics events in a group. For each group reading, it
>    still only read the slots/perf_metrics MSR once
> - Disable PMU for read of topdown events to avoid the NMI issue
> - Move RDPMC support to a separate patch
> - Using event=0x00,umask=0x1X for topdown metrics events
> - Drop the patch which add REMOVE transaction
>    We can indicate x86_pmu_stop() by checking
>    (event && !test_bit(event->hw.idx, cpuc->active_mask)),
>    which is a good place to save the slots/metrics MSR value
> 
> Andi Kleen (2):
>    perf, tools, stat: Support new per thread TopDown metrics
>    perf, tools: Add documentation for topdown metrics
> 
> Kan Liang (11):
>    perf/x86/intel: Introduce the fourth fixed counter
>    perf/x86/intel: Set correct mask for TOPDOWN.SLOTS
>    perf/x86/intel: Move BTS index to 47
>    perf/x86/intel: Basic support for metrics counters
>    perf/x86/intel: Fix the name of perf capabilities for perf METRICS
>    perf/x86/intel: Support hardware TopDown metrics
>    perf/x86/intel: Support per thread RDPMC TopDown metrics
>    perf/x86/intel: Export TopDown events for Icelake
>    perf/x86/intel: Disable sampling read slots and topdown
>    perf/x86/intel: Name global status bit in NMI handler
>    perf/x86: Use event_base_rdpmc for RDPMC userspace support
> 
> Peter Zijlstra (Intel) (1):
>    x86/math64: Provide a sane mul_u64_u32_div() implementation for x86_64
> 
>   arch/x86/events/core.c                 |  80 ++++-
>   arch/x86/events/intel/core.c           | 421 +++++++++++++++++++++++--
>   arch/x86/events/perf_event.h           |  57 +++-
>   arch/x86/include/asm/div64.h           |  13 +
>   arch/x86/include/asm/msr-index.h       |   3 +
>   arch/x86/include/asm/perf_event.h      |  48 ++-
>   include/linux/perf_event.h             |   3 +
>   tools/perf/Documentation/perf-stat.txt |   9 +-
>   tools/perf/Documentation/topdown.txt   | 223 +++++++++++++
>   tools/perf/builtin-stat.c              |  24 ++
>   tools/perf/util/stat-shadow.c          |  89 ++++++
>   tools/perf/util/stat.c                 |   4 +
>   tools/perf/util/stat.h                 |   8 +
>   13 files changed, 924 insertions(+), 58 deletions(-)
>   create mode 100644 tools/perf/Documentation/topdown.txt
> 
