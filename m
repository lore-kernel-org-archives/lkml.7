Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27255C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEE624A59
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFDO4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:56:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:55411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfFDO4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:56:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 07:56:34 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2019 07:56:33 -0700
Received: from [10.125.252.178] (abudanko-mobl.ccr.corp.intel.com [10.125.252.178])
        by linux.intel.com (Postfix) with ESMTP id 5FF225803EA;
        Tue,  4 Jun 2019 07:56:31 -0700 (PDT)
Subject: Re: [PATCH v5] perf record: collect user registers set jointly with
 dwarf stacks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
 <20190530194111.GA6540@kernel.org>
 <3dc0c67e-9ea3-b9f5-1aa2-e87603b29c37@linux.intel.com>
 <20190604141220.GG24504@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ecf1d25f-8c28-934d-f426-26c9d0a68304@linux.intel.com>
Date:   Tue, 4 Jun 2019 17:56:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604141220.GG24504@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.06.2019 17:12, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 31, 2019 at 09:27:38AM +0300, Alexey Budankov escreveu:
<SNIP>
> 
> Now cross building to a few arches is failing, so far:
> 
> [perfbuilder@quaco ~]$ cat /tmp/dm.log/summary
>  alpine:3.4: Ok
>  alpine:3.5: Ok
>  alpine:3.6: Ok
>  alpine:3.7: Ok
>  alpine:3.8: Ok
>  alpine:3.9: Ok
>  alpine:edge: Ok
>  amazonlinux:1: Ok
>  amazonlinux:2: Ok
>  android-ndk:r12b-arm: Ok
>  android-ndk:r15c-arm: Ok
>  centos:5: Ok
>  centos:6: Ok
>  centos:7: Ok
>  clearlinux:latest: Ok
>  debian:8: Ok
>  debian:9: Ok
>  debian:experimental: Ok
>  debian:experimental-x-arm64: Ok
>  debian:experimental-x-mips: FAIL
>  debian:experimental-x-mips64: FAIL
>  debian:experimental-x-mipsel: FAIL
>  fedora:20: Ok
>  fedora:22: Ok
>  fedora:23: Ok
>  fedora:24: Ok
>  fedora:24-x-ARC-uClibc: FAIL
>  fedora:25: Ok
>  fedora:26: Ok
>  fedora:27: Ok
> [perfbuilder@quaco ~]$

That below can fix it. Unfortunately can't test in advance on that architectures.

Thanks,
Alexey

---
 tools/perf/util/evsel.c     | 4 +---
 tools/perf/util/perf_regs.h | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 375ab4eb7560..cc6e7a0dda92 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -669,8 +669,6 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
 	return ret;
 }
 
-#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
-
 static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 					   struct record_opts *opts,
 					   struct callchain_param *param)
@@ -704,7 +702,7 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			if (opts->sample_user_regs) {
+			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
 				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
 				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index cb9c246c8962..47fe34e5f7d5 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -29,12 +29,16 @@ uint64_t arch__user_reg_mask(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
 
+#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
+
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
 
+#define DWARF_MINIMAL_REGS PERF_REGS_MASK
+
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
 	return NULL;
---

> 
> For instance:
> 
> [perfbuilder@quaco ~]$ cat /tmp/dm.log/debian\:experimental-x-mips64
> <SNIP>
>   CC       /tmp/build/perf/tests/pmu.o
> util/evsel.c: In function '__perf_evsel__config_callchain':
> util/evsel.c:672:38: error: 'PERF_REG_IP' undeclared (first use in this function); did you mean 'PERF_REGS_MAX'?
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                       ^~~~~~~~~~~
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
> util/evsel.c:672:38: note: each undeclared identifier is reported only once for each function it appears in
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                       ^~~~~~~~~~~
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
> util/evsel.c:672:62: error: 'PERF_REG_SP' undeclared (first use in this function); did you mean 'PERF_MEM_S'?
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                                               ^~~~~~~~~~~
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
>   LD       /tmp/build/perf/bench/perf-in.o
>   CC       /tmp/build/perf/tests/hists_common.o
> mv: cannot stat '/tmp/build/perf/util/.evsel.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/evsel.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> <SNIP>
> 
> 
> 
> [perfbuilder@quaco ~]$ cat /tmp/dm.log/fedora\:24-x-ARC-uClibc
> 
> <SNIP>
>   CC       /tmp/build/perf/tests/mmap-basic.o
>   CC       /tmp/build/perf/ui/hist.o
> util/evsel.c: In function '__perf_evsel__config_callchain':
> util/evsel.c:672:38: error: 'PERF_REG_IP' undeclared (first use in this function); did you mean 'PERF_MEM_S'?
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                       ^
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
> util/evsel.c:672:38: note: each undeclared identifier is reported only once for each function it appears in
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                       ^
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
> util/evsel.c:672:62: error: 'PERF_REG_SP' undeclared (first use in this function); did you mean 'PERF_REG_IP'?
>  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
>                                                               ^
> util/evsel.c:708:31: note: in expansion of macro 'DWARF_MINIMAL_REGS'
>      attr->sample_regs_user |= DWARF_MINIMAL_REGS;
>                                ^~~~~~~~~~~~~~~~~~
>   MKDIR    /tmp/build/perf/ui/stdio/
> mv: cannot stat '/tmp/build/perf/util/.evsel.o.tmp': No such file or directory
> /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/evsel.o' failed
> make[4]: *** [/tmp/build/perf/util/evsel.o] Error 1
> 
> 
