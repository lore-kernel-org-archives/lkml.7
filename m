Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6673D20857
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKOHk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:40:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKOHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:40:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVWDK-0002ZZ-Ai; Fri, 15 Nov 2019 08:40:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 05F971C08AC;
        Fri, 15 Nov 2019 08:40:18 +0100 (CET)
Date:   Fri, 15 Nov 2019 07:40:17 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Add map_groups to 'struct addr_location'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org>
References: <tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157380361765.29467.9328739216463634278.tip-bot2@tip-bot2>
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

Commit-ID:     d3a022cbdce6f361b1effbff1eb18546690592c8
Gitweb:        https://git.kernel.org/tip/d3a022cbdce6f361b1effbff1eb18546690592c8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 Nov 2019 09:59:48 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 08:20:53 -03:00

perf tools: Add map_groups to 'struct addr_location'

>From there we can get al->mg->machine, so replace that field with the
more useful 'struct map_groups' that for now we're obtaining from
al->map->groups, and that is one thing getting into the way of maps
being fully shareable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c                            |  6 ++---
 tools/perf/util/db-export.c                            | 12 ++++-----
 tools/perf/util/event.c                                |  6 ++---
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/symbol.h                               |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 9a9b56e..89faa64 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			goto out;
 	}
 
-	if (al->map->groups == &al->machine->kmaps) {
-		if (machine__is_host(al->machine)) {
+	if (al->mg == &al->mg->machine->kmaps) {
+		if (machine__is_host(al->mg->machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
 		} else {
@@ -1128,7 +1128,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			al->level = 'g';
 		}
 	} else {
-		if (machine__is_host(al->machine)) {
+		if (machine__is_host(al->mg->machine)) {
 			al->cpumode = PERF_RECORD_MISC_USER;
 			al->level = '.';
 		} else if (perf_guest) {
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 752227b..44b465c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = al->map->dso;
 
-		err = db_export__dso(dbe, dso, al->machine);
+		err = db_export__dso(dbe, dso, al->mg->machine);
 		if (err)
 			return err;
 		*dso_db_id = dso->db_id;
@@ -251,7 +251,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		al.sym = node->sym;
 		al.map = node->map;
-		al.machine = machine;
+		al.mg  = thread->mg;
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
@@ -360,13 +360,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (err)
 		return err;
 
-	err = db_export__machine(dbe, al->machine);
+	err = db_export__machine(dbe, al->mg->machine);
 	if (err)
 		return err;
 
-	main_thread = thread__main_thread(al->machine, thread);
+	main_thread = thread__main_thread(al->mg->machine, thread);
 
-	err = db_export__threads(dbe, thread, main_thread, al->machine, &comm);
+	err = db_export__threads(dbe, thread, main_thread, al->mg->machine, &comm);
 	if (err)
 		goto out_put;
 
@@ -380,7 +380,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (dbe->cpr) {
-		struct call_path *cp = call_path_from_sample(dbe, al->machine,
+		struct call_path *cp = call_path_from_sample(dbe, al->mg->machine,
 							     thread, sample,
 							     evsel);
 		if (cp) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc1e5a9..0141b26 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -461,7 +461,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
-	al->machine = machine;
+	al->mg = mg;
 	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
@@ -474,13 +474,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		mg = &machine->kmaps;
+		al->mg = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		mg = &machine->kmaps;
+		al->mg = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 93c03b3..9e05827 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1127,7 +1127,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
-	tuple_set_u64(t, 2, es->al->machine->db_id);
+	tuple_set_u64(t, 2, es->al->mg->machine->db_id);
 	tuple_set_u64(t, 3, es->al->thread->db_id);
 	tuple_set_u64(t, 4, es->comm_db_id);
 	tuple_set_u64(t, 5, es->dso_db_id);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c3bd16d..0b718cc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -107,8 +107,8 @@ struct ref_reloc_sym {
 };
 
 struct addr_location {
-	struct machine *machine;
 	struct thread *thread;
+	struct map_groups *mg;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
