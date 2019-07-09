Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E78C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9406A2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbgR7Jh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGIFMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:12:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42941 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIFMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:12:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so14428025oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vRMFcZUxaE5NaysvUG7XXbAGbdtg6RMeYvr75dgW7dg=;
        b=vbgR7Jh3lG7BTkMNCT79qoJOK3JQdsT9vKQr7udRfu651qt7DA4aKiFPbDhcetLV9d
         uHRSyAKUzs2qubejCkFlbnm6x2CC0jATYEYGYklOsMzPnzlAAYLFiloNKi3WGnHMuBwX
         M2Udp1R+UDTsYMOR5m4GCLdXzWaihncp3HCqkmOybMaHX3nWsRK2NhPGJGgCg92VNjFS
         OfA0WpnLHUy6D2ZsmK9xjU0493yhrx+wHy/WEFvbtKhIW39IBMMGhtCTy6dTeYlQx4SW
         qqU4lxzBRC0St0wL/zal3z7T6jNvWTAnJbnyikZP4DSmVbrlDcKje1T5xzfbT/s/0CZI
         FYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vRMFcZUxaE5NaysvUG7XXbAGbdtg6RMeYvr75dgW7dg=;
        b=Sg7b/ffJVufYk3gJP5j9ZZibSzM7M97hY3JdxNNDiApPkAjqJcHM8iXsDHvBv6F337
         DRCYK4HWY0SL4KLl4kta69ZBYy9PfaXmgW4kv4Iivxcp3S3A9nBUdQAmjNxAUzGv2v6K
         sVOaHUwrYG/AxmrwnOuJaL9PSpTD7u+83+6GcGvghnGUgS4MQcQrd7y8QqXk7FUPJB3z
         0qmNosFK94owaFkAEoRVQ50hDBZoZgFCEaMbUG30fGNWfzwo9I9wUZFb2TDfdP5PA6Ly
         wLSGKym2FGY3cJJh/DR5A5xmD8JpLG9tou65e9538EczAihF/AueK+F+S9ph0lx3VdjY
         PPhw==
X-Gm-Message-State: APjAAAX43OR1nPN6umxN7a3TywieixkaGbbmhcTpoz+gicX8SvnjNAEy
        8oCHLLgbJYYEf9lez/98Vts5uw==
X-Google-Smtp-Source: APXvYqyje2+6rPLC/CAsU6LJzHhZEAoFO3MhlFmWa7z3kvGDPltUUFdaYOEQ/xd2Eo/a49U8WU4imw==
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr11486922oih.89.1562649129349;
        Mon, 08 Jul 2019 22:12:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 65sm4220642otw.2.2019.07.08.22.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 22:12:08 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:11:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v3] perf cs-etm: Improve completeness for kernel address
 space
Message-ID: <20190709051154.GA11549@leoy-ThinkPad-X240s>
References: <20190620034446.25561-1-leo.yan@linaro.org>
 <CANLsYkwjJ57RWEqS9suLm1+JKicG1LzcHtP8k5qTK1d7bw=1MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANLsYkwjJ57RWEqS9suLm1+JKicG1LzcHtP8k5qTK1d7bw=1MA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Jul 08, 2019 at 11:33:59AM -0600, Mathieu Poirier wrote:
