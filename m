Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94872192B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194520;
	bh=LlvP+hxyaWwn2YHnAexEgK+pO/wgQtQ6fsuuw4Rc9Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCHM/zCL7LR6IbwbMZ0zzZkK0OoLaHcXlGC4omq3nuPJAQTD/ueZr+upqH2XFKtmo
	 5sQfDLjBZxbvfOc5NlYrByrrliee9exwtaGVPHCx0VumcxxLzpZoJkJBeeNqyoWu+v
	 btBrjem+wdi8P6N4lB1e3NLx+xsCBeVU7P8f9ZiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfCUSzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfCUSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:55:16 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9BD21873;
        Thu, 21 Mar 2019 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194515;
        bh=LlvP+hxyaWwn2YHnAexEgK+pO/wgQtQ6fsuuw4Rc9Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbZtqHYOt1Kz25y/ngEZm6F5jqMeZ1LrylvGBvm3EaE6AyD2rLvHCKAA2NYMEQ7Re
         R4WO3rIaejVC3hmlFb4qOiAOCargrKzya6vRRuLTBvNKywtn93d4K19c0BGmR2cl+U
         Jyz8L5Un2CmA5So6H3KaoEBKIxiiXEJ54WwX1nEg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 40/44] perf annotate: Enable annotation of BPF programs
Date:   Thu, 21 Mar 2019 15:51:38 -0300
Message-Id: <20190321185142.11441-41-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

In symbol__disassemble(), DSO_BINARY_TYPE__BPF_PROG_INFO dso calls into
a new function symbol__disassemble_bpf(), where annotation line
information is filled based on the bpf_prog_info and btf data saved in
given perf_env.

symbol__disassemble_bpf() uses binutils's libopcodes to disassemble bpf
programs.

Committer testing:

After fixing this:

  -               u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
  +               u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);

Detected when crossbuilding to a 32-bit arch.

And making all this dependent on HAVE_LIBBFD_SUPPORT and
HAVE_LIBBPF_SUPPORT:

1) Have a BPF program running, one that has BTF info, etc, I used
   the tools/perf/examples/bpf/augmented_raw_syscalls.c put in place
   by 'perf trace'.

  # grep -B1 augmented_raw ~/.perfconfig
  [trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
  #
  # perf trace -e *mmsg
  dnf/6245 sendmmsg(20, 0x7f5485a88030, 2, MSG_NOSIGNAL) = 2
  NetworkManager/10055 sendmmsg(22<socket:[1056822]>, 0x7f8126ad1bb0, 2, MSG_NOSIGNAL) = 2

2) Then do a 'perf record' system wide for a while:

  # perf record -a
  ^C[ perf record: Woken up 68 times to write data ]
  [ perf record: Captured and wrote 19.427 MB perf.data (366891 samples) ]
  #

3) Check that we captured BPF and BTF info in the perf.data file:

  # perf report --header-only | grep 'b[pt]f'
  # event : name = cycles:ppp, , id = { 294789, 294790, 294791, 294792, 294793, 294794, 294795, 294796 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
  # bpf_prog_info of id 13
  # bpf_prog_info of id 14
  # bpf_prog_info of id 15
  # bpf_prog_info of id 16
  # bpf_prog_info of id 17
  # bpf_prog_info of id 18
  # bpf_prog_info of id 21
  # bpf_prog_info of id 22
  # bpf_prog_info of id 41
  # bpf_prog_info of id 42
  # btf info of id 2
  #

