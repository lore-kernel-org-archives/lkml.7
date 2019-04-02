Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED87C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327222133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221252;
	bh=LPK/wEknXbVP94yboQQV0CjQuMEBq3qJ9g++aRsRRyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4GUD//ZGd/3grcKAMSr45n9MqI9Rd5BEwxhVE2g/TDzWWw67rgxU6s7NnPRbDEEn
	 /l5gfDBBzcpoxckmvS/RPhpFaoGxE1orGupRJ0RfZIp3hUY2tMjFBpFKgD29qD0CGp
	 PQrqlq7xrWCd59Hq0SbSnEqhBIR0PcttqzZx6Lk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfDBQHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfDBQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:28 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 376E721473;
        Tue,  2 Apr 2019 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221248;
        bh=LPK/wEknXbVP94yboQQV0CjQuMEBq3qJ9g++aRsRRyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp1haHmliN+NIdfBDi+qruqFSGVgfjLC4ojrqIydyD+nzYUEHHPein1nGDHUrPt6t
         vSON0sXL/VfhyYCyISIYgQ1kzucyhmI7RcnBqVtacOwFSw7fa3VKks03WTg+nFt9UM
         ZN4FcI9817JdQ0eaW28FIZPjODkIUXSdElxHsUsI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/44] tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
Date:   Tue,  2 Apr 2019 13:05:31 -0300
Message-Id: <20190402160549.13544-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implement libzstd feature check, NO_LIBZSTD and LIBZSTD_DIR defines to
override Zstd library sources or disable the feature from the command
line:

  $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd/sources/ clean all
  $ make -C tools/perf NO_LIBZSTD=1 clean all

Auto detection feature status is reported just before compilation
starts.  If your system has some version of the zstd library
preinstalled then the build system finds and uses it during the build.

If you still prefer to compile with some other version of zstd library
you have capability to refer the compilation to that version using
LIBZSTD_DIR define.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/9b4cd8b0-10a3-1f1e-8d6b-5922a7ca216b@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature       |  2 ++
 tools/build/feature/Makefile       |  6 +++++-
 tools/build/feature/test-all.c     |  5 +++++
 tools/build/feature/test-libzstd.c | 12 ++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++++++++++++
 tools/perf/Makefile.perf           |  3 +++
 tools/perf/builtin-version.c       |  2 ++
 7 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/build/feature/test-libzstd.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8d3864b061f3..361207387b1b 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -67,6 +67,7 @@ FEATURE_TESTS_BASIC :=                  \
         sdt				\
         setns				\
         libaio				\
+        libzstd				\
         disassembler-four-args
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -120,6 +121,7 @@ FEATURE_DISPLAY ?=              \
          get_cpuid              \
          bpf			\
          libaio			\
+         libzstd		\
          disassembler-four-args
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
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
index 7853e6d91090..a59c53705093 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -182,6 +182,10 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
+#define main main_test_zstd
+# include "test-libzstd.c"
+#undef main
+
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
@@ -224,6 +228,7 @@ int main(int argc, char *argv[])
 	main_test_libaio();
 	main_test_reallocarray();
 	main_test_disassembler_four_args();
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
index fe3f97e342fa..beb8b48b44e6 100644
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
@@ -787,6 +794,19 @@ ifndef NO_LZMA
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
index e8c9f77e9010..c706548d5b10 100644
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

