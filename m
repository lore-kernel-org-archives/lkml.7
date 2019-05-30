Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9037EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFD3259C2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQgPTfzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfE3Ngw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:36:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44042 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfE3Ngv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:36:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so3532588qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Smw4bLNpL/tznKI/bGSYFYG6TnHgSriFYcFw9YWFlBY=;
        b=FQgPTfzSsBVGa9muPeeKXZHAHGuJQYI53X2mOxUhN5XqB60eDLeJxA5zwNaaNbrWp9
         x6fusAxc5pK4wZ+/R/Q7wmp+NRgACE6r6pbJn3JFYPxGMeepkHdC9BddzOWRaemoKiI3
         SLD1HhG59rG/1tjDlvadIbCsitpgcmgPl3vm03uwzNVIf29YRKp03zDqbHiwcRQ05Ikn
         sAPtCbXvdSzPf4icFrGPXM/xF355KtNpJjBlC5CYWGdGDghcfyDwUAKsBpFbHS7GwmuM
         vzFfRJaqVWK3jNcYnWMZEiYhfmSjzodozVh5XxKE8ZAa8fh3/Un4CS3vJp3ZzRVaMXs1
         ao3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Smw4bLNpL/tznKI/bGSYFYG6TnHgSriFYcFw9YWFlBY=;
        b=tsvBaz5Z0NPZ1eLSMT8cvOQrlpIDOQJqvs1n6qY8AUUICebFkF8sEtHpjG6jltgliU
         bDvRJAf0lGP13yN1mdSWsa4mWKqmpfR2kIA4ZpA3IbmNQme/xx+N9IXzLlJKLHKTfCo/
         /8iOFpf5al3Rc3yyn864idY6clydtb1iR1KRUSfCfIfyZAmjcxHPWH3pxL7M2kjjpgbi
         1xJ7pR/+H0sLvoPtM28vCmXPMXl/zVMBn3KDhmbtlwCmqvjk+EmSkTqslvZBcbAPwX1h
         fJY5/VPyduSY2aCMKK8u/ANF4swMgojWAzRFltD6iZPn2f3FlfCATRGBuw+FQLh2cav+
         g6Pg==
X-Gm-Message-State: APjAAAX6HEjUfcKBiuDx3pMcvgPc+k+WiKlE73p35CrvtA6fnwd/Ghy6
        gAb4uduTssjrUCVZYKNigP0=
X-Google-Smtp-Source: APXvYqzpCjbJlFIq2EvhLJw2oBjhXdZCg/QrniqKXbJQcNhb+aF3yHCYp4wKDhZLzHdqmD0E0SUo7g==
X-Received: by 2002:a0c:b59c:: with SMTP id g28mr3380613qve.171.1559223410001;
        Thu, 30 May 2019 06:36:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m66sm1665830qkb.12.2019.05.30.06.36.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 06:36:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0584341149; Thu, 30 May 2019 10:36:45 -0300 (-03)
Date:   Thu, 30 May 2019 10:36:45 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190530133645.GC21962@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190530105439.GA5927@leoy-ThinkPad-X240s>
 <20190530120709.GA3669@krava>
 <20190530125709.GB5927@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190530125709.GB5927@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 08:57:09PM +0800, Leo Yan escreveu:
> Hi Jiri,
> 
> On Thu, May 30, 2019 at 02:07:10PM +0200, Jiri Olsa wrote:
> > On Thu, May 30, 2019 at 06:54:39PM +0800, Leo Yan wrote:
> > > Hi Jiri,
> > > 
> > > On Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa wrote:
> > > > hi,
> > > > this patchset adds dso support to read and display
> > > > bpf code in intel_pt trace output. I had to change
> > > > some of the kernel maps processing code, so hopefully
> > > > I did not break too many things ;-)
> > > > 
> > > > It's now possible to see bpf code flow via:
> > > > 
> > > >   # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
> > > >   # perf-with-kcore script pt --insn-trace --xed
> > > 
> > > This is very interesting work for me!
> > > 
> > > I want to verify this feature with Arm CoreSight trace, I have one
> > > question so that I have more direction for the tesing:
> > > 
> > > What's the bpf program you are suing for the testing?  e.g. some
> > > testing program under the kernel's folder $kernel/samples/bpf?
> > > Or you uses perf command to launch bpf program?
> > 
> > for this I was using tools/testing/selftests/bpf/test_verifier
> > 
> > I isolated some tests and ran the perf on top of them, like:
> > 
> >   # perf-with-kcore record pt -e intel_pt//ku -- ./test_verifier ...
> 
> Thanks a lot for sharing the info and quick responsing.
> 
> I tried to use the program $kernel/samples/bpf/sampleip to verify this
> patch set, but seems eBPF dso is not contained properly; below is my
> detailed steps:
> 
>     # In the first tty
>     # cd $kernel/samples/bpf/
>     # ./sampleip -F 200 20  => sample ip with 200Hz for 20s
> 
>     # In the second tty
>     # perf-with-kcore record arm_test -e cs_etm/@20070000.etr/uk -- sleep 1
> 
> If I output DSO info with report command it give below info, which
> doesn't contain any info for eBPF DSO?
> 
>     # perf-with-kcore report arm_test -F,dso
> 
>     # Samples: 6M of event 'branches:ku'
>     # Event count (approx.): 6340896
>     #
>     # Shared Object     
>     # ..................
>     #
>       [kernel.kallsyms] 
>       ld-2.28.so        
>       libc-2.28.so      
>       libpthread-2.28.so
>       perf              
>       sleep             
>       [unknown]         

