Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E03C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5892121883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869898;
	bh=hH9Xj4gVzPz9udJoo9bh3AtlV4xEJuY7eS6i8w3Zqto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0wBnlcHZxsJrAa/LdlCzLRlrRx/vkGlE7Lpn7vF5vGxwXQxRxwKlmOe6iqHe6zsQ
	 eIFb+68DqXWvsWIZdRwwPiVmhGnIk5mrdiyk88N7Eywe+A4pWzeD1OcLlwoZaFUGy0
	 qcVyP8wOMWoSwKr9BtbN32NBrm1iluCgzM8KPALg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfH0BiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbfH0BiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:38:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6438120679;
        Tue, 27 Aug 2019 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869893;
        bh=hH9Xj4gVzPz9udJoo9bh3AtlV4xEJuY7eS6i8w3Zqto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQF871iIPXJAZInkV+FSxT2ft5qbFcGB1xIuqzFWMinzWGRBkRN594TozG67x8Tsj
         Yd7sRwT2myONNqtvZzjuUgd0chMf0aXSAj103ytmbMJK1RiSXks1WjfKka+bLkXSH1
         tk2OHMvKsLSuoFxXObFiRrqc5+PUcYvLQnQBJhDQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 30/33] perf tools: Rename perf_event::ksymbol_event to perf_event::ksymbol
Date:   Mon, 26 Aug 2019 22:36:31 -0300
Message-Id: <20190827013634.3173-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like all the other meta events, that extra _event suffix is just
redundant, ditch it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-0q8b2xnfs17q0g523oej75s0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c |  2 +-
 tools/perf/util/event.c     |  6 +++---
 tools/perf/util/event.h     |  2 +-
 tools/perf/util/machine.c   | 16 ++++++++--------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 3be8c480fa1f..69795c32ecf3 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -161,7 +161,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       union perf_event *event,
 					       struct record_opts *opts)
 {
-	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol_event;
+	struct perf_record_ksymbol *ksymbol_event = &event->ksymbol;
 	struct perf_record_bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool = session->tool;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 4447cd25e3f2..bdeaad434e52 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1486,9 +1486,9 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " addr %" PRI_lx64 " len %u type %u flags 0x%x name %s\n",
-		       event->ksymbol_event.addr, event->ksymbol_event.len,
-		       event->ksymbol_event.ksym_type,
-		       event->ksymbol_event.flags, event->ksymbol_event.name);
+		       event->ksymbol.addr, event->ksymbol.len,
+		       event->ksymbol.ksym_type,
+		       event->ksymbol.flags, event->ksymbol.name);
 }
 
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 25f5309a3442..34190e01f307 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -561,7 +561,7 @@ union perf_event {
 	struct perf_record_throttle	throttle;
 	struct perf_record_sample	sample;
 	struct perf_record_bpf_event	bpf_event;
-	struct perf_record_ksymbol	ksymbol_event;
+	struct perf_record_ksymbol	ksymbol;
 	struct attr_event		attr;
 	struct event_update_event	event_update;
 	struct event_type_event		event_type;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 823aaf7b1b83..86b7fd24b1e1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -713,20 +713,20 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct symbol *sym;
 	struct map *map;
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
 	if (!map) {
-		map = dso__new_map(event->ksymbol_event.name);
+		map = dso__new_map(event->ksymbol.name);
 		if (!map)
 			return -ENOMEM;
 
-		map->start = event->ksymbol_event.addr;
-		map->end = map->start + event->ksymbol_event.len;
+		map->start = event->ksymbol.addr;
+		map->end = map->start + event->ksymbol.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
-			  event->ksymbol_event.len,
-			  0, 0, event->ksymbol_event.name);
+			  event->ksymbol.len,
+			  0, 0, event->ksymbol.name);
 	if (!sym)
 		return -ENOMEM;
 	dso__insert_symbol(map->dso, sym);
@@ -739,7 +739,7 @@ static int machine__process_ksymbol_unregister(struct machine *machine,
 {
 	struct map *map;
 
-	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	map = map_groups__find(&machine->kmaps, event->ksymbol.addr);
 	if (map)
 		map_groups__remove(&machine->kmaps, map);
 
@@ -753,7 +753,7 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_ksymbol(event, stdout);
 
-	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
+	if (event->ksymbol.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
 		return machine__process_ksymbol_unregister(machine, event,
 							   sample);
 	return machine__process_ksymbol_register(machine, event, sample);
-- 
2.21.0

