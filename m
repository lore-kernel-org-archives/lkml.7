Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE71C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA34222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570081835;
	bh=6T2e2TjTHSSml1XeWQNSrWSeNqXmR9n+AsNJOgsDu6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oboGoDVtqCAonVp78VfQEsE1LU2Wld9BuRiQtlEfpHn+4QJM2GwWplJGdn7FXrItM
	 M+gdkmixlf4Gpu1dtUVgZmydfCQiqkcp0OflCk1g8Tkfn70/xjh37hvgh6LIJx1DOB
	 QKfTpAMEixSNg2ayEVp0iX4Oj6R8uU0NsImTGNOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfJCFue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbfJCFue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:50:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D9B21D81;
        Thu,  3 Oct 2019 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570081833;
        bh=6T2e2TjTHSSml1XeWQNSrWSeNqXmR9n+AsNJOgsDu6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hH6Qs7ckxIoVPIYV8LK4oqk7plK5oE8+XUYvuXtElatVqcEUnvAiAX3Wh7MLFraHr
         CmiSVFnqim9H/jlHTIpfyNveSuNg3iHgafZ2MwlDTT1YjYqxlB/eCIV11BpN2YQ1v/
         Wvk6yDYAblhXF8qXbQMW/I/9z2TlFCgoym50tSHQ=
Date:   Thu, 3 Oct 2019 14:50:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/3] x86/alternatives,jump_label: Provide better
 text_poke() batching interface
Message-Id: <20191003145028.43cd15c66729a168c4700d36@kernel.org>
In-Reply-To: <20190827181147.110246515@infradead.org>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.110246515@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 27 Aug 2019 20:06:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Adding another text_poke_bp_batch() user made me realize the interface
> is all sorts of wrong. The text poke vector should be internal to the
> implementation.
> 
> This then results in a trivial interface:
> 
>   text_poke_queue()  - which has the 'normal' text_poke_bp() interface
>   text_poke_finish() - which takes no arguments and flushes any
>                        pending text_poke()s.

