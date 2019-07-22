Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5180E21BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817224;
	bh=geBSAxBrfqx9cTVP6kvrxC2Y13BGZ8SmG/e/vEa4RSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjGDYbyVeX4mTmWXktx9DSe3Oayx5+UjsJRINf1q2IOqyKridLvQCVXwDAN4XJaaM
	 Cp2WfHQVTVwXynHJov2pMK5vWbWRSmhCV1r9gR8n8jJdYYf4ALiyq5KBH4zhM7O0NI
	 RUfz54/MQIfls1grcJmCVnMa/ArfQ9fneVn62fK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfGVRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:21 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46F221903;
        Mon, 22 Jul 2019 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817220;
        bh=geBSAxBrfqx9cTVP6kvrxC2Y13BGZ8SmG/e/vEa4RSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SniTnZ4JJmHtwr+QSSegYoS/4pk1TGMjvd3QS0Kj7OwdKMFS1ZSRVjMfVkm0Ge6+/
         86FthTctDw85dlRnze6coIEBBOXYiSYN/7RqBkFRhaNVXrIlGPFLvLAqNqWFtf7cxO
         uX6p4scrDfSbtopbjxNq6+9eFdboUXIXqHufgDs0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 12/37] perf augmented_raw_syscalls: Switch to using BPF_MAP_TYPE_PROG_ARRAY
Date:   Mon, 22 Jul 2019 14:38:14 -0300
Message-Id: <20190722173839.22898-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Trying to control what arguments to copy, which ones were strings, etc
all from userspace via maps went nowhere, lots of difficulties to get
the verifier satisfied, so use what the fine BPF guys designed for such
a syscall handling mechanism: bpf_tail_call + BPF_MAP_TYPE_PROG_ARRAY.

