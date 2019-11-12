Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FB121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583927;
	bh=HGpHIYzaxVnGyi2/K7vA1FN1zhRpOYa9eJom/KTqlXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DBqqkXozjtVJIW3SC3GRsBE/BkE/l+iBC2TAUG500C1Cyj8QR1dOXIq5tjlpYpqXj
	 zW7H6TcZC7+9Sx/KTOIyKe4LS7UP81zVwKVdB3OmQyG6d8EF4Hf96YunJHlMglK+ws
	 6TZr9jFyEXjEaB09QgfhdnyfHyy60aYJoiQ6hA8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfKLSiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfKLSil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:41 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5EC821D7F;
        Tue, 12 Nov 2019 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583919;
        bh=HGpHIYzaxVnGyi2/K7vA1FN1zhRpOYa9eJom/KTqlXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzvZPSgz0HEk4VdlxxaRKf0+rRbKPxgS3oCBK5NAybO7O9uSqM48ax211vIvCw4ed
         C8tmO3tfumHqCNZ1g/HuWyP630WSo789zAp57YZuTMAVw5SRqCI+MoWpcqML+q4wpv
         RJ0MqsGQhK+AUXLVQHvUWBJcr67FU3I+BgdS+S1s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 08/15] pref tools: Make 'struct addr_map_symbol' contain 'struct map_symbol'
Date:   Tue, 12 Nov 2019 15:37:50 -0300
Message-Id: <20191112183757.28660-9-acme@kernel.org>
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

So that we pass that substructure around and with it consolidate lots of
functions that receive a (map, symbol) pair and now can receive just a
'struct map_symbol' pointer.

This further paves the way to add 'struct map_groups' to 'struct
map_symbol' so that we can have all we need for annotation so that we
can ditch 'struct map'->groups, i.e. have the map_groups pointer in a
more central place, avoiding the pointer in the 'struct map' that have
tons of instances.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fs90ttd9q12l7989fo7pw81q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c |  6 +-
 tools/perf/builtin-annotate.c                |  2 +-
 tools/perf/ui/browsers/hists.c               | 20 ++---
 tools/perf/util/annotate.c                   | 43 +++++-----
 tools/perf/util/hist.c                       | 54 ++++++------
 tools/perf/util/machine.c                    |  8 +-
 tools/perf/util/map.c                        | 12 +--
 tools/perf/util/map_symbol.h                 |  3 +-
 tools/perf/util/mem-events.c                 |  2 +-
 tools/perf/util/sort.c                       | 89 +++++++++-----------
 10 files changed, 114 insertions(+), 125 deletions(-)

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
index 20050fb54948..bdd7ab34ce4f 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -7,7 +7,7 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	char *endptr, *tok, *name;
 	struct map *map = ms->map;
 	struct addr_map_symbol target = {
-		.map = map,
+		.ms = { .map = map, },
 	};
 
 	tok = strchr(ops->raw, ',');
