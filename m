Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFBC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9F12071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfKZQg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:36:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:39751 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfKZQg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:36:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 08:36:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359212532"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 08:36:53 -0800
From:   roman.sudarikov@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
Subject: [PATCH 5/6] perf tools: Add feature check for libpci
Date:   Tue, 26 Nov 2019 19:36:29 +0300
Message-Id: <20191126163630.17300-6-roman.sudarikov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191126163630.17300-5-roman.sudarikov@linux.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-3-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-4-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-5-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

Add feature check for libpci to show device name in --iiostat mode.
libpci support allows device name to b:d:f notion.

Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  4 ++++
 tools/build/feature/test-all.c    |  5 +++++
 tools/build/feature/test-libpci.c | 10 ++++++++++
 tools/perf/Makefile.config        | 10 ++++++++++
 tools/perf/builtin-version.c      |  1 +
 tools/perf/tests/make             |  1 +
 7 files changed, 33 insertions(+)
 create mode 100644 tools/build/feature/test-libpci.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 8a19753cc26a..bebdfb99607c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -50,6 +50,7 @@ FEATURE_TESTS_BASIC :=                  \
         libelf-mmap                     \
         libnuma                         \
         numa_num_possible_cpus          \
+        libpci                          \
         libperl                         \
         libpython                       \
         libpython-version               \
@@ -115,6 +116,7 @@ FEATURE_DISPLAY ?=              \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
+         libpci                 \
          libperl                \
          libpython              \
          libcrypto              \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 8499385365c0..f0d5f886602d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -28,6 +28,7 @@ FILES=                                          \
          test-libelf-mmap.bin                   \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
+         test-libpci.bin                        \
          test-libperl.bin                       \
          test-libpython.bin                     \
          test-libpython-version.bin             \
@@ -210,6 +211,9 @@ PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
 PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
 FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
+$(OUTPUT)test-libpci.bin:
+	$(BUILD) -lpci
+
 $(OUTPUT)test-libperl.bin:
 	$(BUILD) $(FLAGS_PERL_EMBED)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 88145e8cde1a..c61d34804a06 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -74,6 +74,10 @@
 # include "test-libunwind.c"
 #undef main
 
+#define main main_test_libpci
+# include "test-libpci.c"
+#undef
+
 #define main main_test_libaudit
 # include "test-libaudit.c"
 #undef main
@@ -210,6 +214,7 @@ int main(int argc, char *argv[])
 	main_test_libunwind();
 	main_test_libaudit();
 	main_test_libslang();
+	main_test_libpci();
 	main_test_gtk2(argc, argv);
 	main_test_gtk2_infobar(argc, argv);
 	main_test_libbfd();
diff --git a/tools/build/feature/test-libpci.c b/tools/build/feature/test-libpci.c
new file mode 100644
index 000000000000..4bbeb9ffd687
--- /dev/null
+++ b/tools/build/feature/test-libpci.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "pci/pci.h"
+
+int main(void)
+{
+	struct pci_access *pacc = pci_alloc();
+
+	pci_cleanup(pacc);
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 46f7fba2306c..1b9d341492c8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -839,6 +839,16 @@ ifndef NO_LIBCAP
   endif
 endif
 
+ifndef NO_PCILIB
+  ifeq ($(feature-libpci), 1)
+    CFLAGS += -DHAVE_LIBPCI_SUPPORT
+    EXTLIBS += -lpci
+  else
+    msg := $(warning No libpci found, show pci devices without names in iiostat mode, please install libpci-dev/pciutils-devel);
+    NO_PCILIB := 1
+  endif
+endif
+
 ifndef NO_BACKTRACE
   ifeq ($(feature-backtrace), 1)
     CFLAGS += -DHAVE_BACKTRACE_SUPPORT
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 05cf2af9e2c2..ec4e0eb07825 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -76,6 +76,7 @@ static void library_status(void)
 	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
 	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
 	STATUS(HAVE_ZLIB_SUPPORT, zlib);
+	STATUS(HAVE_LIBPCI_SUPPORT, libpci);
 	STATUS(HAVE_LZMA_SUPPORT, lzma);
 	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
 	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c850d1664c56..0b78cf6e8377 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -109,6 +109,7 @@ make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_LIBCAP=1
+make_minimal        += NO_LIBPCI=1
 
 # $(run) contains all available tests
 run := make_pure
-- 
2.19.1

