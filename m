Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0995E208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="S8FJaMS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfFQTNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:13:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfFQTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:13:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJCXTQ3558744
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:12:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJCXTQ3558744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798754;
        bh=V5nUGu4OXg3ZWzQQjfFFZguJxWQNJqrqFHn1xK9ZHDk=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=S8FJaMS0R2mey6OXfE9oz+KJKLV7iprWfZavam8yU0jqBIYT7KPOmD1bBqqYnLnO1
         Ua9NY8hj2+SRpMNYxhSLCABvDmFouzOVXZPER15v3vRYmL1V9Np5ecVNKgxEl+ER+S
         TwTeeN0ESJhr7h3TxOotnLvv2DCatGNoyu9+qGRZQy3k4z7SPKTlIqBAcOIe3XkV/M
         57L4s2SEHL+DBdi2QbUAw12gYuBxm7aUtMt31TkRl2ZwXpgxuaKFVHbWaXE94CvY6+
         mkE5RVfYdB//vx2TTSTxiaJF7qJ7bGLRnwp+cWnEncWRct7e18Fq/rCrJ09mLM78iU
         wCFrIeghaIvWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJCXRO3558740;
        Mon, 17 Jun 2019 12:12:33 -0700
Date:   Mon, 17 Jun 2019 12:12:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dn863ya0cbsqycxuy0olvbt1@git.kernel.org>
Cc:     yhs@fb.com, jolsa@kernel.org, hpa@zytor.com, brouer@redhat.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, ast@fb.com, mingo@kernel.org,
        andriin@fb.com, namhyung@kernel.org, leo.yan@linaro.org,
        songliubraving@fb.com, tglx@linutronix.de, acme@redhat.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, andriin@fb.com,
          leo.yan@linaro.org, songliubraving@fb.com, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org, yhs@fb.com,
          brouer@redhat.com, daniel@iogearbox.net,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com, ast@fb.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Tell which args are
 filenames and how many bytes to copy
Git-Commit-ID: 4cae8675ea798b141ccdeea0a5b3f46a1e4605eb
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

Commit-ID:  4cae8675ea798b141ccdeea0a5b3f46a1e4605eb
Gitweb:     https://git.kernel.org/tip/4cae8675ea798b141ccdeea0a5b3f46a1e4605eb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 3 Jun 2019 16:52:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:58 -0300

perf augmented_raw_syscalls: Tell which args are filenames and how many bytes to copy

Since we know what args are strings from reading the syscall
descriptions in tracefs and also already mark such args to be beautified
using the syscall_arg__scnprintf_filename() helper, all we need is to
fill in this info in the 'syscalls' BPF map we were using to state which
syscalls the user is interested in, i.e. the syscall filter.

Right now just set that with PATH_MAX and unroll the syscall arg in the
BPF program, as the verifier isn't liking something clang generates when
unrolling the loop.

This also makes the augmented_raw_syscalls.c program support all arches,
since we removed that set of defines with the hard coded syscall
numbers, all should be automatically set for all arches, with the
syscall id mapping done correcly.

Doing baby steps here, i.e. just the first string arg for a syscall is
printed, syscalls with more than one, say, the various rename* syscalls,
need further work, but lets get first something that the BPF verifier
accepts before increasing the complexity

To test it, something like:

 # perf trace -e string -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c

With:

  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
	clang-opt = -g
  [trace]
	#add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
	show_zeros = yes
	show_duration = no
	no_inherit = yes
	show_timestamp = no
	show_arg_names = no
	args_alignment = 40
	show_prefix = yes
  #

That commented add_events line is needed for developing this
augmented_raw_syscalls.c BPF program, as if we add it via the
'add_events' mechanism so as to shorten the 'perf trace' command lines,
then we end up not setting up the -v option which precludes us having
access to the bpf verifier log :-\

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-dn863ya0cbsqycxuy0olvbt1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       |  31 +++
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 232 +++++++----------------
 2 files changed, 95 insertions(+), 168 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 54b2d0fd0d02..19f22127f02e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -972,8 +972,14 @@ struct syscall {
 	struct syscall_arg_fmt *arg_fmt;
 };
 
