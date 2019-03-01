Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D7520850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbfCAQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:38:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:43913 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbfCAQiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:38:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 08:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,428,1544515200"; 
   d="scan'208";a="323258458"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 01 Mar 2019 08:38:54 -0800
Received: from [10.252.14.197] (abudanko-mobl.ccr.corp.intel.com [10.252.14.197])
        by linux.intel.com (Postfix) with ESMTP id 844545805B4;
        Fri,  1 Mar 2019 08:38:52 -0800 (PST)
Subject: [PATCH v5 01/10] feature: implement libzstd check, LIBZSTD_DIR and
 NO_LIBZSTD defines
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
Organization: Intel Corp.
Message-ID: <07191759-153e-fdfd-ea58-562244448c84@linux.intel.com>
Date:   Fri, 1 Mar 2019 19:38:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement libzstd feature check, NO_LIBZSTD and LIBZSTD_DIR defines
to override Zstd library sources or disable the feature from the
command line:

  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd/sources/ clean all
  $ make -C tools/perf NO_LIBZSTD=1 clean all

Auto detection feature status is reported just before compilation starts.
If your system has some version of the zstd library preinstalled then
the build system finds and uses it during the build.

If you still prefer to compile with some other version of zstd library
that is not preinstalled you have capability to refer the compilation
to that version using LIBZSTD_DIR define.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v5:
- implemented perf version --build-options extension for aio and zstd

---
 tools/build/Makefile.feature       |  6 ++++--
 tools/build/feature/Makefile       |  6 +++++-
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libzstd.c | 12 ++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++++++++++++
 tools/perf/Makefile.perf           |  3 +++
 tools/perf/builtin-version.c       |  2 ++
 7 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 61e46d54a67c..adf791cbd726 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -66,7 +66,8 @@ FEATURE_TESTS_BASIC :=                  \
         sched_getcpu			\
         sdt				\
         setns				\
-        libaio
+        libaio				\
+        libzstd
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -118,7 +119,8 @@ FEATURE_DISPLAY ?=              \
          lzma                   \
          get_cpuid              \
          bpf			\
-         libaio
+         libaio			\
+         libzstd
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7ceb4441b627..4b8244ee65ce 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -62,7 +62,8 @@ FILES=                                          \
          test-clang.bin				\
          test-llvm.bin				\
          test-llvm-version.bin			\
-         test-libaio.bin
+         test-libaio.bin			\
+         test-libzstd.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -301,6 +302,9 @@ $(OUTPUT)test-clang.bin:
 $(OUTPUT)test-libaio.bin:
 	$(BUILD) -lrt
 
+$(OUTPUT)test-libzstd.bin:
+	$(BUILD) -lzstd
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index e903b86b742f..b0dda7db2a17 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -178,6 +178,10 @@
 # include "test-reallocarray.c"
 #undef main
 
+#define main main_test_zstd
+# include "test-libzstd.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -219,6 +223,7 @@ int main(int argc, char *argv[])
 	main_test_setns();
 	main_test_libaio();
 	main_test_reallocarray();
+	main_test_libzstd();
 
 	return 0;
 }
diff --git a/tools/build/feature/test-libzstd.c b/tools/build/feature/test-libzstd.c
new file mode 100644
index 000000000000..55268c01b84d
--- /dev/null
+++ b/tools/build/feature/test-libzstd.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <zstd.h>
+
+int main(void)
+{
+	ZSTD_CStream	*cstream;
+
+	cstream = ZSTD_createCStream();
+	ZSTD_freeCStream(cstream);
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0f11d5891301..4949bdb16a66 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -152,6 +152,13 @@ endif
 FEATURE_CHECK_CFLAGS-libbabeltrace := $(LIBBABELTRACE_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libbabeltrace := $(LIBBABELTRACE_LDFLAGS) -lbabeltrace-ctf
 
+ifdef LIBZSTD_DIR
+  LIBZSTD_CFLAGS  := -I$(LIBZSTD_DIR)/lib
+  LIBZSTD_LDFLAGS := -L$(LIBZSTD_DIR)/lib
+endif
+FEATURE_CHECK_CFLAGS-libzstd := $(LIBZSTD_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libzstd := $(LIBZSTD_LDFLAGS)
+
 FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi -I$(srctree)/tools/include/uapi
 # include ARCH specific config
 -include $(src-perf)/arch/$(SRCARCH)/Makefile
@@ -782,6 +789,19 @@ ifndef NO_LZMA
   endif
 endif
 
+ifndef NO_LIBZSTD
+  ifeq ($(feature-libzstd), 1)
+    CFLAGS += -DHAVE_ZSTD_SUPPORT
+    CFLAGS += $(LIBZSTD_CFLAGS)
+    LDFLAGS += $(LIBZSTD_LDFLAGS)
+    EXTLIBS += -lzstd
+    $(call detected,CONFIG_ZSTD)
+  else
+    msg := $(warning No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR);
+    NO_LIBZSTD := 1
+  endif
+endif
+
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 01f7555fd933..06b927ee6ee3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -108,6 +108,9 @@ include ../scripts/utilities.mak
 # streaming for record mode. Currently Posix AIO trace streaming is
 # supported only when linking with glibc.
 #
+# Define NO_LIBZSTD if you do not want support of Zstandard based runtime
+# trace compression in record mode.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 50df168be326..f470144d1a70 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -78,6 +78,8 @@ static void library_status(void)
 	STATUS(HAVE_LZMA_SUPPORT, lzma);
 	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
 	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
+	STATUS(HAVE_AIO_SUPPORT, aio);
+	STATUS(HAVE_ZSTD_SUPPORT, zstd);
 }
 
 int cmd_version(int argc, const char **argv)
-- 
2.20.1

