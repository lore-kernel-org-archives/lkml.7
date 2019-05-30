Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C63C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AD4257C3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CQEO4LWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfE3IAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:00:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfE3IAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:00:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U80C7H2900917
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:00:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U80C7H2900917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203213;
        bh=pw2/bHwFp58+URpxsj90Ud+Rt2N0jd1fJLdIfpQNHg0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=CQEO4LWPCmMkb+WKvELpu/0PNkvqT8j4ZCWoqvSdi9ogbgkzbwLYuKWKfTfSbJtf0
         BM8cMImpWacPsHAwW00Fy/0sAAa24M6XAyop70kL8ZaZRWvwim8N5NbGIpB6DjVS3w
         GlAT6h+iaz53yk/Dhr9Gks3evV4y/VsEzBubDYjLXmEzWWJu/vkcXYl4/d4XafdSUz
         9jmz8XELBLz0TVFYHaGzJltl4veaIhzzxuOx062+fRfBFNJAP5495wZn3QCsLr0Ps6
         e2/pIK6uztsrZl7b4hQ7E2dxsACIwbvRpARRy3l8jWbUa0qEmXQv25p7jPlcdwE0QJ
         OH2BZo/e1gZSg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U80Cc62900912;
        Thu, 30 May 2019 01:00:12 -0700
Date:   Thu, 30 May 2019 01:00:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-erau5xjtt8wvgnhvdbchstuk@git.kernel.org>
Cc:     tglx@linutronix.de, brendan.d.gregg@gmail.com, hpa@zytor.com,
        acme@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
        jolsa@kernel.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com
Reply-To: linux-kernel@vger.kernel.org, lclaudio@redhat.com,
          mingo@kernel.org, viro@zeniv.linux.org.uk, jolsa@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          brendan.d.gregg@gmail.com, hpa@zytor.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Beautify 'fspick' arguments
Git-Commit-ID: 693bd3949be6c73218e3666d85e37841d678ea7b
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

Commit-ID:  693bd3949be6c73218e3666d85e37841d678ea7b
Gitweb:     https://git.kernel.org/tip/693bd3949be6c73218e3666d85e37841d678ea7b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 20 May 2019 16:24:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:42 -0300

perf trace: Beautify 'fspick' arguments

Use existing beautifiers for the first 2 args (dfd, path) and wire up
the recently introduced fspick flags table generator.

Now it should be possible to just use:

   perf trace -e fspick

