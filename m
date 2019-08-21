Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC30EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A76622DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjB1S6nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHUJQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:16:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34531 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfHUJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:16:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so1207438qkk.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1QRYDqooKQHuUqRGCmS19leZIGl6bRizM+3I8whQhcQ=;
        b=SjB1S6nk40lIfA80YLg3MaxW1PPIqSOZtvemM93SZaCc5b++TcGMboXvNxFORLvnTQ
         2MQXpvPONs9iChZVYYnmLyI3avbWT5l9A1pQpYtMGpKf47RX5JazF+Z0I10pWRoxbPm2
         xO8SJjgUExs8wFhfjKf2i9vvHc7v0L4p/txal/QNYEj7jPDVQu/gXE/1lq5Ay1c49lCI
         yCO1dOEPQhP634ibcVOKeAnuP8ZuwVhM4xG6CA2XcjyoMlHmiglKhPnTSTGG8otnZZZN
         9hZOSr2BI6mntWopbVJOV0upftyOZqb6B/R8hJBVp3OpdoIXFo2Rw5hqi2Y9bfmSJKjy
         dRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1QRYDqooKQHuUqRGCmS19leZIGl6bRizM+3I8whQhcQ=;
        b=FIXYq/BQz3qvqrA7b4oDayDzoJ52iMldI9n6R0cg8Gf+lKhbqVDElQq+vZlTr28P7f
         MBWMh6JhXJ3q0Qis9aXx+CsuQVEo43hTJb91GYWJtqNoBBjhyXA7g94gw7am2x+BkE9G
         2XPSsZ0QFWvLCn7Gxg92lDS/Sa8A7ht2hJnTND5QQehloN5NHt0VB3+50GBpa+6ADd2M
         qyEYYXa7teyakzP5Jb3RuO9v3xuwsit7ZGJLPGWOeF6itD1b44LCHh8dwb6W8OKoMu/e
         AMzXTRdBp/pKGZcx1muLVYfUptpk2lUqeiTetWjHtG9OPtRJA296OBf79CiEDvHt08Be
         TQSg==
X-Gm-Message-State: APjAAAXUiPu6n8w7Ts+X/svE6h2kRbb54CzYwZNACs60CmwPfR7/h3hQ
        QbI8S8YBAzGVmDnFaDTrJzDChX5tA6Nou2gRLF0=
X-Google-Smtp-Source: APXvYqxueI2CvpCpcHnyAvd/xbaVVqWugVLgBH6/w1evVP3qmYFPu/qLSr/S4GHaY9KPCmFffu1HwCLsEsKOr1Bje3o=
X-Received: by 2002:a37:6397:: with SMTP id x145mr28742727qkb.56.1566379009816;
 Wed, 21 Aug 2019 02:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566290744.git.han_mao@c-sky.com> <820d80272fc5627b8d00e684663a614470217606.1566290744.git.han_mao@c-sky.com>
In-Reply-To: <820d80272fc5627b8d00e684663a614470217606.1566290744.git.han_mao@c-sky.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 21 Aug 2019 17:16:13 +0800
Message-ID: <CAEbi=3cBu8pbHZQk9ff79DLzHurKTSAwABEfW3aT=v-1brqppg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] riscv: Add perf callchain support
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

