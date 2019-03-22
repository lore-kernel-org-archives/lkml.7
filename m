Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D620C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487BE2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbfCVWo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:44:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:44:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMhpHB755899
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:43:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMhokL755894;
        Fri, 22 Mar 2019 15:43:50 -0700
Date:   Fri, 22 Mar 2019 15:43:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-8a1b1718214cfd945fef14b3031e4e7262882a86@git.kernel.org>
Cc:     guro@fb.com, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jakub.kicinski@netronome.com,
        daniel@iogearbox.net, acme@redhat.com, sdf@google.com,
        ast@kernel.org, songliubraving@fb.com, mingo@kernel.org,
        hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          jakub.kicinski@netronome.com, guro@fb.com, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org, sdf@google.com,
          ast@kernel.org, songliubraving@fb.com, hpa@zytor.com,
          mingo@kernel.org, daniel@iogearbox.net, acme@redhat.com
In-Reply-To: <20190312053051.2690567-13-songliubraving@fb.com>
References: <20190312053051.2690567-13-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf build: Check what binutils's
 'disassembler()' signature to use
Git-Commit-ID: 8a1b1718214cfd945fef14b3031e4e7262882a86
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

Commit-ID:  8a1b1718214cfd945fef14b3031e4e7262882a86
Gitweb:     https://git.kernel.org/tip/8a1b1718214cfd945fef14b3031e4e7262882a86
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:48 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Mar 2019 16:42:10 -0300

perf build: Check what binutils's 'disassembler()' signature to use

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
