Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE6C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5BA22311
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKTJdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:33:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:4016 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfKTJdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:33:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 01:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="200656867"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2019 01:33:13 -0800
Received: from [10.249.33.94] (abudanko-mobl.ccr.corp.intel.com [10.249.33.94])
        by linux.intel.com (Postfix) with ESMTP id 74AD658049B;
        Wed, 20 Nov 2019 01:33:11 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1 0/3] perf record: adapt NUMA awareness to machines with
 #CPUs > 1K
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
Date:   Wed, 20 Nov 2019 12:33:10 +0300
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

tools bitmap API has been extended with bitmap_equal() operation
and its implementation is derived from the kernel one.

---
Alexey Budankov (3):
  tools bitmap: extend bitmap API with bitmap_equal()
  perf mmap: declare type for cpu mask of arbitrary length
  perf record: adapt affinity to machines with #CPUs > 1K

 tools/include/linux/bitmap.h | 21 +++++++++++++++++++++
 tools/lib/bitmap.c           | 15 +++++++++++++++
 tools/perf/builtin-record.c  | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.c       | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.h       | 11 ++++++++++-
 5 files changed, 90 insertions(+), 13 deletions(-)

---
Testing:

  $ tools/perf/perf record -v --affinity=cpu -- ls
  thread mask[8]: empty
  Using CPUID GenuineIntel-6-5E-3
  ...
  mmap size 528384B
  0x7f95f8f85010: mmap mask[8]: 0
  0x7f95f8f950d8: mmap mask[8]: 1
  0x7f95f8fa51a0: mmap mask[8]: 2
  0x7f95f8fb5268: mmap mask[8]: 3
  0x7f95f8fc5330: mmap mask[8]: 4
  0x7f95f8fd53f8: mmap mask[8]: 5
  0x7f95f8fe54c0: mmap mask[8]: 6
  0x7f95f8ff5588: mmap mask[8]: 7
  ...
  thread mask[8]: 0
  thread mask[8]: 1
  thread mask[8]: 2
  thread mask[8]: 3
  arch			      copy     Documentation  init     kernel	 MAINTAINERS	  modules.builtin.modinfo  perf.data	  scripts   System.map	vmlinux
  block			      COPYING  drivers	      ipc      lbuild	 Makefile	  modules.order		   perf.data.old  security  tools	vmlinux.o
  certs			      CREDITS  fs	      Kbuild   lib	 mm		  Module.symvers	   README	  sound     usr
  config-5.2.7-100.fc29.x86_64  crypto   include	      Kconfig  LICENSES  modules.builtin  net			   samples	  stdio     virt
  thread mask[8]: 4
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
  ...
  [ perf record: Captured and wrote 0.014 MB perf.data (11 samples) ]

-- 
2.20.1
