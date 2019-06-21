Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1D21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138830;
	bh=wSYzjKTAc0qodf9WUIuakww92jvbloHrH3KieQGil+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b66fA6s0hDKywY1ixhvqaklhliEdkDezKFFV+lkOAeJh/VQ2IecFg9nZ808E5K64I
	 TZI7bKRItoZIUG6PuM6fVJryY3ea+wpiZtR9HHDSln7XL7L4mlZXsCCbP7qXGZnsmS
	 /Sq9Dmb5wGrxjXQqetdAAwVNqSTQ11Kztcr5C7sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfFURk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFURk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:27 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC18208C3;
        Fri, 21 Jun 2019 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138827;
        bh=wSYzjKTAc0qodf9WUIuakww92jvbloHrH3KieQGil+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MadkrLSluTCOxlQEVL8I32I7gwHtbkvenMdp0/EfSsU2lhqKSA/IbXOXMWiUvdbjm
         sduXZcUyCcBqmgq1eXgwHhtoO/77w+p2VevdjBs9jnZ6Axx4LSoLhydKrAWyW1cZQa
         OkQkNleWYGJZfOM02eUJzwxSBA+l54iCOSOMWu60=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 14/25] tools build: Check if gettid() is available before providing helper
Date:   Fri, 21 Jun 2019 14:38:20 -0300
Message-Id: <20190621173831.13780-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/build/Makefile.feature      |  1 +
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-all.c    |  5 +++++
 tools/build/feature/test-gettid.c | 11 +++++++++++
 tools/perf/Makefile.config        |  4 ++++
 tools/perf/jvmti/jvmti_agent.c    |  2 ++
 6 files changed, 27 insertions(+)
 create mode 100644 tools/build/feature/test-gettid.c

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
diff --git a/tools/build/feature/test-gettid.c b/tools/build/feature/test-gettid.c
new file mode 100644
index 000000000000..ef24e42d3f1b
--- /dev/null
+++ b/tools/build/feature/test-gettid.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#define _GNU_SOURCE
+#include <unistd.h>
+
+int main(void)
+{
+	return gettid();
+}
+
+#undef _GNU_SOURCE
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
-- 
2.20.1

