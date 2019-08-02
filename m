Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB7921773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404539AbfHBI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:57:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404441AbfHBI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:57:33 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0008A6206093DD2F0D4;
        Fri,  2 Aug 2019 16:57:29 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 16:57:19 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jeremy.linton@arm.com>, <linux-perf-users@vger.kernel.org>
Subject: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe events
Date:   Fri, 2 Aug 2019 17:40:12 +0800
Message-ID: <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
Profiling Extensions (SPE) support") is merged, "perf record" and
"perf report --dump-raw-trace" have been supported. However, the
raw data that is dumped cannot be used without parsing.

This patch is to improve the "perf report" support for spe, and
further process the data. Currently, support for the three events
of llc-miss, tlb-miss, and branch-miss is added.

Example usage:

--------------------------------------------------------------------
...
    37.84%    37.84%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
    16.22%    16.22%  dd       [kernel.kallsyms]  [k] copy_page
     5.41%     5.41%  dd       [kernel.kallsyms]  [k] find_vma
     5.41%     5.41%  dd       [kernel.kallsyms]  [k] perf_event_mmap
     5.41%     5.41%  dd       [kernel.kallsyms]  [k] zap_pte_range
     5.41%     5.41%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
     5.41%     5.41%  dd       libc-2.28.so       [.] _nl_intern_locale_data
     2.70%     2.70%  dd       [kernel.kallsyms]  [k] __remove_shared_vm_struct.isra.1
     2.70%     2.70%  dd       [kernel.kallsyms]  [k] kmem_cache_free
     2.70%     2.70%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
     2.70%     2.70%  dd       dd                 [.] 0x000000000000d9d8
     2.70%     2.70%  dd       ld-2.28.so         [.] _dl_relocate_object
     2.70%     2.70%  dd       libc-2.28.so       [.] __unregister_atfork
     2.70%     2.70%  dd       libc-2.28.so       [.] _dl_addr

    12.50%    12.50%  dd       [kernel.kallsyms]  [k] __audit_syscall_entry
    12.50%    12.50%  dd       [kernel.kallsyms]  [k] kmem_cache_free
    12.50%    12.50%  dd       [kernel.kallsyms]  [k] perf_iterate_ctx.constprop.64
    12.50%    12.50%  dd       [kernel.kallsyms]  [k] ttwu_do_wakeup.isra.19
    12.50%    12.50%  dd       dd                 [.] 0x000000000000d9d8
    12.50%    12.50%  dd       libc-2.28.so       [.] __unregister_atfork
    12.50%    12.50%  dd       libc-2.28.so       [.] _nl_intern_locale_data
    12.50%    12.50%  dd       libc-2.28.so       [.] vfprintf

    16.67%    16.67%  dd       libc-2.28.so       [.] read_alias_file
     8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
     8.33%     8.33%  dd       [kernel.kallsyms]  [k] __arch_copy_to_user
     8.33%     8.33%  dd       [kernel.kallsyms]  [k] lookup_fast
     8.33%     8.33%  dd       [kernel.kallsyms]  [k] strncpy_from_user
     8.33%     8.33%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
     8.33%     8.33%  dd       ld-2.28.so         [.] check_match
     8.33%     8.33%  dd       libc-2.28.so       [.] __GI___printf_fp_l
     8.33%     8.33%  dd       libc-2.28.so       [.] _dl_addr
     8.33%     8.33%  dd       libc-2.28.so       [.] _int_malloc
     8.33%     8.33%  dd       libc-2.28.so       [.] _nl_intern_locale_data

--------------------------------------------------------------------

After that, more analysis and processing of the raw data of spe
will be done.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 tools/perf/builtin-report.c                        |   5 +
 tools/perf/util/arm-spe-decoder/Build              |   2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 214 ++++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  51 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   2 +
 tools/perf/util/arm-spe.c                          | 715 ++++++++++++++++++++-
 tools/perf/util/auxtrace.c                         |  45 ++
 tools/perf/util/auxtrace.h                         |  27 +
 tools/perf/util/session.h                          |   2 +
 9 files changed, 1028 insertions(+), 35 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index abf0b9b..fadc8eb 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1007,6 +1007,7 @@ int cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
 	struct itrace_synth_opts itrace_synth_opts = { .set = 0, };
+	struct arm_spe_synth_opts arm_spe_synth_opts;
 	struct stat st;
 	bool has_br_stack = false;
 	int branch_mode = -1;
@@ -1165,6 +1166,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
 			    itrace_parse_synth_opts),