Looks good to me. Maybe it is easy to apply to optprobe too.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/text-patching.h |   16 ++-----
>  arch/x86/kernel/alternative.c        |   64 +++++++++++++++++++++++++---
>  arch/x86/kernel/jump_label.c         |   80 +++++++++--------------------------
>  3 files changed, 84 insertions(+), 76 deletions(-)
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -25,14 +25,6 @@ static inline void apply_paravirt(struct
>   */
>  #define POKE_MAX_OPCODE_SIZE	5
>  
> -struct text_poke_loc {
> -	void *addr;
> -	int len;
> -	s32 rel32;
> -	u8 opcode;
> -	const char text[POKE_MAX_OPCODE_SIZE];
> -};
> -
>  extern void text_poke_early(void *addr, const void *opcode, size_t len);
>  
>  /*
> @@ -53,13 +45,15 @@ extern void *text_poke(void *addr, const
>  extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
> -extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
> -extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
> -			       const void *opcode, size_t len, const void *emulate);
> +
> +extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
> +extern void text_poke_finish(void);
> +
>  extern int after_bootmem;
>  extern __ro_after_init struct mm_struct *poking_mm;
>  extern __ro_after_init unsigned long poking_addr;
>  
> +
>  #ifndef CONFIG_UML_X86
>  static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
>  {
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -936,6 +936,14 @@ static void do_sync_core(void *info)
>  	sync_core();
>  }
>  
> +struct text_poke_loc {
> +	void *addr;
> +	int len;
> +	s32 rel32;
> +	u8 opcode;
> +	const char text[POKE_MAX_OPCODE_SIZE];
> +};
> +
>  static struct bp_patching_desc {
>  	struct text_poke_loc *vec;
>  	int nr_entries;
> @@ -1017,6 +1025,10 @@ int poke_int3_handler(struct pt_regs *re
>  }
>  NOKPROBE_SYMBOL(poke_int3_handler);
>  
> +#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
> +static struct text_poke_loc tp_vec[TP_VEC_MAX];
> +static int tp_vec_nr;
> +
>  /**
>   * text_poke_bp_batch() -- update instructions on live kernel on SMP
>   * @tp:			vector of instructions to patch
> @@ -1038,7 +1050,7 @@ NOKPROBE_SYMBOL(poke_int3_handler);
>   *		  replacing opcode
>   *	- sync cores
>   */
> -void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> +static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  {
>  	unsigned char int3 = INT3_INSN_OPCODE;
>  	int patched_all_but_first = 0;
> @@ -1105,11 +1117,7 @@ void text_poke_loc_init(struct text_poke
>  {
>  	struct insn insn;
>  
> -	if (!opcode)
> -		opcode = (void *)tp->text;
> -	else
> -		memcpy((void *)tp->text, opcode, len);
> -
> +	memcpy((void *)tp->text, opcode, len);
>  	if (!emulate)
>  		emulate = opcode;
>  
> @@ -1147,6 +1155,50 @@ void text_poke_loc_init(struct text_poke
>  	}
>  }
>  
> +/*
> + * We hard rely on the tp_vec being ordered; ensure this is so by flushing
> + * early if needed.
> + */
> +static bool tp_order_fail(void *addr)
> +{
> +	struct text_poke_loc *tp;
> +
> +	if (!tp_vec_nr)
> +		return false;
> +
> +	if (!addr) /* force */
> +		return true;
> +
> +	tp = &tp_vec[tp_vec_nr - 1];
> +	if ((unsigned long)tp->addr > (unsigned long)addr)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void text_poke_flush(void *addr)
> +{
> +	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
> +		text_poke_bp_batch(tp_vec, tp_vec_nr);
> +		tp_vec_nr = 0;
> +	}
> +}
> +
> +void text_poke_finish(void)
> +{
> +	text_poke_flush(NULL);
> +}
> +
> +void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate)
> +{
> +	struct text_poke_loc *tp;
> +
> +	text_poke_flush(addr);
> +
> +	tp = &tp_vec[tp_vec_nr++];
> +	text_poke_loc_init(tp, addr, opcode, len, emulate);
> +}
> +
>  /**
>   * text_poke_bp() -- update instructions on live kernel on SMP
>   * @addr:	address to patch
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, in
>  	BUG();
>  }
>  
> -static void __jump_label_set_jump_code(struct jump_entry *entry,
> -				       enum jump_label_type type,
> -				       union jump_code_union *code,
> -				       int init)
> +static const void *
> +__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
>  {
> +	static union jump_code_union code; /* relies on text_mutex */
>  	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>  	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
>  	const void *expect;
>  	int line;
>  
> -	code->jump = 0xe9;
> -	code->offset = jump_entry_target(entry) -
> +	lockdep_assert_held(&text_mutex);
> +
> +	code.jump = JMP32_INSN_OPCODE;
> +	code.offset = jump_entry_target(entry) -
>  		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>  
>  	if (init) {
> @@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(s
>  	} else if (type == JUMP_LABEL_JMP) {
>  		expect = ideal_nop; line = __LINE__;
>  	} else {
> -		expect = code->code; line = __LINE__;
> +		expect = code.code; line = __LINE__;
>  	}
>  
>  	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
>  		bug_at((void *)jump_entry_code(entry), line);
>  
>  	if (type == JUMP_LABEL_NOP)
> -		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
> +		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
> +
> +	return &code;
>  }
>  
>  static void __ref __jump_label_transform(struct jump_entry *entry,
>  					 enum jump_label_type type,
>  					 int init)
>  {
> -	union jump_code_union code;
> -
> -	__jump_label_set_jump_code(entry, type, &code, init);
> +	const void *opcode = __jump_label_set_jump_code(entry, type, init);
>  
>  	/*
>  	 * As long as only a single processor is running and the code is still
> @@ -84,12 +85,12 @@ static void __ref __jump_label_transform
>  	 * always nop being the 'currently valid' instruction
>  	 */
>  	if (init || system_state == SYSTEM_BOOTING) {
> -		text_poke_early((void *)jump_entry_code(entry), &code,
> +		text_poke_early((void *)jump_entry_code(entry), opcode,
>  				JUMP_LABEL_NOP_SIZE);
>  		return;
>  	}
>  
> -	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
> +	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
>  }
>  
>  void arch_jump_label_transform(struct jump_entry *entry,
> @@ -100,15 +101,10 @@ void arch_jump_label_transform(struct ju
>  	mutex_unlock(&text_mutex);
>  }
>  
> -#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_loc))
> -static struct text_poke_loc tp_vec[TP_VEC_MAX];
> -static int tp_vec_nr;
> -
>  bool arch_jump_label_transform_queue(struct jump_entry *entry,
>  				     enum jump_label_type type)
>  {
> -	struct text_poke_loc *tp;
> -	void *entry_code;
> +	const void *opcode;
>  
>  	if (system_state == SYSTEM_BOOTING) {
>  		/*
> @@ -118,53 +114,19 @@ bool arch_jump_label_transform_queue(str
>  		return true;
>  	}
>  
> -	/*
> -	 * No more space in the vector, tell upper layer to apply
> -	 * the queue before continuing.
> -	 */
> -	if (tp_vec_nr == TP_VEC_MAX)
> -		return false;
> -
> -	tp = &tp_vec[tp_vec_nr];
> -
> -	entry_code = (void *)jump_entry_code(entry);
> -
> -	/*
> -	 * The INT3 handler will do a bsearch in the queue, so we need entries
> -	 * to be sorted. We can survive an unsorted list by rejecting the entry,
> -	 * forcing the generic jump_label code to apply the queue. Warning once,
> -	 * to raise the attention to the case of an unsorted entry that is
> -	 * better not happen, because, in the worst case we will perform in the
> -	 * same way as we do without batching - with some more overhead.
> -	 */
> -	if (tp_vec_nr > 0) {
> -		int prev = tp_vec_nr - 1;
> -		struct text_poke_loc *prev_tp = &tp_vec[prev];
> -
> -		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
> -			return false;
> -	}
> -
> -	__jump_label_set_jump_code(entry, type,
> -				   (union jump_code_union *)&tp->text, 0);
> -
> -	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
> -
> -	tp_vec_nr++;
> -
> +	mutex_lock(&text_mutex);
> +	opcode = __jump_label_set_jump_code(entry, type, 0);
> +	text_poke_queue((void *)jump_entry_code(entry),
> +			opcode, JUMP_LABEL_NOP_SIZE, NULL);
> +	mutex_unlock(&text_mutex);
>  	return true;
>  }
>  
>  void arch_jump_label_transform_apply(void)
>  {
> -	if (!tp_vec_nr)
> -		return;
> -
>  	mutex_lock(&text_mutex);
> -	text_poke_bp_batch(tp_vec, tp_vec_nr);
> +	text_poke_finish();
>  	mutex_unlock(&text_mutex);
> -
> -	tp_vec_nr = 0;
>  }
>  
>  static enum {
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
