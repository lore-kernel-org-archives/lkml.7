Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA555C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3A2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570078857;
	bh=njtu0OkOzNBPk2ukjq+D+AXlJWPLLwB5dM0rxH8u1JI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZPzUCz23rrUi7kBtmMdc+wFmsRLqodXSgJsqDSGMQio5PJr6hqMfXczbFUkh2tvb0
	 H7ZJYs27acas/OrhMjGBaeFJASV0baU8OsuxlOkah+1+KG3mmAsVzjFL/Fazu+c5yI
	 Q898Vg67rRkeLtmMMDI4a1895cB2FSLYiX6oqvrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfJCFA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJCFA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:00:56 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5548921D81;
        Thu,  3 Oct 2019 05:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570078854;
        bh=njtu0OkOzNBPk2ukjq+D+AXlJWPLLwB5dM0rxH8u1JI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tA4R2S4OTMzp5gKbi8UnwWz4QMp7vaStoYKcpCHG0WtRxfaazDu1XwWlqkrQ8AaNu
         As2VJ0tOWz83dWfyODuixhV02/RDBU3N2SSIroITz6oROkwDyBh771T2sM4f6FX44b
         oI3rSxoodGjaePY1YpxPkzSYuWK9eMWAm9FsaNCw=
Date:   Thu, 3 Oct 2019 14:00:50 +0900
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
Subject: Re: [PATCH 1/3] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-Id: <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
In-Reply-To: <20190827181147.053490768@infradead.org>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.053490768@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 27 Aug 2019 20:06:23 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> In preparation for static_call and variable size jump_label support,
> teach text_poke_bp() to emulate instructions, namely:
> 
>   JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5
> 
> The current text_poke_bp() takes a @handler argument which is used as
> a jump target when the temporary INT3 is hit by a different CPU.
> 
> When patching CALL instructions, this doesn't work because we'd miss
> the PUSH of the return address. Instead, teach poke_int3_handler() to
> emulate an instruction, typically the instruction we're patching in.
> 
> This fits almost all text_poke_bp() users, except
> arch_unoptimize_kprobe() which restores random text, and for that site
> we have to build an explicit emulate instruction.

OK, and in this case, I would like to change RELATIVEJUMP_OPCODE
to JMP32_INSN_OPCODE for readability. (or at least
making RELATIVEJUMP_OPCODE as an alias of JMP32_INSN_OPCODE)

