Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60494C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262B420828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfDANBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:01:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:60535 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDANBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:01:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 06:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="147005075"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Apr 2019 06:01:36 -0700
Received: from [10.254.82.10] (kliang2-mobl.ccr.corp.intel.com [10.254.82.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 441F5580435;
        Mon,  1 Apr 2019 06:01:35 -0700 (PDT)
Subject: Re: [PATCH V4 00/23] perf: Add Icelake support
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f8c734ff-43b7-894b-419f-6f2cda85e10d@linux.intel.com>
Date:   Mon, 1 Apr 2019 09:01:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190326160901.4887-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Thomas,

Have you got a chance to review this series?

Any comments are very appreciated.

Thanks,
Kan

On 3/26/2019 12:08 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The patch series intends to add Icelake support for Linux perf.
> 
> PATCH 1-18: Kernel patches to support Icelake.
>   - 1-5: Support adaptive PEBS feature
>   - 6-7: Enable core support with some new features, e.g. 8 generic
>     counters, new event constraints, a new fixed counter.
>   - 8-11: Enable cstate, rapl, msr and uncore support on Icelake
>   - 12-18: Support hardware Metrics counters and SLOT fixed counter for
>     Topdown events.
>   - 19: Support CPUID 10.ECX to disable fixed counters
> 
> PATCH 20-23: Perf tool patches to support XMM, Topdown and event list.
> 
> Changes since V3:
> - Keep the old names for GPRs. Rename PERF_REG_X86_MAX to
>    PERF_REG_X86_XMM_MAX
> - Remove unnecessary REG_RESERVED
> - Add REG_NOSUPPORT for 32bit
> 
> Changes since V2:
> - Make the setup_pebs_sample_data() a function pointer argument
> - Use cpuc->pebs_record_size unconditionally
> - Add comments for EVENT_CONSTRAINT_RANGE
> - Correct the Author of "perf/x86: Support constraint ranges"
> 
> Changes since V1:
> - Avoid the interface changes for perf_reg_value() and
>    perf_output_sample_regs().
> - Remove the extra_regs in struct perf_sample_data.
> - Add struct x86_perf_regs
> - Add has_xmm_regs to indicate the specific platform which support XMM
>    registers collection.
> - Add check in x86_pmu_hw_config() to reject invalid config of regs_user
>    and regs_intr.
> - Rename intel_hsw_weight and intel_hsw_transaction
> - Add missed inline for intel_get_tsx_transaction()
> - Add new patch to extract code of event update in short period
> - Code rebase on top of c634dc6bdede
> - Rename @d to pebs_data_cfg
> - Make pebs_update_adaptive_cfg readable
> - Clear pebs_data_cfg and pebs_record_size for first PEBS in add
> - Don't clear ICL_EVENTSEL_ADAPTIVE. Rely on MSR_PEBS_CFG settings
> - Change PEBS record parsing order (bug fix)
> - Support struct x86_perf_regs
> - make get_pebs_status generic
> - specific intel_pmu_drain_pebs_icl()
> - Use cpuc->pebs_record_size to replace format_size
> - Use 'size' to replace 'range_end' for constraint ranges
> - Add x86_pmu.has_xmm_regs = true;
> - Add more explanation in change log of REMOVE transaction
> - Make perf_regs.h consistent between kernel and user space
> 
> Andi Kleen (11):
>    perf/x86/intel: Extract memory code PEBS parser for reuse
>    perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them
>    perf/core: Support a REMOVE transaction
>    perf/x86/intel: Basic support for metrics counters
>    perf/x86/intel: Support overflows on SLOTS
>    perf/x86/intel: Set correct weight for topdown subevent counters
>    perf/x86/intel: Export new top down events for Icelake
>    perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
>    perf, tools: Add support for recording and printing XMM registers
>    perf, tools, stat: Support new per thread TopDown metrics
>    perf, tools: Add documentation for topdown metrics
> 
> Kan Liang (11):
>    perf/x86: Support outputting XMM registers
>    perf/x86/intel/ds: Extract code of event update in short period
>    perf/x86/intel: Support adaptive PEBSv4
>    perf/x86/intel: Add Icelake support
>    perf/x86/intel/cstate: Add Icelake support
>    perf/x86/intel/rapl: Add Icelake support
>    perf/x86/msr: Add Icelake support
>    perf/x86/intel/uncore: Add Intel Icelake uncore support
>    perf/x86/intel: Support hardware TopDown metrics
>    perf/x86/intel: Disable sampling read slots and topdown
>    perf vendor events intel: Add JSON files for Icelake
> 
> Peter Zijlstra (1):
>    perf/x86: Support constraint ranges
> 
>   arch/x86/events/core.c                        |  81 +-
>   arch/x86/events/intel/core.c                  | 422 ++++++++-
>   arch/x86/events/intel/cstate.c                |   2 +
>   arch/x86/events/intel/ds.c                    | 496 ++++++++--
>   arch/x86/events/intel/lbr.c                   |  35 +-
>   arch/x86/events/intel/rapl.c                  |   2 +
>   arch/x86/events/intel/uncore.c                |   6 +
>   arch/x86/events/intel/uncore.h                |   1 +
>   arch/x86/events/intel/uncore_snb.c            |  91 ++
>   arch/x86/events/msr.c                         |   1 +
>   arch/x86/events/perf_event.h                  |  93 +-
>   arch/x86/include/asm/intel_ds.h               |   2 +-
>   arch/x86/include/asm/msr-index.h              |   4 +
>   arch/x86/include/asm/perf_event.h             |  79 +-
>   arch/x86/include/uapi/asm/perf_regs.h         |  23 +-
>   arch/x86/kernel/perf_regs.c                   |  27 +-
>   include/linux/perf_event.h                    |   7 +
>   kernel/events/core.c                          |   5 +
>   tools/arch/x86/include/uapi/asm/perf_regs.h   |  23 +-
>   tools/perf/Documentation/perf-stat.txt        |   9 +-
>   tools/perf/Documentation/topdown.txt          | 223 +++++
>   tools/perf/arch/x86/include/perf_regs.h       |  25 +-
>   tools/perf/arch/x86/util/perf_regs.c          |  16 +
>   tools/perf/builtin-stat.c                     |  24 +
>   .../pmu-events/arch/x86/icelake/cache.json    | 552 +++++++++++
>   .../arch/x86/icelake/floating-point.json      |  90 ++
>   .../pmu-events/arch/x86/icelake/frontend.json | 424 +++++++++
>   .../pmu-events/arch/x86/icelake/memory.json   | 410 ++++++++
>   .../pmu-events/arch/x86/icelake/other.json    | 133 +++
>   .../pmu-events/arch/x86/icelake/pipeline.json | 892 ++++++++++++++++++
>   .../arch/x86/icelake/virtual-memory.json      | 236 +++++
>   tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>   tools/perf/util/perf_regs.h                   |   1 +
>   tools/perf/util/stat-shadow.c                 |  89 ++
>   tools/perf/util/stat.c                        |   4 +
>   tools/perf/util/stat.h                        |   8 +
>   36 files changed, 4418 insertions(+), 119 deletions(-)
>   create mode 100644 tools/perf/Documentation/topdown.txt
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/cache.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/floating-point.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/frontend.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/memory.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/other.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/pipeline.json
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
> 
