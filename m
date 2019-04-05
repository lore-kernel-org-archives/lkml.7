Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F6E2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfDELgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:36:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:36:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BZfSa2734062
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:35:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BZeDL2734059;
        Fri, 5 Apr 2019 04:35:40 -0700
Date:   Fri, 5 Apr 2019 04:35:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-76gce2d2ghzq537ubwhjkone@git.kernel.org>
Cc:     lclaudio@redhat.com, yhs@fb.com, brouer@redhat.com,
        namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, borkmann@iogearbox.net, g.borello@gmail.com,
        kafai@fb.com, tglx@linutronix.de, andriin@fb.com,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        wangnan0@huawei.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, acme@redhat.com, brouer@redhat.com,
          lclaudio@redhat.com, yhs@fb.com, jolsa@kernel.org,
          wangnan0@huawei.com, andriin@fb.com, adrian.hunter@intel.com,
          hpa@zytor.com, kafai@fb.com, tglx@linutronix.de,
          g.borello@gmail.com, borkmann@iogearbox.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Use a PERCPU_ARRAY map
 to copy more string bytes
Git-Commit-ID: 59f3bd7802d3ff7e6ddcce600f361bed288a97dd
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

Commit-ID:  59f3bd7802d3ff7e6ddcce600f361bed288a97dd
Gitweb:     https://git.kernel.org/tip/59f3bd7802d3ff7e6ddcce600f361bed288a97dd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 22 Mar 2019 14:48:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf augmented_raw_syscalls: Use a PERCPU_ARRAY map to copy more string bytes

The previous method, copying to the BPF stack limited us in how many
bytes we could copy from strings, use a PERCPU_ARRAY map like devised by
the sysdig guys[1] to copy more bytes:

Before:

  # trace --no-inherit -e openat touch `python -c "print "$s" 'a' * 2000"`
  touch: cannot touch 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa': File name too!
  long
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", O_CREAT|O_NOCTTY|O_NONBLOCK|O_WRONLY, S_IRUGO|S_IWUGO) = -1 ENAMETOOLONG (File name too long)
  openat(AT_FDCWD, "/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
  openat(AT_FDCWD, "/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  openat(AT_FDCWD, "/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
  <SNIP some openat calls>
  #

After:

  [root@quaco acme]# trace --no-inherit -e openat touch `python -c "print "$s" 'a' * 2000"`
  <STRIP what is the same as in the 'before' part>
  openat(AT_FDCWD, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!
 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", O_CREAT|O_NOCTTY!
 |O_NONBLOC) = -1 ENAMETOOLONG (File name too long)
  <STRIP what is the same as in the 'before' part>

If we leave something like 'perf trace -e string' to trace all syscalls
with a string, and then do some 'perf top', to get some annotation for
the augmented_raw_syscalls.o BPF program we get:

       │     → callq  *ffffffffc45576d1                                                                                                          ▒
       │                augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,                                          ▒
  0.05 │       mov    %eax,0x40(%r13)

Looking with pahole, expanding types, asking for hex offsets and sizes,
and use of BTF type information to see what is at that 0x40 offset from
%r13:

  # pahole -F btf -C augmented_args_filename --expand_types --hex /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  struct augmented_args_filename {
	struct syscall_enter_args {
		long long unsigned int common_tp_fields;                                 /*     0   0x8 */
		long int           syscall_nr;                                           /*   0x8   0x8 */
		long unsigned int  args[6];                                              /*  0x10  0x30 */
	} args; /*     0  0x40 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct augmented_filename {
		unsigned int       size;                                                 /*  0x40   0x4 */
		int                reserved;                                             /*  0x44   0x4 */
		char               value[4096];                                          /*  0x48 0x1000 */
	} filename; /*  0x40 0x1008 */

	/* size: 4168, cachelines: 66, members: 2 */
	/* last cacheline: 8 bytes */
  };
  #

Then looking if PATH_MAX leaves some signature in the tests:

       │                if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {                                            ▒
       │       cmp    $0xfff,%rdi

0xfff == 4095
sizeof(augmented_args->filename.value) == PATH_MAX == 4096

[1] https://sysdig.com/blog/the-art-of-writing-ebpf-programs-a-primer/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Daniel Borkmann <borkmann@iogearbox.net>
Cc: Gianluca Borello <g.borello@gmail.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
cc: Martin Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-76gce2d2ghzq537ubwhjkone@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 46 ++++++++++++++----------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9f8b31ad7a49..2422894a8194 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -15,6 +15,7 @@
  */
 
 #include <unistd.h>
+#include <linux/limits.h>
 #include <pid_filter.h>
 
 /* bpf-output associated map */
@@ -41,7 +42,7 @@ struct syscall_exit_args {
 struct augmented_filename {
 	unsigned int	size;
 	int		reserved;
-	char		value[256];
+	char		value[PATH_MAX];
 };
 
 /* syscalls where the first arg is a string */
@@ -119,23 +120,32 @@ struct augmented_filename {
 
 pid_filter(pids_filtered);
 
+struct augmented_args_filename {
+       struct syscall_enter_args args;
+       struct augmented_filename filename;
+};
+
+bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-	struct {
-		struct syscall_enter_args args;
-		struct augmented_filename filename;
-	} augmented_args;
-	struct syscall *syscall;
-	unsigned int len = sizeof(augmented_args);
+	struct augmented_args_filename *augmented_args;
+	unsigned int len = sizeof(*augmented_args);
 	const void *filename_arg = NULL;
+	struct syscall *syscall;
+	int key = 0;
+
+        augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+        if (augmented_args == NULL)
+                return 1;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
-	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
+	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
 	if (syscall == NULL || !syscall->enabled)
 		return 0;
 	/*
@@ -191,7 +201,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * processor architecture, making the kernel part the same no matter what
 	 * kernel version or processor architecture it runs on.
 	 */
-	switch (augmented_args.args.syscall_nr) {
+	switch (augmented_args->args.syscall_nr) {
 	case SYS_ACCT:
 	case SYS_ADD_KEY:
 	case SYS_CHDIR:
@@ -263,20 +273,20 @@ int sys_enter(struct syscall_enter_args *args)
 	}
 
 	if (filename_arg != NULL) {
-		augmented_args.filename.reserved = 0;
-		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
-							      sizeof(augmented_args.filename.value),
+		augmented_args->filename.reserved = 0;
+		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
+							      sizeof(augmented_args->filename.value),
 							      filename_arg);
-		if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {
-			len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;
-			len &= sizeof(augmented_args.filename.value) - 1;
+		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
+			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
+			len &= sizeof(augmented_args->filename.value) - 1;
 		}
 	} else {
-		len = sizeof(augmented_args.args);
+		len = sizeof(augmented_args->args);
 	}
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
 SEC("raw_syscalls:sys_exit")