The series leading to this should have explained it thoroughly, but the
end result, explained via gdb should help understand this:

  Breakpoint 1, syscall_arg__scnprintf_filename (bf=0xc002b1 "", size=2031, arg=0x7fffffff7970) at builtin-trace.c:1268
  1268	{
  (gdb) n
  1269		unsigned long ptr = arg->val;
  (gdb) n
  1271		if (arg->augmented.args)
  (gdb) n
  1272			return syscall_arg__scnprintf_augmented_string(arg, bf, size);
  (gdb) s
  syscall_arg__scnprintf_augmented_string (arg=0x7fffffff7970, bf=0xc002b1 "", size=2031) at builtin-trace.c:1251
  1251	{
  (gdb) n
  1252		struct augmented_arg *augmented_arg = arg->augmented.args;
  (gdb) n
  1253		size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
  (gdb) n
  1258		int consumed = sizeof(*augmented_arg) + augmented_arg->size;
  (gdb) p bf
  $1 = 0xc002b1 "\"/etc/ld.so.cache\""
  (gdb) bt
  #0  syscall_arg__scnprintf_augmented_string (arg=0x7fffffff7970, bf=0xc002b1 "\"/etc/ld.so.cache\"", size=2031) at builtin-trace.c:1258
  #1  0x0000000000492634 in syscall_arg__scnprintf_filename (bf=0xc002b1 "\"/etc/ld.so.cache\"", size=2031, arg=0x7fffffff7970) at builtin-trace.c:1272
  #2  0x0000000000493cd7 in syscall__scnprintf_val (sc=0xc0de68, bf=0xc002b1 "\"/etc/ld.so.cache\"", size=2031, arg=0x7fffffff7970, val=140737354091036) at builtin-trace.c:1689
  #3  0x000000000049404f in syscall__scnprintf_args (sc=0xc0de68, bf=0xc002a7 "AT_FDCWD, \"/etc/ld.so.cache\"", size=2041, args=0x7ffff6cbf1ec "\234\377\377\377", augmented_args=0x7ffff6cbf21c, augmented_args_size=28, trace=0x7fffffffa170,
      thread=0xbff940) at builtin-trace.c:1756
  #4  0x0000000000494a97 in trace__sys_enter (trace=0x7fffffffa170, evsel=0xbe1900, event=0x7ffff6cbf1a0, sample=0x7fffffff7b00) at builtin-trace.c:1975
  #5  0x0000000000496ff1 in trace__handle_event (trace=0x7fffffffa170, event=0x7ffff6cbf1a0, sample=0x7fffffff7b00) at builtin-trace.c:2685
  #6  0x0000000000497edb in __trace__deliver_event (trace=0x7fffffffa170, event=0x7ffff6cbf1a0) at builtin-trace.c:3029
  #7  0x000000000049801e in trace__deliver_event (trace=0x7fffffffa170, event=0x7ffff6cbf1a0) at builtin-trace.c:3056
  #8  0x00000000004988de in trace__run (trace=0x7fffffffa170, argc=2, argv=0x7fffffffd660) at builtin-trace.c:3258
  #9  0x000000000049c2d3 in cmd_trace (argc=2, argv=0x7fffffffd660) at builtin-trace.c:4220
  #10 0x00000000004dcb6c in run_builtin (p=0xa18e00 <commands+576>, argc=5, argv=0x7fffffffd660) at perf.c:304
  #11 0x00000000004dcdd9 in handle_internal_command (argc=5, argv=0x7fffffffd660) at perf.c:356
  #12 0x00000000004dcf20 in run_argv (argcp=0x7fffffffd4bc, argv=0x7fffffffd4b0) at perf.c:400
  #13 0x00000000004dd28c in main (argc=5, argv=0x7fffffffd660) at perf.c:522
  (gdb)
  (gdb) continue
  Continuing.
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3

Now its a matter of automagically assigning the BPF programs copying
syscall arg pointers to functions that are "open"-like (i.e. that need
only the first syscall arg copied as a string), or "openat"-like (2nd
arg, etc).

End result in tool output:

  # perf trace -e open* ls /tmp/notthere
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libselinux.so.1", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libcap.so.2", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libpcre2-8.so.0", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) = ls: cannot access '/tmp/notthere'-1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/coreutils.mo", O_RDONLY: No such file or directory) =
  -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-snc7ry99cl6r0pqaspjim98x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 127 +++---------------
 1 file changed, 16 insertions(+), 111 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 661936f90fe0..ce308b9a317c 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -174,131 +174,36 @@ int sys_enter(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
-	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
-	if (syscall == NULL || !syscall->enabled)
-		return 0;
 	/*
-	 * Yonghong and Edward Cree sayz:
-	 *
-	 * https://www.spinics.net/lists/netdev/msg531645.html
-	 *
-	 * >>   R0=inv(id=0) R1=inv2 R6=ctx(id=0,off=0,imm=0) R7=inv64 R10=fp0,call_-1
-	 * >> 10: (bf) r1 = r6
-	 * >> 11: (07) r1 += 16
-	 * >> 12: (05) goto pc+2
-	 * >> 15: (79) r3 = *(u64 *)(r1 +0)
-	 * >> dereference of modified ctx ptr R1 off=16 disallowed
-	 * > Aha, we at least got a different error message this time.
-	 * > And indeed llvm has done that optimisation, rather than the more obvious
-	 * > 11: r3 = *(u64 *)(r1 +16)
-	 * > because it wants to have lots of reads share a single insn.  You may be able
-	 * > to defeat that optimisation by adding compiler barriers, idk.  Maybe someone
-	 * > with llvm knowledge can figure out how to stop it (ideally, llvm would know
-	 * > when it's generating for bpf backend and not do that).  -O0?  ¯\_(ツ)_/¯
-	 *
-	 * The optimization mostly likes below:
-	 *
-	 *	br1:
-	 * 	...
-	 *	r1 += 16
-	 *	goto merge
-	 *	br2:
-	 *	...
-	 *	r1 += 20
-	 *	goto merge
-	 *	merge:
-	 *	*(u64 *)(r1 + 0)
-	 *
-	 * The compiler tries to merge common loads. There is no easy way to
-	 * stop this compiler optimization without turning off a lot of other
-	 * optimizations. The easiest way is to add barriers:
-	 *
-	 * 	 __asm__ __volatile__("": : :"memory")
-	 *
-	 * 	 after the ctx memory access to prevent their down stream merging.
+	 * Jump to syscall specific augmenter, even if the default one,
+	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
+	 * unagmented tracepoint payload.
 	 */
-	/*
-	 * For now copy just the first string arg, we need to improve the protocol
-	 * and have more than one.
-	 *
-	 * Using the unrolled loop is not working, only when we do it manually,
-	 * check this out later...
-
-	u8 arg;
-#pragma clang loop unroll(full)
-	for (arg = 0; arg < 6; ++arg) {
-		if (syscall->string_args_len[arg] != 0) {
-			filename_len = syscall->string_args_len[arg];
-			filename_arg = (const void *)args->args[arg];
-			__asm__ __volatile__("": : :"memory");
-			break;
-		}
-	}
-
-	verifier log:
-
-; if (syscall->string_args_len[arg] != 0) {
-37: (69) r3 = *(u16 *)(r0 +2)
- R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1_w=inv0 R2_w=map_value(id=0,off=2,ks=4,vs=14,imm=0) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
-; if (syscall->string_args_len[arg] != 0) {
-38: (55) if r3 != 0x0 goto pc+5
- R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1=inv0 R2=map_value(id=0,off=2,ks=4,vs=14,imm=0) R3=inv0 R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
-39: (b7) r1 = 1
-; if (syscall->string_args_len[arg] != 0) {
-40: (bf) r2 = r0
-41: (07) r2 += 4
-42: (69) r3 = *(u16 *)(r0 +4)
- R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1_w=inv1 R2_w=map_value(id=0,off=4,ks=4,vs=14,imm=0) R3_w=inv0 R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
-; if (syscall->string_args_len[arg] != 0) {
-43: (15) if r3 == 0x0 goto pc+32
- R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1=inv1 R2=map_value(id=0,off=4,ks=4,vs=14,imm=0) R3=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
-; filename_arg = (const void *)args->args[arg];
-44: (67) r1 <<= 3
-45: (bf) r3 = r6
-46: (0f) r3 += r1
-47: (b7) r5 = 64
-48: (79) r3 = *(u64 *)(r3 +16)
-dereference of modified ctx ptr R3 off=8 disallowed
-processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_states 12 mark_read 7
-	*/
-
-#define __loop_iter(arg) \
-	if (syscall->string_args_len[arg] != 0) { \
-		unsigned int filename_len = syscall->string_args_len[arg]; \
-		const void *filename_arg = (const void *)args->args[arg]; \
-		if (filename_len <= sizeof(augmented_args->filename.value)) \
-			len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
-#define loop_iter_first() __loop_iter(0); }
-#define loop_iter(arg) else __loop_iter(arg); }
-#define loop_iter_last(arg) else __loop_iter(arg); __asm__ __volatile__("": : :"memory"); }
-
-	loop_iter_first()
-	loop_iter(1)
-	loop_iter(2)
-	loop_iter(3)
-	loop_iter(4)
-	loop_iter_last(5)
+	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
+	return 0;
 }
 
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
-	struct syscall *syscall;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
 	probe_read(&exit_args, sizeof(exit_args), args);
-
-	syscall = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
-	if (syscall == NULL || !syscall->enabled)
-		return 0;
-
-	return 1;
+	/*
+	 * Jump to syscall specific return augmenter, even if the default one,
+	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
+	 * unagmented tracepoint payload.
+	 */
+	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
+	/*
+	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
+	 */
+	return 0;
 }
 
 license(GPL);
-- 
2.21.0

