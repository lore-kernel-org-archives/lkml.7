Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178CC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5A20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pPBaQUtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfILMSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:18:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58713 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILMSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:18:45 -0400
Received: from [26.252.58.3] ([172.58.27.94])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8CCHprQ3302160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 12 Sep 2019 05:17:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8CCHprQ3302160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019081901; t=1568290675;
        bh=XUtKFvK6K4S+CS2rLO+1BrbGuHCKBoLO+N3C38fmh2I=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=pPBaQUtqztU6dN55sIIXdoRwTjv4Am8EtPEaCw1ek0mXAHFale5viyAOlc69v8qVS
         Sh2m7OWJnqR58rBueeTZqkHLQyfJjbwmH8UZ3QIiUnbRvxLB1SJbvTy901DJ3BcYCl
         RWOSzCReWUysozcnDw65lG/h9OkOCwVj9e1VqrWh06C2DnJRbcONUe0kWHtmBGNhpR
         T8YKRCzA8Do/iXMRd3tLr8+6TDuGPsHFiiDpinGYg3+Ob9Nd/tWa7C+kh1oQN43ggT
         3bxfEYsyFN994+t6GgKpJQAWVg/ad4aSC6kcvombFhXI3EnxaIKNcKx1EdeSEsZVwH
         OhpRxbmwJHliw==