4) Check which programs got recorded:

   # perf report | grep bpf_prog | head
     0.16%  exe              bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
     0.14%  exe              bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.08%  fuse-overlayfs   bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
     0.07%  fuse-overlayfs   bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.01%  clang-4.0        bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.01%  clang-4.0        bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  clang            bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
     0.00%  runc             bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  clang            bpf_prog_819967866022f1e1_sys_enter      [k] bpf_prog_819967866022f1e1_sys_enter
     0.00%  sh               bpf_prog_c1bd85c092d6e4aa_sys_exit       [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
  #

  This was with the default --sort order for 'perf report', which is:

    --sort comm,dso,symbol

  If we just look for the symbol, for instance:

   # perf report --sort symbol | grep bpf_prog | head
     0.26%  [k] bpf_prog_819967866022f1e1_sys_enter                -      -
     0.24%  [k] bpf_prog_c1bd85c092d6e4aa_sys_exit                 -      -
   #

  or the DSO:

   # perf report --sort dso | grep bpf_prog | head
     0.26%  bpf_prog_819967866022f1e1_sys_enter
     0.24%  bpf_prog_c1bd85c092d6e4aa_sys_exit
  #

We'll see the two BPF programs that augmented_raw_syscalls.o puts in
place,  one attached to the raw_syscalls:sys_enter and another to the
raw_syscalls:sys_exit tracepoints, as expected.

Now we can finally do, from the command line, annotation for one of
those two symbols, with the original BPF program source coude intermixed
with the disassembled JITed code:

  # perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter

  Samples: 950  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 553756947, [percent: local period]
  bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
  Percent      int sys_enter(struct syscall_enter_args *args)
   53.41         push   %rbp

    0.63         mov    %rsp,%rbp
    0.31         sub    $0x170,%rsp
    1.93         sub    $0x28,%rbp
    7.02         mov    %rbx,0x0(%rbp)
    3.20         mov    %r13,0x8(%rbp)
    1.07         mov    %r14,0x10(%rbp)
    0.61         mov    %r15,0x18(%rbp)
    0.11         xor    %eax,%eax
    1.29         mov    %rax,0x20(%rbp)
    0.11         mov    %rdi,%rbx
               	return bpf_get_current_pid_tgid();
    2.02       → callq  *ffffffffda6776d9
    2.76         mov    %eax,-0x148(%rbp)
                 mov    %rbp,%rsi
               int sys_enter(struct syscall_enter_args *args)
                 add    $0xfffffffffffffeb8,%rsi
               	return bpf_map_lookup_elem(pids, &pid) != NULL;
                 movabs $0xffff975ac2607800,%rdi

    1.26       → callq  *ffffffffda6789e9
                 cmp    $0x0,%rax
    2.43       → je     0
                 add    $0x38,%rax
    0.21         xor    %r13d,%r13d
               	if (pid_filter__has(&pids_filtered, getpid()))
    0.81         cmp    $0x0,%rax
               → jne    0
                 mov    %rbp,%rdi
               	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
    2.22         add    $0xfffffffffffffeb8,%rdi
    0.11         mov    $0x40,%esi
    0.32         mov    %rbx,%rdx
    2.74       → callq  *ffffffffda658409
               	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
    0.22         mov    %rbp,%rsi
    1.69         add    $0xfffffffffffffec0,%rsi
               	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
                 movabs $0xffff975bfcd36000,%rdi

                 add    $0xd0,%rdi
    0.21         mov    0x0(%rsi),%eax
    0.93         cmp    $0x200,%rax
               → jae    0
    0.10         shl    $0x3,%rax

    0.11         add    %rdi,%rax
    0.11       → jmp    0
                 xor    %eax,%eax
               	if (syscall == NULL || !syscall->enabled)
    1.07         cmp    $0x0,%rax
               → je     0
               	if (syscall == NULL || !syscall->enabled)
    6.57         movzbq 0x0(%rax),%rdi

               	if (syscall == NULL || !syscall->enabled)
                 cmp    $0x0,%rdi
    0.95       → je     0
                 mov    $0x40,%r8d
               	switch (augmented_args.args.syscall_nr) {
                 mov    -0x140(%rbp),%rdi
               	switch (augmented_args.args.syscall_nr) {
                 cmp    $0x2,%rdi
               → je     0
                 cmp    $0x101,%rdi
               → je     0
                 cmp    $0x15,%rdi
               → jne    0
               	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
                 mov    0x10(%rbx),%rdx
               → jmp    0
               	case SYS_OPENAT: filename_arg = (const void *)args->args[1];
                 mov    0x18(%rbx),%rdx
               	if (filename_arg != NULL) {
                 cmp    $0x0,%rdx
               → je     0
                 xor    %edi,%edi
               		augmented_args.filename.reserved = 0;
                 mov    %edi,-0x104(%rbp)
               		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                 mov    %rbp,%rdi
                 add    $0xffffffffffffff00,%rdi
               		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                 mov    $0x100,%esi
               → callq  *ffffffffda658499
                 mov    $0x148,%r8d
               		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                 mov    %eax,-0x108(%rbp)
               		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
                 mov    %rax,%rdi
                 shl    $0x20,%rdi

                 shr    $0x20,%rdi

               		if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {
                 cmp    $0xff,%rdi
               → ja     0
               			len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;
                 add    $0x48,%rax
               			len &= sizeof(augmented_args.filename.value) - 1;
                 and    $0xff,%rax
                 mov    %rax,%r8
                 mov    %rbp,%rcx
               	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
                 add    $0xfffffffffffffeb8,%rcx
                 mov    %rbx,%rdi
                 movabs $0xffff975fbd72d800,%rsi

                 mov    $0xffffffff,%edx
               → callq  *ffffffffda658ad9
                 mov    %rax,%r13
               }
                 mov    %r13,%rax
    0.72         mov    0x0(%rbp),%rbx
                 mov    0x8(%rbp),%r13
    1.16         mov    0x10(%rbp),%r14
    0.10         mov    0x18(%rbp),%r15
    0.42         add    $0x28,%rbp
    0.54         leaveq
    0.54       ← retq
  #

Please see 'man perf-config' to see how to control what should be seen,
via ~/.perfconfig [annotate] section, for instance, one can suppress the
source code and see just the disassembly, etc.

Alternatively, use the TUI bu just using 'perf annotate', press
'/bpf_prog' to see the bpf symbols, press enter and do the interactive
annotation, which allows for dumping to a file after selecting the
the various output tunables, for instance, the above without source code
intermixed, plus showing all the instruction offsets:

  # perf annotate bpf_prog_819967866022f1e1_sys_enter

Then press: 's' to hide the source code + 'O' twice to show all
instruction offsets, then 'P' to print to the
bpf_prog_819967866022f1e1_sys_enter.annotation file, which will have:

  # cat bpf_prog_819967866022f1e1_sys_enter.annotation
  bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
  Event: cycles:ppp

   53.41    0:   push   %rbp

    0.63    1:   mov    %rsp,%rbp
    0.31    4:   sub    $0x170,%rsp
    1.93    b:   sub    $0x28,%rbp
    7.02    f:   mov    %rbx,0x0(%rbp)
    3.20   13:   mov    %r13,0x8(%rbp)
    1.07   17:   mov    %r14,0x10(%rbp)
    0.61   1b:   mov    %r15,0x18(%rbp)
    0.11   1f:   xor    %eax,%eax
    1.29   21:   mov    %rax,0x20(%rbp)
    0.11   25:   mov    %rdi,%rbx
    2.02   28: → callq  *ffffffffda6776d9
    2.76   2d:   mov    %eax,-0x148(%rbp)
           33:   mov    %rbp,%rsi
           36:   add    $0xfffffffffffffeb8,%rsi
           3d:   movabs $0xffff975ac2607800,%rdi

    1.26   47: → callq  *ffffffffda6789e9
           4c:   cmp    $0x0,%rax
    2.43   50: → je     0
           52:   add    $0x38,%rax
    0.21   56:   xor    %r13d,%r13d
    0.81   59:   cmp    $0x0,%rax
           5d: → jne    0
           63:   mov    %rbp,%rdi
    2.22   66:   add    $0xfffffffffffffeb8,%rdi
    0.11   6d:   mov    $0x40,%esi
    0.32   72:   mov    %rbx,%rdx
    2.74   75: → callq  *ffffffffda658409
    0.22   7a:   mov    %rbp,%rsi
    1.69   7d:   add    $0xfffffffffffffec0,%rsi
           84:   movabs $0xffff975bfcd36000,%rdi

           8e:   add    $0xd0,%rdi
    0.21   95:   mov    0x0(%rsi),%eax
    0.93   98:   cmp    $0x200,%rax
           9f: → jae    0
    0.10   a1:   shl    $0x3,%rax

    0.11   a5:   add    %rdi,%rax
    0.11   a8: → jmp    0
           aa:   xor    %eax,%eax
    1.07   ac:   cmp    $0x0,%rax
           b0: → je     0
    6.57   b6:   movzbq 0x0(%rax),%rdi

           bb:   cmp    $0x0,%rdi
    0.95   bf: → je     0
           c5:   mov    $0x40,%r8d
           cb:   mov    -0x140(%rbp),%rdi
           d2:   cmp    $0x2,%rdi
           d6: → je     0
           d8:   cmp    $0x101,%rdi
           df: → je     0
           e1:   cmp    $0x15,%rdi
           e5: → jne    0
           e7:   mov    0x10(%rbx),%rdx
           eb: → jmp    0
           ed:   mov    0x18(%rbx),%rdx
           f1:   cmp    $0x0,%rdx
           f5: → je     0
           f7:   xor    %edi,%edi
           f9:   mov    %edi,-0x104(%rbp)
           ff:   mov    %rbp,%rdi
          102:   add    $0xffffffffffffff00,%rdi
          109:   mov    $0x100,%esi
          10e: → callq  *ffffffffda658499
          113:   mov    $0x148,%r8d
          119:   mov    %eax,-0x108(%rbp)
          11f:   mov    %rax,%rdi
          122:   shl    $0x20,%rdi

          126:   shr    $0x20,%rdi

          12a:   cmp    $0xff,%rdi
          131: → ja     0
          133:   add    $0x48,%rax
          137:   and    $0xff,%rax
          13d:   mov    %rax,%r8
          140:   mov    %rbp,%rcx
          143:   add    $0xfffffffffffffeb8,%rcx
          14a:   mov    %rbx,%rdi
          14d:   movabs $0xffff975fbd72d800,%rsi

          157:   mov    $0xffffffff,%edx
          15c: → callq  *ffffffffda658ad9
          161:   mov    %rax,%r13
          164:   mov    %r13,%rax
    0.72  167:   mov    0x0(%rbp),%rbx
          16b:   mov    0x8(%rbp),%r13
    1.16  16f:   mov    0x10(%rbp),%r14
    0.10  173:   mov    0x18(%rbp),%r15
    0.42  177:   add    $0x28,%rbp
    0.54  17b:   leaveq
    0.54  17c: ← retq

Another cool way to test all this is to symple use 'perf top' look for
those symbols, go there and press enter, annotate it live :-)

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c  | 163 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/annotate.h  |   1 +
 tools/perf/util/bpf-event.c |   2 +-
 3 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5f6dbbf5d749..c8b01176c9e1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -10,6 +10,10 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <libgen.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <linux/btf.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
@@ -24,6 +28,7 @@
 #include "annotate.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "bpf-event.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -31,6 +36,7 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1615,6 +1621,9 @@ int symbol__strerror_disassemble(struct symbol *sym __maybe_unused, struct map *
 			  "  --vmlinux vmlinux\n", build_id_msg ?: "");
 	}
 		break;
+	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
+		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
+		break;
 	default:
 		scnprintf(buf, buflen, "Internal error: Invalid %d error code\n", errnum);
 		break;
@@ -1674,6 +1683,156 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
+#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+#define PACKAGE "perf"
+#include <bfd.h>
+#include <dis-asm.h>
+
+static int symbol__disassemble_bpf(struct symbol *sym,
+				   struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotation_options *opts = args->options;
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct disassemble_info info;
+	struct dso *dso = map->dso;
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	int ret = -1;
+	char *buf;
+	bfd *bfdf;
+	FILE *s;
+
+	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return -1;
+
+	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
+		 sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	perf_exe(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	assert(bfdf);
+	assert(bfd_check_format(bfdf, bfd_object));
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s)
+		goto out;
+	init_disassemble_info(&info, s,
+			      (fprintf_ftype) fprintf);
+
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
+						 dso->bpf_prog.id);
+	if (!info_node)
+		goto out;
+	info_linear = info_node->info_linear;
+	sub_id = dso->bpf_prog.sub_id;
+
+	info.buffer = (void *)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso->bpf_prog.env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	assert(disassemble);
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!opts->hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl) {
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+			}
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+}
+#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
+				   struct annotate_args *args __maybe_unused)
+{
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+}
+#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
+
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
@@ -1701,7 +1860,9 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	pr_debug("annotating [%p] %30s : [%p] %30s\n",
 		 dso, dso->long_name, sym, sym->name);
 
-	if (dso__is_kcore(dso)) {
+	if (dso->binary_type == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+		return symbol__disassemble_bpf(sym, args);
+	} else if (dso__is_kcore(dso)) {
 		kce.kcore_filename = symfs_filename;
 		kce.addr = map__rip_2objdump(map, sym->start);
 		kce.offs = sym->start;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index df34fe483164..5bc0cf655d37 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -369,6 +369,7 @@ enum symbol_disassemble_errno {
 	__SYMBOL_ANNOTATE_ERRNO__START		= -10000,
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
+	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
 
 	__SYMBOL_ANNOTATE_ERRNO__END,
 };
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 852e960692cb..7ffe7db59828 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -46,7 +46,7 @@ static int machine__process_bpf_event_load(struct machine *machine,
 	info_linear = info_node->info_linear;
 
 	for (i = 0; i < info_linear->info.nr_jited_ksyms; i++) {
-		u64 *addrs = (u64 *)(info_linear->info.jited_ksyms);
+		u64 *addrs = (u64 *)(uintptr_t)(info_linear->info.jited_ksyms);
 		u64 addr = addrs[i];
 		struct map *map;
 
-- 
2.20.1