Mao Han <han_mao@c-sky.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8820=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patch add support for perf callchain sampling on riscv platform.
> The return address of leaf function is retrieved from pt_regs as
> it is not saved in the outmost frame.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Makefile                |   3 +
>  arch/riscv/kernel/Makefile         |   3 +-
>  arch/riscv/kernel/perf_callchain.c | 115 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_callchain.c
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7a117be..946565b 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -54,6 +54,9 @@ endif
>  ifeq ($(CONFIG_MODULE_SECTIONS),y)
>         KBUILD_LDFLAGS_MODULE +=3D -T $(srctree)/arch/riscv/kernel/module=
.lds
>  endif
> +ifeq ($(CONFIG_PERF_EVENTS),y)
> +        KBUILD_CFLAGS +=3D -fno-omit-frame-pointer
> +endif
>
>  KBUILD_CFLAGS_MODULE +=3D $(call cc-option,-mno-relax)
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 2420d37..b1bea89 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_MODULE_SECTIONS) +=3D module-sections.o
>  obj-$(CONFIG_FUNCTION_TRACER)  +=3D mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)   +=3D mcount-dyn.o
>
> -obj-$(CONFIG_PERF_EVENTS)      +=3D perf_event.o
> +obj-$(CONFIG_PERF_EVENTS)      +=3D perf_event.o
> +obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o
>
>  clean:
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> new file mode 100644
> index 0000000..d75d15c
> --- /dev/null
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
> +
> +#include <linux/perf_event.h>
> +#include <linux/uaccess.h>
> +
> +/* Kernel callchain */
> +struct stackframe {
> +       unsigned long fp;
> +       unsigned long ra;
> +};
> +
> +static int unwind_frame_kernel(struct stackframe *frame)
> +{
> +       if (kstack_end((void *)frame->fp))
> +               return -EPERM;
> +       if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
> +               return -EPERM;
> +       if (frame->fp < CONFIG_PAGE_OFFSET)
> +               return -EPERM;
> +
> +       *frame =3D *((struct stackframe *)frame->fp - 1);
> +       if (__kernel_text_address(frame->ra)) {
> +               int graph =3D 0;
> +
> +               frame->ra =3D ftrace_graph_ret_addr(NULL, &graph, frame->=
ra,
> +                               NULL);
> +       }
> +       return 0;
> +}
> +
> +static void notrace walk_stackframe(struct stackframe *fr,
> +                       struct perf_callchain_entry_ctx *entry)
> +{
> +       do {
> +               perf_callchain_store(entry, fr->ra);
> +       } while (unwind_frame_kernel(fr) >=3D 0);
> +}
> +
> +/*
> + * Get the return address for a single stackframe and return a pointer t=
o the
> + * next frame tail.
> + */
> +static unsigned long user_backtrace(struct perf_callchain_entry_ctx *ent=
ry,
> +                       unsigned long fp, unsigned long reg_ra)
> +{
> +       struct stackframe buftail;
> +       unsigned long ra =3D 0;
> +       unsigned long *user_frame_tail =3D
> +                       (unsigned long *)(fp - sizeof(struct stackframe))=
;
> +
> +       /* Check accessibility of one struct frame_tail beyond */
> +       if (!access_ok(user_frame_tail, sizeof(buftail)))
> +               return 0;
> +       if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> +                                     sizeof(buftail)))
> +               return 0;
> +
> +       if (reg_ra !=3D 0)
> +               ra =3D reg_ra;
> +       else
> +               ra =3D buftail.ra;
> +
> +       fp =3D buftail.fp;
> +       perf_callchain_store(entry, ra);
> +
> +       return fp;
> +}
> +
> +/*
> + * This will be called when the target is in user mode
> + * This function will only be called when we use
> + * "PERF_SAMPLE_CALLCHAIN" in
> + * kernel/events/core.c:perf_prepare_sample()
> + *
> + * How to trigger perf_callchain_[user/kernel] :
> + * $ perf record -e cpu-clock --call-graph fp ./program
> + * $ perf report --call-graph
> + *
> + * On RISC-V platform, the program being sampled and the C library
> + * need to be compiled with -fno-omit-frame-pointer, otherwise
> + * the user stack will not contain function frame.
> + */
> +void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> +                        struct pt_regs *regs)
> +{
> +       unsigned long fp =3D 0;
> +
> +       /* RISC-V does not support virtualization. */
> +       if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
> +               return;
> +
> +       fp =3D regs->s0;
> +       perf_callchain_store(entry, regs->sepc);
> +
> +       fp =3D user_backtrace(entry, fp, regs->ra);
> +       while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
> +               fp =3D user_backtrace(entry, fp, 0);
> +}
> +
> +void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> +                          struct pt_regs *regs)
> +{
> +       struct stackframe fr;
> +
> +       /* RISC-V does not support virtualization. */
> +       if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
> +               pr_warn("RISC-V does not support perf in guest mode!");
> +               return;
> +       }
> +
> +       fr.fp =3D regs->s0;
> +       fr.ra =3D regs->ra;
> +       walk_stackframe(&fr, entry);
> +}
> --
> 2.7.4
>

Not sure if I did something wrong. I encounter a build error when I
try to build tools/perf/tests

  CC       arch/riscv/util/dwarf-regs.o
