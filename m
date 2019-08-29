Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C556C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19112166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfH2TEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:04:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfH2TCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg6-00054p-78; Thu, 29 Aug 2019 21:01:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C0B561C07C3;
        Thu, 29 Aug 2019 21:01:49 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf clang: Delete needless util-cxx.h header
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        He Kuang <hekuang@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-1r5tvfnwiydjxhukgqs6bi11@git.kernel.org>
References: <tip-1r5tvfnwiydjxhukgqs6bi11@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156710530970.10532.5221592756860725372.tip-bot2@tip-bot2>
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

Commit-ID:     630aec1a7fd60ac355d5f2d67b5454912c5971a6
Gitweb:        https://git.kernel.org/tip/630aec1a7fd60ac355d5f2d67b5454912c5971a6
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 28 Aug 2019 09:59:10 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:14:57 -03:00

perf clang: Delete needless util-cxx.h header

It was put in place just to make sure the 'new' C++ operator wouldn't
clash with some argument name in util.h, but there is not anymore any
such argument and also the reason stated for util.h to be included there
was to get the __maybe_unused definition, that is in linux/compiler.h,
so use that instead and nuke util-cxx.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1r5tvfnwiydjxhukgqs6bi11@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c       |  1 +
 tools/perf/util/c++/clang-c.h      |  2 +-
 tools/perf/util/c++/clang-test.cpp |  4 +++-
 tools/perf/util/util-cxx.h         | 27 ---------------------------
 4 files changed, 5 insertions(+), 29 deletions(-)
 delete mode 100644 tools/perf/util/util-cxx.h

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index e20d7c5..80a828e 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -23,6 +23,7 @@
 #include "probe-finder.h" // for MAX_PROBES
 #include "parse-events.h"
 #include "strfilter.h"
+#include "util.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
 
diff --git a/tools/perf/util/c++/clang-c.h b/tools/perf/util/c++/clang-c.h
index e513366..2df8a45 100644
--- a/tools/perf/util/c++/clang-c.h
+++ b/tools/perf/util/c++/clang-c.h
@@ -3,7 +3,6 @@
 #define PERF_UTIL_CLANG_C_H
 
 #include <stddef.h>	/* for size_t */
-#include <util-cxx.h>	/* for __maybe_unused */
 
 #ifdef __cplusplus
 extern "C" {
@@ -22,6 +21,7 @@ extern int perf_clang__compile_bpf(const char *filename,
 #else
 
 #include <errno.h>
+#include <linux/compiler.h>	/* for __maybe_unused */
 
 static inline void perf_clang__init(void) { }
 static inline void perf_clang__cleanup(void) { }
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
index 7b042a5..21b2360 100644
--- a/tools/perf/util/c++/clang-test.cpp
+++ b/tools/perf/util/c++/clang-test.cpp
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "clang.h"
 #include "clang-c.h"
+extern "C" {
+#include "../util.h"
+}
 #include "llvm/IR/Function.h"
 #include "llvm/IR/LLVMContext.h"
 
-#include <util-cxx.h>
 #include <tests/llvm.h>
 #include <string>
 
diff --git a/tools/perf/util/util-cxx.h b/tools/perf/util/util-cxx.h
deleted file mode 100644
index 80a99e4..0000000
--- a/tools/perf/util/util-cxx.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Support C++ source use utilities defined in util.h
- */
-
-#ifndef PERF_UTIL_UTIL_CXX_H
-#define PERF_UTIL_UTIL_CXX_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-/*
- * Now 'new' is the only C++ keyword found in util.h:
- * in tools/include/linux/rbtree.h
- *
- * Other keywords, like class and delete, should be
- * redefined if necessary.
- */
-#define new _new
-#include "util.h"
-#undef new
-
-#ifdef __cplusplus
-}
-#endif
-#endif
