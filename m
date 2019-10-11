Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26604C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDE820673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824718;
	bh=FpjDNM3Xp9ccpZyDrr9pFgkDarJSWw1PYzTLkyKKt3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yJoNviCszSOHKAhH86NNS7XUH4NYvjshPkqbdOGS8e7P83WbKjr3v7fJAVRWrPmSV
	 P7r04CBBDq/W3I9TxWhoZ/K+ZmzeQGxbyMdmEq+hHyPOmYu8pA7CuyYuqUczYNMFG2
	 ggDB5M1aNBP6sXQrIoEmObBZ6ZcItfSMY5U8wrjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfJKUL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJKULz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:11:55 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E71522475;
        Fri, 11 Oct 2019 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824714;
        bh=FpjDNM3Xp9ccpZyDrr9pFgkDarJSWw1PYzTLkyKKt3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zcQW2piuDvY1KsN2IeTyKTpTA6zbI0H1OIovFwa2z7OgOG5ItbGkBYSN/0vNbpLZ3
         4kDEv3WokzAlEHScnRqHkKMQ087l6NFBl3zGJghIqKksQBq7IGdOtTrY3DXE3phqzw
         O501g3Bh7YeaRhC2HynTcMcIKnLba4kyNbfiMZY4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 68/69] perf tools: Propagate CFLAGS to libperf
Date:   Fri, 11 Oct 2019 17:05:58 -0300
Message-Id: <20191011200559.7156-69-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 46f7fba2306c..063202c53b64 100644
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
index 45c14dc24f4b..a099a8a89447 100644
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
index d0b9ae422b9f..58fc894b76c5 100644
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
-- 
2.21.0

