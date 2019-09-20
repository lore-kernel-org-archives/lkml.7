Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A8E20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989629;
	bh=7VDBlySs4qcQYyPUCyz8WIIk4UjSyht+6xPumEnhYhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JaNVn1pc+9UOFHsQ87e+tJ0PInsDG111JdcMz7U+1waORynHRRM0eJ4MNXEB05iM8
	 TRPqk488hnyK6UOg24EAL9BkJ5pa7/jntDUseIZHQ0kjDYIXsVD3LLPgFUU254Dgyq
	 15rPKMlcvQnA40+6i2Krd6Jw3Qf+Ie8Oxhncd83k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389591AbfITO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388974AbfITO0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAC9F20B7C;
        Fri, 20 Sep 2019 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989578;
        bh=7VDBlySs4qcQYyPUCyz8WIIk4UjSyht+6xPumEnhYhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KntfAg+ahLUlJToXrzXFyKK3JNnhOUDQegc3CTSXGcbZnBrwEXNqZdUXnvkye0F+D
         mre1Njzu2/VONMeh6v3YmG/qbQ6J55Rg9+fuOSBDq/pDFDnw1CK1QG4jdRJnOw/qCt
         mLZD2c02w6lBJbLFbeD+OjwbaTSLQQ4ijDYnBaQk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/31] perf tools: Remove debug.h from places where it is not needed
Date:   Fri, 20 Sep 2019 11:25:20 -0300
Message-Id: <20190920142542.12047-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Pruning a bit more the includes dependency tree. Building this thing on
lots of containers takes time, we better reduce the time per build, each
container is doing 6 builds when clang and clang-devel are available,
and the plan is to do a 'make -C tools/perf build-test' that have many
more.

Also helps when doing normal development, as touching some random file
will have a much reduced chance of triggering lots of rebuilds.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-r889ur2cxe16m91m2a4pl15p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/unwind-libunwind.c | 2 +-
 tools/perf/arch/powerpc/util/sym-handling.c   | 1 -
 tools/perf/tests/clang.c                      | 1 -
 tools/perf/ui/browsers/header.c               | 1 -
 tools/perf/ui/gtk/helpline.c                  | 1 -
 tools/perf/ui/gtk/util.c                      | 1 -
 tools/perf/ui/helpline.c                      | 1 -
 tools/perf/ui/tui/helpline.c                  | 1 -
 tools/perf/ui/tui/util.c                      | 1 -
 tools/perf/util/branch.c                      | 1 -
 tools/perf/util/demangle-java.c               | 1 -
 tools/perf/util/libunwind/arm64.c             | 1 -
 tools/perf/util/libunwind/x86_32.c            | 1 -
 tools/perf/util/target.c                      | 1 -
 tools/perf/util/usage.c                       | 1 -
 tools/perf/util/zlib.c                        | 2 --
 16 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/tools/perf/arch/arm64/util/unwind-libunwind.c b/tools/perf/arch/arm64/util/unwind-libunwind.c
index 002520d4036b..1495a9523a23 100644
--- a/tools/perf/arch/arm64/util/unwind-libunwind.c
+++ b/tools/perf/arch/arm64/util/unwind-libunwind.c
@@ -5,8 +5,8 @@
 #include <libunwind.h>
 #include "perf_regs.h"
 #include "../../util/unwind.h"
-#include "../../util/debug.h"
 #endif
+#include "../../util/debug.h"
 
 int LIBUNWIND__ARCH_REG_ID(int regnum)
 {
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 8a4b717e0a53..abb7a12d8f93 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
  */
 
-#include "debug.h"
 #include "dso.h"
 #include "symbol.h"
 #include "map.h"
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
index f45fe11dcf50..ff2711a40940 100644
--- a/tools/perf/tests/clang.c
+++ b/tools/perf/tests/clang.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "tests.h"
-#include "debug.h"
 #include "util.h"
 #include "c++/clang-c.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/ui/browsers/header.c b/tools/perf/ui/browsers/header.c
index 0f59a7001479..57e6e4332f74 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/debug.h"
 #include "ui/browser.h"
 #include "ui/keysyms.h"
 #include "ui/ui.h"
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index e166da9ec767..e40a006aead8 100644
--- a/tools/perf/ui/gtk/helpline.c
+++ b/tools/perf/ui/gtk/helpline.c
@@ -6,7 +6,6 @@
 #include "gtk.h"
 #include "../ui.h"
 #include "../helpline.h"
-#include "../../util/debug.h"
 
 static void gtk_helpline_pop(void)
 {
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index c2c558958b9c..c47f5c387838 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../util.h"
-#include "../../util/debug.h"
 #include "gtk.h"
 
 #include <stdlib.h>
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index 54bcd08df87e..e00901450f91 100644
--- a/tools/perf/ui/helpline.c
+++ b/tools/perf/ui/helpline.c
@@ -3,7 +3,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "../util/debug.h"
 #include "helpline.h"
 #include "ui.h"
 #include "../util/util.h"
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 5f188f678c55..298d6af82fdd 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -6,7 +6,6 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 
-#include "../../util/debug.h"
 #include "../helpline.h"
 #include "../ui.h"
 #include "../libslang.h"
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 087d9ab054c8..b98dd0e31dc1 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -5,7 +5,6 @@
 #include <stdlib.h>
 #include <sys/ttydefaults.h>
 
-#include "../../util/debug.h"
 #include "../browser.h"
 #include "../keysyms.h"
 #include "../helpline.h"
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 9d1e090084a2..52261e5f718a 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,5 +1,4 @@
 #include "util/util.h"
-#include "util/debug.h"
 #include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 763328c151e9..6fb7f34c0814 100644
--- a/tools/perf/util/demangle-java.c
+++ b/tools/perf/util/demangle-java.c
@@ -3,7 +3,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include "debug.h"
 #include "symbol.h"
 
 #include "demangle-java.h"
diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 66756e6be111..6b4e5a0892f8 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -22,7 +22,6 @@
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_ARM64_SP
 
 #include "unwind.h"
-#include "debug.h"
 #include "libunwind-aarch64.h"
 #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
 #include "../../arch/arm64/util/unwind-libunwind.c"
diff --git a/tools/perf/util/libunwind/x86_32.c b/tools/perf/util/libunwind/x86_32.c
index c5e568188e19..21c216c40a3b 100644
--- a/tools/perf/util/libunwind/x86_32.c
+++ b/tools/perf/util/libunwind/x86_32.c
@@ -22,7 +22,6 @@
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_X86_SP
 
 #include "unwind.h"
-#include "debug.h"
 #include "libunwind-x86.h"
 #include <../../../../arch/x86/include/uapi/asm/perf_regs.h>
 
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 565f7aef7e6c..e152d2bbe3a3 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -7,7 +7,6 @@
 
 #include "target.h"
 #include "util.h"
-#include "debug.h"
 
 #include <pwd.h>
 #include <stdio.h>
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 3949a60b00ae..196438ee4c9d 100644
--- a/tools/perf/util/usage.c
+++ b/tools/perf/util/usage.c
@@ -8,7 +8,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "util.h"
-#include "debug.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/compiler.h>
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 59d456f716e9..deb6e69adb5a 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -10,8 +10,6 @@
 
 #include "util/compress.h"
 #include "util/util.h"
-#include "util/debug.h"
-
 
 #define CHUNK_SIZE  16384
 
-- 
2.21.0

