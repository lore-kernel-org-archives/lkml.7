Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB1AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE32821721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570515838;
	bh=PayrCHJ6CKuHB2m91W2g2LTibcXFRhuTXyq+S9WBkso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ARBsPIf8pzWOrpH18U8Pp2gk6fxeH8bVjPC4a12dd0yu6r2vncpdiafPF2DaVZLSR
	 rP8Os61bKlJnJ46+7g+Wwgp0eZ9LOqAF9ve39wuDZwDn3Ouuhm+CYHF5ET9U4Q0rwf
	 AQoYnyH7sw56K+dbeCn2m4N1rFpZOYtqQXQDGs4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfJHGX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbfJHGX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:23:57 -0400
Received: from devnote2 (p242255-mobac01.tokyo.ocn.ne.jp [153.233.233.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA89A2067B;
        Tue,  8 Oct 2019 06:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570515836;
        bh=PayrCHJ6CKuHB2m91W2g2LTibcXFRhuTXyq+S9WBkso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q+12F1sRbVzll3Ypj2wVEICidH0pHPDXP8OwXl6po3GFTh654woFP3oNupLsFzbEF
         2/vgr+VvR1xtrAzCQn3QRVAOCvqIy8nLlrecX2ESy1rVn2mq3ql2Tv92wM7Y41Q4Zt
         MTaqSS54tXu3TCUxTHt+T4VpqMmBHmY00EIg1Nu0=
Date:   Tue, 8 Oct 2019 15:23:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 4/6] x86/alternatives: Add and use text_gen_insn()
 helper
Message-Id: <20191008152349.293e77b5315acf42f6e607ec@kernel.org>
In-Reply-To: <20191007081945.05309765.9@infradead.org>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.05309765.9@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019 10:17:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Provide a simple helper function to create common instruction
> encodings.

Thanks for using correct INSN_OPCODE:)
This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/text-patching.h |    2 +
>  arch/x86/kernel/alternative.c        |   36 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/jump_label.c         |   31 ++++++++++--------------------
>  arch/x86/kernel/kprobes/opt.c        |    7 ------
>  4 files changed, 50 insertions(+), 26 deletions(-)
> 
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -49,6 +49,8 @@ extern void text_poke_bp(void *addr, con
>  extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
>  extern void text_poke_finish(void);
>  
> +extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
> +
>  extern int after_bootmem;
>  extern __ro_after_init struct mm_struct *poking_mm;
>  extern __ro_after_init unsigned long poking_addr;
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1237,3 +1237,39 @@ void text_poke_bp(void *addr, const void
>  	text_poke_loc_init(&tp, addr, opcode, len, emulate);
>  	text_poke_bp_batch(&tp, 1);
>  }
> +
> +union text_poke_insn {
> +	u8 text[POKE_MAX_OPCODE_SIZE];
> +	struct {
> +		u8 opcode;
> +		s32 disp;
> +	} __attribute__((packed));
> +};
> +
> +void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
> +{
> +	static union text_poke_insn insn; /* text_mutex */
> +	int size = 0;
> +
> +	lockdep_assert_held(&text_mutex);
> +
> +	insn.opcode = opcode;
> +
> +#define __CASE(insn)	\
> +	case insn##_INSN_OPCODE: size = insn##_INSN_SIZE; break
> +
> +	switch(opcode) {
> +	__CASE(INT3);
> +	__CASE(CALL);
> +	__CASE(JMP32);
> +	__CASE(JMP8);
> +	}
> +
> +	if (size > 1) {
> +		insn.disp = (long)dest - (long)(addr + size);
> +		if (size == 2)
> +			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
> +	}
> +
> +	return &insn.text;
> +}
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -16,15 +16,7 @@
>  #include <asm/alternative.h>
>  #include <asm/text-patching.h>
>  
> -union jump_code_union {
> -	char code[JUMP_LABEL_NOP_SIZE];
> -	struct {
> -		char jump;
> -		int offset;
> -	} __attribute__((packed));
> -};
> -
> -static void bug_at(unsigned char *ip, int line)
> +static void bug_at(const void *ip, int line)
>  {
>  	/*
>  	 * The location is not an op that we were expecting.
> @@ -38,33 +30,32 @@ static void bug_at(unsigned char *ip, in
>  static const void *
>  __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
>  {
> -	static union jump_code_union code; /* relies on text_mutex */
>  	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>  	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
> -	const void *expect;
> +	const void *expect, *code;
> +	const void *addr, *dest;
>  	int line;
>  
> -	lockdep_assert_held(&text_mutex);
> +	addr = (void *)jump_entry_code(entry);
> +	dest = (void *)jump_entry_target(entry);
>  
> -	code.jump = JMP32_INSN_OPCODE;
> -	code.offset = jump_entry_target(entry) -
> -		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> +	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
>  
>  	if (init) {
>  		expect = default_nop; line = __LINE__;
>  	} else if (type == JUMP_LABEL_JMP) {
>  		expect = ideal_nop; line = __LINE__;
>  	} else {
> -		expect = code.code; line = __LINE__;
> +		expect = code; line = __LINE__;
>  	}
>  
> -	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
> -		bug_at((void *)jump_entry_code(entry), line);
> +	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
> +		bug_at(addr, line);
>  
>  	if (type == JUMP_LABEL_NOP)
> -		memcpy(&code, ideal_nop, JUMP_LABEL_NOP_SIZE);
> +		code = ideal_nop;
>  
> -	return &code;
> +	return code;
>  }
>  
>  static void inline __jump_label_transform(struct jump_entry *entry,
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -447,18 +447,13 @@ void arch_optimize_kprobes(struct list_h
>  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>  {
>  	u8 insn_buff[RELATIVEJUMP_SIZE];
> -	u8 emulate_buff[RELATIVEJUMP_SIZE];
>  
>  	/* Set int3 to first byte for kprobes */
>  	insn_buff[0] = BREAKPOINT_INSTRUCTION;
>  	memcpy(insn_buff + 1, op->optinsn.copied_insn, RELATIVE_ADDR_SIZE);
>  
> -	emulate_buff[0] = RELATIVEJUMP_OPCODE;
> -	*(s32 *)(&emulate_buff[1]) = (s32)((long)op->optinsn.insn -
> -			((long)op->kp.addr + RELATIVEJUMP_SIZE));
> -
>  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> -		     emulate_buff);
> +		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
>  }
>  
>  /*
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