One other way of testing this:

I used perf trace's use of BPF, using:

[root@quaco ~]# cat ~/.perfconfig
[llvm]
	dump-obj = true
	clang-opt = -g
[trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
	show_zeros = yes
	show_duration = no
	no_inherit = yes
	show_timestamp = no
	show_arg_names = no
	args_alignment = 40
	show_prefix = yes

For arm64 this needs fixing, tools/perf/examples/bpf/augmented_raw_syscalls.c
(its in the kernel sources) is still hard coded for x86_64 syscall numbers :-\

Use some other BPF workload, one that has its programs being hit so that
we get samples in it, in my case running:

    # perf trace

For system wide strace like tracing, which hooks in the
raw_syscalls:sys_enter and raw_syscalls:sys_exit tracepoints, I got:

[root@quaco ~]# perf record -a sleep 2s
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 3.136 MB perf.data (32020 samples) ]
[root@quaco ~]# perf report --stdio -s dso | head -40
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 32K of event 'cycles'
# Event count (approx.): 6201422424
#
# Overhead  Shared Object
# ........  ...................................
#
    80.92%  [kernel.vmlinux]
     5.14%  libxul.so
     3.60%  libc-2.28.so
     1.88%  sshd
     1.18%  trace
     1.02%  [nf_conntrack]
     0.73%  firefox
     0.57%  libcrypto.so.1.1.1b
     0.50%  libpthread-2.28.so
     0.45%  [r8152]
     0.44%  bpf_prog_2cf7fd321e9b084c_sys_enter
     0.43%  [JIT] tid 10475
     0.39%  bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.33%  [unknown]
     0.28%  [JIT] tid 10033
     0.21%  [JIT] tid 7243
     0.21%  libglib-2.0.so.0.5800.3
     0.14%  [nf_nat]
     0.13%  [JIT] tid 9488
     0.13%  [vdso]
     0.12%  ld-2.28.so
     0.09%  [iptable_raw]
     0.08%  [kvm]
     0.08%  libpulsecore-12.2.so
     0.07%  [iptable_mangle]
     0.06%  libjansson.so.4.11.0
     0.06%  libpulsecommon-12.2.so
     0.05%  [nf_defrag_ipv4]
     0.04%  libasound.so.2.0.0
[root@quaco ~]#

So you see those bpf_prog_2cf7fd321e9b084c_sys_enter and
bpf_prog_c1bd85c092d6e4aa_sys_exit DSOs, those are the BPF proggies that
'perf trace' used clang to build and then hooked into the raw_syscalls
tracepoints.

If I furthermore ask for annotating the only symbol in that DSO, I get
source code intermixed with the BPF jitted code, make sure you use a
recent enough clang version, here I'm using, looking at the dumped .o
file (asked via ~/.perfconfig's llvm.dump-obj=y that has BTF info
generated by clang because we have also llvm.clang-opt=-g there):

[root@quaco ~]# file /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
[root@quaco ~]# eu-readelf -winfo /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep -w producer
           producer             (strp) "clang version 9.0.0 (https://git.llvm.org/git/clang.git/ 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://git.llvm.org/git/llvm.git/ a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)"
[root@quaco ~]# readelf -SW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep -i BTF
  [23] .BTF              PROGBITS        0000000000000000 00229c 000c03 00      0   0  1
  [24] .BTF.ext          PROGBITS        0000000000000000 002e9f 000300 00      0   0  1
  [25] .rel.BTF.ext      REL             0000000000000000 004700 0002d0 10     31  24  8
[root@quaco ~]# 