+	OPT_CALLBACK_OPTARG(0, "spe", &arm_spe_synth_opts, NULL, "spe opts",
+			    "ARM SPE Tracing options",
+			    arm_spe_parse_synth_opts),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "show-ref-call-graph", &symbol_conf.show_ref_callgraph,
@@ -1266,6 +1270,7 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	session->itrace_synth_opts = &itrace_synth_opts;
+	session->arm_spe_synth_opts = &arm_spe_synth_opts;
 
 	report.session = session;
 
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
index 16efbc2..f8dae13 100644
--- a/tools/perf/util/arm-spe-decoder/Build
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -1 +1 @@
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o arm-spe-decoder.o
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
new file mode 100644
index 0000000..8008375
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm_spe_decoder.c: ARM SPE support
+ */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <linux/compiler.h>
+#include <linux/zalloc.h>
+
+#include "../util.h"
+#include "../auxtrace.h"
+
+#include "arm-spe-pkt-decoder.h"
+#include "arm-spe-decoder.h"
+
+struct arm_spe_decoder {
+	int (*get_trace)(struct arm_spe_buffer *buffer, void *data);
+	void *data;
+	struct arm_spe_state state;
+	const unsigned char *buf;
+	size_t len;
+	uint64_t pos;
+	struct arm_spe_pkt packet;
+	int pkt_step;
+	int pkt_len;
+	int last_packet_type;
+
+	uint64_t last_ip;
+	uint64_t ip;
+	uint64_t timestamp;
+	uint64_t sample_timestamp;
+	const unsigned char *next_buf;
+	size_t next_len;
+	unsigned char temp_buf[ARM_SPE_PKT_MAX_SZ];
+};
+
+static uint64_t arm_spe_calc_ip(uint64_t payload)
+{
+	uint64_t ip = (payload & ~(0xffULL << 56));
+
+	/* fill high 8 bits for kernel virtual address */
+	if (ip & 0x1000000000000ULL)
+		ip |= (uint64_t)0xff00000000000000ULL;
+
+	return ip;
+}
+
+struct arm_spe_decoder *arm_spe_decoder_new(struct arm_spe_params *params)
+{
+	struct arm_spe_decoder *decoder;
+
+	if (!params->get_trace)
+		return NULL;
+
+	decoder = zalloc(sizeof(struct arm_spe_decoder));
+	if (!decoder)
+		return NULL;
+
+	decoder->get_trace          = params->get_trace;
+	decoder->data               = params->data;
+
+	return decoder;
+}
+
+void arm_spe_decoder_free(struct arm_spe_decoder *decoder)
+{
+	free(decoder);
+}
+
+static int arm_spe_bad_packet(struct arm_spe_decoder *decoder)
+{
+	decoder->pkt_len = 1;
+	decoder->pkt_step = 1;
+	pr_debug("ERROR: Bad packet\n");
+
+	return -EBADMSG;
+}
+
+
+static int arm_spe_get_data(struct arm_spe_decoder *decoder)
+{
+	struct arm_spe_buffer buffer = { .buf = 0, };
+	int ret;
+
+	decoder->pkt_step = 0;
+
+	pr_debug("Getting more data\n");
+	ret = decoder->get_trace(&buffer, decoder->data);
+	if (ret)
+		return ret;
+
+	decoder->buf = buffer.buf;
+	decoder->len = buffer.len;
+	if (!decoder->len) {
+		pr_debug("No more data\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+static int arm_spe_get_next_data(struct arm_spe_decoder *decoder)
+{
+	return arm_spe_get_data(decoder);
+}
+
+static int arm_spe_get_next_packet(struct arm_spe_decoder *decoder)
+{
+	int ret;
+
+	decoder->last_packet_type = decoder->packet.type;
+
+	do {
+		decoder->pos += decoder->pkt_step;
+		decoder->buf += decoder->pkt_step;
+		decoder->len -= decoder->pkt_step;
+
+
+		if (!decoder->len) {
+			ret = arm_spe_get_next_data(decoder);
+			if (ret)
+				return ret;
+		}
+
+		ret = arm_spe_get_packet(decoder->buf, decoder->len,
+				&decoder->packet);
+		if (ret <= 0)
+			return arm_spe_bad_packet(decoder);
+
+		decoder->pkt_len = ret;
+		decoder->pkt_step = ret;
+	} while (decoder->packet.type == ARM_SPE_PAD);
+
+	return 0;
+}
+
+static int arm_spe_walk_trace(struct arm_spe_decoder *decoder)
+{
+	int err;
+	int idx;
+	uint64_t payload;
+
+	while (1) {
+		err = arm_spe_get_next_packet(decoder);
+		if (err)
+			return err;
+
+		idx = decoder->packet.index;
+		payload = decoder->packet.payload;
+
+		switch (decoder->packet.type) {
+		case ARM_SPE_TIMESTAMP:
+			decoder->sample_timestamp = payload;
+			return 0;
+		case ARM_SPE_END:
+			decoder->sample_timestamp = 0;
+			return 0;
+		case ARM_SPE_ADDRESS:
+			decoder->ip = arm_spe_calc_ip(payload);
+			if (idx == 0)
+				decoder->state.from_ip = decoder->ip;
+			else if (idx == 1)
+				decoder->state.to_ip = decoder->ip;
+			break;
+		case ARM_SPE_COUNTER:
+			break;
+		case ARM_SPE_CONTEXT:
+			break;
+		case ARM_SPE_OP_TYPE:
+			break;
+		case ARM_SPE_EVENTS:
+			if (payload & 0x20)
+				decoder->state.type |= ARM_SPE_TLB_MISS;
+			if (payload & 0x80)
+				decoder->state.type |= ARM_SPE_BRANCH_MISS;
+			if (idx > 1 && (payload & 0x200))
+				decoder->state.type |= ARM_SPE_LLC_MISS;
+
+			break;
+		case ARM_SPE_DATA_SOURCE:
+			break;
+		case ARM_SPE_BAD:
+			break;
+		case ARM_SPE_PAD:
+			break;
+		default:
+			pr_err("Get Packet Error!\n");
+			return -ENOSYS;
+		}
+	}
+}
+
+const struct arm_spe_state *arm_spe_decode(struct arm_spe_decoder *decoder)
+{
+	int err;
+
+	decoder->state.type = 0;
+
+	err = arm_spe_walk_trace(decoder);
+	if (err)
+		decoder->state.err = err;
+
+	decoder->state.timestamp = decoder->sample_timestamp;
+
+	return &decoder->state;
+}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
new file mode 100644
index 0000000..e327378
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm_spe_decoder.c: ARM SPE support
+ */
+
+#ifndef INCLUDE__ARM_SPE_DECODER_H__
+#define INCLUDE__ARM_SPE_DECODER_H__
+
+#include <stdint.h>
+#include <stddef.h>
+#include <stdbool.h>
+
+enum arm_spe_sample_type {
+	ARM_SPE_LLC_MISS	= 1 << 0,
+	ARM_SPE_TLB_MISS	= 1 << 1,
+	ARM_SPE_BRANCH_MISS	= 1 << 2,
+	ARM_SPE_EX_STOP		= 1 << 6,
+};
+
+struct arm_spe_state {
+	enum arm_spe_sample_type type;
+	int err;
+	uint64_t from_ip;
+	uint64_t to_ip;
+	uint64_t timestamp;
+};
+
+struct arm_spe_insn;
+
+struct arm_spe_buffer {
+	const unsigned char *buf;
+	size_t len;
+	u64 offset;
+	bool consecutive;
+	uint64_t ref_timestamp;
+	uint64_t trace_nr;
+};
+
+struct arm_spe_params {
+	int (*get_trace)(struct arm_spe_buffer *buffer, void *data);
+	void *data;
+};
+
+struct arm_spe_decoder;
+
+struct arm_spe_decoder *arm_spe_decoder_new(struct arm_spe_params *params);
+void arm_spe_decoder_free(struct arm_spe_decoder *decoder);
+
+const struct arm_spe_state *arm_spe_decode(struct arm_spe_decoder *decoder);
+
+#endif
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index d786ef6..865d1e3 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -15,6 +15,8 @@
 #define ARM_SPE_NEED_MORE_BYTES		-1
 #define ARM_SPE_BAD_PACKET		-2
 
+#define ARM_SPE_PKT_MAX_SZ		16
+
 enum arm_spe_pkt_type {
 	ARM_SPE_BAD,
 	ARM_SPE_PAD,
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index c07837c..cf066a1 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -21,30 +21,57 @@
 #include "machine.h"
 #include "session.h"
 #include "thread.h"
+#include "thread-stack.h"
+#include "symbol.h"
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
+#include "arm-spe-decoder/arm-spe-decoder.h"
 #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
+#define MAX_TIMESTAMP (~0ULL)
+
 struct arm_spe {
 	struct auxtrace			auxtrace;
 	struct auxtrace_queues		queues;
 	struct auxtrace_heap		heap;
+	struct arm_spe_synth_opts	synth_opts;
 	u32				auxtrace_type;
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
+
+	u8				timeless_decoding;
+	u8				data_queued;
+
+	u8				sample_llc_miss;
+	u8				sample_tlb_miss;
+	u8				sample_branch_miss;
+	u64				llc_miss_id;
+	u64				tlb_miss_id;
+	u64				branch_miss_id;
+	u64				kernel_start;
+
+	unsigned long			num_events;
 };
 
 struct arm_spe_queue {
-	struct arm_spe		*spe;
-	unsigned int		queue_nr;
-	struct auxtrace_buffer	*buffer;
-	bool			on_heap;
-	bool			done;
-	pid_t			pid;
-	pid_t			tid;
-	int			cpu;
+	struct arm_spe			*spe;
+	unsigned int			queue_nr;
+	struct auxtrace_buffer		*buffer;
+	struct auxtrace_buffer		*old_buffer;
+	union perf_event		*event_buf;
+	bool				on_heap;
+	bool				done;
+	pid_t				pid;
+	pid_t				tid;
+	int				cpu;
+	void				*decoder;
+	const struct arm_spe_state	*state;
+	u64				time;
+	u64				timestamp;
+	struct thread			*thread;
+	bool				have_sample;
 };
 
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
@@ -93,44 +120,487 @@ static void arm_spe_dump_event(struct arm_spe *spe, unsigned char *buf,
 	arm_spe_dump(spe, buf, len);
 }
 
-static int arm_spe_process_event(struct perf_session *session __maybe_unused,
-				 union perf_event *event __maybe_unused,
-				 struct perf_sample *sample __maybe_unused,
-				 struct perf_tool *tool __maybe_unused)
+static int arm_spe_get_trace(struct arm_spe_buffer *b, void *data)
 {
+	struct arm_spe_queue *speq = data;
+	struct auxtrace_buffer *buffer = speq->buffer;
+	struct auxtrace_buffer *old_buffer = speq->old_buffer;
+	struct auxtrace_queue *queue;
+
+	queue = &speq->spe->queues.queue_array[speq->queue_nr];
+
+	buffer = auxtrace_buffer__next(queue, buffer);
+	/* If no more data, drop the previous auxtrace_buffer and return */
+	if (!buffer) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		b->len = 0;
+		return 0;
+	}
+
+	speq->buffer = buffer;
+
+	/* If the aux_buffer doesn't have data associated, try to load it */
+	if (!buffer->data) {
+		/* get the file desc associated with the perf data file */
+		int fd = perf_data__fd(speq->spe->session->data);
+
+		buffer->data = auxtrace_buffer__get_data(buffer, fd);
+		if (!buffer->data)
+			return -ENOMEM;
+	}
+
+	if (buffer->use_data) {
+		b->len = buffer->use_size;
+		b->buf = buffer->use_data;
+	} else {
+		b->len = buffer->size;
+		b->buf = buffer->data;
+	}
+
+	b->ref_timestamp = buffer->reference;
+
+	if (b->len) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		speq->old_buffer = buffer;
+	} else {
+		auxtrace_buffer__drop_data(buffer);
+		return arm_spe_get_trace(b, data);
+	}
+
 	return 0;
 }
 
+static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
+		unsigned int queue_nr)
+{
+	struct arm_spe_params params = { .get_trace = 0, };
+	struct arm_spe_queue *speq;
+
+	speq = zalloc(sizeof(*speq));
+	if (!speq)
+		return NULL;
+
+	speq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
+	if (!speq->event_buf)
+		goto out_free;
+
+	speq->spe = spe;
+	speq->queue_nr = queue_nr;
+	speq->pid = -1;
+	speq->tid = -1;
+	speq->cpu = -1;
+
+	/* params set */
+	params.get_trace = arm_spe_get_trace;
+	params.data = speq;
+
+	/* create new decoder */
+	speq->decoder = arm_spe_decoder_new(&params);
+	if (!speq->decoder)
+		goto out_free;
+
+	return speq;
+
+out_free:
+	zfree(&speq->event_buf);
+	free(speq);
+
+	return NULL;
+}
+
+static inline u8 arm_spe_cpumode(struct arm_spe *spe, uint64_t ip)
+{
+	return ip >= spe->kernel_start ?
+		PERF_RECORD_MISC_KERNEL :
+		PERF_RECORD_MISC_USER;
+}
+
+static void arm_spe_prep_sample(struct arm_spe *spe,
+				struct arm_spe_queue *speq,
+				union perf_event *event,
+				struct perf_sample *sample)
+{
+	if (!spe->timeless_decoding)
+		sample->time = speq->timestamp;
+
+	sample->ip = speq->state->from_ip;
+	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
+	sample->pid = speq->pid;
+	sample->tid = speq->tid;
+	sample->addr = speq->state->to_ip;
+	sample->period = 1;
+	sample->cpu = speq->cpu;
+
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.misc = sample->cpumode;
+	event->sample.header.size = sizeof(struct perf_event_header);
+}
+
+static inline int
+arm_spe_deliver_synth_event(struct arm_spe *spe,
+			    struct arm_spe_queue *speq __maybe_unused,
+			    union perf_event *event,
+			    struct perf_sample *sample)
+{
+	int ret;
+
+	ret = perf_session__deliver_synth_event(spe->session, event, sample);
+	if (ret)
+		pr_err("ARM SPE: failed to deliver event, error %d\n", ret);
+
+	return ret;
+}
+
+static int
+arm_spe_synth_spe_events_sample(struct arm_spe_queue *speq,
+				u64 spe_events_id)
+{
+	struct arm_spe *spe = speq->spe;
+	union perf_event *event = speq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+
+	arm_spe_prep_sample(spe, speq, event, &sample);
+
+	sample.id = spe_events_id;
+	sample.stream_id = spe_events_id;
+
+	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
+}
+
+static int arm_spe_sample(struct arm_spe_queue *speq)
+{
+	const struct arm_spe_state *state = speq->state;
+	struct arm_spe *spe = speq->spe;
+	int err;
+
+	if (!speq->have_sample)
+		return 0;
+
+	speq->have_sample = false;
+
+	if (spe->sample_llc_miss && (state->type & ARM_SPE_LLC_MISS)) {
+		err = arm_spe_synth_spe_events_sample(speq, spe->llc_miss_id);
+		if (err)
+			return err;
+	}
+
+	if (spe->sample_tlb_miss && (state->type & ARM_SPE_TLB_MISS)) {
+		err = arm_spe_synth_spe_events_sample(speq, spe->tlb_miss_id);
+		if (err)
+			return err;
+	}
+
+	if (spe->sample_branch_miss && (state->type & ARM_SPE_BRANCH_MISS)) {
+		err = arm_spe_synth_spe_events_sample(speq,
+						      spe->branch_miss_id);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
+{
+	const struct arm_spe_state *state = speq->state;
+	struct arm_spe *spe = speq->spe;
+	int err;
+
+	if (!spe->kernel_start)
+		spe->kernel_start = machine__kernel_start(spe->machine);
+
+	while (1) {
+		err = arm_spe_sample(speq);
+		if (err)
+			return err;
+
+		state = arm_spe_decode(speq->decoder);
+		if (state->err) {
+			if (state->err == -ENODATA) {
+				pr_debug("No data or all data has been processed.\n");
+				return 1;
+			}
+			continue;
+		}
+
+		speq->state = state;
+		speq->have_sample = true;
+
+		if (!spe->timeless_decoding && speq->timestamp >= *timestamp) {
+			*timestamp = speq->timestamp;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int arm_spe__setup_queue(struct arm_spe *spe,
+			       struct auxtrace_queue *queue,
+			       unsigned int queue_nr)
+{
+	struct arm_spe_queue *speq = queue->priv;
+
+	if (list_empty(&queue->head) || speq)
+		return 0;
+
+	speq = arm_spe__alloc_queue(spe, queue_nr);
+
+	if (!speq)
+		return -ENOMEM;
+
+	queue->priv = speq;
+
+	if (queue->cpu != -1)
+		speq->cpu = queue->cpu;
+
+	speq->tid = queue->tid;
+
+	if (!speq->on_heap) {
+		const struct arm_spe_state *state;
+		int ret;
+
+		if (spe->timeless_decoding)
+			return 0;
+
+retry:
+		state = arm_spe_decode(speq->decoder);
+		if (state->err) {
+			if (state->err == -ENODATA) {
+				pr_debug("queue %u has no timestamp\n",
+						queue_nr);
+				return 0;
+			}
+			goto retry;
+		}
+
+		speq->timestamp = state->timestamp;
+		speq->state = state;
+		speq->have_sample = true;
+		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
+		if (ret)
+			return ret;
+		speq->on_heap = true;
+	}
+
+	return 0;
+}
+
+static int arm_spe__setup_queues(struct arm_spe *spe)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < spe->queues.nr_queues; i++) {
+		ret = arm_spe__setup_queue(spe, &spe->queues.queue_array[i], i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int arm_spe__update_queues(struct arm_spe *spe)
+{
+	if (spe->queues.new_data) {
+		spe->queues.new_data = false;
+		return arm_spe__setup_queues(spe);
+	}
+
+	return 0;
+}
+
+static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
+{
+	struct perf_evsel *evsel;
+	struct perf_evlist *evlist = spe->session->evlist;
+	bool timeless_decoding = true;
+
+	/*
+	 * Circle through the list of event and complain if we find one
+	 * with the time bit set.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		if ((evsel->attr.sample_type & PERF_SAMPLE_TIME))
+			timeless_decoding = false;
+	}
+
+	return timeless_decoding;
+}
+
+static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
+				    struct auxtrace_queue *queue)
+{
+	struct arm_spe_queue *speq = queue->priv;
+
+	if (queue->tid == -1) {
+		speq->tid = machine__get_current_tid(spe->machine, speq->cpu);
+		thread__zput(speq->thread);
+	}
+
+	if ((!speq->thread) && (speq->tid != -1)) {
+		speq->thread = machine__find_thread(spe->machine, -1,
+						    speq->tid);
+	}
+
+	if (speq->thread) {
+		speq->pid = speq->thread->pid_;
+		if (queue->cpu == -1)
+			speq->cpu = speq->thread->cpu;
+	}
+}
+
+static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
+{
+	unsigned int queue_nr;
+	u64 ts;
+	int ret;
+
+	while (1) {
+		struct auxtrace_queue *queue;
+		struct arm_spe_queue *speq;
+
+		if (!spe->heap.heap_cnt)
+			return 0;
+
+		if (spe->heap.heap_array[0].ordinal >= timestamp)
+			return 0;
+
+		queue_nr = spe->heap.heap_array[0].queue_nr;
+		queue = &spe->queues.queue_array[queue_nr];
+		speq = queue->priv;
+
+		auxtrace_heap__pop(&spe->heap);
+
+		if (spe->heap.heap_cnt) {
+			ts = spe->heap.heap_array[0].ordinal + 1;
+			if (ts > timestamp)
+				ts = timestamp;
+		} else {
+			ts = timestamp;
+		}
+
+		arm_spe_set_pid_tid_cpu(spe, queue);
+
+		ret = arm_spe_run_decoder(speq, &ts);
+		if (ret < 0) {
+			auxtrace_heap__add(&spe->heap, queue_nr, ts);
+			return ret;
+		}
+
+		if (!ret) {
+			ret = auxtrace_heap__add(&spe->heap, queue_nr, ts);
+			if (ret < 0)
+				return ret;
+		} else {
+			speq->on_heap = false;
+		}
+	}
+
+	return 0;
+}
+
+static int arm_spe_process_timeless_queues(struct arm_spe *spe, pid_t tid,
+					    u64 time_)
+{
+	struct auxtrace_queues *queues = &spe->queues;
+	unsigned int i;
+	u64 ts = 0;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		struct auxtrace_queue *queue = &spe->queues.queue_array[i];
+		struct arm_spe_queue *speq = queue->priv;
+
+		if (speq && (tid == -1 || speq->tid == tid)) {
+			speq->time = time_;
+			arm_spe_set_pid_tid_cpu(spe, queue);
+			arm_spe_run_decoder(speq, &ts);
+		}
+	}
+	return 0;
+}
+
+static int arm_spe_process_event(struct perf_session *session,
+				 union perf_event *event,
+				 struct perf_sample *sample,
+				 struct perf_tool *tool)
+{
+	int err = 0;
+	u64 timestamp;
+	struct arm_spe *spe = container_of(session->auxtrace,
+			struct arm_spe, auxtrace);
+
+	if (dump_trace)
+		return 0;
+
+	if (!tool->ordered_events) {
+		pr_err("CoreSight SPE Trace requires ordered events\n");
+		return -EINVAL;
+	}
+
+	if (sample->time && (sample->time != (u64) -1))
+		timestamp = sample->time;
+	else
+		timestamp = 0;
+
+	if (timestamp || spe->timeless_decoding) {
+		err = arm_spe__update_queues(spe);
+		if (err)
+			return err;
+	}
+
+	if (spe->timeless_decoding) {
+		if (event->header.type == PERF_RECORD_EXIT) {
+			err = arm_spe_process_timeless_queues(spe,
+					event->fork.tid,
+					sample->time);
+		}
+	} else if (timestamp) {
+		if (event->header.type == PERF_RECORD_EXIT) {
+			err = arm_spe_process_queues(spe, timestamp);
+			if (err)
+				return err;
+		}
+	}
+
+	return err;
+}
+
 static int arm_spe_process_auxtrace_event(struct perf_session *session,
 					  union perf_event *event,
 					  struct perf_tool *tool __maybe_unused)
 {
 	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
 					     auxtrace);
-	struct auxtrace_buffer *buffer;
-	off_t data_offset;
-	int fd = perf_data__fd(session->data);
-	int err;
 
-	if (perf_data__is_pipe(session->data)) {
-		data_offset = 0;
-	} else {
-		data_offset = lseek(fd, 0, SEEK_CUR);
-		if (data_offset == -1)
-			return -errno;
-	}
+	if (!spe->data_queued) {
+		struct auxtrace_buffer *buffer;
+		off_t data_offset;
+		int fd = perf_data__fd(session->data);
+		int err;
 
-	err = auxtrace_queues__add_event(&spe->queues, session, event,
-					 data_offset, &buffer);
-	if (err)
-		return err;
-
-	/* Dump here now we have copied a piped trace out of the pipe */
-	if (dump_trace) {
-		if (auxtrace_buffer__get_data(buffer, fd)) {
-			arm_spe_dump_event(spe, buffer->data,
-					     buffer->size);
-			auxtrace_buffer__put_data(buffer);
+		if (perf_data__is_pipe(session->data)) {
+			data_offset = 0;
+		} else {
+			data_offset = lseek(fd, 0, SEEK_CUR);
+			if (data_offset == -1)
+				return -errno;
+		}
+
+		err = auxtrace_queues__add_event(&spe->queues, session, event,
+				data_offset, &buffer);
+		if (err)
+			return err;
+
+		/* Dump here now we have copied a piped trace out of the pipe */
+		if (dump_trace) {
+			if (auxtrace_buffer__get_data(buffer, fd)) {
+				arm_spe_dump_event(spe, buffer->data,
+						buffer->size);
+				auxtrace_buffer__put_data(buffer);
+			}
 		}
 	}
 
@@ -140,6 +610,25 @@ static int arm_spe_process_auxtrace_event(struct perf_session *session,
 static int arm_spe_flush(struct perf_session *session __maybe_unused,
 			 struct perf_tool *tool __maybe_unused)
 {
+	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe,
+			auxtrace);
+	int ret;
+
+	if (dump_trace)
+		return 0;
+
+	if (!tool->ordered_events)
+		return -EINVAL;
+
+	ret = arm_spe__update_queues(spe);
+	if (ret < 0)
+		return ret;
+
+	if (spe->timeless_decoding)
+		return arm_spe_process_timeless_queues(spe, -1,
+				MAX_TIMESTAMP - 1);
+
+	return arm_spe_process_queues(spe, MAX_TIMESTAMP);
 	return 0;
 }
 
@@ -149,6 +638,9 @@ static void arm_spe_free_queue(void *priv)
 
 	if (!speq)
 		return;
+	thread__zput(speq->thread);
+	arm_spe_decoder_free(speq->decoder);
+	zfree(&speq->event_buf);
 	free(speq);
 }
 
@@ -189,6 +681,137 @@ static void arm_spe_print_info(u64 *arr)
 	fprintf(stdout, arm_spe_info_fmts[ARM_SPE_PMU_TYPE], arr[ARM_SPE_PMU_TYPE]);
 }
 
+struct arm_spe_synth {
+	struct perf_tool dummy_tool;
+	struct perf_session *session;
+};
+
+static int arm_spe_event_synth(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample __maybe_unused,
+			       struct machine *machine __maybe_unused)
+{
+	struct arm_spe_synth *arm_spe_synth =
+		      container_of(tool, struct arm_spe_synth, dummy_tool);
+
+	return perf_session__deliver_synth_event(arm_spe_synth->session,
+						 event, NULL);
+}
+
+static int arm_spe_synth_event(struct perf_session *session,
+			       struct perf_event_attr *attr, u64 id)
+{
+	struct arm_spe_synth arm_spe_synth;
+
+	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
+	arm_spe_synth.session = session;
+
+	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
+					   &id, arm_spe_event_synth);
+}
+
+static void arm_spe_set_event_name(struct perf_evlist *evlist, u64 id,
+				    const char *name)
+{
+	struct perf_evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->id && evsel->id[0] == id) {
+			if (evsel->name)
+				zfree(&evsel->name);
+			evsel->name = strdup(name);
+			break;
+		}
+	}
+}
+
+static int
+arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
+{
+	struct perf_evlist *evlist = session->evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr;
+	bool found = false;
+	u64 id;
+	int err;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->attr.type == spe->pmu_type) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_debug("No selected events with CoreSight Trace data\n");
+		return 0;
+	}
+
+	memset(&attr, 0, sizeof(struct perf_event_attr));
+	attr.size = sizeof(struct perf_event_attr);
+	attr.type = PERF_TYPE_HARDWARE;
+	attr.sample_type = evsel->attr.sample_type & PERF_SAMPLE_MASK;
+	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
+		PERF_SAMPLE_PERIOD;
+	if (spe->timeless_decoding)
+		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
+	else
+		attr.sample_type |= PERF_SAMPLE_TIME;
+
+	attr.exclude_user = evsel->attr.exclude_user;
+	attr.exclude_kernel = evsel->attr.exclude_kernel;
+	attr.exclude_hv = evsel->attr.exclude_hv;
+	attr.exclude_host = evsel->attr.exclude_host;
+	attr.exclude_guest = evsel->attr.exclude_guest;
+	attr.sample_id_all = evsel->attr.sample_id_all;
+	attr.read_format = evsel->attr.read_format;
+
+	/* create new id val to be a fixed offset from evsel id */
+	id = evsel->id[0] + 1000000000;
+
+	if (!id)
+		id = 1;
+
+	/* spe events set */
+	if (spe->synth_opts.llc_miss) {
+		spe->sample_llc_miss = true;
+
+		/* llc-miss */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->llc_miss_id = id;
+		arm_spe_set_event_name(evlist, id, "llc-miss");
+		id += 1;
+	}
+
+	if (spe->synth_opts.tlb_miss) {
+		spe->sample_tlb_miss = true;
+
+		/* tlb-miss */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->tlb_miss_id = id;
+		arm_spe_set_event_name(evlist, id, "tlb-miss");
+		id += 1;
+	}
+
+	if (spe->synth_opts.branch_miss) {
+		spe->sample_branch_miss = true;
+
+		/* branch-miss */
+		err = arm_spe_synth_event(session, &attr, id);
+		if (err)
+			return err;
+		spe->branch_miss_id = id;
+		arm_spe_set_event_name(evlist, id, "branch-miss");
+		id += 1;
+	}
+
+	return 0;
+}
+
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -197,6 +820,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	struct arm_spe *spe;
 	int err;
 
+
 	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
 					min_sz)
 		return -EINVAL;
@@ -214,6 +838,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 
+	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 	spe->auxtrace.process_event = arm_spe_process_event;
 	spe->auxtrace.process_auxtrace_event = arm_spe_process_auxtrace_event;
 	spe->auxtrace.flush_events = arm_spe_flush;
@@ -223,8 +848,30 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 
 	arm_spe_print_info(&auxtrace_info->priv[0]);
 
+	if (dump_trace)
+		return 0;
+
+	if (session->arm_spe_synth_opts && session->arm_spe_synth_opts->set)
+		spe->synth_opts = *session->arm_spe_synth_opts;
+	else
+		arm_spe_synth_opts__set_default(&spe->synth_opts);
+
+	err = arm_spe_synth_events(spe, session);
+	if (err)
+		goto err_free_queues;
+
+	err = auxtrace_queues__process_index(&spe->queues, session);
+	if (err)
+		goto err_free_queues;
+
+	if (spe->queues.populated)
+		spe->data_queued = true;
+
 	return 0;
 
+err_free_queues:
+	auxtrace_queues__free(&spe->queues);
+	session->auxtrace = NULL;
 err_free:
 	free(spe);
 	return err;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ec0af36..3884cc4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1137,6 +1137,51 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 	return -EINVAL;
 }
 
