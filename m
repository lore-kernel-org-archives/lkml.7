Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DF92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405679AbfITQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404971AbfITQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLek-00049b-36; Fri, 20 Sep 2019 18:21:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1AAA61C0E34;
        Fri, 20 Sep 2019 18:21:01 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:00 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tools: Remove debug.h from places where it is
 not needed
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-r889ur2cxe16m91m2a4pl15p@git.kernel.org>
References: <tip-r889ur2cxe16m91m2a4pl15p@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646098.24167.15439088929691950490.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4a903c2e151423be9af19c7eb35d4667be21c4c1
Gitweb:        https://git.kernel.org/tip/4a903c2e151423be9af19c7eb35d4667be21c4c1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 03 Sep 2019 10:11:53 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:20 -03:00

perf tools: Remove debug.h from places where it is not needed

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
index 002520d..1495a95 100644
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
index 8a4b717..abb7a12 100644
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
index f45fe11..ff2711a 100644
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
index 0f59a70..57e6e43 100644
--- a/tools/perf/ui/browsers/header.c
+++ b/tools/perf/ui/browsers/header.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/debug.h"
 #include "ui/browser.h"
 #include "ui/keysyms.h"
 #include "ui/ui.h"
diff --git a/tools/perf/ui/gtk/helpline.c b/tools/perf/ui/gtk/helpline.c
index e166da9..e40a006 100644
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
index c2c5589..c47f5c3 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "../util.h"
-#include "../../util/debug.h"
 #include "gtk.h"
 
 #include <stdlib.h>
diff --git a/tools/perf/ui/helpline.c b/tools/perf/ui/helpline.c
index 54bcd08..e009014 100644
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
index 5f188f6..298d6af 100644
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
index 087d9ab..b98dd0e 100644
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
index 9d1e090..52261e5 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -1,5 +1,4 @@
 #include "util/util.h"
-#include "util/debug.h"
 #include "util/map_symbol.h"
 #include "util/branch.h"
 #include <linux/kernel.h>
diff --git a/tools/perf/util/demangle-java.c b/tools/perf/util/demangle-java.c
index 763328c..6fb7f34 100644
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
index 66756e6..6b4e5a0 100644
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
index c5e5681..21c216c 100644
--- a/tools/perf/util/libunwind/x86_32.c
+++ b/tools/perf/util/libunwind/x86_32.c
@@ -22,7 +22,6 @@
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_X86_SP
 
 #include "unwind.h"
-#include "debug.h"
 #include "libunwind-x86.h"
 #include <../../../../arch/x86/include/uapi/asm/perf_regs.h>
 
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 565f7ae..e152d2b 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -7,7 +7,6 @@
 
 #include "target.h"
 #include "util.h"
-#include "debug.h"
 
 #include <pwd.h>
 #include <stdio.h>
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 3949a60..196438e 100644
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
index 59d456f..deb6e69 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -10,8 +10,6 @@
 
 #include "util/compress.h"
 #include "util/util.h"
-#include "util/debug.h"
-
 
 #define CHUNK_SIZE  16384
 