As root and see all move_mount syscalls with its args beautified, either
using the vfs_getname perf probe method or using the
augmented_raw_syscalls.c eBPF helper to get the pathnames, the other
args should work in all cases, i.e. all that is needed can be obtained
directly from the raw_syscalls:sys_enter tracepoint args.

  # cat sys_fspick.c
  #define _GNU_SOURCE        /* See feature_test_macros(7) */
  #include <unistd.h>
  #include <sys/syscall.h>   /* For SYS_xxx definitions */
  #include <fcntl.h>

  #define __NR_fspick 433

  #define FSPICK_CLOEXEC          0x00000001
  #define FSPICK_SYMLINK_NOFOLLOW 0x00000002
  #define FSPICK_NO_AUTOMOUNT     0x00000004
  #define FSPICK_EMPTY_PATH       0x00000008

  static inline int sys_fspick(int fd, const char *path, int flags)
  {
  	syscall(__NR_fspick, fd, path, flags);
  }

  int main(int argc, char *argv[])
  {
  	int flags = 0, fd = 0;

  	open("/foo", 0);
  	sys_fspick(fd++, "/foo1", flags);
  	flags |= FSPICK_CLOEXEC;
  	sys_fspick(fd++, "/foo2", flags);
  	flags |= FSPICK_SYMLINK_NOFOLLOW;
  	sys_fspick(fd++, "/foo3", flags);
  	flags |= FSPICK_NO_AUTOMOUNT;
  	sys_fspick(fd++, "/foo4", flags);
  	flags |= FSPICK_EMPTY_PATH;
  	return sys_fspick(fd++, "/foo5", flags);
  }
  # perf trace -e fspick ./sys_fspick
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  fspick(0, "/foo1", 0)                   = -1 ENOENT (No such file or directory)
  fspick(1, "/foo2", FSPICK_CLOEXEC)      = -1 ENOENT (No such file or directory)
  fspick(2, "/foo3", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
  fspick(3, "/foo4", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW|FSPICK_NO_AUTOMOUNT) = -1 ENOENT (No such file or directory)
  fspick(4, "/foo5", FSPICK_CLOEXEC|FSPICK_SYMLINK_NOFOLLOW|FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = -1 ENOENT (No such file or directory)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-erau5xjtt8wvgnhvdbchstuk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                         |  8 ++++++++
 tools/perf/builtin-trace.c                       |  4 ++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c |  2 ++
 tools/perf/trace/beauty/Build                    |  1 +
 tools/perf/trace/beauty/beauty.h                 |  3 +++
 tools/perf/trace/beauty/fspick.c                 | 24 ++++++++++++++++++++++++
 6 files changed, 42 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 20448d8cc162..fe93f8c46080 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -419,6 +419,12 @@ fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
 $(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
 	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
 
+fspick_arrays := $(beauty_outdir)/fspick_arrays.c
+fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
+
+$(fspick_arrays): $(linux_uapi_dir)/fs.h $(fspick_tbls)
+	$(Q)$(SHELL) '$(fspick_tbls)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -634,6 +640,7 @@ build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
 	$(fadvise_advice_array) \
+	$(fspick_arrays) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
@@ -929,6 +936,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(fadvise_advice_array) \
+		$(OUTPUT)$(fspick_arrays) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b76c950e4393..1643da631699 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -713,6 +713,10 @@ static struct syscall_fmt {
 		   [2] = { .scnprintf =  SCA_FCNTL_ARG, /* arg */ }, }, },
 	{ .name	    = "flock",
 	  .arg = { [1] = { .scnprintf = SCA_FLOCK, /* cmd */ }, }, },
+	{ .name     = "fspick",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT,	  /* dfd */ },
+		   [1] = { .scnprintf = SCA_FILENAME,	  /* path */ },
+		   [2] = { .scnprintf = SCA_FSPICK_FLAGS, /* flags */ }, }, },
 	{ .name	    = "fstat", .alias = "newfstat", },
 	{ .name	    = "fstatat", .alias = "newfstatat", },
 	{ .name	    = "futex",
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 8d0c0976696e..68a3d61752ce 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -118,6 +118,7 @@ struct augmented_filename {
 #define SYS_EXECVEAT           322
 #define SYS_STATX              332
 #define SYS_MOVE_MOUNT         429
+#define SYS_FSPICK             433
 
 pid_filter(pids_filtered);
 
@@ -253,6 +254,7 @@ int sys_enter(struct syscall_enter_args *args)
 	case SYS_FINIT_MODULE:
 	case SYS_FREMOVEXATTR:
 	case SYS_FSETXATTR:
+	case SYS_FSPICK:
 	case SYS_FUTIMESAT:
 	case SYS_INOTIFY_ADD_WATCH:
 	case SYS_LINKAT:
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index d84812c094ba..c2d38b2b606b 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -1,6 +1,7 @@
 perf-y += clone.o
 perf-y += fcntl.o
 perf-y += flock.o
+perf-y += fspick.o
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
 perf-y += ioctl.o
 endif
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index dfb84032d8eb..90c1ee708dc9 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -141,6 +141,9 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_flock(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FLOCK syscall_arg__scnprintf_flock
 
+size_t syscall_arg__scnprintf_fspick_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FSPICK_FLAGS syscall_arg__scnprintf_fspick_flags
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_IOCTL_CMD syscall_arg__scnprintf_ioctl_cmd
 
diff --git a/tools/perf/trace/beauty/fspick.c b/tools/perf/trace/beauty/fspick.c
new file mode 100644
index 000000000000..c402479c96f0
--- /dev/null
+++ b/tools/perf/trace/beauty/fspick.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/fspick.c
+ *
+ *  Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/log2.h>
+
+static size_t fspick__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
+{
+#include "trace/beauty/generated/fspick_arrays.c"
+       static DEFINE_STRARRAY(fspick_flags, "FSPICK_");
+
+       return strarray__scnprintf_flags(&strarray__fspick_flags, bf, size, show_prefix, flags);
+}
+
+size_t syscall_arg__scnprintf_fspick_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+
+	return fspick__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
+}
