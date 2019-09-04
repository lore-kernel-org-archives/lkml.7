Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7162C3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E44B23400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaH7rksA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfIDH0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:26:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33828 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:26:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id q203so9478778qke.1;
        Wed, 04 Sep 2019 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kILb5kRYDfIYgYQ1PBbvSwMF1niGIDsl+wR4HOmjCNU=;
        b=uaH7rksAotumr8ax8nw/7oZzX88KtciuB4aJ9gY+h5WmbKYjYKwAw8WlZiMT4gK1Zf
         fC/DfZIjMkOfV1qiTNAHt0xbHCcIcvHDjmVIKet7G//yQjN9wXNVh8mM4c33A+Sk1tz9
         tSNuXGdeJpMpWb6piTpZYzFqOK9EmBdxCp62AEv/DSDKAMPKQB7DLmnM93jxgNqbRbxf
         btEo7DD0c1+rS1q7/e/epSE3JOFDBkoPI3phxSKIblGPzzum88Wh5+ngmSLgnxIOHKXT
         N627ni0RkZd4yLOUXDgvNpypgN4/PVBim0tWW7Ryuh2atbZAIAjleJWGWlpVSHtu5KOA
         4opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kILb5kRYDfIYgYQ1PBbvSwMF1niGIDsl+wR4HOmjCNU=;
        b=gOK0MmHTW2b2bzEo1kmko8YAU1vRjNrSJ4yrRXQOZibs6EqJW3uYBqC26cMS0D+x2j
         R3AW5FYCJdtCfwifWBNVgqppEx2FWiTt0/g0PZgabtL46IoNXplx7KxXoop2xArOUSJR
         v+AVDFZp6rJv6u7tm5mD3keQA219fr5gEk51ZsA5uXo3coJYJIwpe20dnVC5Z+nqt8GM
         vsynxWpLMMStuaxXRE67qVJQWljy9OXDgYnDvO5BFEh8bT+rPYLbChMPkdEmgpwEozVa
         SIdi5o1jJRsQe7hfBt+Sr1yB9w2z8PgmHVUGRLQgNI6iQLeyY+NwaPdXpuhMgzxOhzEr
         brPA==
X-Gm-Message-State: APjAAAUaBbhiGl6UFQe9DpdRGmpgcO63FitzDzcLaBUVGepap7GEJo2m
        HQa0cnG/aXswC2xbg9lPvaW9Te7dEP4AfCTMm4w=
X-Google-Smtp-Source: APXvYqz/cc5gz57o2Qkbc9WLcqb/307wIfQ5/nIT/cA75tR1A4lzBM4tRRE+t597oIcoHCe72n/2ZfbnJj0S3C9vCQg=
X-Received: by 2002:a37:4f84:: with SMTP id d126mr19937883qkb.430.1567581961441;
 Wed, 04 Sep 2019 00:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567060834.git.han_mao@c-sky.com>
In-Reply-To: <cover.1567060834.git.han_mao@c-sky.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 4 Sep 2019 15:25:23 +0800
Message-ID: <CAEbi=3cMhBsC3n6DpOfvSD0-ZgGbV=0ik8avjugYzRHcimFRbA@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] riscv: Add perf callchain support
To:     Mao Han <han_mao@c-sky.com>, greentime.hu@sifive.com
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mao Han <han_mao@c-sky.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patch set add perf callchain(FP/DWARF) support for RISC-V.
> It comes from the csky version callchain support with some
> slight modifications. The patchset base on Linux 5.3-rc6.
>
> Changes since v5:
>   - use walk_stackframe from stacktrace.c to handle
>     kernel callchain unwinding(fix invalid mem access)
>
> Changes since v4:
>   - Add missing PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
>     verified with extra CFLAGS(-Wall -Werror)
>
> Changes since v3:
>   - Add more strict check for unwind_frame_kernel
>   - update for kernel 5.3
>
> Changes since v2:
>   - fix inconsistent comment
>   - force to build kernel with -fno-omit-frame-pointer if perf
>     event is enabled
>
> Changes since v1:
>   - simplify implementation and code convention
>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>
>
> Mao Han (3):
>   riscv: Add perf callchain support
>   riscv: Add support for perf registers sampling
>   riscv: Add support for libdw
>
>  arch/riscv/Kconfig                            |  2 +
>  arch/riscv/Makefile                           |  3 +
>  arch/riscv/include/uapi/asm/perf_regs.h       | 42 ++++++++++++
>  arch/riscv/kernel/Makefile                    |  4 +-
>  arch/riscv/kernel/perf_callchain.c            | 95 +++++++++++++++++++++=
+++++
>  arch/riscv/kernel/perf_regs.c                 | 44 ++++++++++++
>  arch/riscv/kernel/stacktrace.c                |  2 +-
>  tools/arch/riscv/include/uapi/asm/perf_regs.h | 42 ++++++++++++
>  tools/perf/Makefile.config                    |  6 +-
>  tools/perf/arch/riscv/Build                   |  1 +
>  tools/perf/arch/riscv/Makefile                |  4 ++
>  tools/perf/arch/riscv/include/perf_regs.h     | 96 +++++++++++++++++++++=
++++++
>  tools/perf/arch/riscv/util/Build              |  2 +
>  tools/perf/arch/riscv/util/dwarf-regs.c       | 72 ++++++++++++++++++++
>  tools/perf/arch/riscv/util/unwind-libdw.c     | 57 ++++++++++++++++
>  15 files changed, 469 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/riscv/kernel/perf_callchain.c
>  create mode 100644 arch/riscv/kernel/perf_regs.c
>  create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/riscv/Build
>  create mode 100644 tools/perf/arch/riscv/Makefile
>  create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
>  create mode 100644 tools/perf/arch/riscv/util/Build
>  create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c
>

