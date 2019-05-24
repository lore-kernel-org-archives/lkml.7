Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C7BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CC52133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0qmFGpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbfEXA1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:27:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38255 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfEXA1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:27:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id p26so2448037qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 17:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0N+IOMnJlDjQ6/kZV5z3mQs/0M2QXWC1woPW3TQ2cPU=;
        b=Z0qmFGpRVDzAm+meMWpabEyfCm3qjJrmpRuBec25IyvpKhIxbAjybyyoCc623qSnkL
         4kWASGoQb6U6qf6EK/mpAX5+PEnOkFUHnPLqh8wSmNefi19bC9APMwcIXDu54Jo4u8Wm
         rvGnI5+wWeL++bBiw2U1aJm0z/3c1+1LMtDQ2MAKwDGPcbyYvCWlpIMf/lv/yEgBBSTs
         2dUyKKR40v6lyBLDQVzDnPD+SdJUQkOwbVRfgl82cBDGgjMvq72s608D/hLdEfZeZ2jZ
         Ht9ON/FqJvQJ/eHJkx0PY/13MR9mdVFPXFYdyLq+RCZHGDIN9BkONC/Hn9Xixf19H/jl
         TyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0N+IOMnJlDjQ6/kZV5z3mQs/0M2QXWC1woPW3TQ2cPU=;
        b=T/FDOF2Tx1D7xsswqwtkxlHDHcBhyNI7e4ZYi8Ukhw1wU5B5zgLe0kGa+O3t1P0HxW
         lpJF9VQWZRmSVX41bakokAMfzoUzMSHRrp5Y2eeqHPF/x9GHFp0N2S3ccjXkimZZijZi
         I68tSTrkSEd6KiU5tbccFQkNmsqzBKYxbGRfdKnlne8P81IE2MmHu88p4BruRGyAeuJt
         v15DF1OS7nhWbOxba4jejGJl1oHxx8rqGiPBO/bxS0iY0GgZQ5jGEBxLZXJXxBfacQvW
         jL72yCzHm0XSP4nN1dFh0NVOlxCBhMyDd29oi89w66jZEz7VYWlRMm+kqvfzYRwF4zio
         okSg==
X-Gm-Message-State: APjAAAUox3LW2UscO3Cvm9hNAy3dcU7yxweIFybpdF/nIOY3erAr8uji
        hqoTsXS6QSdiJyCZyI8uMXk=
X-Google-Smtp-Source: APXvYqwwWQNaVeVil2HE3XkUKxef1lU7VNWGKKYjWM7MJd6MFyeNGvqI5W9xQCisozT5Z9ntEBPqGQ==
X-Received: by 2002:ae9:c106:: with SMTP id z6mr16134938qki.65.1558657662578;
        Thu, 23 May 2019 17:27:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id g20sm552834qtc.53.2019.05.23.17.27.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 17:27:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A48641149; Thu, 23 May 2019 21:27:21 -0300 (-03)
Date:   Thu, 23 May 2019 21:27:21 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
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
Message-ID: <20190524002721.GA17479@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa escreveu:
> hi,
> this patchset adds dso support to read and display
> bpf code in intel_pt trace output. I had to change
> some of the kernel maps processing code, so hopefully
> I did not break too many things ;-)

One of these patches need some uintptr_t (IIRC) somewhere:

  CC       /tmp/build/perf/util/color_config.o
util/dso.c: In function 'bpf_read':
util/dso.c:725:8: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  buf = (u8 *) node->info_linear->info.jited_prog_insns;
        ^
  CC       /tmp/build/perf/util/metricgroup.o


Several 32-bit cross builds failed:

  51    30.64 ubuntu:16.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  52    74.89 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  53    32.23 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  54    75.33 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  55    75.96 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  56    71.70 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57   280.83 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3.2) 7.2.0
  58   274.85 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  59    33.88 ubuntu:18.04-x-arm            : FAIL arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  60    84.57 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04) 7.4.0
  61    27.01 ubuntu:18.04-x-m68k           : FAIL m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  62    34.56 ubuntu:18.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  63    87.19 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  64    88.42 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  65   150.80 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  66    75.12 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  67    31.68 ubuntu:18.04-x-sh4            : FAIL sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  68    73.71 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04) 7.4.0
  69   263.82 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.2.0-7ubuntu1) 8.2.0
  70   261.61 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  71    71.94 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  72    87.70 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  73    28.21 ubuntu:19.04-x-hppa           : FAIL hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
 