> On Wed, 19 Jun 2019 at 21:45, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Arm and arm64 architecture reserve some memory regions prior to the
> > symbol '_stext' and these memory regions later will be used by device
> > module and BPF jit.  The current code misses to consider these memory
> > regions thus any address in the regions will be taken as user space
> > mode, but perf cannot find the corresponding dso with the wrong CPU
> > mode so we misses to generate samples for device module and BPF
> > related trace data.
> >
> > This patch parse the link scripts to get the memory size prior to start
> > address and reduce this size from 'etmq->etm->kernel_start', then can
> > get a fixed up kernel start address which contain memory regions for
> > device module and BPF.  Finally, cs_etm__cpu_mode() can return right
> > mode for these memory regions and perf can successfully generate
> > samples.
> >
> > The reason for parsing the link scripts is Arm architecture changes text
> > offset dependent on different platforms, which define multiple text
> > offsets in $kernel/arch/arm/Makefile.  This offset is decided when build
> > kernel and the final value is extended in the link script, so we can
> > extract the used value from the link script.  We use the same way to
> > parse arm64 link script as well.  If fail to find the link script, the
> > pre start memory size is assumed as zero, in this case it has no any
> > change caused with this patch.
> >
> > Below is detailed info for testing this patch:
> >
> > - Build LLVM/Clang 8.0 or later version;
> >
> > - Configure perf with ~/.perfconfig:
> >
> >   root@debian:~# cat ~/.perfconfig
> >   # this file is auto-generated.
> >   [llvm]
> >           clang-path = /mnt/build/llvm-build/build/install/bin/clang
> >           kbuild-dir = /mnt/linux-kernel/linux-cs-dev/
> >           clang-opt = "-g"
> >           dump-obj = true
> >
> >   [trace]
> >           show_zeros = yes
> >           show_duration = no
> >           no_inherit = yes
> >           show_timestamp = no
> >           show_arg_names = no
> >           args_alignment = 40
> >           show_prefix = yes
> >
> > - Run 'perf trace' command with eBPF event:
> >
> >   root@debian:~# perf trace -e string \
> >       -e $kernel/tools/perf/examples/bpf/augmented_raw_syscalls.c
> >
> > - Read eBPF program memory mapping in kernel:
> >
> >   root@debian:~# echo 1 > /proc/sys/net/core/bpf_jit_kallsyms
> >   root@debian:~# cat /proc/kallsyms | grep -E "bpf_prog_.+_sys_[enter|exit]"
> >   ffff000000086a84 t bpf_prog_f173133dc38ccf87_sys_enter  [bpf]
> >   ffff000000088618 t bpf_prog_c1bd85c092d6e4aa_sys_exit   [bpf]
> >
> > - Launch any program which accesses file system frequently so can hit
> >   the system calls trace flow with eBPF event;
> >
> > - Capture CoreSight trace data with filtering eBPF program:
> >
> >   root@debian:~# perf record -e cs_etm/@20070000.etr/ \
> >           --filter 'filter 0xffff000000086a84/0x800' -a sleep 5s
> >
> > - Annotate for symbol 'bpf_prog_f173133dc38ccf87_sys_enter':
> >
> >   root@debian:~# perf report
> >   Then select 'branches' samples and press 'a' to annotate symbol
> >   'bpf_prog_f173133dc38ccf87_sys_enter', press 'P' to print to the
> >   bpf_prog_f173133dc38ccf87_sys_enter.annotation file:
> >
> >   root@debian:~# cat bpf_prog_f173133dc38ccf87_sys_enter.annotation
> >
> >   bpf_prog_f173133dc38ccf87_sys_enter() bpf_prog_f173133dc38ccf87_sys_enter
> >   Event: branches
> >
> >   Percent      int sys_enter(struct syscall_enter_args *args)
> >                  stp  x29, x30, [sp, #-16]!
> >
> >                 int key = 0;
> >                  mov  x29, sp
> >
> >                        augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
> >                  stp  x19, x20, [sp, #-16]!
> >
> >                        augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
> >                  stp  x21, x22, [sp, #-16]!
> >
> >                  stp  x25, x26, [sp, #-16]!
> >
> >                 return bpf_get_current_pid_tgid();
> >                  mov  x25, sp
> >
> >                 return bpf_get_current_pid_tgid();
> >                  mov  x26, #0x0                         // #0
> >
> >                  sub  sp, sp, #0x10
> >
> >                 return bpf_map_lookup_elem(pids, &pid) != NULL;
> >                  add  x19, x0, #0x0
> >
> >                  mov  x0, #0x0                          // #0
> >
> >                  mov  x10, #0xfffffffffffffff8          // #-8
> >
> >                 if (pid_filter__has(&pids_filtered, getpid()))
> >                  str  w0, [x25, x10]
> >
> >                 probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
> >                  add  x1, x25, #0x0
> >
> >                 probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
> >                  mov  x10, #0xfffffffffffffff8          // #-8
> >
> >                 syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
> >                  add  x1, x1, x10
> >
> >                 syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
> >                  mov  x0, #0xffff8009ffffffff           // #-140694538682369
> >
> >                  movk x0, #0x6698, lsl #16
> >
> >                  movk x0, #0x3e00
> >
> >                  mov  x10, #0xffffffffffff1040          // #-61376
> >
> >                 if (syscall == NULL || !syscall->enabled)
> >                  movk x10, #0x1023, lsl #16
> >
> >                 if (syscall == NULL || !syscall->enabled)
> >                  movk x10, #0x0, lsl #32
> >
> >                 loop_iter_first()
> >     3.69       → blr  bpf_prog_f173133dc38ccf87_sys_enter
> >                 loop_iter_first()
> >                  add  x7, x0, #0x0
> >
> >                 loop_iter_first()
> >                  add  x20, x7, #0x0
> >
> >                 int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
> >                  mov  x0, #0x1                          // #1
> 
> I'm not sure all this information about annotation should be in the
> changelog.  This patch is about being able to decode traces that
> executed outside the current kernel addresse range and as such simply
> using "perf report" or "perf script" successfully is enough to test
> this set.  Any information that goes beyond that muddies the water.

Agree.  Will remove this in the new patch.

> >   [...]
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
> > Cc: coresight@lists.linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/Makefile.config | 22 ++++++++++++++++++++++
> >  tools/perf/util/cs-etm.c   | 19 ++++++++++++++++++-
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 51dd00f65709..a58cd5a43a98 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -418,6 +418,28 @@ ifdef CORESIGHT
> >      endif
> >      LDFLAGS += $(LIBOPENCSD_LDFLAGS)
> >      EXTLIBS += $(OPENCSDLIBS)
> > +    PRE_START_SIZE := 0
> > +    ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/kernel/vmlinux.lds),)
> > +      ifeq ($(SRCARCH),arm64)
> > +        # Extract info from lds:
> > +        #  . = ((((((((0xffffffffffffffff)) - (((1)) << (48)) + 1) + (0)) + (0x08000000))) + (0x08000000))) + 0x00080000;
> > +        # PRE_START_SIZE := (0x08000000 + 0x08000000 + 0x00080000) = 0x10080000
> > +        PRE_START_SIZE := $(shell egrep ' \. \= \({8}0x[0-9a-fA-F]+\){2}' \
> > +          $(srctree)/arch/$(SRCARCH)/kernel/vmlinux.lds | \
> > +          sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
> > +          awk -F' ' '{printf "0x%x", $$6+$$7+$$8}' 2>/dev/null)
> > +      endif
> > +      ifeq ($(SRCARCH),arm)
> > +        # Extract info from lds:
> > +        #   . = ((0xC0000000)) + 0x00208000;
> > +        # PRE_START_SIZE := 0x00208000
> > +        PRE_START_SIZE := $(shell egrep ' \. \= \({2}0x[0-9a-fA-F]+\){2}' \
> > +          $(srctree)/arch/$(SRCARCH)/kernel/vmlinux.lds | \
> > +          sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
> > +          awk -F' ' '{printf "0x%x", $$2}' 2>/dev/null)
> > +      endif
> > +    endif
> > +    CFLAGS += -DARM_PRE_START_SIZE=$(PRE_START_SIZE)
> 
> It might be useful to do this for arm and arm64 regardless of
> CoreSight but I'll let Arnaldo decide on this.

Ah, good point!  On Arm/arm64 platforms, if we want to parse kernel
address space with considering eBPF/module, the kernel start address
needs to be compensated in the function machine__get_kernel_start(),
so this can let PMU or other events to work correctly.

Will wait a bit if Arnaldo could give out guidance.

> >      $(call detected,CONFIG_LIBOPENCSD)
> >      ifdef CSTRACE_RAW
> >        CFLAGS += -DCS_DEBUG_RAW
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 0c7776b51045..5fa0be3a3904 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -613,10 +613,27 @@ static void cs_etm__free(struct perf_session *session)
> >  static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> >  {
> >         struct machine *machine;
> > +       u64 fixup_kernel_start = 0;
> >
> >         machine = etmq->etm->machine;
> >
> > -       if (address >= etmq->etm->kernel_start) {
> > +       /*
> > +        * Since arm and arm64 specify some memory regions prior to
> > +        * 'kernel_start', kernel addresses can be less than 'kernel_start'.
> > +        *
> > +        * For arm architecture, the 16MB virtual memory space prior to
> > +        * 'kernel_start' is allocated to device modules, a PMD table if
> > +        * CONFIG_HIGHMEM is enabled and a PGD table.
> > +        *
> > +        * For arm64 architecture, the root PGD table, device module memory
> > +        * region and BPF jit region are prior to 'kernel_start'.
> > +        *
> > +        * To reflect the complete kernel address space, compensate these
> > +        * pre-defined regions for kernel start address.
> > +        */
> > +       fixup_kernel_start = etmq->etm->kernel_start - ARM_PRE_START_SIZE;
> > +
> > +       if (address >= fixup_kernel_start) {
> >                 if (machine__is_host(machine))
> >                         return PERF_RECORD_MISC_KERNEL;
> >                 else
> 
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks a lot for the reviewing & testing; and very appreciate your much
consumed time :)

Thanks,
Leo Yan
