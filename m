Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FEC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E7420857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfKOHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:41:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfKOHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDJ-0002Yk-Ev; Fri, 15 Nov 2019 08:40:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 11E181C08AC;
        Fri, 15 Nov 2019 08:40:17 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf unwind: Use 'struct map_symbol' in 'struct
 unwind_entry'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-epsiibeprpxa8qpwji47uskc@git.kernel.org>
References: <tip-epsiibeprpxa8qpwji47uskc@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361668.29467.18173777516441491656.tip-bot2@tip-bot2>
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

Commit-ID:     c1529738f5eb5fe7c472e0374ad7954d52566df9
Gitweb:        https://git.kernel.org/tip/c1529738f5eb5fe7c472e0374ad7954d52566df9
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 11:58:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf unwind: Use 'struct map_symbol' in 'struct unwind_entry'

To help in passing that info around to callchain routines that, for the
same reason, are moving to use 'struct map_symbol'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-epsiibeprpxa8qpwji47uskc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/dwarf-unwind.c          |  2 +-
 tools/perf/util/machine.c                | 17 +++++++++--------
 tools/perf/util/unwind-libdw.c           |  6 +++---
 tools/perf/util/unwind-libunwind-local.c |  6 +++---
 tools/perf/util/unwind.h                 |  8 +++-----
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 4f4ecbc..779ce28 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -59,7 +59,7 @@ int test_dwarf_unwind__krava_1(struct thread *thread);
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	unsigned long *cnt = (unsigned long *) arg;
-	char *symbol = entry->sym ? entry->sym->name : NULL;
+	char *symbol = entry->ms.sym ? entry->ms.sym->name : NULL;
 	static const char *funcs[MAX_STACK] = {
 		"test__arch_unwind_sample",
 		"test_dwarf_unwind__thread",
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e768ef2..3874bb8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2448,9 +2448,10 @@ check_calls:
 	return 0;
 }
 
-static int append_inlines(struct callchain_cursor *cursor,
-			  struct map *map, struct symbol *sym, u64 ip)
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip)
 {
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
 	u64 addr;
@@ -2488,22 +2489,22 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	const char *srcline = NULL;
 	u64 addr = entry->ip;
 
-	if (symbol_conf.hide_unresolved && entry->sym == NULL)
+	if (symbol_conf.hide_unresolved && entry->ms.sym == NULL)
 		return 0;
 
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+	if (append_inlines(cursor, &entry->ms, entry->ip) == 0)
 		return 0;
 
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	if (entry->map)
-		addr = map__map_ip(entry->map, entry->ip);
+	if (entry->ms.map)
+		addr = map__map_ip(entry->ms.map, entry->ip);
 
-	srcline = callchain_srcline(entry->map, entry->sym, addr);
+	srcline = callchain_srcline(entry->ms.map, entry->ms.sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
-				       entry->map, entry->sym,
+				       entry->ms.map, entry->ms.sym,
 				       false, NULL, 0, 0, 0, srcline);
 }
 
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 15f6e46..73c00d7 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -80,9 +80,9 @@ static int entry(u64 ip, struct unwind_info *ui)
 	if (__report_module(&al, ip, ui))
 		return -1;
 
-	e->ip  = ip;
-	e->map = al.map;
-	e->sym = al.sym;
+	e->ip	  = ip;
+	e->ms.map = al.map;
+	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 1800887..6e3873d 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -575,9 +575,9 @@ static int entry(u64 ip, struct thread *thread,
 	struct unwind_entry e;
 	struct addr_location al;
 
-	e.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-	e.ip  = ip;
-	e.map = al.map;
+	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
+	e.ip     = ip;
+	e.ms.map = al.map;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 3a7d00c..50337c9 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -4,17 +4,15 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include "util/map_symbol.h"
 
-struct map;
 struct map_groups;
 struct perf_sample;
-struct symbol;
 struct thread;
 
 struct unwind_entry {
-	struct map	*map;
-	struct symbol	*sym;
-	u64		ip;
+	struct map_symbol ms;
+	u64		  ip;
 };
 
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
