Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186E9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6924650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLRO1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:27:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:21673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfLRO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 06:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="240803874"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2019 06:27:15 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf tools: Add support for PERF_RECORD_TEXT_POKE
Date:   Wed, 18 Dec 2019 16:26:17 +0200
Message-Id: <20191218142618.19332-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218142618.19332-1-adrian.hunter@intel.com>
References: <20191218142618.19332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add processing for PERF_RECORD_TEXT_POKE events. When a text poke event is
processed, then the kernel dso data cache is updated with the poked bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 19 +++++++++-
 tools/perf/builtin-record.c               | 45 +++++++++++++++++++++++
 tools/perf/lib/include/perf/event.h       |  8 ++++
 tools/perf/util/event.c                   | 39 ++++++++++++++++++++
 tools/perf/util/event.h                   |  5 +++
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/machine.c                 | 34 +++++++++++++++++
 tools/perf/util/machine.h                 |  3 ++
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/record.c                  | 10 +++++
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/session.c                 | 20 ++++++++++
 tools/perf/util/tool.h                    |  3 +-
 13 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 377d794d3105..d8422ebf128c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -377,7 +377,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1006,6 +1007,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * Records changes to kernel text i.e. self-modified code.
+	 * 'len' is the number of old bytes, which is the same as the number
+	 * of new bytes. 'bytes' contains the old bytes followed immediately
+	 * by the new bytes.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u16				len;
+	 *	u8				bytes[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_TEXT_POKE			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..d56c3cbe97ae 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -723,6 +723,43 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 
 #endif
 
+static int record__config_text_poke(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int err;
+
+	/* Nothing to do if text poke is already configured */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.text_poke)
+			return 0;
+	}
+
+	err = parse_events(evlist, "dummy:u", NULL);
+	if (err)
+		return err;
+
+	evsel = evlist__last(evlist);
+
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = 1;
+	evsel->core.attr.text_poke = 1;
+
+	evsel->core.system_wide = true;
+	evsel->no_aux_samples = true;
+	evsel->immediate = true;
+
+	/* Text poke must be collected on all CPUs */
+	perf_cpu_map__put(evsel->core.own_cpus);
+	evsel->core.own_cpus = perf_cpu_map__new(NULL);
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
+
+	perf_evsel__set_sample_bit(evsel, TIME);
+	perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
+
+	return 0;
+}
+
 static bool record__kcore_readable(struct machine *machine)
 {
 	char kcore[PATH_MAX];
@@ -2610,6 +2647,14 @@ int cmd_record(int argc, const char **argv)
 	if (rec->opts.full_auxtrace)
 		rec->buildid_all = true;
 
+	if (rec->opts.text_poke) {
+		err = record__config_text_poke(rec->evlist);
+		if (err) {
+			pr_err("record__config_text_poke failed, error %d\n", err);
+			goto out;
+		}
+	}
+
 	if (record_opts__config(&rec->opts)) {
 		err = -EINVAL;
 		goto out;
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 18106899cb4e..ecd2087e122e 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -105,6 +105,13 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_text_poke_event {
+	struct perf_event_header header;
+	__u64			addr;
+	__u16			len;
+	__u8			bytes[];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -360,6 +367,7 @@ union perf_event {
 	struct perf_record_sample		sample;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
+	struct perf_record_text_poke_event	text_poke;
 	struct perf_record_header_attr		attr;
 	struct perf_record_event_update		event_update;
 	struct perf_record_header_event_type	event_type;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c5447ff516a2..b0d934cdda31 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -31,6 +31,7 @@
 #include "stat.h"
 #include "session.h"
 #include "bpf-event.h"
+#include "print_binary.h"
 #include "tool.h"
 #include "../perf.h"
 
@@ -54,6 +55,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
+	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -252,6 +254,14 @@ int perf_event__process_bpf(struct perf_tool *tool __maybe_unused,
 	return machine__process_bpf(machine, event, sample);
 }
 
+int perf_event__process_text_poke(struct perf_tool *tool __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine)
+{
+	return machine__process_text_poke(machine, event, sample);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64 "]: %c %s\n",
@@ -398,6 +408,32 @@ size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
+static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
+			     void *extra __maybe_unused, FILE *fp)
+{
+	if (op == BINARY_PRINT_NUM_DATA)
+		return fprintf(fp, " %02x", val);
+	if (op == BINARY_PRINT_LINE_END)
+		return fprintf(fp, "\n");
+	return 0;
+}
+
+size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp)
+{
+	size_t ret = fprintf(fp, " addr %#" PRI_lx64 " len %u\n",
+			     event->text_poke.addr,
+			     event->text_poke.len);
+
+	ret += fprintf(fp, "     old bytes:");
+	ret += binary__fprintf(event->text_poke.bytes, event->text_poke.len, 16,
+			       text_poke_printer, NULL, fp);
+	ret += fprintf(fp, "     new bytes:");
+	ret += binary__fprintf(event->text_poke.bytes + event->text_poke.len,
+			       event->text_poke.len, 16, text_poke_printer,
+			       NULL, fp);
+	return ret;
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -439,6 +475,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_BPF_EVENT:
 		ret += perf_event__fprintf_bpf(event, fp);
 		break;
+	case PERF_RECORD_TEXT_POKE:
+		ret += perf_event__fprintf_text_poke(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 85223159737c..cbe98e22527f 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -345,6 +345,10 @@ int perf_event__process_bpf(struct perf_tool *tool,
 			    union perf_event *event,
 			    struct perf_sample *sample,
 			    struct machine *machine);
+int perf_event__process_text_poke(struct perf_tool *tool,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine);
 int perf_event__process(struct perf_tool *tool,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -378,6 +382,7 @@ size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f5bd5c386df1..93e9b35e53b0 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -175,6 +175,7 @@ struct callchain_param;
 void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
+bool perf_can_record_text_poke_events(void);
 bool perf_can_record_cpu_wide(void);
 bool perf_can_aux_sample(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..3449af7f6b81 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -770,6 +770,38 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	return machine__process_ksymbol_register(machine, event, sample);
 }
 
+int machine__process_text_poke(struct machine *machine, union perf_event *event,
+			       struct perf_sample *sample __maybe_unused)
+{
+	struct map *map = maps__find(&machine->kmaps, event->text_poke.addr);
+
+	if (dump_trace)
+		perf_event__fprintf_text_poke(event, stdout);
+
+	if (map) {
+		u8 *new_bytes = event->text_poke.bytes + event->text_poke.len;
+		int ret;
+
+		/*
+		 * Kernel maps might be changed when loading symbols so loading
+		 * must be done prior to using kernel maps.
+		 */
+		map__load(map);
+		ret = dso__data_write_cache_addr(map->dso, map, machine,
+						 event->text_poke.addr,
+						 new_bytes,
+						 event->text_poke.len);
+		if (ret != event->text_poke.len)
+			pr_err("Failed to write kernel text poke at %#" PRI_lx64 "\n",
+			       event->text_poke.addr);
+	} else {
+		pr_err("Failed to find kernel text poke address map for %#" PRI_lx64 "\n",
+		       event->text_poke.addr);
+	}
+
+	return 0;
+}
+
 static struct map *machine__addnew_module_map(struct machine *machine, u64 start,
 					      const char *filename)
 {
@@ -1901,6 +1933,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_ksymbol(machine, event, sample); break;
 	case PERF_RECORD_BPF_EVENT:
 		ret = machine__process_bpf(machine, event, sample); break;
+	case PERF_RECORD_TEXT_POKE:
+		ret = machine__process_text_poke(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index be0a930eca89..0bb086acb7ed 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -135,6 +135,9 @@ int machine__process_mmap2_event(struct machine *machine, union perf_event *even
 int machine__process_ksymbol(struct machine *machine,
 			     union perf_event *event,
 			     struct perf_sample *sample);
+int machine__process_text_poke(struct machine *machine,
+			       union perf_event *event,
+			       struct perf_sample *sample);
 int machine__process_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 651203126c71..4c6c700335a6 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -144,6 +144,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
+	PRINT_ATTRf(text_poke, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 7def66168503..207ba2a65008 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -97,6 +97,11 @@ static void perf_probe_context_switch(struct evsel *evsel)
 	evsel->core.attr.context_switch = 1;
 }
 
+static void perf_probe_text_poke(struct evsel *evsel)
+{
+	evsel->core.attr.text_poke = 1;
+}
+
 bool perf_can_sample_identifier(void)
 {
 	return perf_probe_api(perf_probe_sample_identifier);
@@ -112,6 +117,11 @@ bool perf_can_record_switch_events(void)
 	return perf_probe_api(perf_probe_context_switch);
 }
 
+bool perf_can_record_text_poke_events(void)
+{
+	return perf_probe_api(perf_probe_text_poke);
+}
+
 bool perf_can_record_cpu_wide(void)
 {
 	struct perf_event_attr attr = {
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 5421fd2ad383..127b4ca11fd3 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -46,6 +46,7 @@ struct record_opts {
 	bool	      sample_id;
 	bool	      no_bpf_event;
 	bool	      kcore;
+	bool	      text_poke;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0d7d25b23e3..c0cd316d8e28 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -489,6 +489,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->ksymbol = perf_event__process_ksymbol;
 	if (tool->bpf == NULL)
 		tool->bpf = perf_event__process_bpf;
+	if (tool->text_poke == NULL)
+		tool->text_poke = perf_event__process_text_poke;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -658,6 +660,21 @@ static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
 		swap_sample_id_all(event, &event->context_switch + 1);
 }
 
+static void perf_event__text_poke_swap(union perf_event *event, bool sample_id_all)
+{
+	event->text_poke.addr  = bswap_64(event->text_poke.addr);
+	event->text_poke.len   = bswap_16(event->text_poke.len);
+
+	if (sample_id_all) {
+		size_t len = sizeof(event->text_poke.len) +
+			     event->text_poke.len * 2;
+		void *data = &event->text_poke.len;
+
+		data += PERF_ALIGN(len, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+}
+
 static void perf_event__throttle_swap(union perf_event *event,
 				      bool sample_id_all)
 {
@@ -931,6 +948,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
+	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1470,6 +1488,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
 		return tool->bpf(tool, event, sample, machine);
+	case PERF_RECORD_TEXT_POKE:
+		return tool->text_poke(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2abbf668b8de..006182923bbe 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -56,7 +56,8 @@ struct perf_tool {
 			throttle,
 			unthrottle,
 			ksymbol,
-			bpf;
+			bpf,
+			text_poke;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.17.1

