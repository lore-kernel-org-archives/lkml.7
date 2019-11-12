Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62546C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3782021E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583918;
	bh=+OYypPXhE56rRs0i42A3qAksmd2H2K8WvTRENOiVgIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cK10pu0IqW6CLus2a3D2xza5x8UzlWJxZm/YCpDa5xMmG+l2HKuBDnQyGdCo1mLtU
	 rZiE2FV/37QdzzcVWS90I4OelLOD2Gq0G7cN99ZAjTb2lar4/ON/2v/p2YQLdAQikT
	 fPfvbALfASk3N4QvzucghfmA9nhGiBEPGSjUDkHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKLSig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfKLSie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:34 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC0021A49;
        Tue, 12 Nov 2019 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583912;
        bh=+OYypPXhE56rRs0i42A3qAksmd2H2K8WvTRENOiVgIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xuZE3ipBc40UwcK5ULTDvR8xu6ZXE1ojr71u6cdcAuYjg6ZflW6OPFJ/bsgqZzGi/
         FzXR4nqiWBbmt9ja7g/URtNPos0k4SbjcIWGRinNc+MfgrHLxPNj+/0I7I3pjM9Iw5
         1ONESh+BiDCgKvNq+YrSNvW3+sDAf6v21sSwQvpE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 06/15] perf unwind: Use 'struct map_symbol' in 'struct unwind_entry'
Date:   Tue, 12 Nov 2019 15:37:48 -0300
Message-Id: <20191112183757.28660-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 4f4ecbcbe87e..779ce280a0e9 100644
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
index e768ef24633f..3874bb89ac79 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2448,9 +2448,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
index 15f6e46d7124..73c00d776a5f 100644
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
index 1800887b2255..6e3873dd9a31 100644
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
index 3a7d00c20d86..50337c966979 100644
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
-- 
2.21.0

