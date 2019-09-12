Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49DECDE20
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A529D20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 07:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfILHBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 03:01:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:25131 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729356AbfILHBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 03:01:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 00:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="384969399"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2019 00:01:50 -0700
Subject: Re: Tracing text poke / kernel self-modifying code (Was: Re: [RFC v2
 0/6] x86: dynamic indirect branch promotion)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
References: <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
 <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
 <20190109103544.GH1900@hirez.programming.kicks-ass.net>
 <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com>
 <20190829085339.GN2369@hirez.programming.kicks-ass.net>
 <d37f678f-cf1d-5c98-228f-05bed99f2112@intel.com>
 <20190829114602.GR2369@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <533cc422-3f26-591f-f41c-b385d8c8ff05@intel.com>
Date:   Thu, 12 Sep 2019 10:00:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829114602.GR2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/19 2:46 PM, Peter Zijlstra wrote:
> On Thu, Aug 29, 2019 at 12:40:56PM +0300, Adrian Hunter wrote:
>> Can you expand on "and ensure the poke_handler preserves the existing
>> control flow"?  Whatever the INT3-handler does will be traced normally so
>> long as it does not itself execute self-modified code.
> 
> My thinking was that the code shouldn't change semantics before emitting
> the RECORD_TEXT_POKE; but you're right in that that doesn't seem to
> matter much.
> 
> Either we run the old code or INT3 does 'something'.  Then we get
> RECORD_TEXT_POKE and finish the poke.  Which tells that the moment INT3
> stops the new text is in place.
> 
> I suppose that works too, and requires less changes.


What about this?


diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 70c09967a999..00aa9bef2b9d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -30,6 +30,7 @@ struct text_poke_loc {
 	void *addr;
 	size_t len;
 	const char opcode[POKE_MAX_OPCODE_SIZE];
+	char old_opcode[POKE_MAX_OPCODE_SIZE];
 };
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ccd32013c47a..c781bbbbbafd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -3,6 +3,7 @@
 
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/perf_event.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/stringify.h>
@@ -1045,8 +1046,10 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 	/*
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
-	for (i = 0; i < nr_entries; i++)
+	for (i = 0; i < nr_entries; i++) {
+		memcpy(tp[i].old_opcode, tp[i].addr, tp[i].len);
 		text_poke(tp[i].addr, &int3, sizeof(int3));
+	}
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
@@ -1071,6 +1074,11 @@ void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
+	for (i = 0; i < nr_entries; i++) {
+		perf_event_text_poke((unsigned long)tp[i].addr,
+				     tp[i].old_opcode, tp[i].opcode, tp[i].len);
+	}
+
 	/*
 	 * Third step: replace the first byte (int3) by the first byte of
 	 * replacing opcode.
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..f4c6095d2110 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1183,6 +1183,8 @@ extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
 extern void perf_event_namespaces(struct task_struct *tsk);
 extern void perf_event_fork(struct task_struct *tsk);
+extern void perf_event_text_poke(unsigned long addr, const void *old_bytes,
+				 const void *new_bytes, size_t len);
 
 /* Callchains */
 DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
@@ -1406,6 +1408,10 @@ static inline void perf_event_exec(void)				{ }
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
index bb7b271397a6..6396d4c0d2f9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -375,7 +375,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				text_poke      :  1, /* include text poke events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1000,6 +1001,22 @@ enum perf_event_type {
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
+ 	PERF_RECORD_TEXT_POKE			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 811bb333c986..43c0d3d232dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_text_poke_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4339,7 +4340,7 @@ static bool is_sb_event(struct perf_event *event)
 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
 	    attr->comm || attr->comm_exec ||
 	    attr->task || attr->ksymbol ||
-	    attr->context_switch ||
+	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
 	return false;
@@ -4413,6 +4414,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_dec(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_dec(&nr_text_poke_events);
 
 	if (dec) {
 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
@@ -8045,6 +8048,85 @@ void perf_event_bpf_event(struct bpf_prog *prog,
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
+	tot  = sizeof(text_poke_event.len) + (len << 1);
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
@@ -10331,6 +10413,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
 		atomic_inc(&nr_bpf_events);
+	if (event->attr.text_poke)
+		atomic_inc(&nr_text_poke_events);
 
 	if (inc) {
 		/*
-- 
2.17.1

