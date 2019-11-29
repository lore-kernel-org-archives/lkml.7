Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971B02176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfK2KBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:01:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:36373 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfK2KBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:01:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 02:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="207386122"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2019 02:01:06 -0800
Received: from [10.125.252.110] (abudanko-mobl.ccr.corp.intel.com [10.125.252.110])
        by linux.intel.com (Postfix) with ESMTP id 3AB955802B9;
        Fri, 29 Nov 2019 02:01:04 -0800 (PST)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3 0/3] perf record: adapt NUMA awareness to machines with
 #CPUs > 1K
Organization: Intel Corp.
Message-ID: <908dbe98-7d8d-0ec1-d4ae-242f3e104979@linux.intel.com>
Date:   Fri, 29 Nov 2019 13:01:03 +0300
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

 tools/include/linux/bitmap.h | 30 +++++++++++++++++++++++++++
 tools/lib/bitmap.c           | 15 ++++++++++++++
 tools/perf/builtin-record.c  | 27 ++++++++++++++++++------
 tools/perf/util/mmap.c       | 40 ++++++++++++++++++++++++++++++------
 tools/perf/util/mmap.h       | 13 +++++++++++-
 5 files changed, 112 insertions(+), 13 deletions(-)

---
Changes in v3:
- implemented perf_mmap__print_cpu_mask() function
- use perf_mmap__print_cpu_mask() to log thread and mmap cpus masks
  when verbose level is equal to 2
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
...
------------------------------------------------------------
perf_event_attr:
...
mmap size 528384B
0x7fddecf760b8: mmap mask[8]: 0
0x7fddecf86180: mmap mask[8]: 1
0x7fddecf96248: mmap mask[8]: 2
0x7fddecfa6310: mmap mask[8]: 3
0x7fddecfb63d8: mmap mask[8]: 4
0x7fddecfc64a0: mmap mask[8]: 5
0x7fddecfd6568: mmap mask[8]: 6
0x7fddecfe6630: mmap mask[8]: 7
------------------------------------------------------------
perf_event_attr:
...
Synthesizing TSC conversion information
0x7fddecf760b8: thread mask[8]: 0
0x7fddecf86180: thread mask[8]: 1
0x7fddecf96248: thread mask[8]: 2
arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
0x7fddecfa6310: thread mask[8]: 3
0x7fddecfb63d8: thread mask[8]: 4
0x7fddecfc64a0: thread mask[8]: 5
0x7fddecfd6568: thread mask[8]: 6
0x7fddecfe6630: thread mask[8]: 7
0x7fddecf760b8: thread mask[8]: 0
0x7fddecf86180: thread mask[8]: 1
0x7fddecf96248: thread mask[8]: 2
0x7fddecfa6310: thread mask[8]: 3
0x7fddecfb63d8: thread mask[8]: 4
0x7fddecfc64a0: thread mask[8]: 5
0x7fddecfd6568: thread mask[8]: 6
0x7fddecfe6630: thread mask[8]: 7
[ perf record: Woken up 0 times to write data ]
0x7fddecf760b8: thread mask[8]: 0
0x7fddecf86180: thread mask[8]: 1
0x7fddecf96248: thread mask[8]: 2
0x7fddecfa6310: thread mask[8]: 3
0x7fddecfb63d8: thread mask[8]: 4
0x7fddecfc64a0: thread mask[8]: 5
0x7fddecfd6568: thread mask[8]: 6
0x7fddecfe6630: thread mask[8]: 7
Looking at the vmlinux_path (8 entries long)
Using vmlinux for symbols
[ perf record: Captured and wrote 0.014 MB perf.data (8 samples) ]

-- 
2.20.1

