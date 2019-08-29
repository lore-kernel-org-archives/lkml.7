Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1EBC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470B322CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089615;
	bh=Ecglz1BsaX8i9IhIjkmKGJ5G2iFMjQdAuHQqNhefkv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CUm7qDT3bxCL7PwJU8BUKIG2KUY2xuyPNhy16RQ5EcvzcIR9J668Jts+3fIxRF4QD
	 lixwAw0T8l1vBzRnWOZG4lZi20DOSOUTQBUW5CLnNlK6zITtBG89kHUr/7ilIpUYam
	 6tNJFQJojVsWjCpW0izfRsX8RbIxRePtlAEmhDEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfH2OkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfH2OkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0EB2342D;
        Thu, 29 Aug 2019 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089610;
        bh=Ecglz1BsaX8i9IhIjkmKGJ5G2iFMjQdAuHQqNhefkv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zf6ZBoRsyXCBFvjbRlDXK64cfNl3YD0N0GklUx2VN0OefeushF/2v/ofy9mrrXdU/
         1oG1qCgifxDfJd88CVhXRByCZiqn0ze+jI9QKaCFS6h4lWWNVGpyn20akNHtUXCr75
         1hxqbOQ88A4LpNVxdKdrXINGxZub2sg7ilOx/Ck0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/37] perf clang: Delete needless util-cxx.h header
Date:   Thu, 29 Aug 2019 11:38:49 -0300
Message-Id: <20190829143917.29745-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index e20d7c5e1925..80a828e75cf6 100644
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
index e513366f2ee0..2df8a45bd088 100644
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
index 7b042a5ebc68..21b23605f78b 100644
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
index 80a99e458d4e..000000000000
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
-- 
2.21.0

