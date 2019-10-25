Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9590CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE8D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406381AbfJYIfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:35:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:37801 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404179AbfJYIfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:35:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="210334040"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 01:35:50 -0700
Received: from [10.125.252.238] (unknown [10.125.252.238])
        by linux.intel.com (Postfix) with ESMTP id A54DE580104;
        Fri, 25 Oct 2019 01:35:47 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v5 0/4] perf/core: fix restoring of Intel LBR call stack on a
 context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Date:   Fri, 25 Oct 2019 11:35:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Restore Intel LBR call stack from cloned inactive task perf context on
a context switch. This change inherently addresses inconsistency in LBR 
call stack data provided on a sample in record profiling mode:

  $ perf record -N -B -T -R --call-graph lbr \
         -e cpu/period=0xcdfe60,event=0x3c,name=\'CPU_CLK_UNHALTED.THREAD\'/Duk \
         --clockid=monotonic_raw -- ./miniFE.x nx 25 ny 25 nz 25

Let's assume threads A, B, C belonging to the same process. 
B and C are siblings of A and their perf contexts are treated as equivalent.
At some point B blocks on a futex (non preempt context switch).
B's LBRs are preserved at B's perf context task_ctx_data and B's events 
are removed from PMU and disabled. B's perf context becomes inactive.

Later C gets on a cpu, runs, gets profiled and eventually switches to 
the awaken but not yet running B. The optimized context switch path is 
executed swapping B's and C's task_ctx_data pointers at perf event contexts.
So C's task_ctx_data will refer preserved B's LBRs on the following 
switch-in event.

However, as far B's perf context is inactive there is no enabled events
in there and B's task_ctx_data->lbr_callstack_users is equal to 0.
When B gets on the cpu B's events reviving is skipped following
the optimized context switch path and B's task_ctx_data->lbr_callstack_users
remains 0. Thus B's LBR's are not restored by pmu sched_task() code called 
in the end of perf context switch-in callback for B.

In the report that manifests as having short fragments of B's
call stack, still tracked by LBR's HW between adjacent samples,
but the whole thread call tree doesn't aggregate.

The fix has been evaluated when profiling miniFE [1] (C++, OpenMP)
workload running 64 threads on Intel Skylake EP (64 core, 2 sockets):

  $ perf report --call-graph callee,flat

5.3.0-rc6+ (tip perf/core) - fixed

-   92.66%    82.64%  miniFE.x  libiomp5.so         [.] _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
   - 69.14% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_fork_barrier
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone
   - 21.89% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        miniFE::cg_solve<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, int>, miniFE::matvec_std<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, in
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone
   - 1.63% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        main
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone

5.0.13-300.fc30.x86_64 - no fix

-   90.29%    81.01%  miniFE.x  libiomp5.so         [.] _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
   - 33.45% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_fork_barrier
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone
     87.63% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
   - 54.79% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_fork_barrier
        __kmp_launch_thread
   - 9.18% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        miniFE::cg_solve<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, int>, miniFE::matvec_std<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, in
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone
   - 41.28% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_fork_barrier
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
   - 15.77% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        miniFE::cg_solve<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, int>, miniFE::matvec_std<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, in
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
   - 11.56% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        miniFE::cg_solve<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, int>, miniFE::matvec_std<miniFE::CSRMatrix<double, int, int>, miniFE::Vector<double, int, in
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
   - 2.33% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_release
        __kmp_barrier
        __kmpc_reduce_nowait
        main
        __kmp_invoke_microtask
        __kmp_invoke_task_func
        __kmp_launch_thread
        _INTERNAL_24_______src_z_Linux_util_c_3e0095e6::__kmp_launch_worker
        start_thread
        __clone
     0.67% _INTERNAL_25_______src_kmp_barrier_cpp_1d20fae8::__kmp_hyper_barrier_gather
     0.57% __kmp_hardware_timestamp

[1] https://www.hpcadvisorycouncil.com/pdf/miniFE_Analysis_and_Profiling.pdf

---
Alexey Budankov (4):
  perf/core,x86: introduce swap_task_ctx() method at struct pmu
  perf/x86: install platform specific swap_task_ctx adapter
  perf/x86/intel: implement LBR callstacks context synchronization
  perf/core,x86: synchronize PMU task contexts on optimized context switches

 arch/x86/events/core.c       |  8 ++++++++
 arch/x86/events/intel/core.c |  7 +++++++
 arch/x86/events/intel/lbr.c  | 23 +++++++++++++++++++++++
 arch/x86/events/perf_event.h | 11 +++++++++++
 include/linux/perf_event.h   |  9 +++++++++
 kernel/events/core.c         | 13 ++++++++++++-
 6 files changed, 70 insertions(+), 1 deletion(-)

---
Changes in v5:
- renamed sync_task_ctx to swap_task_ctx;
- converted type of prev and next swap_task_ctx() params to struct perf_event_context;
- implemented check on availability of swap_task_ctx() pointer in pmu type
  at perf core implementation;
- moved swap of ctx->task_ctx_data pointers to architecture specific
  intel_pmu_lbr_swap_task_ctx() implementation;

Changes in v4:
- moved check on simultaneous task_ctx_data objects availability 
  to the perf/core layer;
- marked sync_task_ctx() as the optional in code comments;
- renamed params of sync_task_ctx() to prev and next;

Changes in v3:
- replaced assignment with swap at intel_pmu_lbr_sync_task_ctx()

Changes in v2:
- implemented sync_task_ctx() method at perf,x86,intel pmu types;
- employed the method on the optimized context switch path between 
  equivalent perf event contexts;

-- 
2.20.1