# perf annotate --stdio2 bpf_prog_2cf7fd321e9b084c_sys_enter
Samples: 107  of event 'cycles', 4000 Hz, Event count (approx.): 27440959, [percent: local period]
bpf_prog_2cf7fd321e9b084c_sys_enter() bpf_prog_2cf7fd321e9b084c_sys_enter
Percent      int sys_enter(struct syscall_enter_args *args)
 65.78         push   %rbp
   
  0.48         mov    %rsp,%rbp
               sub    $0x30,%rsp
  1.41         sub    $0x28,%rbp
 10.66         mov    %rbx,0x0(%rbp)
  2.63         mov    %r13,0x8(%rbp)
               mov    %r14,0x10(%rbp)
  0.67         mov    %r15,0x18(%rbp)
  0.96         xor    %eax,%eax
               mov    %rax,0x20(%rbp)
               mov    %rdi,%rbx
               xor    %edi,%edi
             	int key = 0;
  0.70         mov    %edi,-0x8(%rbp)
               mov    %rbp,%rsi
             int sys_enter(struct syscall_enter_args *args)
  0.68         add    $0xfffffffffffffff8,%rsi
                     augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
  0.70         movabs $0xffff9c4bdf9d3800,%rdi

  0.70       → callq  *fffffffff98e80d5
               mov    %rax,%r13
               mov    $0x1,%eax
                     if (augmented_args == NULL)
  4.20         cmp    $0x0,%r13
             ↓ je     2b1     
             	return bpf_get_current_pid_tgid();
             → callq  *fffffffff98e4ac5
  0.70         mov    %eax,-0x4(%rbp)
               mov    %rbp,%rsi
               add    $0xfffffffffffffffc,%rsi
             	return bpf_map_lookup_elem(pids, &pid) != NULL;
  0.70         movabs $0xffff9c4f01d6a000,%rdi

  0.67       → callq  *fffffffff98e6085
               cmp    $0x0,%rax
             ↓ je     7d      
               add    $0x38,%rax
  1.80   7d:   mov    %rax,%rdi
               
               xor    %eax,%eax
             	if (pid_filter__has(&pids_filtered, getpid()))
               cmp    $0x0,%rdi
             ↓ jne    2b1     
             	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
  0.29         mov    %r13,%rdi
               mov    $0x40,%esi
               mov    %rbx,%rdx
             → callq  *fffffffff98c4025
             	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
               mov    %r13,%r14
               add    $0x8,%r14
             	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
               movabs $0xffff9c4efe8aa000,%rdi

               mov    %r14,%rsi
               add    $0xd0,%rdi
               mov    0x0(%rsi),%eax
               cmp    $0x200,%rax
             ↓ jae    cc      
               shl    $0x3,%rax

               add    %rdi,%rax
             ↓ jmp    ce      
         cc:   xor    %eax,%eax
         ce:   mov    %rax,%rdi
               
               xor    %eax,%eax
             	if (syscall == NULL || !syscall->enabled)
               cmp    $0x0,%rdi
             ↓ je     2b1     
             	if (syscall == NULL || !syscall->enabled)
  0.91         movzbq 0x0(%rdi),%rdi

               
               xor    %eax,%eax
             	if (syscall == NULL || !syscall->enabled)
               cmp    $0x0,%rdi
             ↓ je     2b1     
               mov    $0x40,%r8d
             	switch (augmented_args->args.syscall_nr) {
               mov    0x0(%r14),%rdi
             	switch (augmented_args->args.syscall_nr) {
               cmp    $0xef,%rdi
             ↓ jg     188     
               mov    %rdi,%rdx
               add    $0xffffffffffffff65,%rdx
               cmp    $0x2c,%rdx
             ↓ ja     11a     
             ↓ jmpq   20a     
        11a:   mov    %rdi,%rsi
               add    $0xffffffffffffffb4,%rsi
               cmp    $0x3d,%rsi
             ↓ ja     14b     
               mov    $0x1,%edx
               push   %rcx
   
               mov    %rsi,%rcx
               shl    %cl,%rdx

               pop    %rcx
   
               movabs $0x2200000000057fd1,%rsi

               and    %rsi,%rdx
               cmp    $0x0,%rdx
             ↓ jne    24b     
        14b:   cmp    $0x3b,%rdi
             ↓ ja     297     
               mov    $0x1,%esi
               push   %rcx
   
               mov    %rdi,%rcx
               shl    %cl,%rsi

               pop    %rcx
   
               movabs $0x800000000200054,%rdx

               and    %rdx,%rsi
               cmp    $0x0,%rsi
             ↓ jne    24b     
               cmp    $0x12,%rdi
             ↓ je     245     
             ↓ jmpq   297     
        188:   mov    %rdi,%rdx
               add    $0xffffffffffffff10,%rdx
               cmp    $0x3f,%rdx
             ↓ ja     1cc     
               mov    $0x1,%esi
               push   %rcx
   
               mov    %rdx,%rcx
               shl    %cl,%rsi

               pop    %rcx
   
               movabs $0x800001003bfe4004,%rdx

               mov    %rsi,%rcx
               and    %rdx,%rcx
               cmp    $0x0,%rcx
             ↓ jne    245     
               and    $0x4000303,%rsi
               cmp    $0x0,%rsi
             ↓ jne    24b     
        1cc:   mov    %rdi,%rsi
               add    $0xfffffffffffffec7,%rsi
               cmp    $0x13,%rsi
             ↓ ja     1fc     
               mov    $0x1,%edx
               push   %rcx
   
               mov    %rsi,%rcx
               shl    %cl,%rdx

               pop    %rcx
   
               and    $0x80209,%rdx
               cmp    $0x0,%rdx
             ↓ jne    245     
               cmp    $0x6,%rsi
             ↓ je     24b     
        1fc:   cmp    $0x1b1,%rdi
             ↓ je     245     
             ↓ jmpq   297     
        20a:   mov    $0x1,%esi
               push   %rcx
   
               mov    %rdx,%rcx
               shl    %cl,%rsi

               pop    %rcx
   
               movabs $0xdb600203141,%rdx

               mov    %rsi,%rcx
               and    %rdx,%rcx
               cmp    $0x0,%rcx
             ↓ jne    24b     
               movabs $0x104801000000,%rdx

               and    %rdx,%rsi
               cmp    $0x0,%rsi
             ↓ jne    245     
             ↑ jmpq   11a     
             	case SYS_OPENAT: filename_arg = (const void *)args->args[1];
        245:   mov    0x18(%rbx),%rdx
             ↓ jmp    24f     
             	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
        24b:   mov    0x10(%rbx),%rdx
             	if (filename_arg != NULL) {
        24f:   cmp    $0x0,%rdx
             ↓ je     297     
               xor    %edi,%edi
             		augmented_args->filename.reserved = 0;
               mov    %edi,0x44(%r13)
             		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
               mov    %r13,%rdi
               add    $0x48,%rdi
             		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
               mov    $0x1000,%esi
             → callq  *fffffffff98c4135
             		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
               mov    %eax,0x40(%r13)
               mov    $0x1048,%r8d
             		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
               mov    %rax,%rdi
               shl    $0x20,%rdi

               shr    $0x20,%rdi

             		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
               cmp    $0xfff,%rdi
             ↓ ja     297     
             			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
               add    $0x48,%rax
             			len &= sizeof(augmented_args->filename.value) - 1;
               and    $0xfff,%rax
               mov    %rax,%r8
             	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
        297:   mov    %rbx,%rdi
               movabs $0xffff9c4bdf9d3a00,%rsi

               mov    $0xffffffff,%edx
               mov    %r13,%rcx
             → callq  *fffffffff98c4775
             }          
  3.52  2b1:   mov    0x0(%rbp),%rbx
               mov    0x8(%rbp),%r13
               mov    0x10(%rbp),%r14
               mov    0x18(%rbp),%r15
               add    $0x28,%rbp
  1.84         leaveq         
             ← retq           

Look at the perf.data file for the required records, included in Linux
v5.1:

[root@quaco ~]# perf report -D | egrep 'PERF_RECORD_(BPF|KSYMBOL)'
0 0 0x54f0 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0240484 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
0 0 0x5540 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 13
0 0 0x5570 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0283679 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
0 0 0x55c0 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 14
0 0 0x55f0 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc023cef7 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
0 0 0x5640 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 15
0 0 0x5670 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0242837 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
0 0 0x56c0 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 16
0 0 0x56f0 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc046d593 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
0 0 0x5740 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 17
0 0 0x5770 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc046f397 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
0 0 0x57c0 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 18
0 0 0x57f0 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0d98039 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
0 0 0x5840 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 21
0 0 0x5870 [0x50]: PERF_RECORD_KSYMBOL addr ffffffffc0d9ad98 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
0 0 0x58c0 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 22
0 0 0x58f0 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffc092241b len 711 type 1 flags 0x0 name bpf_prog_2cf7fd321e9b084c_sys_enter
0 0 0x5948 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 286
0 0 0x5978 [0x58]: PERF_RECORD_KSYMBOL addr ffffffffc0b0d2d4 len 191 type 1 flags 0x0 name bpf_prog_c1bd85c092d6e4aa_sys_exit
0 0 0x59d0 [0x30]: PERF_RECORD_BPF_EVENT type 1, flags 0, id 287
[root@quaco ~]# perf evlist -v
cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
[root@quaco ~]#
 
> > I had to add some small sleep before the test_verifier exit,
> > so the perf bpf thread could catch up and download the program
> > details before test_verifier exited.
> 
> This seems to me for a 'real' eBPF program, do we also need extra sleep
> so that perf bpf can save dso properly?

See abovwe.
 
> BTW, I have another question: to display eBPF code, except this feature
> can be used by hardware tracing (e.g. intel_pt), it also can be used
> by other PMU events and timer events, right?

Yeah, again, see above.
 
> Thanks,
> Leo Yan

-- 

- Arnaldo
