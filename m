Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C7EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB3227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLRO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:27:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:21673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLRO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 06:27:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="240803863"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2019 06:27:12 -0800
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
Subject: [PATCH 1/3] perf/x86: Add perf text poke event
Date:   Wed, 18 Dec 2019 16:26:16 +0200
Message-Id: <20191218142618.19332-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218142618.19332-1-adrian.hunter@intel.com>
References: <20191218142618.19332-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record changes to kernel text (i.e. self-modifying code) in order to
support tracers like Intel PT decoding through jump labels.

A copy of the running kernel code is needed as a reference point
(e.g. from /proc/kcore). The text poke event records the old bytes
and the new bytes so that the event can be processed forwards or backwards.

In the case of Intel PT tracing, the executable code must be walked to
reconstruct the control flow. For x86 a jump label text poke begins:
  - write INT3 byte
  - IPI-SYNC
  - write instruction tail
At this point the actual control flow will be through the INT3 and handler
and not hit the old or new instruction. Intel PT outputs FUP/TIP packets
for the INT3, so the flow can still be decoded. Subsequently:
  - emit RECORD_TEXT_POKE with the new instruction
  - IPI-SYNC
  - write first byte
  - IPI-SYNC
So before the text poke event timestamp, the decoder will see either the
old instruction flow or FUP/TIP of INT3. After the text poke event
timestamp, the decoder will see either the new instruction flow or FUP/TIP
of INT3. Thus decoders can use the timestamp as the point at which to
modify the executable code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/alternative.c   | 37 +++++++++++++-
 include/linux/perf_event.h      |  6 +++
 include/uapi/linux/perf_event.h | 19 ++++++-
 kernel/events/core.c            | 87 ++++++++++++++++++++++++++++++++-
 4 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 30e86730655c..f932f8f4caf4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
@@ -946,6 +947,7 @@ struct text_poke_loc {
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 old;
 };
 
 static struct bp_patching_desc {
@@ -1087,8 +1089,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
+		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
 		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
+	}
 
 	text_poke_sync();
 
@@ -1096,14 +1100,45 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
+		u8 old[POKE_MAX_OPCODE_SIZE] = { tp[i].old, };
 		int len = text_opcode_size(tp[i].opcode);
 
 		if (len - INT3_INSN_SIZE > 0) {
+			memcpy(old + INT3_INSN_SIZE,
+			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+			       len - INT3_INSN_SIZE);
 			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
 				  (const char *)tp[i].text + INT3_INSN_SIZE,
 				  len - INT3_INSN_SIZE);
 			do_sync++;
 		}
+
+		/*
+		 * Emit a perf event to record the text poke, primarily to
+		 * support Intel PT decoding which must walk the executable code
+		 * to reconstruct the trace. The flow up to here is:
+		 *   - write INT3 byte
+		 *   - IPI-SYNC
+		 *   - write instruction tail
+		 * At this point the actual control flow will be through the
+		 * INT3 and handler and not hit the old or new instruction.
+		 * Intel PT outputs FUP/TIP packets for the INT3, so the flow
+		 * can still be decoded. Subsequently:
+		 *   - emit RECORD_TEXT_POKE with the new instruction
+		 *   - IPI-SYNC
+		 *   - write first byte
+		 *   - IPI-SYNC
+		 * So before the text poke event timestamp, the decoder will see
+		 * either the old instruction flow or FUP/TIP of INT3. After the
+		 * text poke event timestamp, the decoder will see either the
+		 * new instruction flow or FUP/TIP of INT3. Thus decoders can
+		 * use the timestamp as the point at which to modify the
+		 * executable code.
+		 * The old instruction is recorded so that the event can be
+		 * processed forwards or backwards.
+		 */
+		perf_event_text_poke((unsigned long)text_poke_addr(&tp[i]), old,
+				     tp[i].text, len);
 	}
 
 	if (do_sync) {
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6d4c22aee384..2cfc127e3534 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1212,6 +1212,8 @@ extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
 extern void perf_event_namespaces(struct task_struct *tsk);
 extern void perf_event_fork(struct task_struct *tsk);
+extern void perf_event_text_poke(unsigned long addr, const void *old_bytes,
+				 const void *new_bytes, size_t len);
 
 /* Callchains */
 DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
@@ -1462,6 +1464,10 @@ static inline void perf_event_exec(void)				{ }
 static inline void perf_event_comm(struct task_struct *tsk, bool exec)	{ }
 static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
 static inline void perf_event_fork(struct task_struct *tsk)		{ }
+static inline void perf_event_text_poke(unsigned long addr,
+					const void *old_bytes,
+					const void *new_bytes,
+					size_t len)			{ }
 static inline void perf_event_init(void)				{ }
 static inline int  perf_swevent_get_recursion_context(void)		{ return -1; }
 static inline void perf_swevent_put_recursion_context(int rctx)		{ }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794d3105..d8422ebf128c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c0b11b234290..4996f2bbf9b6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_text_poke_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4397,7 +4398,7 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch ||
+	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
 	return false;
@@ -4471,6 +4472,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_dec(&nr_text_poke_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8309,6 +8312,86 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
 }
 
+struct perf_text_poke_event {
+	const void		*old_bytes;
+	const void		*new_bytes;
+	size_t			pad;
+	u16			len;
+
+	struct {
+		struct perf_event_header	header;
+
+		u64				addr;
+	} event_id;
+};
+
+static int perf_event_text_poke_match(struct perf_event *event)
+{
+	return event->attr.text_poke;
+}
+
+// TODO: go back and check peter's comments
+static void perf_event_text_poke_output(struct perf_event *event, void *data)
+{
+	struct perf_text_poke_event *text_poke_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u64 padding = 0;
+	int ret;
+
+	if (!perf_event_text_poke_match(event))
+		return;
+
+	perf_event_header__init_id(&text_poke_event->event_id.header, &sample, event);
+
+	ret = perf_output_begin(&handle, event, text_poke_event->event_id.header.size);
+	if (ret)
+		return;
+
+	perf_output_put(&handle, text_poke_event->event_id);
+	perf_output_put(&handle, text_poke_event->len);
+
+	__output_copy(&handle, text_poke_event->old_bytes, text_poke_event->len);
+	__output_copy(&handle, text_poke_event->new_bytes, text_poke_event->len);
+
+	if (text_poke_event->pad)
+		__output_copy(&handle, &padding, text_poke_event->pad);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+}
+
+void perf_event_text_poke(unsigned long addr, const void *old_bytes,
+			  const void *new_bytes, size_t len)
+{
+	struct perf_text_poke_event text_poke_event;
+	size_t tot, pad;
+
+	if (!atomic_read(&nr_text_poke_events))
+		return;
+
+	tot  = sizeof(text_poke_event.len) + (len * 2);
+	pad  = ALIGN(tot, sizeof(u64)) - tot;
+
+	text_poke_event = (struct perf_text_poke_event){
+		.old_bytes    = old_bytes,
+		.new_bytes    = new_bytes,
+		.pad          = pad,
+		.len          = len,
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_TEXT_POKE,
+				.misc = PERF_RECORD_MISC_KERNEL,
+				.size = sizeof(text_poke_event.event_id) + tot + pad,
+			},
+			.addr = addr,
+		},
+	};
+
+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
+}
+
 void perf_event_itrace_started(struct perf_event *event)
 {
 	event->attach_state |= PERF_ATTACH_ITRACE;
@@ -10623,6 +10706,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_inc(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_inc(&nr_text_poke_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