Tested-by: Greentime Hu <greentime.hu@sifive.com>

I tested this patchset based on v5.3-rc6 and it can use dwarf or fp to
backtrace in Unleashed board.

# perf record -e cpu-clock --call-graph dwarf ls -l /
total 4
drwxr-xr-x    2 root     root             0 Aug 26  2019 bin
drwxr-xr-x    5 root     root         12720 Jan  1 00:00 dev
drwxr-xr-x    5 root     root             0 Jan  1 00:00 etc
-rwxr-xr-x    1 root     root           178 Aug 26  2019 init
drwxr-xr-x    2 root     root             0 Aug 26  2019 lib
lrwxrwxrwx    1 root     root             3 Aug 19  2019 lib64 -> lib
lrwxrwxrwx    1 root     root            11 Aug 19  2019 linuxrc -> bin/bus=
ybox
drwxr-xr-x    2 root     root             0 Aug 19  2019 media
drwxr-xr-x    2 root     root             0 Aug 19  2019 mnt
drwxr-xr-x    2 root     root             0 Aug 19  2019 opt
dr-xr-xr-x   66 root     root             0 Jan  1 00:00 proc
drwx------    3 root     root             0 Jan  1 00:01 root
drwxr-xr-x    3 root     root           140 Jan  1 00:00 run
drwxr-xr-x    2 root     root             0 Aug 19  2019 sbin
dr-xr-xr-x   11 root     root             0 Jan  1 00:00 sys
drwxrwxrwt    2 root     root            60 Jan  1 00:00 tmp
drwxr-xr-x    6 root     root             0 Aug 26  2019 usr
drwxr-xr-x    4 root     root             0 Aug 26  2019 var
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.175 MB perf.data (21 samples) ]

# perf record -e cpu-clock --call-graph fp ls -l /
total 4
drwxr-xr-x    2 root     root             0 Aug 26  2019 bin
drwxr-xr-x    5 root     root         12720 Jan  1 00:00 dev
drwxr-xr-x    5 root     root             0 Jan  1 00:00 etc
-rwxr-xr-x    1 root     root           178 Aug 26  2019 init
drwxr-xr-x    2 root     root             0 Aug 26  2019 lib
lrwxrwxrwx    1 root     root             3 Aug 19  2019 lib64 -> lib
lrwxrwxrwx    1 root     root            11 Aug 19  2019 linuxrc -> bin/bus=
ybox
drwxr-xr-x    2 root     root             0 Aug 19  2019 media
drwxr-xr-x    2 root     root             0 Aug 19  2019 mnt
drwxr-xr-x    2 root     root             0 Aug 19  2019 opt
dr-xr-xr-x   66 root     root             0 Jan  1 00:00 proc
drwx------    3 root     root             0 Jan  1 00:00 root
drwxr-xr-x    3 root     root           140 Jan  1 00:00 run
drwxr-xr-x    2 root     root             0 Aug 19  2019 sbin
dr-xr-xr-x   11 root     root             0 Jan  1 00:00 sys
drwxrwxrwt    2 root     root            60 Jan  1 00:00 tmp
drwxr-xr-x    6 root     root             0 Aug 26  2019 usr
drwxr-xr-x    4 root     root             0 Aug 26  2019 var
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.004 MB perf.data (19 samples) ]

# perf test
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
14: Parse sched tracepoints fields             : Ok
15: syscalls:sys_enter_openat event fields     : FAILED!
16: Setup struct perf_event_attr               : Skip
17: Match and link multiple hists              : Ok
18: 'import perf' in python                    : FAILED!
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
34: Track with sched_switch                    : FAILED!
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
41.3: BPF prologue generation                  : Skip
41.4: BPF relocation checker                   : Skip
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
#
