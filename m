Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157ABC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF95921789
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948468;
	bh=dIOGrypPY/Tv2updsE/EeOJYMhxyDI/OtpZcrASRxYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XtHw4w2u5phzcczB014imNgeArpTfwU4D6Vl7YAnVfJxO1JkP9aoK1yGKvdqihLMQ
	 PTJK3EB7lrcvrKHDpQE/bQVZl7vrFzs313Nfdpsnm47lh6OqWhRn36stqmd9d5kUY8
	 rW1IkKIAJpv8dKwIgrYC6sX1IAzVim9a1+7jJJdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfK1NlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfK1NlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:05 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B8D217D6;
        Thu, 28 Nov 2019 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948464;
        bh=dIOGrypPY/Tv2updsE/EeOJYMhxyDI/OtpZcrASRxYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ld4Hd46iwWTyaIOfNEFqpEvlNXusP/yltDp3eCOHL7lXzrFmH6HKabz4ncjTlQ/ag
         R40IUdjMmDqdOXPgUrYnUBI+QqUvX6jcZonRQAOTmNE2154k3PZsDZ8rvaKoE+GJTF
         nmTrIRA7JM7H/zJ4yo/aW3NF+yzRGIS+FUa6/UVQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 09/22] perf addr_location: Rename al->mg to al->maps
Date:   Thu, 28 Nov 2019 10:40:14 -0300
Message-Id: <20191128134027.23726-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step on the merge of 'struct maps' with 'struct map_groups'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-foo95pyyp3bhocbt7yd8qrvq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c                          |  8 ++++----
 tools/perf/util/db-export.c                          | 12 ++++++------
 tools/perf/util/event.c                              |  6 +++---
 tools/perf/util/hist.c                               |  8 ++++----
 tools/perf/util/machine.c                            |  6 +++---
 .../perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/symbol.h                             |  2 +-
 tools/perf/util/unwind-libdw.c                       |  2 +-
 tools/perf/util/unwind-libunwind-local.c             |  2 +-
 9 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 5cefce33b66b..c7270c057b6b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1106,7 +1106,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	al->mg	= node->ms.mg;
+	al->maps = node->ms.mg;
 	al->map = node->ms.map;
 	al->sym = node->ms.sym;
 	al->srcline = node->srcline;
@@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			goto out;
 	}
 
-	if (al->mg == &al->mg->machine->kmaps) {
-		if (machine__is_host(al->mg->machine)) {
+	if (al->maps == &al->maps->machine->kmaps) {
+		if (machine__is_host(al->maps->machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
 		} else {
@@ -1128,7 +1128,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			al->level = 'g';
 		}
 	} else {
-		if (machine__is_host(al->mg->machine)) {
+		if (machine__is_host(al->maps->machine)) {
 			al->cpumode = PERF_RECORD_MISC_USER;
 			al->level = '.';
 		} else if (perf_guest) {
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index e726922eb663..db7447154622 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = al->map->dso;
 
-		err = db_export__dso(dbe, dso, al->mg->machine);
+		err = db_export__dso(dbe, dso, al->maps->machine);
 		if (err)
 			return err;
 		*dso_db_id = dso->db_id;
@@ -251,7 +251,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		al.sym = node->ms.sym;
 		al.map = node->ms.map;
-		al.mg  = thread->maps;
+		al.maps = thread->maps;
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
@@ -360,13 +360,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (err)
 		return err;
 
-	err = db_export__machine(dbe, al->mg->machine);
+	err = db_export__machine(dbe, al->maps->machine);
 	if (err)
 		return err;
 
-	main_thread = thread__main_thread(al->mg->machine, thread);
+	main_thread = thread__main_thread(al->maps->machine, thread);
 
-	err = db_export__threads(dbe, thread, main_thread, al->mg->machine, &comm);
+	err = db_export__threads(dbe, thread, main_thread, al->maps->machine, &comm);
 	if (err)
 		goto out_put;
 
@@ -380,7 +380,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (dbe->cpr) {
-		struct call_path *cp = call_path_from_sample(dbe, al->mg->machine,
+		struct call_path *cp = call_path_from_sample(dbe, al->maps->machine,
 							     thread, sample,
 							     evsel);
 		if (cp) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2f0b77366cc0..fc3da38beef0 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -461,7 +461,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
-	al->mg = mg;
+	al->maps = mg;
 	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
@@ -474,13 +474,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		al->mg = mg = &machine->kmaps;
+		al->maps = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		al->mg = mg = &machine->kmaps;
+		al->maps = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0a8d72ae93ca..5ebfbe373442 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -692,7 +692,7 @@ __hists__add_entry(struct hists *hists,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
 		.ms = {
-			.mg	= al->mg,
+			.mg	= al->maps,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
@@ -760,7 +760,7 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 		.block_info = block_info,
 		.hists = hists,
 		.ms = {
-			.mg  = al->mg,
+			.mg  = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
@@ -895,7 +895,7 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
-	al->mg  = bi[i].to.ms.mg;
+	al->maps = bi[i].to.ms.mg;
 	al->map = bi[i].to.ms.map;
 	al->sym = bi[i].to.ms.sym;
 	al->addr = bi[i].to.addr;
@@ -1072,7 +1072,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.comm = thread__comm(al->thread),
 		.ip = al->addr,
 		.ms = {
-			.mg  = al->mg,
+			.mg  = al->maps,
 			.map = al->map,
 			.sym = al->sym,
 		},
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b351476407e6..de5d6b4727e3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1934,7 +1934,7 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.mg;
+	ams->ms.mg  = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = 0;
@@ -1952,7 +1952,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
-	ams->ms.mg  = al.mg;
+	ams->ms.mg  = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
@@ -2069,7 +2069,7 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
-	ms.mg  = al.mg;
+	ms.mg  = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
 	srcline = callchain_srcline(&ms, al.addr);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 9581a904af29..80ca5d0ab7fe 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1127,7 +1127,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
-	tuple_set_u64(t, 2, es->al->mg->machine->db_id);
+	tuple_set_u64(t, 2, es->al->maps->machine->db_id);
 	tuple_set_u64(t, 3, es->al->thread->db_id);
 	tuple_set_u64(t, 4, es->comm_db_id);
 	tuple_set_u64(t, 5, es->dso_db_id);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d3e8faeab3f2..29c4ea4c354f 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -108,7 +108,7 @@ struct ref_reloc_sym {
 
 struct addr_location {
 	struct thread *thread;
-	struct maps   *mg;
+	struct maps   *maps;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 33f655207c62..bb4f515bdff9 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -81,7 +81,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 		return -1;
 
 	e->ip	  = ip;
-	e->ms.mg  = al.mg;
+	e->ms.mg  = al.maps;
 	e->ms.map = al.map;
 	e->ms.sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 30f921f63487..a744dfaefef5 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -578,7 +578,7 @@ static int entry(u64 ip, struct thread *thread,
 	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
-	e.ms.mg  = al.mg;
+	e.ms.mg  = al.maps;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
-- 
2.21.0

