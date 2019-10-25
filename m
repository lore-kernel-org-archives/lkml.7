Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA0821E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504686AbfJYNB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:01:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:41239 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504641AbfJYNB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:01:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 06:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201802367"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.55])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 06:01:19 -0700
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
Subject: [PATCH RFC 4/6] perf tools: Add support for PERF_RECORD_TEXT_POKE
Date:   Fri, 25 Oct 2019 15:59:58 +0300
Message-Id: <20191025130000.13032-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025130000.13032-1-adrian.hunter@intel.com>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add processing for PERF_RECORD_TEXT_POKE events. When a text poke event is
processed, if the PERF_TEXT_POKE_UPDATE flag is set, then the kernel dso
data cache is updated with the poked bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/include/uapi/linux/perf_event.h     | 28 +++++++++++++-
 tools/perf/arch/x86/util/intel-pt.c       |  1 +
 tools/perf/builtin-record.c               | 45 +++++++++++++++++++++++
 tools/perf/lib/include/perf/event.h       |  9 +++++
 tools/perf/util/event.c                   | 39 ++++++++++++++++++++
 tools/perf/util/event.h                   |  5 +++
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/machine.c                 | 38 +++++++++++++++++++
 tools/perf/util/machine.h                 |  3 ++
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/record.c                  | 10 +++++
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/session.c                 | 22 +++++++++++
 tools/perf/util/tool.h                    |  3 +-
 14 files changed, 204 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..c8d1f52a7fce 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -375,7 +375,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1000,6 +1001,26 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * Records changes to kernel text i.e. self-modified code.
+	 * 'flags' has PERF_TEXT_POKE_UPDATE (i.e. bit 0) set to
+	 * indicate to tools to update old bytes to new bytes in the
+	 * executable image.
+	 * 'len' is the number of old bytes, which is the same as the number
+	 * of new bytes. 'bytes' contains the old bytes followed immediately
+	 * by the new bytes.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u16				flags;
+	 *	u16				len;
+	 *	u8				bytes[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_TEXT_POKE			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1041,6 +1062,11 @@ enum perf_callchain_context {
 #define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
 #define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
 
+/**
+ * PERF_RECORD_TEXT_POKE::flags bits
+ */
+#define PERF_TEXT_POKE_UPDATE		0x01	/* update old bytes to new bytes */
+
 #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
 #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d6d26256915f..a81ce60876f6 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -17,6 +17,7 @@
 #include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
+#include "../../util/evsel_config.h"
 #include "../../util/cpumap.h"
 #include "../../util/mmap.h"
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f6664bb08b26..5a5a5e84b136 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -702,6 +702,43 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 
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
@@ -2507,6 +2544,14 @@ int cmd_record(int argc, const char **argv)
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
index 18106899cb4e..0127125eefd7 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -105,6 +105,14 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_text_poke_event {
+	struct perf_event_header header;
+	__u64			addr;
+	__u16			flags;
+	__u16			len;
+	__u8			bytes[];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
@@ -360,6 +368,7 @@ union perf_event {
 	struct perf_record_sample		sample;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
+	struct perf_record_text_poke_event	text_poke;
 	struct perf_record_header_attr		attr;
 	struct perf_record_event_update		event_update;
 	struct perf_record_header_event_type	event_type;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc1e5a991008..b1e59fc3bce9 100644
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
+	size_t ret = fprintf(fp, " addr %#" PRI_lx64 " flags %#x len %u\n",
+			     event->text_poke.addr, event->text_poke.flags,
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
index a0a0c91cde4a..f0f4f4db6e22 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -339,6 +339,10 @@ int perf_event__process_bpf(struct perf_tool *tool,
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
@@ -372,6 +376,7 @@ size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_text_poke(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 13051409fd22..a2b9fa8fb281 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -175,6 +175,7 @@ struct callchain_param;
 void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
+bool perf_can_record_text_poke_events(void);
 bool perf_can_record_cpu_wide(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 70a9f8716a4b..edf0327093b8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -767,6 +767,42 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	return machine__process_ksymbol_register(machine, event, sample);
 }
 
+int machine__process_text_poke(struct machine *machine, union perf_event *event,
+			       struct perf_sample *sample __maybe_unused)
+{
+	struct map_groups *mg = &machine->kmaps;
+	struct map *map = map_groups__find(mg, event->text_poke.addr);
+
+	if (dump_trace)
+		perf_event__fprintf_text_poke(event, stdout);
+
+	if (!(event->text_poke.flags & PERF_TEXT_POKE_UPDATE))
+		return 0;
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
 static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
 {
 	const char *dup_filename;
@@ -1931,6 +1967,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_ksymbol(machine, event, sample); break;
 	case PERF_RECORD_BPF_EVENT:
 		ret = machine__process_bpf(machine, event, sample); break;
+	case PERF_RECORD_TEXT_POKE:
+		ret = machine__process_text_poke(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 18e13c0ccd6a..af936ec01c46 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -134,6 +134,9 @@ int machine__process_mmap2_event(struct machine *machine, union perf_event *even
 int machine__process_ksymbol(struct machine *machine,
 			     union perf_event *event,
 			     struct perf_sample *sample);
+int machine__process_text_poke(struct machine *machine,
+			       union perf_event *event,
+			       struct perf_sample *sample);
 int machine__process_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index d4ad3f04923a..0134ffd27b23 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -143,6 +143,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_regs_intr, p_hex);
 	PRINT_ATTRf(aux_watermark, p_unsigned);
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
+	PRINT_ATTRf(text_poke, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8579505c29a4..a58d01b65078 100644
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
index 948bbcf9aef3..acc04d873059 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -45,6 +45,7 @@ struct record_opts {
 	bool	      sample_id;
 	bool	      no_bpf_event;
 	bool	      kcore;
+	bool	      text_poke;
 	unsigned int  freq;
 	unsigned int  mmap_pages;
 	unsigned int  auxtrace_mmap_pages;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f07b8ecb91bc..e2c0e72701b0 100644
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
@@ -658,6 +660,23 @@ static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
 		swap_sample_id_all(event, &event->context_switch + 1);
 }
 
+static void perf_event__text_poke_swap(union perf_event *event, bool sample_id_all)
+{
+	event->text_poke.addr  = bswap_64(event->text_poke.addr);
+	event->text_poke.flags = bswap_16(event->text_poke.flags);
+	event->text_poke.len   = bswap_16(event->text_poke.len);
+
+	if (sample_id_all) {
+		size_t len = sizeof(event->text_poke.flags) +
+			     sizeof(event->text_poke.len) +
+			     event->text_poke.len * 2;
+		void *data = &event->text_poke.flags;
+
+		data += PERF_ALIGN(len, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+}
+
 static void perf_event__throttle_swap(union perf_event *event,
 				      bool sample_id_all)
 {
@@ -930,6 +949,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH]		  = perf_event__switch_swap,
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
+	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1469,6 +1489,8 @@ static int machines__deliver_event(struct machines *machines,
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