+/*
+ * Must match what is in the BPF program:
+ *
+ * tools/perf/examples/bpf/augmented_raw_syscalls.c
+ */
 struct bpf_map_syscall_entry {
 	bool	enabled;
+	u16	string_args_len[6];
 };
 
 /*
@@ -2711,6 +2717,25 @@ out_enomem:
 }
 
 #ifdef HAVE_LIBBPF_SUPPORT
+static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+	int arg = 0;
+
+	if (sc == NULL)
+		goto out;
+
+	for (; arg < sc->nr_args; ++arg) {
+		entry->string_args_len[arg] = 0;
+		if (sc->arg_fmt[arg].scnprintf == SCA_FILENAME) {
+			/* Should be set like strace -s strsize */
+			entry->string_args_len[arg] = PATH_MAX;
+		}
+	}
+out:
+	for (; arg < 6; ++arg)
+		entry->string_args_len[arg] = 0;
+}
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
@@ -2723,6 +2748,9 @@ static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 	for (i = 0; i < trace->ev_qualifier_ids.nr; ++i) {
 		int key = trace->ev_qualifier_ids.entries[i];
 
+		if (value.enabled)
+			trace__init_bpf_map_syscall_args(trace, key, &value);
+
 		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
 		if (err)
 			break;
@@ -2740,6 +2768,9 @@ static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		if (enabled)
+			trace__init_bpf_map_syscall_args(trace, key, &value);
+
 		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
 			break;
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 68a3d61752ce..c9fd3b4d8e55 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -21,8 +21,14 @@
 /* bpf-output associated map */
 bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
+/*
+ * string_args_len: one per syscall arg, 0 means not a string or don't copy it,
+ * 		    PATH_MAX for copying everything, any other value to limit
+ * 		    it a la 'strace -s strsize'.
+ */
 struct syscall {
 	bool	enabled;
+	u16	string_args_len[6];
 };
 
 bpf_map(syscalls, ARRAY, int, struct syscall, 512);
@@ -45,81 +51,6 @@ struct augmented_filename {
 	char		value[PATH_MAX];
 };
 
-/* syscalls where the first arg is a string */
-#define SYS_OPEN                 2
-#define SYS_STAT                 4
-#define SYS_LSTAT                6
-#define SYS_ACCESS              21
-#define SYS_EXECVE              59
-#define SYS_TRUNCATE            76
-#define SYS_CHDIR               80
-#define SYS_RENAME              82
-#define SYS_MKDIR               83
-#define SYS_RMDIR               84
-#define SYS_CREAT               85
-#define SYS_LINK                86
-#define SYS_UNLINK              87
-#define SYS_SYMLINK             88
-#define SYS_READLINK            89
-#define SYS_CHMOD               90
-#define SYS_CHOWN               92
-#define SYS_LCHOWN              94
-#define SYS_MKNOD              133
-#define SYS_STATFS             137
-#define SYS_PIVOT_ROOT         155
-#define SYS_CHROOT             161
-#define SYS_ACCT               163
-#define SYS_SWAPON             167
-#define SYS_SWAPOFF            168
-#define SYS_DELETE_MODULE      176
-#define SYS_SETXATTR           188
-#define SYS_LSETXATTR          189
-#define SYS_GETXATTR           191
-#define SYS_LGETXATTR          192
-#define SYS_LISTXATTR          194
-#define SYS_LLISTXATTR         195
-#define SYS_REMOVEXATTR        197
-#define SYS_LREMOVEXATTR       198
-#define SYS_MQ_OPEN            240
-#define SYS_MQ_UNLINK          241
-#define SYS_ADD_KEY            248
-#define SYS_REQUEST_KEY        249
-#define SYS_SYMLINKAT          266
-#define SYS_MEMFD_CREATE       319
-
-/* syscalls where the second arg is a string */
-
-#define SYS_PWRITE64            18
-#define SYS_EXECVE              59
-#define SYS_RENAME              82
-#define SYS_QUOTACTL           179
-#define SYS_FSETXATTR          190
-#define SYS_FGETXATTR          193
-#define SYS_FREMOVEXATTR       199
-#define SYS_MQ_TIMEDSEND       242
-#define SYS_REQUEST_KEY        249
-#define SYS_INOTIFY_ADD_WATCH  254
-#define SYS_OPENAT             257
-#define SYS_MKDIRAT            258
-#define SYS_MKNODAT            259
-#define SYS_FCHOWNAT           260
-#define SYS_FUTIMESAT          261
-#define SYS_NEWFSTATAT         262
-#define SYS_UNLINKAT           263
-#define SYS_RENAMEAT           264
-#define SYS_LINKAT             265
-#define SYS_READLINKAT         267
-#define SYS_FCHMODAT           268
-#define SYS_FACCESSAT          269
-#define SYS_UTIMENSAT          280
-#define SYS_NAME_TO_HANDLE_AT  303
-#define SYS_FINIT_MODULE       313
-#define SYS_RENAMEAT2          316
-#define SYS_EXECVEAT           322
-#define SYS_STATX              332
-#define SYS_MOVE_MOUNT         429
-#define SYS_FSPICK             433
-
 pid_filter(pids_filtered);
 
 struct augmented_args_filename {
@@ -133,7 +64,7 @@ SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len = sizeof(*augmented_args);
+	unsigned int len = sizeof(*augmented_args), filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -191,104 +122,69 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	/*
-	 * This table of what args are strings will be provided by userspace,
-	 * in the syscalls map, i.e. we will already have to do the lookup to
-	 * see if this specific syscall is filtered, so we can as well get more
-	 * info about what syscall args are strings or pointers, and how many
-	 * bytes to copy, per arg, etc.
+	 * For now copy just the first string arg, we need to improve the protocol
+	 * and have more than one.
 	 *
-	 * For now hard code it, till we have all the basic mechanisms in place
-	 * to automate everything and make the kernel part be completely driven
-	 * by information obtained in userspace for each kernel version and
-	 * processor architecture, making the kernel part the same no matter what
-	 * kernel version or processor architecture it runs on.
-	 */
-	switch (augmented_args->args.syscall_nr) {
-	case SYS_ACCT:
-	case SYS_ADD_KEY:
-	case SYS_CHDIR:
-	case SYS_CHMOD:
-	case SYS_CHOWN:
-	case SYS_CHROOT:
-	case SYS_CREAT:
-	case SYS_DELETE_MODULE:
-	case SYS_EXECVE:
-	case SYS_GETXATTR:
-	case SYS_LCHOWN:
-	case SYS_LGETXATTR:
-	case SYS_LINK:
-	case SYS_LISTXATTR:
-	case SYS_LLISTXATTR:
-	case SYS_LREMOVEXATTR:
-	case SYS_LSETXATTR:
-	case SYS_LSTAT:
-	case SYS_MEMFD_CREATE:
-	case SYS_MKDIR:
-	case SYS_MKNOD:
-	case SYS_MQ_OPEN:
-	case SYS_MQ_UNLINK:
-	case SYS_PIVOT_ROOT:
-	case SYS_READLINK:
-	case SYS_REMOVEXATTR:
-	case SYS_RENAME:
-	case SYS_REQUEST_KEY:
-	case SYS_RMDIR:
-	case SYS_SETXATTR:
-	case SYS_STAT:
-	case SYS_STATFS:
-	case SYS_SWAPOFF:
-	case SYS_SWAPON:
-	case SYS_SYMLINK:
-	case SYS_SYMLINKAT:
-	case SYS_TRUNCATE:
-	case SYS_UNLINK:
-	case SYS_ACCESS:
-	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
+	 * Using the unrolled loop is not working, only when we do it manually,
+	 * check this out later...
+
+	u8 arg;
+#pragma clang loop unroll(full)
+	for (arg = 0; arg < 6; ++arg) {
+		if (syscall->string_args_len[arg] != 0) {
+			filename_len = syscall->string_args_len[arg];
+			filename_arg = (const void *)args->args[arg];
 			__asm__ __volatile__("": : :"memory");
-			 break;
-	case SYS_EXECVEAT:
-	case SYS_FACCESSAT:
-	case SYS_FCHMODAT:
-	case SYS_FCHOWNAT:
-	case SYS_FGETXATTR:
-	case SYS_FINIT_MODULE:
-	case SYS_FREMOVEXATTR:
-	case SYS_FSETXATTR:
-	case SYS_FSPICK:
-	case SYS_FUTIMESAT:
-	case SYS_INOTIFY_ADD_WATCH:
-	case SYS_LINKAT:
-	case SYS_MKDIRAT:
-	case SYS_MKNODAT:
-	// case SYS_MOVE_MOUNT:
-	// For now don't copy move_mount first string arg, as it has two and
-	// 'perf trace's syscall_arg__scnprintf_filename() will use the one
-	// copied here, the first, for both args, duplicating the first and
-	// ignoring the second.
-	//
-	// We need to copy both here and make syscall_arg__scnprintf_filename
-	// skip the first when reading the second, using the size of the first, etc.
-	// Shouldn't be difficult, but now its perf/urgent time, lets wait for
-	// the next devel window.
-	case SYS_MQ_TIMEDSEND:
-	case SYS_NAME_TO_HANDLE_AT:
-	case SYS_NEWFSTATAT:
-	case SYS_PWRITE64:
-	case SYS_QUOTACTL:
-	case SYS_READLINKAT:
-	case SYS_RENAMEAT:
-	case SYS_RENAMEAT2:
-	case SYS_STATX:
-	case SYS_UNLINKAT:
-	case SYS_UTIMENSAT:
-	case SYS_OPENAT: filename_arg = (const void *)args->args[1];
-			 break;
+			break;
+		}
 	}
 
-	if (filename_arg != NULL) {
+	verifier log:
+
+; if (syscall->string_args_len[arg] != 0) {
+37: (69) r3 = *(u16 *)(r0 +2)
+ R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1_w=inv0 R2_w=map_value(id=0,off=2,ks=4,vs=14,imm=0) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
+; if (syscall->string_args_len[arg] != 0) {
+38: (55) if r3 != 0x0 goto pc+5
+ R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1=inv0 R2=map_value(id=0,off=2,ks=4,vs=14,imm=0) R3=inv0 R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
+39: (b7) r1 = 1
+; if (syscall->string_args_len[arg] != 0) {
+40: (bf) r2 = r0
+41: (07) r2 += 4
+42: (69) r3 = *(u16 *)(r0 +4)
+ R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1_w=inv1 R2_w=map_value(id=0,off=4,ks=4,vs=14,imm=0) R3_w=inv0 R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
+; if (syscall->string_args_len[arg] != 0) {
+43: (15) if r3 == 0x0 goto pc+32
+ R0=map_value(id=0,off=0,ks=4,vs=14,imm=0) R1=inv1 R2=map_value(id=0,off=4,ks=4,vs=14,imm=0) R3=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)) R6=ctx(id=0,off=0,imm=0) R7=map_value(id=0,off=0,ks=4,vs=4168,imm=0) R10=fp0,call_-1 fp-8=mmmmmmmm
+; filename_arg = (const void *)args->args[arg];
+44: (67) r1 <<= 3
+45: (bf) r3 = r6
+46: (0f) r3 += r1
+47: (b7) r5 = 64
+48: (79) r3 = *(u64 *)(r3 +16)
+dereference of modified ctx ptr R3 off=8 disallowed
+processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_states 12 mark_read 7
+	*/
+
+#define __loop_iter(arg) \
+	if (syscall->string_args_len[arg] != 0) { \
+		filename_len = syscall->string_args_len[arg]; \
+		filename_arg = (const void *)args->args[arg];
+#define loop_iter_first() __loop_iter(0); }
+#define loop_iter(arg) else __loop_iter(arg); }
+#define loop_iter_last(arg) else __loop_iter(arg); __asm__ __volatile__("": : :"memory"); }
+
+	loop_iter_first()
+	loop_iter(1)
+	loop_iter(2)
+	loop_iter(3)
+	loop_iter(4)
+	loop_iter_last(5)
+
+	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
 		augmented_args->filename.reserved = 0;
 		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
-							      sizeof(augmented_args->filename.value),
+							      filename_len,
 							      filename_arg);
 		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
 			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
