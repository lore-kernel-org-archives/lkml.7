Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4261EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098BB22CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfHUK5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:57:09 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48000 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfHUK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:57:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.258884-0.00885615-0.73226;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.FFrRGz4_1566385024;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FFrRGz4_1566385024)
          by smtp.aliyun-inc.com(10.147.40.44);
          Wed, 21 Aug 2019 18:57:04 +0800
Date:   Wed, 21 Aug 2019 18:57:04 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@sifive.com, hch@lst.de,
        linux-csky@vegr.kernel.org
Subject: Re: [PATCH V4 1/3] riscv: Add perf callchain support
Message-ID: <20190821105704.GA8431@vmh-VirtualBox>
References: <cover.1566290744.git.han_mao@c-sky.com>
 <820d80272fc5627b8d00e684663a614470217606.1566290744.git.han_mao@c-sky.com>
 <CAEbi=3cBu8pbHZQk9ff79DLzHurKTSAwABEfW3aT=v-1brqppg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEbi=3cBu8pbHZQk9ff79DLzHurKTSAwABEfW3aT=v-1brqppg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,
On Wed, Aug 21, 2019 at 05:16:13PM +0800, Greentime Hu wrote:
> Hi Mao,
> 
> Mao Han <han_mao@c-sky.com> 於 2019年8月20日 週二 下午4:57寫道：
> >
> > This patch add support for perf callchain sampling on riscv platform.
> > The return address of leaf function is retrieved from pt_regs as
> > it is not saved in the outmost frame.
> >
> >
> 
> Not sure if I did something wrong. I encounter a build error when I
> try to build tools/perf/tests
> 
>   CC       arch/riscv/util/dwarf-regs.o
> arch/riscv/util/dwarf-regs.c:64:5: error: no previous prototype for
> ‘regs_query_register_offset’ [-Werror=missing-prototypes]
>

This seems becasue I didn't add PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
in tools/perf/arch/riscv/Makefile so the prototype in
./util/include/dwarf-regs.h is not declared. I'll add that in the next
version.
 
> I simply add its prototype and it could be built pass.
> This is my testing results.
> # ./perf test
>  1: vmlinux symtab matches kallsyms                       : Skip
>  2: Detect openat syscall event                           : FAILED!
>  3: Detect openat syscall event on all cpus               : FAILED!
>  4: Read samples using the mmap interface                 : FAILED!
>  5: Test data source output                               : Ok
>  6: Parse event definition strings                        : FAILED!
>  7: Simple expression parser                              : Ok
>  8: PERF_RECORD_* events & perf_sample fields             : FAILED!
>  9: Parse perf pmu format                                 : Ok
> 10: DSO data read                                         : Ok
> 11: DSO data cache                                        : Ok
> 12: DSO data reopen                                       : Ok
> 13: Roundtrip evsel->name                                 : Ok
> 14: Parse sched tracepoints fields                        : FAILED!
> 15: syscalls:sys_enter_openat event fields                : FAILED!
> 16: Setup struct perf_event_attr                          : FAILED!
> 17: Match and link multiple hists                         : Ok
> 18: 'import perf' in python                               : FAILED!
> 
> 19: Breakpoint overflow signal handler                    : FAILED!
> 20: Breakpoint overflow sampling                          : FAILED!
> 21: Breakpoint accounting                                 : Skip
> 22: Watchpoint                                            :
> 22.1: Read Only Watchpoint                                : FAILED!
> 22.2: Write Only Watchpoint                               : FAILED!
> 22.3: Read / Write Watchpoint                             : FAILED!
> 22.4: Modify Watchpoint                                   : FAILED!
> 23: Number of exit events of a simple workload            : Ok
> 24: Software clock events period values                   : Ok
> 25: Object code reading                                   : Ok
> 26: Sample parsing                                        : Ok
> 27: Use a dummy software event to keep tracking           : Ok
> 28: Parse with no sample_id_all bit set                   : Ok
> 29: Filter hist entries                                   : Ok
> 30: Lookup mmap thread                                    : Ok
> 31: Share thread mg                                       : Ok
> 32: Sort output of hist entries                           : Ok
> 33: Cumulate child hist entries                           : Ok
> 34: Track with sched_switch                               : Ok
> 35: Filter fds with revents mask in a fdarray             : Ok
> 36: Add fd to a fdarray, making it autogrow               : Ok
> 37: kmod_path__parse                                      : Ok
> 38: Thread map                                            : Ok
> 39: LLVM search and compile                               :
> 39.1: Basic BPF llvm compile                              : Skip
> 39.2: kbuild searching                                    : Skip
> 39.3: Compile source for BPF prologue generation          : Skip
> 39.4: Compile source for BPF relocation                   : Skip
> 40: Session topology                                      : FAILED!
> 41: BPF filter                                            :
> 41.1: Basic BPF filtering                                 : Skip
> 41.2: BPF pinning                                         : Skip
> 41.3: BPF relocation checker                              : Skip
> 42: Synthesize thread map                                 : Ok
> 43: Remove thread map                                     : Ok
> 44: Synthesize cpu map                                    : Ok
> 45: Synthesize stat config                                : Ok
> 46: Synthesize stat                                       : Ok
> 47: Synthesize stat round                                 : Ok
> 48: Synthesize attr update                                : Ok
> 49: Event times                                           : Ok
> 50: Read backward ring buffer                             : Skip
> 51: Print cpu map                                         : Ok
> 52: Probe SDT events                                      : Skip
> 53: is_printable_array                                    : Ok
> 54: Print bitmap                                          : Ok
> 55: perf hooks                                            : Ok
> 56: builtin clang support                                 : Skip (not
> compiled in)
> 57: unit_number__scnprintf                                : Ok
> 58: mem2node                                              : Ok
> 59: time utils                                            : Ok
> 60: map_groups__merge_in                                  : Ok
> 61: probe libc's inet_pton & backtrace it with ping       : FAILED!
> 62: Add vfs_getname probe to get syscall args filenames   : FAILED!
> 63: Check open filename arg using perf trace + vfs_getname: Skip
> 64: Use vfs_getname probe to get syscall args filenames   : FAILED!
> 65: Zstd perf.data compression/decompression              : Skip
>

