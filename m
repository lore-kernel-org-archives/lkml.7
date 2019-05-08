Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B513EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74407214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321620;
	bh=N38VbolsvzfVYNshxM1wUzDse9TGaO3gEZOziTxty3Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E/rvzuoNJRBl9Iw/QI0saIsHB/fAZmUcHVlrhTvDUoQQ+4Xx4yYVQca0vkhKPSh4J
	 tnWqVjKPnK1JmHuzndccsxyBW+yrfp3KrNim4KFAdi9IhoEfNdHfPake4EGDZBfUxT
	 gGwIe0buYTjzWTM+CmaKpnop9zYEPxQcfBhpBvyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfEHNUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbfEHNUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89E4E307E052;
        Wed,  8 May 2019 13:20:17 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6519F10027C9;
        Wed,  8 May 2019 13:20:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Subject: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Date:   Wed,  8 May 2019 15:19:58 +0200
Message-Id: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 13:20:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset adds dso support to read and display
bpf code in intel_pt trace output. I had to change
some of the kernel maps processing code, so hopefully
I did not break too many things ;-)

It's now possible to see bpf code flow via:

  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
  # perf-with-kcore script pt --insn-trace --xed
  ...
           sleep 36660 [016] 1057036.806464404:  ffffffff811dfba5 trace_call_bpf+0x65 ([kernel.kallsyms])               nopl  %eax, (%rax,%rax,1)
           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbaa trace_call_bpf+0x6a ([kernel.kallsyms])               movq  0x30(%rbx), %rax
           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbae trace_call_bpf+0x6e ([kernel.kallsyms])               leaq  0x38(%rbx), %rsi
           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb2 trace_call_bpf+0x72 ([kernel.kallsyms])               mov %r13, %rdi
           sleep 36660 [016] 1057036.806464404:  ffffffff811dfbb5 trace_call_bpf+0x75 ([kernel.kallsyms])               callq  0xffffffff81c00c30
           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c30 __x86_indirect_thunk_rax+0x0 ([kernel.kallsyms])              callq  0xffffffff81c00c3c
           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c3c __x86_indirect_thunk_rax+0xc ([kernel.kallsyms])              movq  %rax, (%rsp)
           sleep 36660 [016] 1057036.806464404:  ffffffff81c00c40 __x86_indirect_thunk_rax+0x10 ([kernel.kallsyms])             retq
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89ef bpf_prog_da4fe6b3d2c29b25_trace_return+0x0 (bpf_prog_da4fe6b3d2c29b25_trace_return)           pushq  %rbp
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f0 bpf_prog_da4fe6b3d2c29b25_trace_return+0x1 (bpf_prog_da4fe6b3d2c29b25_trace_return)           mov %rsp, %rbp
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89f3 bpf_prog_da4fe6b3d2c29b25_trace_return+0x4 (bpf_prog_da4fe6b3d2c29b25_trace_return)           sub $0x158, %rsp
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fa bpf_prog_da4fe6b3d2c29b25_trace_return+0xb (bpf_prog_da4fe6b3d2c29b25_trace_return)           sub $0x28, %rbp
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e89fe bpf_prog_da4fe6b3d2c29b25_trace_return+0xf (bpf_prog_da4fe6b3d2c29b25_trace_return)           movq  %rbx, (%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a02 bpf_prog_da4fe6b3d2c29b25_trace_return+0x13 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r13, 0x8(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a06 bpf_prog_da4fe6b3d2c29b25_trace_return+0x17 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r14, 0x10(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0a bpf_prog_da4fe6b3d2c29b25_trace_return+0x1b (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %r15, 0x18(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a0e bpf_prog_da4fe6b3d2c29b25_trace_return+0x1f (bpf_prog_da4fe6b3d2c29b25_trace_return)          xor %eax, %eax
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a10 bpf_prog_da4fe6b3d2c29b25_trace_return+0x21 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rax, 0x20(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a14 bpf_prog_da4fe6b3d2c29b25_trace_return+0x25 (bpf_prog_da4fe6b3d2c29b25_trace_return)          mov %rdi, %rbx
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a17 bpf_prog_da4fe6b3d2c29b25_trace_return+0x28 (bpf_prog_da4fe6b3d2c29b25_trace_return)          callq  0xffffffff811fed50
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed50 bpf_get_current_pid_tgid+0x0 ([kernel.kallsyms])              nopl  %eax, (%rax,%rax,1)
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed55 bpf_get_current_pid_tgid+0x5 ([kernel.kallsyms])              movq  %gs:0x15c00, %rdx
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed5e bpf_get_current_pid_tgid+0xe ([kernel.kallsyms])              test %rdx, %rdx
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed61 bpf_get_current_pid_tgid+0x11 ([kernel.kallsyms])             jz 0xffffffff811fed79
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed63 bpf_get_current_pid_tgid+0x13 ([kernel.kallsyms])             movsxdl  0x494(%rdx), %rax
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed6a bpf_get_current_pid_tgid+0x1a ([kernel.kallsyms])             movsxdl  0x490(%rdx), %rdx
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed71 bpf_get_current_pid_tgid+0x21 ([kernel.kallsyms])             shl $0x20, %rax
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed75 bpf_get_current_pid_tgid+0x25 ([kernel.kallsyms])             or %rdx, %rax
           sleep 36660 [016] 1057036.806464725:  ffffffff811fed78 bpf_get_current_pid_tgid+0x28 ([kernel.kallsyms])             retq
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a1c bpf_prog_da4fe6b3d2c29b25_trace_return+0x2d (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rax, -0x8(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a20 bpf_prog_da4fe6b3d2c29b25_trace_return+0x31 (bpf_prog_da4fe6b3d2c29b25_trace_return)          xor %edi, %edi
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a22 bpf_prog_da4fe6b3d2c29b25_trace_return+0x33 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rdi, -0x10(%rbp)
           sleep 36660 [016] 1057036.806464725:  ffffffffa05e8a26 bpf_prog_da4fe6b3d2c29b25_trace_return+0x37 (bpf_prog_da4fe6b3d2c29b25_trace_return)          movq  %rdi, -0x18(%rbp)

  # perf-core/perf-with-kcore script pt --call-trace
  ...
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                kretprobe_perf_func
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                    trace_call_bpf
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                            __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_pid_tgid
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_ktime_get_ns
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                    __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                __htab_map_lookup_elem
           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]                       )                                    memcmp
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_uid_gid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kgid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kuid
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                    perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                        perf_prepare_sample
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                            perf_misc_flags
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                    __x86_indirect_thunk_rax


v3 changes:
  - fix the padding code in patch 7 (Song Liu)
  - rebased on current Arnaldo's perf/core with merged perf/urgent

v2 changes:
  - fix missing pthread_mutex_unlock [Stanislav Fomichev]
  - removed eBPF dso reusing [Adrian Hunter]
  - merge eBPF and kcore maps [Adrian Hunter]
  - few patches already applied
  - added some perf script helper options
  - patches are rebased on top of Arnaldo's perf/core with perf/urgent merged in

It's also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
Jiri Olsa (12):
      perf tools: Separate generic code in dso__data_file_size
      perf tools: Separate generic code in dso_cache__read
      perf tools: Simplify dso_cache__read function
      perf tools: Add bpf dso read and size hooks
      perf tools: Read also the end of the kernel
      perf tools: Keep zero in pgoff bpf map
      perf script: Pad dso name for --call-trace
      perf tools: Preserve eBPF maps when loading kcore
      perf tests: Add map_groups__merge_in test
      perf script: Add --show-bpf-events to show eBPF related events
      perf script: Remove superfluous bpf event titles
      perf script: Add --show-all-events option

 tools/include/linux/kernel.h             |   1 +
 tools/lib/vsprintf.c                     |  19 +++++++++++++++++++
 tools/perf/Documentation/perf-script.txt |   6 ++++++
 tools/perf/builtin-script.c              |  56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   4 ++++
 tools/perf/tests/map_groups.c            | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/dso.c                    | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------
 tools/perf/util/event.c                  |   4 ++--
 tools/perf/util/machine.c                |  31 ++++++++++++++++++++-----------
 tools/perf/util/map.c                    |   6 ++++++
 tools/perf/util/map_groups.h             |   2 ++
 tools/perf/util/symbol.c                 |  97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/symbol_conf.h            |   1 +
 15 files changed, 421 insertions(+), 53 deletions(-)
 create mode 100644 tools/perf/tests/map_groups.c