Date:   Thu, 12 Sep 2019 13:17:39 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <533cc422-3f26-591f-f41c-b385d8c8ff05@intel.com>
References: <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com> <20190108101058.GB6808@hirez.programming.kicks-ass.net> <20190108172721.GN6118@tassilo.jf.intel.com> <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com> <20190108190104.GC1900@hirez.programming.kicks-ass.net> <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com> <20190109103544.GH1900@hirez.programming.kicks-ass.net> <7b4952c2-d3e3-488f-3697-2e8b71c58063@intel.com> <20190829085339.GN2369@hirez.programming.kicks-ass.net> <d37f678f-cf1d-5c98-228f-05bed99f2112@intel.com> <20190829114602.GR2369@hirez.programming.kicks-ass.net> <533cc422-3f26-591f-f41c-b385d8c8ff05@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Tracing text poke / kernel self-modifying code (Was: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion)
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
From:   hpa@zytor.com
Message-ID: <164232F0-A132-479B-AF63-1357C77F081B@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 12, 2019 8:00:39 AM GMT+01:00, Adrian Hunter <adrian=2Ehunter@=
intel=2Ecom> wrote:
>On 29/08/19 2:46 PM, Peter Zijlstra wrote:
>> On Thu, Aug 29, 2019 at 12:40:56PM +0300, Adrian Hunter wrote:
>>> Can you expand on "and ensure the poke_handler preserves the
>existing
>>> control flow"?  Whatever the INT3-handler does will be traced
>normally so
>>> long as it does not itself execute self-modified code=2E
>>=20
>> My thinking was that the code shouldn't change semantics before
>emitting
>> the RECORD_TEXT_POKE; but you're right in that that doesn't seem to
>> matter much=2E
>>=20
>> Either we run the old code or INT3 does 'something'=2E  Then we get
>> RECORD_TEXT_POKE and finish the poke=2E  Which tells that the moment
>INT3
>> stops the new text is in place=2E
>>=20
>> I suppose that works too, and requires less changes=2E
>
>
>What about this?
>
>
>diff --git a/arch/x86/include/asm/text-patching=2Eh
>b/arch/x86/include/asm/text-patching=2Eh
>index 70c09967a999=2E=2E00aa9bef2b9d 100644
>--- a/arch/x86/include/asm/text-patching=2Eh
>+++ b/arch/x86/include/asm/text-patching=2Eh
>@@ -30,6 +30,7 @@ struct text_poke_loc {
> 	void *addr;
> 	size_t len;
> 	const char opcode[POKE_MAX_OPCODE_SIZE];
>+	char old_opcode[POKE_MAX_OPCODE_SIZE];
> };
>=20
>extern void text_poke_early(void *addr, const void *opcode, size_t
>len);
>diff --git a/arch/x86/kernel/alternative=2Ec
>b/arch/x86/kernel/alternative=2Ec
>index ccd32013c47a=2E=2Ec781bbbbbafd 100644
>--- a/arch/x86/kernel/alternative=2Ec
>+++ b/arch/x86/kernel/alternative=2Ec
>@@ -3,6 +3,7 @@
>=20
> #include <linux/module=2Eh>
> #include <linux/sched=2Eh>
>+#include <linux/perf_event=2Eh>
> #include <linux/mutex=2Eh>
> #include <linux/list=2Eh>
> #include <linux/stringify=2Eh>
>@@ -1045,8 +1046,10 @@ void text_poke_bp_batch(struct text_poke_loc
>*tp, unsigned int nr_entries)
> 	/*
> 	 * First step: add a int3 trap to the address that will be patched=2E
> 	 */
>-	for (i =3D 0; i < nr_entries; i++)
>+	for (i =3D 0; i < nr_entries; i++) {
>+		memcpy(tp[i]=2Eold_opcode, tp[i]=2Eaddr, tp[i]=2Elen);
> 		text_poke(tp[i]=2Eaddr, &int3, sizeof(int3));
>+	}
>=20
> 	on_each_cpu(do_sync_core, NULL, 1);
>=20
>@@ -1071,6 +1074,11 @@ void text_poke_bp_batch(struct text_poke_loc
>*tp, unsigned int nr_entries)
> 		on_each_cpu(do_sync_core, NULL, 1);
> 	}
>=20
>+	for (i =3D 0; i < nr_entries; i++) {
>+		perf_event_text_poke((unsigned long)tp[i]=2Eaddr,
>+				     tp[i]=2Eold_opcode, tp[i]=2Eopcode, tp[i]=2Elen);
>+	}
>+
> 	/*
> 	 * Third step: replace the first byte (int3) by the first byte of
> 	 * replacing opcode=2E
>diff --git a/include/linux/perf_event=2Eh b/include/linux/perf_event=2Eh
>index 61448c19a132=2E=2Ef4c6095d2110 100644
>--- a/include/linux/perf_event=2Eh
>+++ b/include/linux/perf_event=2Eh
>@@ -1183,6 +1183,8 @@ extern void perf_event_exec(void);
> extern void perf_event_comm(struct task_struct *tsk, bool exec);
> extern void perf_event_namespaces(struct task_struct *tsk);
> extern void perf_event_fork(struct task_struct *tsk);
>+extern void perf_event_text_poke(unsigned long addr, const void
>*old_bytes,
>+				 const void *new_bytes, size_t len);
>=20
> /* Callchains */
> DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>@@ -1406,6 +1408,10 @@ static inline void perf_event_exec(void)				{ }
>static inline void perf_event_comm(struct task_struct *tsk, bool
>exec)	{ }
> static inline void perf_event_namespaces(struct task_struct *tsk)	{ }
> static inline void perf_event_fork(struct task_struct *tsk)		{ }
>+static inline void perf_event_text_poke(unsigned long addr,
>+					const void *old_bytes,
>+					const void *new_bytes,
>+					size_t len)			{ }
> static inline void perf_event_init(void)				{ }
>static inline int  perf_swevent_get_recursion_context(void)		{ return
>-1; }
> static inline void perf_swevent_put_recursion_context(int rctx)		{ }
>diff --git a/include/uapi/linux/perf_event=2Eh
>b/include/uapi/linux/perf_event=2Eh
>index bb7b271397a6=2E=2E6396d4c0d2f9 100644
>--- a/include/uapi/linux/perf_event=2Eh
>+++ b/include/uapi/linux/perf_event=2Eh
>@@ -375,7 +375,8 @@ struct perf_event_attr {
> 				ksymbol        :  1, /* include ksymbol events */
> 				bpf_event      :  1, /* include bpf events */
> 				aux_output     :  1, /* generate AUX records instead of events */
>-				__reserved_1   : 32;
>+				text_poke      :  1, /* include text poke events */
>+				__reserved_1   : 31;
>=20
> 	union {
> 		__u32		wakeup_events;	  /* wakeup every n events */
>@@ -1000,6 +1001,22 @@ enum perf_event_type {
> 	 */
> 	PERF_RECORD_BPF_EVENT			=3D 18,
>=20
>+	/*
>+	 * Records changes to kernel text i=2Ee=2E self-modified code=2E
>+	 * 'len' is the number of old bytes, which is the same as the number
>+	 * of new bytes=2E 'bytes' contains the old bytes followed immediately
>+	 * by the new bytes=2E
>+	 *
>+	 * struct {
>+	 *	struct perf_event_header	header;
>+	 *	u64				addr;
>+	 *	u16				len;
>+	 *	u8				bytes[];
>+	 *	struct sample_id		sample_id;
>+	 * };
>+	 */
>+ 	PERF_RECORD_TEXT_POKE			=3D 19,
>+
> 	PERF_RECORD_MAX,			/* non-ABI */
> };
>=20
>diff --git a/kernel/events/core=2Ec b/kernel/events/core=2Ec
>index 811bb333c986=2E=2E43c0d3d232dc 100644
>--- a/kernel/events/core=2Ec
>+++ b/kernel/events/core=2Ec
>@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
> static atomic_t nr_switch_events __read_mostly;
> static atomic_t nr_ksymbol_events __read_mostly;
> static atomic_t nr_bpf_events __read_mostly;
>+static atomic_t nr_text_poke_events __read_mostly;
>=20
> static LIST_HEAD(pmus);
> static DEFINE_MUTEX(pmus_lock);
>@@ -4339,7 +4340,7 @@ static bool is_sb_event(struct perf_event *event)
> 	if (attr->mmap || attr->mmap_data || attr->mmap2 ||
> 	    attr->comm || attr->comm_exec ||
> 	    attr->task || attr->ksymbol ||
>-	    attr->context_switch ||
>+	    attr->context_switch || attr->text_poke ||
> 	    attr->bpf_event)
> 		return true;
> 	return false;
>@@ -4413,6 +4414,8 @@ static void unaccount_event(struct perf_event
>*event)
> 		atomic_dec(&nr_ksymbol_events);
> 	if (event->attr=2Ebpf_event)
> 		atomic_dec(&nr_bpf_events);
>+	if (event->attr=2Etext_poke)
>+		atomic_dec(&nr_text_poke_events);
>=20
> 	if (dec) {
> 		if (!atomic_add_unless(&perf_sched_count, -1, 1))
>@@ -8045,6 +8048,85 @@ void perf_event_bpf_event(struct bpf_prog *prog,
> 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
> }
>=20
>+struct perf_text_poke_event {
>+	const void		*old_bytes;
>+	const void		*new_bytes;
>+	size_t			pad;
>+	u16			len;
>+
>+	struct {
>+		struct perf_event_header	header;
>+
>+		u64				addr;
>+	} event_id;
>+};
>+
>+static int perf_event_text_poke_match(struct perf_event *event)
>+{
>+	return event->attr=2Etext_poke;
>+}
>+
>+static void perf_event_text_poke_output(struct perf_event *event, void
>*data)
>+{
>+	struct perf_text_poke_event *text_poke_event =3D data;
>+	struct perf_output_handle handle;
>+	struct perf_sample_data sample;
>+	u64 padding =3D 0;
>+	int ret;
>+
>+	if (!perf_event_text_poke_match(event))
>+		return;
>+
>+	perf_event_header__init_id(&text_poke_event->event_id=2Eheader,
>&sample, event);
>+
>+	ret =3D perf_output_begin(&handle, event,
>text_poke_event->event_id=2Eheader=2Esize);
>+	if (ret)
>+		return;
>+
>+	perf_output_put(&handle, text_poke_event->event_id);
>+	perf_output_put(&handle, text_poke_event->len);
>+
>+	__output_copy(&handle, text_poke_event->old_bytes,
>text_poke_event->len);
>+	__output_copy(&handle, text_poke_event->new_bytes,
>text_poke_event->len);
>+
>+	if (text_poke_event->pad)
>+		__output_copy(&handle, &padding, text_poke_event->pad);
>+
>+	perf_event__output_id_sample(event, &handle, &sample);
>+
>+	perf_output_end(&handle);
>+}
>+
>+void perf_event_text_poke(unsigned long addr, const void *old_bytes,
>+			  const void *new_bytes, size_t len)
>+{
>+	struct perf_text_poke_event text_poke_event;
>+	size_t tot, pad;
>+
>+	if (!atomic_read(&nr_text_poke_events))
>+		return;
>+
>+	tot  =3D sizeof(text_poke_event=2Elen) + (len << 1);
>+	pad  =3D ALIGN(tot, sizeof(u64)) - tot;
>+
>+	text_poke_event =3D (struct perf_text_poke_event){
>+		=2Eold_bytes    =3D old_bytes,
>+		=2Enew_bytes    =3D new_bytes,
>+		=2Epad          =3D pad,
>+		=2Elen          =3D len,
>+		=2Eevent_id  =3D {
>+			=2Eheader =3D {
>+				=2Etype =3D PERF_RECORD_TEXT_POKE,
>+				=2Emisc =3D PERF_RECORD_MISC_KERNEL,
>+				=2Esize =3D sizeof(text_poke_event=2Eevent_id) + tot + pad,
>+			},
>+			=2Eaddr =3D addr,
>+		},
>+	};
>+
>+	perf_iterate_sb(perf_event_text_poke_output, &text_poke_event, NULL);
>+}
>+
> void perf_event_itrace_started(struct perf_event *event)
> {
> 	event->attach_state |=3D PERF_ATTACH_ITRACE;
>@@ -10331,6 +10413,8 @@ static void account_event(struct perf_event
>*event)
> 		atomic_inc(&nr_ksymbol_events);
> 	if (event->attr=2Ebpf_event)
> 		atomic_inc(&nr_bpf_events);
>+	if (event->attr=2Etext_poke)
>+		atomic_inc(&nr_text_poke_events);
>=20
> 	if (inc) {
> 		/*

Wasn't there was a long discussion about this a while ago=2E Holding (or s=
pinning) on INT 3 has a lot of nice properties, e=2Eg=2E no need to emulate=
 instructions=2E However, there were concerns about deadlocks=2E I proposed=
 an algorithm which I *believe* addressed the deadlocks, but obviously when=
 it comes to deadlock avoidance one pair of eyeballs is not enough=2E

My flight is about to take off so I can't look up the email thread right n=
ow, unfortunately=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
