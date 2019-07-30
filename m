Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C57C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA32C206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i0zQevjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfG3Rzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:55:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59935 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbfG3Rzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:55:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHtbJh3321046
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:55:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHtbJh3321046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509337;
        bh=mbO4kHc5p4kXC1EJz8tejGMFXbTNSX6t8WrNGxv8ubY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=i0zQevjUuVe05cHU9tyIRJG4YOImourPvhmxxdH968nSiB9cEUEr/+2zfp+6GavmO
         MO1WjTCF9dJiJ5FipjkVwbYFmAYHtlicXPYVtgyZFWDfq/QbNT/F/+ncB5iuWOZi++
         bE3beacw8OW/797KRcrxDhViQF2Gdp49qFavO+nBBlir7B+DMwsbA+hilCyovUTVfj
         cml8x3dGI9lgGa5zFE26aq4FhYlgvTGgh4CKCof+1JeLoUN83/ZIMkjE7rpHE4VB3m
         pxWs1YWmy0SUNAM8s/ztPw8PjnR13kZXLpO824zIXxGWjez6NQuRiVcIZeGIRu3SP4
         QSYMqgoNPoLCQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHtZAS3321042;
        Tue, 30 Jul 2019 10:55:35 -0700
Date:   Tue, 30 Jul 2019 10:55:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-snc7ry99cl6r0pqaspjim98x@git.kernel.org>
Cc:     adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, lclaudio@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: lclaudio@redhat.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          namhyung@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Switch to using
 BPF_MAP_TYPE_PROG_ARRAY
Git-Commit-ID: bf134ca6c8eafd7ddc28840f767259b97e950bac
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bf134ca6c8eafd7ddc28840f767259b97e950bac
Gitweb:     https://git.kernel.org/tip/bf134ca6c8eafd7ddc28840f767259b97e950bac
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 12:34:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf augmented_raw_syscalls: Switch to using BPF_MAP_TYPE_PROG_ARRAY

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
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 127 +++--------------------
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
