Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ECAC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AFE20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kBrbqBSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGILen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:34:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGILem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:34:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69BYRpj1893497
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 04:34:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69BYRpj1893497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562672068;
        bh=FuvtqhZa0w3lMifnK35Py0gpFtop77VfgXn4b6ItiEc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kBrbqBSRW7oH9L+78XjyE1a4u7TSNmGwuC8IbCfuIkLikLn6e1gCUQWtOexFHnH9P
         GLhK1nQh2A0014mJ0tAVDdSeTc3IhqKZ09E2Bya7ADP92ERULZZqdE7EXjQdqPEPS2
         m1JBT1ekp7vYB0uT/GiHH6mb8F4Q46iUu3etbbkKgTH1VZGVOcqBnrYbdV0tIEZiUh
         JXM9M+vxDLMgu4VisWnpRfEi8cXadD8fj8S05eO2q04kLYwipQVd0WPvu6yRx63AoK
         +531Mx/Di1IQl5UxNlO0brATKMpOuZ2YSAYQsJrUFxf0kDpPuZYTUhmBa74ys9LFUj
         Lpm0Uibr55U+A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69BYQdi1893494;
        Tue, 9 Jul 2019 04:34:26 -0700
Date:   Tue, 9 Jul 2019 04:34:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yfy3ch53agmklwu9o7rlgf9c@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, fweimer@redhat.com,
        eranian@google.com, mingo@kernel.org, labbott@redhat.com,
        namhyung@kernel.org, acme@redhat.com
Reply-To: namhyung@kernel.org, fweimer@redhat.com, eranian@google.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
          labbott@redhat.com, mingo@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build: Check if gettid() is available before
 providing helper
Git-Commit-ID: 05c78468a60f2fd961cd0a0c01c27f288bf81204
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190709113426.fisFSXN7nuA87wJTu34IKnF_hgizTOBdOFpFyGFE6qA@z>

Commit-ID:  05c78468a60f2fd961cd0a0c01c27f288bf81204
Gitweb:     https://git.kernel.org/tip/05c78468a60f2fd961cd0a0c01c27f288bf81204
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 12:04:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sun, 7 Jul 2019 17:53:09 -0300

tools build: Check if gettid() is available before providing helper

Laura reported that the perf build failed in fedora when we got a glibc
that provides gettid(), which I reproduced using fedora rawhide with the
glibc-devel-2.29.9000-26.fc31.x86_64 package.

Add a feature check to avoid providing a gettid() helper in such
systems.

On a fedora rawhide system with this patch applied we now get:

  [root@7a5f55352234 perf]# grep gettid /tmp/build/perf/FEATURE-DUMP
  feature-gettid=1
  [root@7a5f55352234 perf]# cat /tmp/build/perf/feature/test-gettid.make.output
  [root@7a5f55352234 perf]# ldd /tmp/build/perf/feature/test-gettid.bin
          linux-vdso.so.1 (0x00007ffc6b1f6000)
          libc.so.6 => /lib64/libc.so.6 (0x00007f04e0a74000)
          /lib64/ld-linux-x86-64.so.2 (0x00007f04e0c47000)
  [root@7a5f55352234 perf]# nm /tmp/build/perf/feature/test-gettid.bin | grep -w gettid
                   U gettid@@GLIBC_2.30
  [root@7a5f55352234 perf]#

While on a fedora:29 system:

  [acme@quaco perf]$ grep gettid /tmp/build/perf/FEATURE-DUMP
  feature-gettid=0
  [acme@quaco perf]$ cat /tmp/build/perf/feature/test-gettid.make.output
  test-gettid.c: In function ‘main’:
  test-gettid.c:8:9: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
    return gettid();
           ^~~~~~
           getgid
  cc1: all warnings being treated as errors
  [acme@quaco perf]$

Reported-by: Laura Abbott <labbott@redhat.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-yfy3ch53agmklwu9o7rlgf9c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature                                       | 1 +
 tools/build/feature/Makefile                                       | 4 ++++
 tools/build/feature/test-all.c                                     | 5 +++++
 tools/build/feature/{test-get_current_dir_name.c => test-gettid.c} | 6 +++---
 tools/perf/Makefile.config                                         | 4 ++++
 tools/perf/jvmti/jvmti_agent.c                                     | 2 ++
 6 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3b24231c58a2..50377cc2f5f9 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -36,6 +36,7 @@ FEATURE_TESTS_BASIC :=                  \
         fortify-source                  \
         sync-compare-and-swap           \
         get_current_dir_name            \
+        gettid				\
         glibc                           \
         gtk2                            \
         gtk2-infobar                    \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4b8244ee65ce..523ee42db0c8 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -54,6 +54,7 @@ FILES=                                          \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
+         test-gettid.bin			\
          test-jvmti.bin				\
          test-jvmti-cmlr.bin			\
          test-sched_getcpu.bin			\
@@ -267,6 +268,9 @@ $(OUTPUT)test-sdt.bin:
 $(OUTPUT)test-cxx.bin:
 	$(BUILDXX) -std=gnu++11
 
+$(OUTPUT)test-gettid.bin:
+	$(BUILD)
+
 $(OUTPUT)test-jvmti.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index a59c53705093..3b3d5d72124a 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -38,6 +38,10 @@
 # include "test-get_current_dir_name.c"
 #undef main
 
+#define main main_test_gettid
+# include "test-gettid.c"
+#undef main
+
 #define main main_test_glibc
 # include "test-glibc.c"
 #undef main
@@ -195,6 +199,7 @@ int main(int argc, char *argv[])
 	main_test_libelf();
 	main_test_libelf_mmap();
 	main_test_get_current_dir_name();
+	main_test_gettid();
 	main_test_glibc();
 	main_test_dwarf();
 	main_test_dwarf_getlocations();
diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-gettid.c
similarity index 53%
copy from tools/build/feature/test-get_current_dir_name.c
copy to tools/build/feature/test-gettid.c
index c3c201691b4f..ef24e42d3f1b 100644
--- a/tools/build/feature/test-get_current_dir_name.c
+++ b/tools/build/feature/test-gettid.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 #define _GNU_SOURCE
 #include <unistd.h>
-#include <stdlib.h>
 
 int main(void)
 {
-	free(get_current_dir_name());
-	return 0;
+	return gettid();
 }
+
 #undef _GNU_SOURCE
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 85fbcd265351..a6251e622c7e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -332,6 +332,10 @@ ifeq ($(feature-get_current_dir_name), 1)
   CFLAGS += -DHAVE_GET_CURRENT_DIR_NAME
 endif
 
+ifeq ($(feature-gettid), 1)
+  CFLAGS += -DHAVE_GETTID
+endif
+
 ifdef NO_LIBELF
   NO_DWARF := 1
   NO_DEMANGLE := 1
diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index f7eb63cbbc65..88108598d6e9 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -45,10 +45,12 @@
 static char jit_path[PATH_MAX];
 static void *marker_addr;
 
+#ifndef HAVE_GETTID
 static inline pid_t gettid(void)
 {
 	return (pid_t)syscall(__NR_gettid);
 }
+#endif
 
 static int get_e_machine(struct jitheader *hdr)
 {
