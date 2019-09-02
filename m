Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF30C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D091215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfIBITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56236 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbfIBIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVu-00084j-Sh; Mon, 02 Sep 2019 10:16:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0B941C0DF6;
        Mon,  2 Sep 2019 10:16:32 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:32 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf dso: Adopt DSO related macros from symbol.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-edenkmjt1oe5fks2s6umd30b@git.kernel.org>
References: <tip-edenkmjt1oe5fks2s6umd30b@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219258.17330.10301827707018214523.tip-bot2@tip-bot2>
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

Commit-ID:     fac583fdb6741bf4850928b2a5bb8b0118b5879c
Gitweb:        https://git.kernel.org/tip/fac583fdb6741bf4850928b2a5bb8b0118b5879c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 09:43:25 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:19:28 -03:00

perf dso: Adopt DSO related macros from symbol.h

Reducing the size of symbol.h by removing things that are better placed
somewhere else.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-edenkmjt1oe5fks2s6umd30b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c   | 1 +
 tools/perf/util/build-id.c   | 1 +
 tools/perf/util/dso.h        | 3 +++
 tools/perf/util/probe-file.c | 1 +
 tools/perf/util/symbol.c     | 1 +
 tools/perf/util/symbol.h     | 3 ---
 6 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3bd1691..67a7513 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -20,6 +20,7 @@
 #include "color.h"
 #include "config.h"
 #include "cache.h"
+#include "dso.h"
 #include "map.h"
 #include "symbol.h"
 #include "srcline.h"
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 4c96a33..e5fb777 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include "dso.h"
 #include "build-id.h"
 #include "event.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 6e3f637..ff0b818 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -16,6 +16,9 @@ struct machine;
 struct map;
 struct perf_env;
 
+#define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
+#define DSO__NAME_KCORE		"[kernel.kcore]"
+
 enum dso_binary_type {
 	DSO_BINARY_TYPE__KALLSYMS = 0,
 	DSO_BINARY_TYPE__GUEST_KALLSYMS,
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5b4d493..10d2ab1 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -16,6 +16,7 @@
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "dso.h"
 #include "cache.h"
 #include "color.h"
 #include "symbol.h"
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c37cca6..b11a696 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,7 @@
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
+#include "dso.h"
 #include "util.h"
 #include "debug.h"
 #include "event.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 183f630..159c596 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -46,9 +46,6 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
 #endif
 
-#define DSO__NAME_KALLSYMS	"[kernel.kallsyms]"
-#define DSO__NAME_KCORE		"[kernel.kcore]"
-
 /** struct symbol - symtab entry
  *
  * @ignore - resolvable but tools ignore it (e.g. idle routines)