The perf test result I got is quiet similar to yours, but with 5
less testcases.

 1: vmlinux symtab matches kallsyms            : Skip
 2: Detect openat syscall event                : FAILED!
 3: Detect openat syscall event on all cpus    : FAILED!
 4: Read samples using the mmap interface      : FAILED!
 5: Test data source output                    : Ok
 6: Parse event definition strings             : FAILED!
 7: Simple expression parser                   : Ok
 8: PERF_RECORD_* events & perf_sample fields  : FAILED!
 9: Parse perf pmu format                      : Ok
10: DSO data read                              : Ok
11: DSO data cache                             : Ok
12: DSO data reopen                            : Ok
13: Roundtrip evsel->name                      : Ok
14: Parse sched tracepoints fields             : FAILED!
15: syscalls:sys_enter_openat event fields     : FAILED!
16: Setup struct perf_event_attr               : Skip
17: Match and link multiple hists              : Ok
18: 'import perf' in python                    : Ok
19: Breakpoint overflow signal handler         : FAILED!
20: Breakpoint overflow sampling               : FAILED!
21: Breakpoint accounting                      : Skip
22: Watchpoint                                 :
22.1: Read Only Watchpoint                     : FAILED!
22.2: Write Only Watchpoint                    : FAILED!
22.3: Read / Write Watchpoint                  : FAILED!
22.4: Modify Watchpoint                        : FAILED!
23: Number of exit events of a simple workload : Ok
24: Software clock events period values        : Ok
25: Object code reading                        : Ok
26: Sample parsing                             : Ok
27: Use a dummy software event to keep tracking: Ok
28: Parse with no sample_id_all bit set        : Ok
29: Filter hist entries                        : Ok
30: Lookup mmap thread                         : Ok
31: Share thread mg                            : Ok
32: Sort output of hist entries                : Ok
33: Cumulate child hist entries                : Ok
34: Track with sched_switch                    : Ok
35: Filter fds with revents mask in a fdarray  : Ok
36: Add fd to a fdarray, making it autogrow    : Ok
37: kmod_path__parse                           : Ok
38: Thread map                                 : Ok
39: LLVM search and compile                    :
39.1: Basic BPF llvm compile                    : Skip
39.2: kbuild searching                          : Skip
39.3: Compile source for BPF prologue generation: Skip
39.4: Compile source for BPF relocation         : Skip
40: Session topology                           : FAILED!
41: BPF filter                                 :
41.1: Basic BPF filtering                      : Skip
41.2: BPF pinning                              : Skip
41.3: BPF relocation checker                   : Skip
42: Synthesize thread map                      : Ok
43: Remove thread map                          : Ok
44: Synthesize cpu map                         : Ok
45: Synthesize stat config                     : Ok
46: Synthesize stat                            : Ok
47: Synthesize stat round                      : Ok
48: Synthesize attr update                     : Ok
49: Event times                                : Ok
50: Read backward ring buffer                  : Skip
51: Print cpu map                              : Ok
52: Probe SDT events                           : Skip
53: is_printable_array                         : Ok
54: Print bitmap                               : Ok
55: perf hooks                                 : Ok
56: builtin clang support                      : Skip (not compiled in)
57: unit_number__scnprintf                     : Ok
58: mem2node                                   : Ok
59: time utils                                 : Ok
60: map_groups__merge_in                       : Ok

The comparison before/after applied this patch set:

/tools/perf/util# diff perf_test_before perf_test_after
1d0
< # perf test
8c7
<  7: Simple expression parser                   : FAILED!
---
>  7: Simple expression parser                   : Ok
