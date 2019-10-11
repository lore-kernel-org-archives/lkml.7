Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AABC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9711214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570796521;
	bh=MqUX+JZgCizRiDntKWuJryUxEwcAdUMB3acOw5wvjFY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RqgsVkjR6x04iD1+Ykvyi7n3bogutiMz0RutrmeGnUSma8KTIxTYjXQdPt7YZqlfN
	 SEoNAeQB3G1IlOkIusJYNU5wJosWkj8ry5YK2/kffN5F4y6x+SX+aQ9BjYvlMEaxIN
	 LSN+e9ZD0UiIb8h1sCJs1qJgEV5Xxg9wP0znLcf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfJKMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfJKMV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5B4885537;
        Fri, 11 Oct 2019 12:21:57 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.206.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED3A76012A;
        Fri, 11 Oct 2019 12:21:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Propagate CFLAGS to libperf
Date:   Fri, 11 Oct 2019 14:21:55 +0200
Message-Id: <20191011122155.15738-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 11 Oct 2019 12:21:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi reported that 'make DEBUG=1' does not propagate
to the libbperf code. It's true also for the other
flags. Changing the code to propagate the global
build flags to libperf compilation.

Reported-by: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/n/tip-sgq5yeyvitp655s2iq3e75ls@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