arch/riscv/util/dwarf-regs.c:64:5: error: no previous prototype for
=E2=80=98regs_query_register_offset=E2=80=99 [-Werror=3Dmissing-prototypes]

I simply add its prototype and it could be built pass.
This is my testing results.
# ./perf test
 1: vmlinux symtab matches kallsyms                       : Skip
 2: Detect openat syscall event                           : FAILED!
 3: Detect openat syscall event on all cpus               : FAILED!
 4: Read samples using the mmap interface                 : FAILED!
 5: Test data source output                               : Ok
 6: Parse event definition strings                        : FAILED!
 7: Simple expression parser                              : Ok
 8: PERF_RECORD_* events & perf_sample fields             : FAILED!
 9: Parse perf pmu format                                 : Ok
10: DSO data read                                         : Ok
11: DSO data cache                                        : Ok
12: DSO data reopen                                       : Ok
13: Roundtrip evsel->name                                 : Ok
14: Parse sched tracepoints fields                        : FAILED!
15: syscalls:sys_enter_openat event fields                : FAILED!
16: Setup struct perf_event_attr                          : FAILED!
17: Match and link multiple hists                         : Ok
18: 'import perf' in python                               : FAILED!

19: Breakpoint overflow signal handler                    : FAILED!
20: Breakpoint overflow sampling                          : FAILED!
21: Breakpoint accounting                                 : Skip
22: Watchpoint                                            :
22.1: Read Only Watchpoint                                : FAILED!
22.2: Write Only Watchpoint                               : FAILED!
22.3: Read / Write Watchpoint                             : FAILED!
22.4: Modify Watchpoint                                   : FAILED!
23: Number of exit events of a simple workload            : Ok
24: Software clock events period values                   : Ok
25: Object code reading                                   : Ok
26: Sample parsing                                        : Ok
27: Use a dummy software event to keep tracking           : Ok
28: Parse with no sample_id_all bit set                   : Ok
29: Filter hist entries                                   : Ok
30: Lookup mmap thread                                    : Ok
31: Share thread mg                                       : Ok
32: Sort output of hist entries                           : Ok
33: Cumulate child hist entries                           : Ok
34: Track with sched_switch                               : Ok
35: Filter fds with revents mask in a fdarray             : Ok
36: Add fd to a fdarray, making it autogrow               : Ok
37: kmod_path__parse                                      : Ok
38: Thread map                                            : Ok
39: LLVM search and compile                               :
39.1: Basic BPF llvm compile                              : Skip
39.2: kbuild searching                                    : Skip
39.3: Compile source for BPF prologue generation          : Skip
39.4: Compile source for BPF relocation                   : Skip
40: Session topology                                      : FAILED!
41: BPF filter                                            :
41.1: Basic BPF filtering                                 : Skip
41.2: BPF pinning                                         : Skip
41.3: BPF relocation checker                              : Skip
42: Synthesize thread map                                 : Ok
43: Remove thread map                                     : Ok
44: Synthesize cpu map                                    : Ok
45: Synthesize stat config                                : Ok
46: Synthesize stat                                       : Ok
47: Synthesize stat round                                 : Ok
48: Synthesize attr update                                : Ok
49: Event times                                           : Ok
50: Read backward ring buffer                             : Skip
51: Print cpu map                                         : Ok
52: Probe SDT events                                      : Skip
53: is_printable_array                                    : Ok
54: Print bitmap                                          : Ok
55: perf hooks                                            : Ok
56: builtin clang support                                 : Skip (not
compiled in)
57: unit_number__scnprintf                                : Ok
58: mem2node                                              : Ok
59: time utils                                            : Ok
60: map_groups__merge_in                                  : Ok
61: probe libc's inet_pton & backtrace it with ping       : FAILED!
62: Add vfs_getname probe to get syscall args filenames   : FAILED!
63: Check open filename arg using perf trace + vfs_getname: Skip
64: Use vfs_getname probe to get syscall args filenames   : FAILED!
65: Zstd perf.data compression/decompression              : Skip

I also try the command that Paul pointed out.
./perf record -e cpu-clock --call-graph fp /bin/ls
It works fine now. It can generate a perf.data now.