> It's now possible to see bpf code flow via:
> 
>   # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
>   # perf-with-kcore script pt --insn-trace --xed
>   ...
>            sleep 36660 [016] 1057036.806464404:  ffffffff811dfba5 trace_call_bpf+0x65 ([kernel.kallsyms])               nopl  %eax, (%rax,%rax,1)
>            sleep 36660 [016] 1057036.806464404:  ffffffff811dfbaa trace_call_bpf+0x6a ([kernel.kallsyms])               movq  0x30(%rbx), %rax
>            sleep 36660 [016] 1057036.806464404:  ffffffff811dfbae trace_call_bpf+0x6e ([kernel.kallsyms])               leaq  0x38(%rbx), %rsi
>            sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb2 trace_call_bpf+0x72 ([kernel.kallsyms])               mov %r13, %rdi
>            sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb5 trace_call_bpf+0x75 ([kernel.kallsyms])               callq  0xffffffff81c00c30
>            sleep 36660 [016] 1057036.806464404:  ffffffff81c00c30 __x86_indirect_thunk_rax+0x0 ([kernel.kallsyms])              callq  0xffffffff81c00c3c
>            sleep 36660 [016] 1057036.806464404:  ffffffff81c00c3c __x86_indirect_thunk_rax+0xc ([kernel.kallsyms])              movq  %rax, (%rsp)
>            sleep 36660 [016] 1057036.806464404:  ffffffff81c00c40 __x86_indirect_thunk_rax+0x10 ([kernel.kallsyms])             retq
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e89ef bpf_prog_da4fe6b3d2c29b25_trace_return+0x0 (bpf_prog_da4fe6b3d2c29b25_trace_return)           pushq  %rbp
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f0 bpf_prog_da4fe6b3d2c29b25_trace_return+0x1 (bpf_prog_da4fe6b3d2c29b25_trace_return)           mov %rsp, %rbp
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f3 bpf_prog_da4fe6b3d2c29b25_trace_return+0x4 (bpf_prog_da4fe6b3d2c29b25_trace_return)           sub $0x158, %rsp
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fa bpf_prog_da4fe6b3d2c29b25_trace_return+0xb (bpf_prog_da4fe6b3d2c29b25_trace_return)           sub $0x28, %rbp
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fe bpf_prog_da4fe6b3d2c29b25_trace_return+0xf (bpf_prog_da4fe6b3d2c29b25_trace_return)           movq  %rbx, (%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a02 bpf_prog_da4fe6b3d2c29b25_trace_return+0x13 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r13, 0x8(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a06 bpf_prog_da4fe6b3d2c29b25_trace_return+0x17 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r14, 0x10(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0a bpf_prog_da4fe6b3d2c29b25_trace_return+0x1b (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r15, 0x18(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0e bpf_prog_da4fe6b3d2c29b25_trace_return+0x1f (bpf_prog_da4fe6b3d2c29b25_trace_return)          xor %eax, %eax
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a10 bpf_prog_da4fe6b3d2c29b25_trace_return+0x21 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rax, 0x20(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a14 bpf_prog_da4fe6b3d2c29b25_trace_return+0x25 (bpf_prog_da4fe6b3d2c29b25_trace_return)          mov %rdi, %rbx
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a17 bpf_prog_da4fe6b3d2c29b25_trace_return+0x28 (bpf_prog_da4fe6b3d2c29b25_trace_return)          callq  0xffffffff811fed50
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed50 bpf_get_current_pid_tgid+0x0 ([kernel.kallsyms])              nopl  %eax, (%rax,%rax,1)
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed55 bpf_get_current_pid_tgid+0x5 ([kernel.kallsyms])              movq  %gs:0x15c00, %rdx
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed5e bpf_get_current_pid_tgid+0xe ([kernel.kallsyms])              test %rdx, %rdx
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed61 bpf_get_current_pid_tgid+0x11 ([kernel.kallsyms])             jz 0xffffffff811fed79
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed63 bpf_get_current_pid_tgid+0x13 ([kernel.kallsyms])             movsxdl  0x494(%rdx), %rax
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed6a bpf_get_current_pid_tgid+0x1a ([kernel.kallsyms])             movsxdl  0x490(%rdx), %rdx
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed71 bpf_get_current_pid_tgid+0x21 ([kernel.kallsyms])             shl $0x20, %rax
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed75 bpf_get_current_pid_tgid+0x25 ([kernel.kallsyms])             or %rdx, %rax
>            sleep 36660 [016] 1057036.806464725:  ffffffff811fed78 bpf_get_current_pid_tgid+0x28 ([kernel.kallsyms])             retq
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a1c bpf_prog_da4fe6b3d2c29b25_trace_return+0x2d (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rax, -0x8(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a20 bpf_prog_da4fe6b3d2c29b25_trace_return+0x31 (bpf_prog_da4fe6b3d2c29b25_trace_return)          xor %edi, %edi
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a22 bpf_prog_da4fe6b3d2c29b25_trace_return+0x33 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rdi, -0x10(%rbp)
>            sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a26 bpf_prog_da4fe6b3d2c29b25_trace_return+0x37 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rdi, -0x18(%rbp)
> 
>   # perf-core/perf-with-kcore script pt --call-trace
>   ...
>            sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                kretprobe_perf_func
>            sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                    trace_call_bpf
>            sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                        __x86_indirect_thunk_rax
>            sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                            __x86_indirect_thunk_rax
>            sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_pid_tgid
>            sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_ktime_get_ns
>            sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                    __x86_indirect_thunk_rax
>            sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                        __x86_indirect_thunk_rax
>            sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                __htab_map_lookup_elem
>            sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]                       )                                    memcmp
>            sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
>            sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
>            sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
>            sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_uid_gid
>            sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kgid
>            sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kuid
>            sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_perf_event_output
>            sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                    perf_event_output
>            sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                        perf_prepare_sample
>            sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                            perf_misc_flags
>            sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                __x86_indirect_thunk_rax
>            sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                    __x86_indirect_thunk_rax
> 
> 
> v3 changes:
>   - fix the padding code in patch 7 (Song Liu)
>   - rebased on current Arnaldo's perf/core with merged perf/urgent
> 
> v2 changes:
>   - fix missing pthread_mutex_unlock [Stanislav Fomichev]
>   - removed eBPF dso reusing [Adrian Hunter]
>   - merge eBPF and kcore maps [Adrian Hunter]
>   - few patches already applied
>   - added some perf script helper options
>   - patches are rebased on top of Arnaldo's perf/core with perf/urgent merged in
> 
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes
> 
> thanks,
> jirka
> 
> 
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
> Jiri Olsa (12):
>       perf tools: Separate generic code in dso__data_file_size
>       perf tools: Separate generic code in dso_cache__read
>       perf tools: Simplify dso_cache__read function
>       perf tools: Add bpf dso read and size hooks
>       perf tools: Read also the end of the kernel
>       perf tools: Keep zero in pgoff bpf map
>       perf script: Pad dso name for --call-trace
>       perf tools: Preserve eBPF maps when loading kcore
>       perf tests: Add map_groups__merge_in test
>       perf script: Add --show-bpf-events to show eBPF related events
>       perf script: Remove superfluous bpf event titles
>       perf script: Add --show-all-events option
> 
>  tools/include/linux/kernel.h             |   1 +
>  tools/lib/vsprintf.c                     |  19 +++++++++++++++++++
>  tools/perf/Documentation/perf-script.txt |   6 ++++++
>  tools/perf/builtin-script.c              |  56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/Build                   |   1 +
>  tools/perf/tests/builtin-test.c          |   4 ++++
>  tools/perf/tests/map_groups.c            | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h                 |   1 +
>  tools/perf/util/dso.c                    | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
>  tools/perf/util/event.c                  |   4 ++--
>  tools/perf/util/machine.c                |  31 ++++++++++++++++++++-----------
>  tools/perf/util/map.c                    |   6 ++++++
>  tools/perf/util/map_groups.h             |   2 ++
>  tools/perf/util/symbol.c                 |  97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  tools/perf/util/symbol_conf.h            |   1 +
>  15 files changed, 421 insertions(+), 53 deletions(-)
>  create mode 100644 tools/perf/tests/map_groups.c

-- 

- Arnaldo
