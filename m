Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43323C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BB72184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfC2UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:37:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfC2UhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:37:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKb0TZ3937884
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:37:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKaxc63937881;
        Fri, 29 Mar 2019 13:36:59 -0700
Date:   Fri, 29 Mar 2019 13:36:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h80ycpc6pedg9s5z2rwpy6ws@git.kernel.org>
Cc:     arnd@arndb.de, hpa@zytor.com, mingo@kernel.org, mst@redhat.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, arnd@arndb.de, hpa@zytor.com,
          mst@redhat.com, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Sync
 asm-generic/mman-common.h and linux/mman.h
Git-Commit-ID: be709d48329a500621d2a05835283150ae137b45
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

Commit-ID:  be709d48329a500621d2a05835283150ae137b45
Gitweb:     https://git.kernel.org/tip/be709d48329a500621d2a05835283150ae137b45
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 25 Mar 2019 14:06:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:31:56 -0300

tools headers uapi: Sync asm-generic/mman-common.h and linux/mman.h

To deal with the move of some defines from asm-generic/mmap-common.h to
linux/mman.h done in:

  746c9398f5ac ("arch: move common mmap flags to linux/mman.h")

The generated mmap_flags array stays the same:

  $ tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  $

And to have the system's sys/mman.h find the definition of MAP_SHARED
and MAP_PRIVATE, make sure they are defined in the tools/ mman-common.h
in a way that keeps it the same as the kernel's, need for keeping the
Android's NDK cross build working.

This silences these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h' differs from latest version at 'include/uapi/asm-generic/mman-common.h'
  diff -u tools/include/uapi/asm-generic/mman-common.h include/uapi/asm-generic/mman-common.h
  Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h80ycpc6pedg9s5z2rwpy6ws@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/alpha/include/uapi/asm/mman.h           |  2 --
 tools/arch/mips/include/uapi/asm/mman.h            |  2 --
 tools/arch/parisc/include/uapi/asm/mman.h          |  2 --
 tools/arch/xtensa/include/uapi/asm/mman.h          |  2 --
 tools/include/uapi/asm-generic/mman-common-tools.h | 23 ++++++++++++++++++++++
 tools/include/uapi/asm-generic/mman-common.h       |  4 +---
 tools/include/uapi/asm-generic/mman.h              |  2 +-
 tools/include/uapi/linux/mman.h                    |  4 ++++
 tools/perf/Makefile.perf                           |  4 ++--
 tools/perf/check-headers.sh                        |  2 +-
 tools/perf/trace/beauty/mmap_flags.sh              | 14 ++++++++++---
 11 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/arch/alpha/include/uapi/asm/mman.h b/tools/arch/alpha/include/uapi/asm/mman.h
index c317d3e6867a..ea6a255ae61f 100644
--- a/tools/arch/alpha/include/uapi/asm/mman.h
+++ b/tools/arch/alpha/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x40000
 #define MAP_NORESERVE	0x10000
 #define MAP_POPULATE	0x20000
-#define MAP_PRIVATE	0x02
-#define MAP_SHARED	0x01
 #define MAP_STACK	0x80000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/mips/include/uapi/asm/mman.h b/tools/arch/mips/include/uapi/asm/mman.h
index de2206883abc..c8acaa138d46 100644
--- a/tools/arch/mips/include/uapi/asm/mman.h
+++ b/tools/arch/mips/include/uapi/asm/mman.h
@@ -28,8 +28,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x0400
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x002
-#define MAP_SHARED	0x001
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x04
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/parisc/include/uapi/asm/mman.h b/tools/arch/parisc/include/uapi/asm/mman.h
index 1bd78758bde9..f9fd1325f5bd 100644
--- a/tools/arch/parisc/include/uapi/asm/mman.h
+++ b/tools/arch/parisc/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x4000
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x02
-#define MAP_SHARED	0x01
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/arch/xtensa/include/uapi/asm/mman.h b/tools/arch/xtensa/include/uapi/asm/mman.h
index 34dde6f44dae..f2b08c990afc 100644
--- a/tools/arch/xtensa/include/uapi/asm/mman.h
+++ b/tools/arch/xtensa/include/uapi/asm/mman.h
@@ -27,8 +27,6 @@
 #define MAP_NONBLOCK	0x20000
 #define MAP_NORESERVE	0x0400
 #define MAP_POPULATE	0x10000
-#define MAP_PRIVATE	0x002
-#define MAP_SHARED	0x001
 #define MAP_STACK	0x40000
 #define PROT_EXEC	0x4
 #define PROT_GROWSDOWN	0x01000000
diff --git a/tools/include/uapi/asm-generic/mman-common-tools.h b/tools/include/uapi/asm-generic/mman-common-tools.h
new file mode 100644
index 000000000000..af7d0d3a3182
--- /dev/null
+++ b/tools/include/uapi/asm-generic/mman-common-tools.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
+#define __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
+
+#include <asm-generic/mman-common.h>
+
+/* We need this because we need to have tools/include/uapi/ included in the tools
+ * header search path to get access to stuff that is not yet in the system's
+ * copy of the files in that directory, but since this cset:
+ *
+ *     746c9398f5ac ("arch: move common mmap flags to linux/mman.h")
+ *
+ * We end up making sys/mman.h, that is in the system headers, to not find the
+ * MAP_SHARED and MAP_PRIVATE defines because they are not anymore in our copy
+ * of asm-generic/mman-common.h. So we define them here and include this header
+ * from each of the per arch mman.h headers.
+ */
+#ifndef MAP_SHARED
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#endif
+#endif // __ASM_GENERIC_MMAN_COMMON_TOOLS_ONLY_H
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index e7ee32861d51..abd238d0f7a4 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/tools/include/uapi/asm-generic/mman.h b/tools/include/uapi/asm-generic/mman.h
index 653687d9771b..36c197fc44a0 100644
--- a/tools/include/uapi/asm-generic/mman.h
+++ b/tools/include/uapi/asm-generic/mman.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_MMAN_H
 #define __ASM_GENERIC_MMAN_H
 
-#include <asm-generic/mman-common.h>
+#include <asm-generic/mman-common-tools.h>
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index d0f515d53299..fc1a64c3447b 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
  * size other than the default is desired.  See hugetlb_encode.h.
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 01f7555fd933..e8c9f77e9010 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -481,8 +481,8 @@ $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_t
 mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
 mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
 
-$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
-	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
+$(mmap_flags_array): $(linux_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
+	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(linux_uapi_dir) $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
 mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 7b55613924de..c68ee06cae63 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -103,7 +103,7 @@ done
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
-check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
+check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 
 # diff non-symmetric files
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 32bac9c0d694..5f5eefcb3c74 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -1,15 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: LGPL-2.1
 
-if [ $# -ne 2 ] ; then
+if [ $# -ne 3 ] ; then
 	[ $# -eq 1 ] && hostarch=$1 || hostarch=`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/`
+	linux_header_dir=tools/include/uapi/linux
 	header_dir=tools/include/uapi/asm-generic
 	arch_header_dir=tools/arch/${hostarch}/include/uapi/asm
 else
-	header_dir=$1
-	arch_header_dir=$2
+	linux_header_dir=$1
+	header_dir=$2
+	arch_header_dir=$3
 fi
 
+linux_mman=${linux_header_dir}/mman.h
 arch_mman=${arch_header_dir}/mman.h
 
 # those in egrep -vw are flags, we want just the bits
@@ -20,6 +23,11 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q $regex ${linux_mman} && \
+(egrep $regex ${linux_mman} | \
+	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
 ([ ! -f ${arch_mman} ] || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman}) &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
