Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B70C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23D32071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKYGEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:04:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:23846 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfKYGEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:04:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 22:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="239391717"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2019 22:04:22 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id 90822580495;
        Sun, 24 Nov 2019 22:04:19 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2 0/3] perf record: adapt NUMA awareness to machines with
 #CPUs > 1K
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
Date:   Mon, 25 Nov 2019 09:04:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Current implementation of cpu_set_t type by glibc has internal cpu
mask size limitation of no more than 1024 CPUs. This limitation confines
NUMA awareness of Perf tool in record mode, thru --affinity option,
to the first 1024 CPUs on machines with larger amount of CPUs.

This patch set enables Perf tool to overcome 1024 CPUs limitation by
using a dedicated struct mmap_cpu_mask type and applying tool's bitmap
API operations to manipulate affinity masks of the tool's thread and
the mmaped data buffers.

tools bitmap API has been extended with bitmap_free() function and
bitmap_equal() operation whose implementation is derived from the
kernel one.

---
Alexey Budankov (3):
  tools bitmap: implement bitmap_equal() operation at bitmap API
  perf mmap: declare type for cpu mask of arbitrary length
  perf record: adapt affinity to machines with #CPUs > 1K

 tools/include/linux/bitmap.h | 30 ++++++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 tools/perf/builtin-record.c  | 30 ++++++++++++++++++++++++------
 tools/perf/util/mmap.c       | 31 +++++++++++++++++++++++++------
 tools/perf/util/mmap.h       | 11 ++++++++++-
 5 files changed, 104 insertions(+), 13 deletions(-)

---
Changes in v2:
- implemented bitmap_free() for symmetry with bitmap_alloc()
- capitalized MMAP_CPU_MASK_BYTES() macro
- returned -1 from perf_mmap__setup_affinity_mask()
- implemented releasing of masks using bitmap_free()
- moved debug printing under -vv option

---
Testing:

  tools/perf/perf record -vv --affinity=cpu -- ls
  thread mask[8]: empty
  Using CPUID GenuineIntel-6-5E-3
  intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
  nr_cblocks: 0
  affinity: CPU
  mmap flush: 1
  comp level: 0
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid 28649  cpu 0  group_fd -1  flags 0x8 = 4
  sys_perf_event_open: pid 28649  cpu 1  group_fd -1  flags 0x8 = 5
  sys_perf_event_open: pid 28649  cpu 2  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid 28649  cpu 3  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid 28649  cpu 4  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid 28649  cpu 5  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid 28649  cpu 6  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid 28649  cpu 7  group_fd -1  flags 0x8 = 13
  mmap size 528384B
  0x7f1898200010: mmap mask[8]: 0
  0x7f18982100d8: mmap mask[8]: 1
  0x7f18982201a0: mmap mask[8]: 2
  0x7f1898230268: mmap mask[8]: 3
  0x7f1898240330: mmap mask[8]: 4
  0x7f18982503f8: mmap mask[8]: 5
  0x7f18982604c0: mmap mask[8]: 6
  0x7f1898270588: mmap mask[8]: 7
  ------------------------------------------------------------
  perf_event_attr:
    type                             1
    size                             112
    config                           0x9
    watermark                        1
    sample_id_all                    1
    bpf_event                        1
    { wakeup_events, wakeup_watermark } 1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 14
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 15
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 16
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 17
  sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 18
  sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 19
  sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 20
  sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 21
  ...
  Synthesizing TSC conversion information
  thread mask[8]: 0
  thread mask[8]: 1
  thread mask[8]: 2
  thread mask[8]: 3
  thread mask[8]: 4
  arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
  block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
  certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
  config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
  thread mask[8]: 5
  thread mask[8]: 6
  thread mask[8]: 7
  thread mask[8]: 0
  thread mask[8]: 1
  thread mask[8]: 2
  thread mask[8]: 3
  thread mask[8]: 4
  thread mask[8]: 5
  thread mask[8]: 6
  thread mask[8]: 7
  [ perf record: Woken up 0 times to write data ]
  thread mask[8]: 0
  thread mask[8]: 1
  thread mask[8]: 2
  thread mask[8]: 3
  thread mask[8]: 4
  thread mask[8]: 5
  thread mask[8]: 6
  thread mask[8]: 7
  Looking at the vmlinux_path (8 entries long)
  Using vmlinux for symbols
  [ perf record: Captured and wrote 0.014 MB perf.data (8 samples) ]

-- 
2.20.1