@@ -39,8 +39,8 @@ static int s390_call__parse(struct arch *arch, struct ins_operands *ops,
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (map_groups__find_ams(map->groups, &target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.sym;
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
 
 	return 0;
 }
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 680c59fafeaf..5898662bc8fb 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -83,7 +83,7 @@ static void process_basic_block(struct addr_map_symbol *start,
 				struct addr_map_symbol *end,
 				struct branch_flags *flags)
 {
-	struct symbol *sym = start->sym;
+	struct symbol *sym = start->ms.sym;
 	struct annotation *notes = sym ? symbol__annotation(sym) : NULL;
 	struct block_range_iter iter;
 	struct block_range *entry;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 334afc2139e7..4d2d0acfd41a 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2405,16 +2405,15 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 static int
 add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
-		 struct map *map, struct symbol *sym)
+		 struct map_symbol *ms)
 {
-	if (sym == NULL || map->dso->annotate_warned)
+	if (ms->sym == NULL || ms->map->dso->annotate_warned)
 		return 0;
 
-	if (asprintf(optstr, "Annotate %s", sym->name) < 0)
+	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
 		return 0;
 
-	act->ms.map = map;
-	act->ms.sym = sym;
+	act->ms = *ms;
 	act->fn = do_annotate;
 	return 1;
 }
@@ -3115,20 +3114,17 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       bi->from.map,
-						       bi->from.sym);
-			if (bi->to.sym != bi->from.sym)
+						       &bi->from.ms);
+			if (bi->to.ms.sym != bi->from.ms.sym)
 				nr_options += add_annotate_opt(browser,
 							&actions[nr_options],
 							&options[nr_options],
-							bi->to.map,
-							bi->to.sym);
+							&bi->to.ms);
 		} else {
 			nr_options += add_annotate_opt(browser,
 						       &actions[nr_options],
 						       &options[nr_options],
-						       browser->selection->map,
-						       browser->selection->sym);
+						       browser->selection);
 		}
 skip_annotation:
 		nr_options += add_thread_opt(browser, &actions[nr_options],
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 78ef3cc2eb66..e0a9e9e49bb1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -243,7 +243,7 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	char *endptr, *tok, *name;
 	struct map *map = ms->map;
 	struct addr_map_symbol target = {
-		.map = map,
+		.ms = { .map = map, },
 	};
 
 	ops->target.addr = strtoull(ops->raw, &endptr, 16);
@@ -272,8 +272,8 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	target.addr = map__objdump_2mem(map, ops->target.addr);
 
 	if (map_groups__find_ams(map->groups, &target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.sym;
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
 
 	return 0;
 
@@ -332,7 +332,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	struct map *map = ms->map;
 	struct symbol *sym = ms->sym;
 	struct addr_map_symbol target = {
-		.map = map,
+		.ms = { .map = map, },
 	};
 	const char *c = strchr(ops->raw, ',');
 	u64 start, end;
@@ -392,8 +392,8 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * the symbol searching and disassembly should be done.
 	 */
 	if (map_groups__find_ams(map->groups, &target) == 0 &&
-	    map__rip_2objdump(target.map, map->map_ip(target.map, target.addr)) == ops->target.addr)
-		ops->target.sym = target.sym;
+	    map__rip_2objdump(target.ms.map, map->map_ip(target.ms.map, target.addr)) == ops->target.addr)
+		ops->target.sym = target.ms.sym;
 
 	if (!ops->target.outside) {
 		ops->target.offset = target.addr - start;
@@ -865,14 +865,15 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
 	return 0;
 }
 
-static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
+static int __symbol__inc_addr_samples(struct map_symbol *ms,
 				      struct annotated_source *src, int evidx, u64 addr,
 				      struct perf_sample *sample)
 {
+	struct symbol *sym = ms->sym;
 	unsigned offset;
 	struct sym_hist *h;
 
-	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, map->unmap_ip(map, addr));
+	pr_debug3("%s: addr=%#" PRIx64 "\n", __func__, ms->map->unmap_ip(ms->map, addr));
 
 	if ((addr < sym->start || addr >= sym->end) &&
 	    (addr != sym->end || sym->start != sym->end)) {
@@ -939,17 +940,17 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 	return notes->src;
 }
 
-static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
+static int symbol__inc_addr_samples(struct map_symbol *ms,
 				    struct evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
+	struct symbol *sym = ms->sym;
 	struct annotated_source *src;
 
 	if (sym == NULL)
 		return 0;
 	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
-	return (src) ?  __symbol__inc_addr_samples(sym, map, src, evsel->idx,
-						   addr, sample) : 0;
+	return src ? __symbol__inc_addr_samples(ms, src, evsel->idx, addr, sample) : 0;
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
@@ -997,17 +998,17 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	 * it starts on the function start.
 	 */
 	if (start &&
-		(start->sym == ams->sym ||
-		 (ams->sym &&
-		   start->addr == ams->sym->start + ams->map->start)))
+		(start->ms.sym == ams->ms.sym ||
+		 (ams->ms.sym &&
+		   start->addr == ams->ms.sym->start + ams->ms.map->start)))
 		saddr = start->al_addr;
 	if (saddr == 0)
 		pr_debug2("BB with bad start: addr %"PRIx64" start %"PRIx64" sym %"PRIx64" saddr %"PRIx64"\n",
 			ams->addr,
 			start ? start->addr : 0,
-			ams->sym ? ams->sym->start + ams->map->start : 0,
+			ams->ms.sym ? ams->ms.sym->start + ams->ms.map->start : 0,
 			saddr);
-	err = symbol__account_cycles(ams->al_addr, saddr, ams->sym, cycles);
+	err = symbol__account_cycles(ams->al_addr, saddr, ams->ms.sym, cycles);
 	if (err)
 		pr_debug2("account_cycles failed %d\n", err);
 	return err;
@@ -1093,13 +1094,13 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
 				 struct evsel *evsel)
 {
-	return symbol__inc_addr_samples(ams->sym, ams->map, evsel, ams->al_addr, sample);
+	return symbol__inc_addr_samples(&ams->ms, evsel, ams->al_addr, sample);
 }
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
 				 struct evsel *evsel, u64 ip)
 {
-	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evsel, ip, sample);
+	return symbol__inc_addr_samples(&he->ms, evsel, ip, sample);
 }
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
@@ -1540,13 +1541,13 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	/* kcore has no symbols, so add the call target symbol */
 	if (dl->ins.ops && ins__is_call(&dl->ins) && !dl->ops.target.sym) {
 		struct addr_map_symbol target = {
-			.map = map,
 			.addr = dl->ops.target.addr,
+			.ms = { .map = map, },
 		};
 
 		if (!map_groups__find_ams(map->groups, &target) &&
-		    target.sym->start == target.al_addr)
-			dl->ops.target.sym = target.sym;
+		    target.ms.sym->start == target.al_addr)
+			dl->ops.target.sym = target.ms.sym;
 	}
 
 	annotation_line__add(&dl->al, &notes->src->source);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 78749535dbf3..dec996133cdf 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -112,13 +112,13 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		hists__new_col_len(hists, HISTC_PARENT, h->parent->namelen);
 
 	if (h->branch_info) {
-		if (h->branch_info->from.sym) {
-			symlen = (int)h->branch_info->from.sym->namelen + 4;
+		if (h->branch_info->from.ms.sym) {
+			symlen = (int)h->branch_info->from.ms.sym->namelen + 4;
 			if (verbose > 0)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
 
-			symlen = dso__name_len(h->branch_info->from.map->dso);
+			symlen = dso__name_len(h->branch_info->from.ms.map->dso);
 			hists__new_col_len(hists, HISTC_DSO_FROM, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -126,13 +126,13 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 			hists__set_unres_dso_col_len(hists, HISTC_DSO_FROM);
 		}
 
-		if (h->branch_info->to.sym) {
-			symlen = (int)h->branch_info->to.sym->namelen + 4;
+		if (h->branch_info->to.ms.sym) {
+			symlen = (int)h->branch_info->to.ms.sym->namelen + 4;
 			if (verbose > 0)
 				symlen += BITS_PER_LONG / 4 + 2 + 3;
 			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
 
-			symlen = dso__name_len(h->branch_info->to.map->dso);
+			symlen = dso__name_len(h->branch_info->to.ms.map->dso);
 			hists__new_col_len(hists, HISTC_DSO_TO, symlen);
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
@@ -149,8 +149,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	}
 
 	if (h->mem_info) {
-		if (h->mem_info->daddr.sym) {
-			symlen = (int)h->mem_info->daddr.sym->namelen + 4
+		if (h->mem_info->daddr.ms.sym) {
+			symlen = (int)h->mem_info->daddr.ms.sym->namelen + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL,
 					   symlen);
@@ -164,8 +164,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 					   symlen);
 		}
 
-		if (h->mem_info->iaddr.sym) {
-			symlen = (int)h->mem_info->iaddr.sym->namelen + 4
+		if (h->mem_info->iaddr.ms.sym) {
+			symlen = (int)h->mem_info->iaddr.ms.sym->namelen + 4
 			       + unresolved_col_width + 2;
 			hists__new_col_len(hists, HISTC_MEM_IADDR_SYMBOL,
 					   symlen);
@@ -175,8 +175,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 					   symlen);
 		}
 
-		if (h->mem_info->daddr.map) {
-			symlen = dso__name_len(h->mem_info->daddr.map->dso);
+		if (h->mem_info->daddr.ms.map) {
+			symlen = dso__name_len(h->mem_info->daddr.ms.map->dso);
 			hists__new_col_len(hists, HISTC_MEM_DADDR_DSO,
 					   symlen);
 		} else {
@@ -443,13 +443,13 @@ static int hist_entry__init(struct hist_entry *he,
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
 
-		map__get(he->branch_info->from.map);
-		map__get(he->branch_info->to.map);
+		map__get(he->branch_info->from.ms.map);
+		map__get(he->branch_info->to.ms.map);
 	}
 
 	if (he->mem_info) {
-		map__get(he->mem_info->iaddr.map);
-		map__get(he->mem_info->daddr.map);
+		map__get(he->mem_info->iaddr.ms.map);
+		map__get(he->mem_info->daddr.ms.map);
 	}
 
 	if (hist_entry__has_callchains(he) && symbol_conf.use_callchain)
@@ -492,13 +492,13 @@ static int hist_entry__init(struct hist_entry *he,
 
 err_infos:
 	if (he->branch_info) {
-		map__put(he->branch_info->from.map);
-		map__put(he->branch_info->to.map);
+		map__put(he->branch_info->from.ms.map);
+		map__put(he->branch_info->to.ms.map);
 		zfree(&he->branch_info);
 	}
 	if (he->mem_info) {
-		map__put(he->mem_info->iaddr.map);
-		map__put(he->mem_info->daddr.map);
+		map__put(he->mem_info->iaddr.ms.map);
+		map__put(he->mem_info->daddr.ms.map);
 	}
 err:
 	map__zput(he->ms.map);
@@ -893,8 +893,8 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
-	al->map = bi[i].to.map;
-	al->sym = bi[i].to.sym;
+	al->map = bi[i].to.ms.map;
+	al->sym = bi[i].to.ms.sym;
 	al->addr = bi[i].to.addr;
 	return 1;
 }
@@ -912,7 +912,7 @@ iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *a
 
 	bi = iter->priv;
 
-	if (iter->hide_unresolved && !(bi[i].from.sym && bi[i].to.sym))
+	if (iter->hide_unresolved && !(bi[i].from.ms.sym && bi[i].to.ms.sym))
 		goto out;
 
 	/*
@@ -1251,16 +1251,16 @@ void hist_entry__delete(struct hist_entry *he)
 	map__zput(he->ms.map);
 
 	if (he->branch_info) {
-		map__zput(he->branch_info->from.map);
-		map__zput(he->branch_info->to.map);
+		map__zput(he->branch_info->from.ms.map);
+		map__zput(he->branch_info->to.ms.map);
 		free_srcline(he->branch_info->srcline_from);
 		free_srcline(he->branch_info->srcline_to);
 		zfree(&he->branch_info);
 	}
 
 	if (he->mem_info) {
-		map__zput(he->mem_info->iaddr.map);
-		map__zput(he->mem_info->daddr.map);
+		map__zput(he->mem_info->iaddr.ms.map);
+		map__zput(he->mem_info->daddr.ms.map);
 		mem_info__zput(he->mem_info);
 	}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d08c7285c708..614094d87f05 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1968,8 +1968,8 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
-	ams->sym = al.sym;
-	ams->map = al.map;
+	ams->ms.sym = al.sym;
+	ams->ms.map = al.map;
 	ams->phys_addr = 0;
 }
 
@@ -1985,8 +1985,8 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
-	ams->sym = al.sym;
-	ams->map = al.map;
+	ams->ms.sym = al.sym;
+	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index db842568f4be..6c59f55026c1 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -705,18 +705,18 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
 
 int map_groups__find_ams(struct map_groups *mg, struct addr_map_symbol *ams)
 {
-	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
+	if (ams->addr < ams->ms.map->start || ams->addr >= ams->ms.map->end) {
 		if (mg == NULL)
 			return -1;
-		ams->map = map_groups__find(mg, ams->addr);
-		if (ams->map == NULL)
+		ams->ms.map = map_groups__find(mg, ams->addr);
+		if (ams->ms.map == NULL)
 			return -1;
 	}
 
-	ams->al_addr = ams->map->map_ip(ams->map, ams->addr);
-	ams->sym = map__find_symbol(ams->map, ams->al_addr);
+	ams->al_addr = ams->ms.map->map_ip(ams->ms.map, ams->addr);
+	ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
 
-	return ams->sym ? 0 : -1;
+	return ams->ms.sym ? 0 : -1;
 }
 
 static size_t maps__fprintf(struct maps *maps, FILE *fp)
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 5a1aed9f6bb4..f71cbe1a26a9 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -13,8 +13,7 @@ struct map_symbol {
 };
 
 struct addr_map_symbol {
-	struct map    *map;
-	struct symbol *sym;
+	struct map_symbol ms;
 	u64	      addr;
 	u64	      al_addr;
 	u64	      phys_addr;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 3d391583f2ae..aa29589f6904 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -410,7 +410,7 @@ do {				\
 		return -1;
 	}
 
-	if (!mi->daddr.map || !mi->iaddr.map) {
+	if (!mi->daddr.ms.map || !mi->iaddr.ms.map) {
 		stats->nomap++;
 		return -1;
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 43d1d410854a..6b626e6b111e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -287,10 +287,12 @@ sort__sym_sort(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(right->ms.sym->name, left->ms.sym->name);
 }
 
-static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
+static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 				     u64 ip, char level, char *bf, size_t size,
 				     unsigned int width)
 {
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
 	size_t ret = 0;
 
 	if (verbose > 0) {
@@ -325,7 +327,7 @@ static int _hist_entry__sym_snprintf(struct map *map, struct symbol *sym,
 static int hist_entry__sym_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
-	return _hist_entry__sym_snprintf(he->ms.map, he->ms.sym, he->ip,
+	return _hist_entry__sym_snprintf(&he->ms, he->ip,
 					 he->level, bf, size, width);
 }
 
@@ -386,7 +388,7 @@ struct sort_entry sort_srcline = {
 
 static char *addr_map_symbol__srcline(struct addr_map_symbol *ams)
 {
-	return map__srcline(ams->map, ams->al_addr, ams->sym);
+	return map__srcline(ams->ms.map, ams->al_addr, ams->ms.sym);
 }
 
 static int64_t
@@ -769,15 +771,15 @@ sort__dso_from_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
 
-	return _sort__dso_cmp(left->branch_info->from.map,
-			      right->branch_info->from.map);
+	return _sort__dso_cmp(left->branch_info->from.ms.map,
+			      right->branch_info->from.ms.map);
 }
 
 static int hist_entry__dso_from_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
 	if (he->branch_info)
-		return _hist_entry__dso_snprintf(he->branch_info->from.map,
+		return _hist_entry__dso_snprintf(he->branch_info->from.ms.map,
 						 bf, size, width);
 	else
 		return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -791,8 +793,8 @@ static int hist_entry__dso_from_filter(struct hist_entry *he, int type,
 	if (type != HIST_FILTER__DSO)
 		return -1;
 
-	return dso && (!he->branch_info || !he->branch_info->from.map ||
-		       he->branch_info->from.map->dso != dso);
+	return dso && (!he->branch_info || !he->branch_info->from.ms.map ||
+		       he->branch_info->from.ms.map->dso != dso);
 }
 
 static int64_t
@@ -801,15 +803,15 @@ sort__dso_to_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!left->branch_info || !right->branch_info)
 		return cmp_null(left->branch_info, right->branch_info);
 
-	return _sort__dso_cmp(left->branch_info->to.map,
-			      right->branch_info->to.map);
+	return _sort__dso_cmp(left->branch_info->to.ms.map,
+			      right->branch_info->to.ms.map);
 }
 
 static int hist_entry__dso_to_snprintf(struct hist_entry *he, char *bf,
 				       size_t size, unsigned int width)
 {
 	if (he->branch_info)
-		return _hist_entry__dso_snprintf(he->branch_info->to.map,
+		return _hist_entry__dso_snprintf(he->branch_info->to.ms.map,
 						 bf, size, width);
 	else
 		return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -823,8 +825,8 @@ static int hist_entry__dso_to_filter(struct hist_entry *he, int type,
 	if (type != HIST_FILTER__DSO)
 		return -1;
 
-	return dso && (!he->branch_info || !he->branch_info->to.map ||
-		       he->branch_info->to.map->dso != dso);
+	return dso && (!he->branch_info || !he->branch_info->to.ms.map ||
+		       he->branch_info->to.ms.map->dso != dso);
 }
 
 static int64_t
@@ -839,10 +841,10 @@ sort__sym_from_cmp(struct hist_entry *left, struct hist_entry *right)
 	from_l = &left->branch_info->from;
 	from_r = &right->branch_info->from;
 
-	if (!from_l->sym && !from_r->sym)
+	if (!from_l->ms.sym && !from_r->ms.sym)
 		return _sort__addr_cmp(from_l->addr, from_r->addr);
 
-	return _sort__sym_cmp(from_l->sym, from_r->sym);
+	return _sort__sym_cmp(from_l->ms.sym, from_r->ms.sym);
 }
 
 static int64_t
@@ -856,10 +858,10 @@ sort__sym_to_cmp(struct hist_entry *left, struct hist_entry *right)
 	to_l = &left->branch_info->to;
 	to_r = &right->branch_info->to;
 
-	if (!to_l->sym && !to_r->sym)
+	if (!to_l->ms.sym && !to_r->ms.sym)
 		return _sort__addr_cmp(to_l->addr, to_r->addr);
 
-	return _sort__sym_cmp(to_l->sym, to_r->sym);
+	return _sort__sym_cmp(to_l->ms.sym, to_r->ms.sym);
 }
 
 static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
@@ -868,8 +870,7 @@ static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *from = &he->branch_info->from;
 
-		return _hist_entry__sym_snprintf(from->map, from->sym, from->addr,
-						 he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&from->ms, from->addr, he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -881,8 +882,7 @@ static int hist_entry__sym_to_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *to = &he->branch_info->to;
 
-		return _hist_entry__sym_snprintf(to->map, to->sym, to->addr,
-						 he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&to->ms, to->addr, he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -896,8 +896,8 @@ static int hist_entry__sym_from_filter(struct hist_entry *he, int type,
 	if (type != HIST_FILTER__SYMBOL)
 		return -1;
 
-	return sym && !(he->branch_info && he->branch_info->from.sym &&
-			strstr(he->branch_info->from.sym->name, sym));
+	return sym && !(he->branch_info && he->branch_info->from.ms.sym &&
+			strstr(he->branch_info->from.ms.sym->name, sym));
 }
 
 static int hist_entry__sym_to_filter(struct hist_entry *he, int type,
@@ -908,8 +908,8 @@ static int hist_entry__sym_to_filter(struct hist_entry *he, int type,
 	if (type != HIST_FILTER__SYMBOL)
 		return -1;
 
-	return sym && !(he->branch_info && he->branch_info->to.sym &&
-		        strstr(he->branch_info->to.sym->name, sym));
+	return sym && !(he->branch_info && he->branch_info->to.ms.sym &&
+		        strstr(he->branch_info->to.ms.sym->name, sym));
 }
 
 struct sort_entry sort_dso_from = {
@@ -1017,16 +1017,13 @@ static int hist_entry__daddr_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
 	uint64_t addr = 0;
-	struct map *map = NULL;
-	struct symbol *sym = NULL;
+	struct map_symbol *ms = NULL;
 
 	if (he->mem_info) {
 		addr = he->mem_info->daddr.addr;
-		map = he->mem_info->daddr.map;
-		sym = he->mem_info->daddr.sym;
+		ms = &he->mem_info->daddr.ms;
 	}
-	return _hist_entry__sym_snprintf(map, sym, addr, he->level, bf, size,
-					 width);
+	return _hist_entry__sym_snprintf(ms, addr, he->level, bf, size, width);
 }
 
 int64_t
@@ -1046,16 +1043,13 @@ static int hist_entry__iaddr_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
 	uint64_t addr = 0;
-	struct map *map = NULL;
-	struct symbol *sym = NULL;
+	struct map_symbol *ms = NULL;
 
 	if (he->mem_info) {
 		addr = he->mem_info->iaddr.addr;
-		map  = he->mem_info->iaddr.map;
-		sym  = he->mem_info->iaddr.sym;
+		ms   = &he->mem_info->iaddr.ms;
 	}
-	return _hist_entry__sym_snprintf(map, sym, addr, he->level, bf, size,
-					 width);
+	return _hist_entry__sym_snprintf(ms, addr, he->level, bf, size, width);
 }
 
 static int64_t
@@ -1065,9 +1059,9 @@ sort__dso_daddr_cmp(struct hist_entry *left, struct hist_entry *right)
 	struct map *map_r = NULL;
 
 	if (left->mem_info)
-		map_l = left->mem_info->daddr.map;
+		map_l = left->mem_info->daddr.ms.map;
 	if (right->mem_info)
-		map_r = right->mem_info->daddr.map;
+		map_r = right->mem_info->daddr.ms.map;
 
 	return _sort__dso_cmp(map_l, map_r);
 }
@@ -1078,7 +1072,7 @@ static int hist_entry__dso_daddr_snprintf(struct hist_entry *he, char *bf,
 	struct map *map = NULL;
 
 	if (he->mem_info)
-		map = he->mem_info->daddr.map;
+		map = he->mem_info->daddr.ms.map;
 
 	return _hist_entry__dso_snprintf(map, bf, size, width);
 }
@@ -1208,8 +1202,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (left->cpumode > right->cpumode) return -1;
 	if (left->cpumode < right->cpumode) return 1;
 
-	l_map = left->mem_info->daddr.map;
-	r_map = right->mem_info->daddr.map;
+	l_map = left->mem_info->daddr.ms.map;
+	r_map = right->mem_info->daddr.ms.map;
 
 	/* if both are NULL, jump to sort on al_addr instead */
 	if (!l_map && !r_map)
@@ -1264,14 +1258,14 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 {
 
 	uint64_t addr = 0;
-	struct map *map = NULL;
-	struct symbol *sym = NULL;
+	struct map_symbol *ms = NULL;
 	char level = he->level;
 
 	if (he->mem_info) {
+		struct map *map = he->mem_info->daddr.ms.map;
+
 		addr = cl_address(he->mem_info->daddr.al_addr);
-		map = he->mem_info->daddr.map;
-		sym = he->mem_info->daddr.sym;
+		ms = &he->mem_info->daddr.ms;
 
 		/* print [s] for shared data mmaps */
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
@@ -1283,8 +1277,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		else if (!map)
 			level = 'X';
 	}
-	return _hist_entry__sym_snprintf(map, sym, addr, level, bf, size,
-					 width);
+	return _hist_entry__sym_snprintf(ms, addr, level, bf, size, width);
 }
 
 struct sort_entry sort_mispredict = {
-- 
2.21.0