+void arm_spe_synth_opts__set_default(struct arm_spe_synth_opts *synth_opts)
+{
+	synth_opts->llc_miss = true;
+	synth_opts->tlb_miss = true;
+	synth_opts->branch_miss = true;
+}
+
+int arm_spe_parse_synth_opts(const struct option *opt, const char *str,
+			    int unset __maybe_unused)
+{
+	struct arm_spe_synth_opts *synth_opts = opt->value;
+	const char *p;
+
+	synth_opts->set = true;
+
+	if (!str) {
+		arm_spe_synth_opts__set_default(synth_opts);
+		return 0;
+	}
+
+	for (p = str; *p;) {
+		switch (*p++) {
+		case 'l':
+			synth_opts->llc_miss = true;
+			break;
+		case 't':
+			synth_opts->tlb_miss = true;
+			break;
+		case 'b':
+			synth_opts->branch_miss = true;
+			break;
+		case ' ':
+		case ',':
+			break;
+		default:
+			goto out_err;
+		}
+	}
+
+	return 0;
+
+out_err:
+	pr_err("Bad ARM SPE Tracing options '%s'\n", str);
+	return -EINVAL;
+}
 static const char * const auxtrace_error_type_name[] = {
 	[PERF_AUXTRACE_ERROR_ITRACE] = "instruction trace",
 };
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e9b4c5e..7697788 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -105,6 +105,20 @@ struct itrace_synth_opts {
 };
 
 /**
+ * struct arm_spe_synth_opts - ARM SPE tracing synthesis options.
+ * @set: indicates whether or not options have been set
+ * @llc_miss: whether to synthesize last level cache miss events
+ * @tlb_miss: whether to synthesize TLB miss events
+ * @branch_miss: whether to synthesize Branch miss events
+ */
+struct arm_spe_synth_opts {
+	bool			set;
+	bool			llc_miss;
+	bool			tlb_miss;
+	bool			branch_miss;
+};
+
+/**
  * struct auxtrace_index_entry - indexes a AUX area tracing event within a
  *                               perf.data file.
  * @file_offset: offset within the perf.data file
@@ -531,6 +545,10 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 				    bool no_sample);
 
+int arm_spe_parse_synth_opts(const struct option *opt, const char *str,
+			    int unset);
+void arm_spe_synth_opts__set_default(struct arm_spe_synth_opts *synth_opts);
+
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp);
 void perf_session__auxtrace_error_inc(struct perf_session *session,
 				      union perf_event *event);
@@ -670,6 +688,15 @@ int itrace_parse_synth_opts(const struct option *opt __maybe_unused,
 }
 
 static inline
+int arm_spe_parse_synth_opts(const struct option *opt __maybe_unused,
+			    const char *str __maybe_unused,
+			    int unset __maybe_unused)
+{
+	pr_err("ARM SPE area tracing not supported\n");
+	return -EINVAL;
+}
+
+static inline
 int auxtrace_parse_snapshot_options(struct auxtrace_record *itr __maybe_unused,
 				    struct record_opts *opts __maybe_unused,
 				    const char *str)
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 863dbad..ccaed68 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -19,6 +19,7 @@ struct thread;
 
 struct auxtrace;
 struct itrace_synth_opts;
+struct arm_spe_synth_opts;
 
 struct perf_session {
 	struct perf_header	header;
@@ -26,6 +27,7 @@ struct perf_session {
 	struct perf_evlist	*evlist;
 	struct auxtrace		*auxtrace;
 	struct itrace_synth_opts *itrace_synth_opts;
+	struct arm_spe_synth_opts *arm_spe_synth_opts;
 	struct list_head	auxtrace_index;
 	struct trace_event	tevent;
 	struct time_conv_event	time_conv;
-- 
2.7.4

