Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680ACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9821925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194517;
	bh=Bo7aOd5uEXiwOyUcJLuBqbDUdo0wZCokqScySkn4QD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DEjtKMMvHYirUb8Gs5W1N2DBGTF/u1KUY30FSDWkrGpDnBAYLuawoRCfG0K8FSU/R
	 hdnZvGu3GkdCl/3EXCDXmj5IB/7StwyU+v3TlQonw58eKpQoqIZQgC5OaZo+PDYXxu
	 ufJccrso7AUMJxWWVqKvbHQoaJTPIPD88TP2xbj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfCUSzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbfCUSzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:55:13 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC66920657;
        Thu, 21 Mar 2019 18:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194511;
        bh=Bo7aOd5uEXiwOyUcJLuBqbDUdo0wZCokqScySkn4QD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reSOoFXL1QqjQVjZ97Wl47ut5qn7mKhH7iegfC6ZsWQu8wt1hkWJU3CLnl5vCCfE1
         jlW98J0plWELzjEAtY50/qC8bQx6+jr1s7IzmaS2nR2LaSw+shBRTcAVaLecLEOa41
         x2orwbhfe1UuhnZU9PwwSwYKuBPOUeDEHU/pijPQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 39/44] perf build: Check what binutils's 'disassembler()' signature to use
Date:   Thu, 21 Mar 2019 15:51:37 -0300
Message-Id: <20190321185142.11441-40-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

Commit 003ca0fd2286 ("Refactor disassembler selection") in the binutils
repo, which changed the disassembler() function signature, so we must
use the feature test introduced in fb982666e380 ("tools/bpftool: fix
bpftool build with bintutils >= 2.9") to deal with that.

Committer testing:

After adding the missing function call to test-all.c, and:

  FEATURE_CHECK_LDFLAGS-disassembler-four-args = -bfd -lopcodes

And the fallbacks for cases where we need -liberty and sometimes -lz to
tools/perf/Makefile.config, we get:

  $ make -C tools/perf O=/tmp/build/perf install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ on  ]
  ...                      libaudit: [ on  ]
  ...                        libbfd: [ on  ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ on  ]
  ...        numa_num_possible_cpus: [ on  ]
  ...                       libperl: [ on  ]
  ...                     libpython: [ on  ]
  ...                      libslang: [ on  ]
  ...                     libcrypto: [ on  ]
  ...                     libunwind: [ on  ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ on  ]
  ...                     get_cpuid: [ on  ]
  ...                           bpf: [ on  ]
  ...                        libaio: [ on  ]
  ...        disassembler-four-args: [ on  ]
    CC       /tmp/build/perf/jvmti/libjvmti.o
    CC       /tmp/build/perf/builtin-bench.o
  <SNIP>
  $
  $

The feature detection test-all.bin gets successfully built and linked:

  $ ls -la /tmp/build/perf/feature/test-all.bin
  -rwxrwxr-x. 1 acme acme 2680352 Mar 19 11:07 /tmp/build/perf/feature/test-all.bin
  $ nm /tmp/build/perf/feature/test-all.bin  | grep -w disassembler
  0000000000061f90 T disassembler
  $

Time to move on to the patches that make use of this disassembler()
routine in binutils's libopcodes.

Signed-off-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-13-songliubraving@fb.com
[ split from a larger patch, added missing FEATURE_CHECK_LDFLAGS-disassembler-four-args ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature   | 6 ++++--
 tools/build/feature/test-all.c | 5 +++++
 tools/perf/Makefile.config     | 9 +++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 61e46d54a67c..8d3864b061f3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libaio
+        libaio				\
+        disassembler-four-args
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          get_cpuid              \
          bpf			\
-         libaio
+         libaio			\
+         disassembler-four-args
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e903b86b742f..7853e6d91090 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-reallocarray.c"
 #undef main
 
+#define main main_test_disassembler_four_args
+# include "test-disassembler-four-args.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
+	main_test_disassembler_four_args();
 
 	return 0;
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index df4ad45599ca..fe3f97e342fa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -227,6 +227,8 @@ FEATURE_CHECK_LDFLAGS-libpython-version := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
+FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes
+
 CFLAGS += -fno-omit-frame-pointer
 CFLAGS += -ggdb3
 CFLAGS += -funwind-tables
@@ -725,11 +727,14 @@ else
 
   ifeq ($(feature-libbfd-liberty), 1)
     EXTLIBS += -lbfd -lopcodes -liberty
+    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
   else
     ifeq ($(feature-libbfd-liberty-z), 1)
       EXTLIBS += -lbfd -lopcodes -liberty -lz
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
     endif
   endif
+  $(call feature_check,disassembler-four-args)
 endif
 
 ifdef NO_DEMANGLE
@@ -808,6 +813,10 @@ ifdef HAVE_KVM_STAT_SUPPORT
     CFLAGS += -DHAVE_KVM_STAT_SUPPORT
 endif
 
+ifeq ($(feature-disassembler-four-args), 1)
+    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+endif
+
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
-- 
2.20.1