Except for that, this looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/text-patching.h |   24 ++++++--
>  arch/x86/kernel/alternative.c        |   98 ++++++++++++++++++++++++++---------
>  arch/x86/kernel/jump_label.c         |    9 +--
>  arch/x86/kernel/kprobes/opt.c        |   11 ++-
>  4 files changed, 103 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -26,10 +26,11 @@ static inline void apply_paravirt(struct
>  #define POKE_MAX_OPCODE_SIZE	5
>  
>  struct text_poke_loc {
> -	void *detour;
>  	void *addr;
> -	size_t len;
> -	const char opcode[POKE_MAX_OPCODE_SIZE];
> +	int len;
> +	s32 rel32;
> +	u8 opcode;
> +	const char text[POKE_MAX_OPCODE_SIZE];
>  };
>  
>  extern void text_poke_early(void *addr, const void *opcode, size_t len);
> @@ -51,8 +52,10 @@ extern void text_poke_early(void *addr,
>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
> -extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
> +extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
>  extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
> +extern void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
> +			       const void *opcode, size_t len, const void *emulate);
>  extern int after_bootmem;
>  extern __ro_after_init struct mm_struct *poking_mm;
>  extern __ro_after_init unsigned long poking_addr;
> @@ -63,8 +66,17 @@ static inline void int3_emulate_jmp(stru
>  	regs->ip = ip;
>  }
>  
> -#define INT3_INSN_SIZE 1
> -#define CALL_INSN_SIZE 5
> +#define INT3_INSN_SIZE		1
> +#define INT3_INSN_OPCODE	0xCC
> +
> +#define CALL_INSN_SIZE		5
> +#define CALL_INSN_OPCODE	0xE8
> +
> +#define JMP32_INSN_SIZE		5
> +#define JMP32_INSN_OPCODE	0xE9
> +
> +#define JMP8_INSN_SIZE		2
> +#define JMP8_INSN_OPCODE	0xEB
>  
>  static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
>  {
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -956,16 +956,15 @@ NOKPROBE_SYMBOL(patch_cmp);
>  int poke_int3_handler(struct pt_regs *regs)
>  {
>  	struct text_poke_loc *tp;
> -	unsigned char int3 = 0xcc;
>  	void *ip;
>  
>  	/*
>  	 * Having observed our INT3 instruction, we now must observe
>  	 * bp_patching.nr_entries.
>  	 *
> -	 * 	nr_entries != 0			INT3
> -	 * 	WMB				RMB
> -	 * 	write INT3			if (nr_entries)
> +	 *	nr_entries != 0			INT3
> +	 *	WMB				RMB
> +	 *	write INT3			if (nr_entries)
>  	 *
>  	 * Idem for other elements in bp_patching.
>  	 */
> @@ -978,9 +977,9 @@ int poke_int3_handler(struct pt_regs *re
>  		return 0;
>  
>  	/*
> -	 * Discount the sizeof(int3). See text_poke_bp_batch().
> +	 * Discount the INT3. See text_poke_bp_batch().
>  	 */
> -	ip = (void *) regs->ip - sizeof(int3);
> +	ip = (void *) regs->ip - INT3_INSN_SIZE;
>  
>  	/*
>  	 * Skip the binary search if there is a single member in the vector.
> @@ -997,8 +996,22 @@ int poke_int3_handler(struct pt_regs *re
>  			return 0;
>  	}
>  
> -	/* set up the specified breakpoint detour */
> -	regs->ip = (unsigned long) tp->detour;
> +	ip += tp->len;
> +
> +	switch (tp->opcode) {
> +	case CALL_INSN_OPCODE:
> +		int3_emulate_call(regs, (long)ip + tp->rel32);
> +		break;
> +
> +	case JMP32_INSN_OPCODE:
> +	case JMP8_INSN_OPCODE:
> +		int3_emulate_jmp(regs, (long)ip + tp->rel32);
> +		break;
> +
> +	default: /* nop */
> +		int3_emulate_jmp(regs, (long)ip);
> +		break;
> +	}
>  
>  	return 1;
>  }
> @@ -1027,8 +1040,8 @@ NOKPROBE_SYMBOL(poke_int3_handler);
>   */
>  void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  {
> +	unsigned char int3 = INT3_INSN_OPCODE;
>  	int patched_all_but_first = 0;
> -	unsigned char int3 = 0xcc;
>  	unsigned int i;
>  
>  	lockdep_assert_held(&text_mutex);
> @@ -1056,7 +1069,7 @@ void text_poke_bp_batch(struct text_poke
>  	for (i = 0; i < nr_entries; i++) {
>  		if (tp[i].len - sizeof(int3) > 0) {
>  			text_poke((char *)tp[i].addr + sizeof(int3),
> -				  (const char *)tp[i].opcode + sizeof(int3),
> +				  (const char *)tp[i].text + sizeof(int3),
>  				  tp[i].len - sizeof(int3));
>  			patched_all_but_first++;
>  		}
> @@ -1076,7 +1089,7 @@ void text_poke_bp_batch(struct text_poke
>  	 * replacing opcode.
>  	 */
>  	for (i = 0; i < nr_entries; i++)
> -		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
> +		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
>  
>  	on_each_cpu(do_sync_core, NULL, 1);
>  	/*
> @@ -1087,6 +1100,53 @@ void text_poke_bp_batch(struct text_poke
>  	bp_patching.nr_entries = 0;
>  }
>  
> +void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
> +			const void *opcode, size_t len, const void *emulate)
> +{
> +	struct insn insn;
> +
> +	if (!opcode)
> +		opcode = (void *)tp->text;
> +	else
> +		memcpy((void *)tp->text, opcode, len);
> +
> +	if (!emulate)
> +		emulate = opcode;
> +
> +	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
> +	insn_get_length(&insn);
> +
> +	BUG_ON(!insn_complete(&insn));
> +	BUG_ON(len != insn.length);
> +
> +	tp->addr = addr;
> +	tp->len = len;
> +	tp->opcode = insn.opcode.bytes[0];
> +
> +	switch (tp->opcode) {
> +	case CALL_INSN_OPCODE:
> +	case JMP32_INSN_OPCODE:
> +	case JMP8_INSN_OPCODE:
> +		tp->rel32 = insn.immediate.value;
> +		break;
> +
> +	default: /* assume NOP */
> +		switch (len) {
> +		case 2:
> +			BUG_ON(memcmp(emulate, ideal_nops[len], len));
> +			break;
> +
> +		case 5:
> +			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
> +			break;
> +
> +		default:
> +			BUG();
> +		}
> +		break;
> +	}
> +}
> +
>  /**
>   * text_poke_bp() -- update instructions on live kernel on SMP
>   * @addr:	address to patch
> @@ -1098,20 +1158,10 @@ void text_poke_bp_batch(struct text_poke
>   * dynamically allocated memory. This function should be used when it is
>   * not possible to allocate memory.
>   */
> -void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
> +void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
>  {
> -	struct text_poke_loc tp = {
> -		.detour = handler,
> -		.addr = addr,
> -		.len = len,
> -	};
> -
> -	if (len > POKE_MAX_OPCODE_SIZE) {
> -		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
> -		return;
> -	}
> -
> -	memcpy((void *)tp.opcode, opcode, len);
> +	struct text_poke_loc tp;
>  
> +	text_poke_loc_init(&tp, addr, opcode, len, emulate);
>  	text_poke_bp_batch(&tp, 1);
>  }
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -89,8 +89,7 @@ static void __ref __jump_label_transform
>  		return;
>  	}
>  
> -	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
> -		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> +	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE, NULL);
>  }
>  
>  void arch_jump_label_transform(struct jump_entry *entry,
> @@ -147,11 +146,9 @@ bool arch_jump_label_transform_queue(str
>  	}
>  
>  	__jump_label_set_jump_code(entry, type,
> -				   (union jump_code_union *) &tp->opcode, 0);
> +				   (union jump_code_union *)&tp->text, 0);
>  
> -	tp->addr = entry_code;
> -	tp->detour = entry_code + JUMP_LABEL_NOP_SIZE;
> -	tp->len = JUMP_LABEL_NOP_SIZE;
> +	text_poke_loc_init(tp, entry_code, NULL, JUMP_LABEL_NOP_SIZE, NULL);
>  
>  	tp_vec_nr++;
>  
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -437,8 +437,7 @@ void arch_optimize_kprobes(struct list_h
>  		insn_buff[0] = RELATIVEJUMP_OPCODE;
>  		*(s32 *)(&insn_buff[1]) = rel;
>  
> -		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> -			     op->optinsn.insn);
> +		text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE, NULL);
>  
>  		list_del_init(&op->list);
>  	}
> @@ -448,12 +447,18 @@ void arch_optimize_kprobes(struct list_h
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
>  	u8 insn_buff[RELATIVEJUMP_SIZE];
> +	u8 emulate_buff[RELATIVEJUMP_SIZE];
>  
>  	/* Set int3 to first byte for kprobes */
>  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
>  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
> +
> +	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> +	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> +			((long)op->kp.addr + RELATIVEJUMP_SIZE));
> +
>  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> -		     op->optinsn.insn);
> +		     emulate_buff);
>  }
>  
>  /*
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
