Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78DAECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD922086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJOFef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfJOFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQl-0008Rx-Gz; Tue, 15 Oct 2019 07:31:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 134D41C03AB;
        Tue, 15 Oct 2019 07:31:35 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:34 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Propagate CFLAGS to libperf
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011122155.15738-1-jolsa@kernel.org>
References: <20191011122155.15738-1-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749498.12254.4769233203292412993.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     55542113c690a567e728e40d4181d7d037fc21b0
Gitweb:        https://git.kernel.org/tip/55542113c690a567e728e40d4181d7d037fc21b0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 11 Oct 2019 14:21:55 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 11 Oct 2019 10:55:22 -03:00

perf tools: Propagate CFLAGS to libperf

Andi reported that 'make DEBUG=1' does not propagate to the libbperf
code. It's true also for the other flags. Changing the code to propagate
the global build flags to libperf compilation.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191011122155.15738-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 28 +++++++++++++++-------------
 tools/perf/Makefile.perf   |  2 +-
 tools/perf/lib/core.c      |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 46f7fba..063202c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -188,7 +188,7 @@ endif
 
 # Treat warnings as errors unless directed not to
 ifneq ($(WERROR),0)
-  CFLAGS += -Werror
+  CORE_CFLAGS += -Werror
   CXXFLAGS += -Werror
 endif
 
@@ -198,9 +198,9 @@ endif
 
 ifeq ($(DEBUG),0)
 ifeq ($(CC_NO_CLANG), 0)
-  CFLAGS += -O3
+  CORE_CFLAGS += -O3
 else
-  CFLAGS += -O6
+  CORE_CFLAGS += -O6
 endif
 endif
 
@@ -245,12 +245,12 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
 FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
 
-CFLAGS += -fno-omit-frame-pointer
-CFLAGS += -ggdb3
-CFLAGS += -funwind-tables
-CFLAGS += -Wall
-CFLAGS += -Wextra
-CFLAGS += -std=gnu99
+CORE_CFLAGS += -fno-omit-frame-pointer
+CORE_CFLAGS += -ggdb3
+CORE_CFLAGS += -funwind-tables
+CORE_CFLAGS += -Wall
+CORE_CFLAGS += -Wextra
+CORE_CFLAGS += -std=gnu99
 
 CXXFLAGS += -std=gnu++11 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
@@ -272,12 +272,12 @@ include $(FEATURES_DUMP)
 endif
 
 ifeq ($(feature-stackprotector-all), 1)
-  CFLAGS += -fstack-protector-all
+  CORE_CFLAGS += -fstack-protector-all
 endif
 
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
-    CFLAGS += -D_FORTIFY_SOURCE=2
+    CORE_CFLAGS += -D_FORTIFY_SOURCE=2
   endif
 endif
 
@@ -301,10 +301,12 @@ INC_FLAGS += -I$(src-perf)/util
 INC_FLAGS += -I$(src-perf)
 INC_FLAGS += -I$(srctree)/tools/lib/
 
-CFLAGS   += $(INC_FLAGS)
+CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
+
+CFLAGS   += $(CORE_CFLAGS) $(INC_FLAGS)
 CXXFLAGS += $(INC_FLAGS)
 
-CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
+LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
 
 ifeq ($(feature-sync-compare-and-swap), 1)
   CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 45c14dc..a099a8a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -769,7 +769,7 @@ $(LIBBPF)-clean:
 	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) clean >/dev/null
 
 $(LIBPERF): FORCE
-	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) $(OUTPUT)libperf.a
+	$(Q)$(MAKE) -C $(LIBPERF_DIR) EXTRA_CFLAGS="$(LIBPERF_CFLAGS)" O=$(OUTPUT) $(OUTPUT)libperf.a
 
 $(LIBPERF)-clean:
 	$(call QUIET_CLEAN, libperf)
diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
index d0b9ae4..58fc894 100644
--- a/tools/perf/lib/core.c
+++ b/tools/perf/lib/core.c
@@ -5,11 +5,12 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <unistd.h>
+#include <linux/compiler.h>
 #include <perf/core.h>
 #include <internal/lib.h>
 #include "internal.h"
 
-static int __base_pr(enum libperf_print_level level, const char *format,
+static int __base_pr(enum libperf_print_level level __maybe_unused, const char *format,
 		     va_list args)
 {
 	return vfprintf(stderr, format, args);
