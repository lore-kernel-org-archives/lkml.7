Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55099C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7C82070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PZTlBXxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfFVGoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:44:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfFVGoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:44:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6hikO2006732
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:43:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6hikO2006732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185824;
        bh=oQesUXMisDWymKr9pqObiTgxh+eAPD5m1NY3WRcaJnY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=PZTlBXxjj+Zo8EeblY/EFXMM/6hoASuXZ3A7gWbrPXfSvMhgNcXpoJblJZu+Baop9
         15Rkafnc4fjWjpEw9KF51oRJGIp87V6AIvGKc6gownhCFTfcWtpm9skN8KZ3GV7Jsu
         yEwko6U/KGJ6ZgvusiNTujiWE/9t0Myy1npArbgzIjzL4s7zLA4BWM8XTHN05BFoU+
         Im9ZaB1wkB0jU0nmr021Ux0SpsUdlCrhGxxWqlAnQCscoeo/1Xt43zGStrWv+BWroZ
         MDfiHhv2iTWTKD8KMMXRGe6Xu1m0puXCYCvX2ty1eCPQUhSBDQscKuuzJtam+ODkfc
         q6sHFyT3do7nw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6hi1k2006729;
        Fri, 21 Jun 2019 23:43:44 -0700
Date:   Fri, 21 Jun 2019 23:43:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yfy3ch53agmklwu9o7rlgf9c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
        labbott@redhat.com, eranian@google.com, jolsa@kernel.org,
        fweimer@redhat.com, namhyung@kernel.org
Reply-To: eranian@google.com, labbott@redhat.com, jolsa@kernel.org,
          fweimer@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build: Check if gettid() is available before
 providing helper
Git-Commit-ID: 4541a8bb13a86e504416a13360c8dc64d2fd612a
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

Commit-ID:  4541a8bb13a86e504416a13360c8dc64d2fd612a
Gitweb:     https://git.kernel.org/tip/4541a8bb13a86e504416a13360c8dc64d2fd612a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 12:04:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

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
index 51dd00f65709..5f16a20cae86 100644
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
