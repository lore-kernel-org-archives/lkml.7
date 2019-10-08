Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55262C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2682D20815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o6Nw29ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:29:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfJHO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:29:32 -0400
Received: from zn.tnic (p200300EC2F0B5100B1AE7F6CCC5C3495.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5100:b1ae:7f6c:cc5c:3495])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C492C1EC0716;
        Tue,  8 Oct 2019 16:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570544970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9PJBBSCRdNjF8VxwfgzjbBJn0bf1aZWuK6L0d+VB2mg=;
        b=o6Nw29ctnTHW194qsV5qKF957t/AbcVrtIhq1J/+Po158QASa7d17VL/wU5mNc/6+zGk4O
        Nnm1QyNpKKTOj2k48Joqt/FPNSNvETWZr+zl0WHEX5DJaz6oTTCyiMWszM8S81nfoWEmMM
        pwANodob+6eoUIBFqeReisNw45AeyR4=
Date:   Tue, 8 Oct 2019 16:29:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191008142924.GE14765@zn.tnic>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.88332264.2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007081944.88332264.2@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:17:17AM +0200, Peter Zijlstra wrote:
> In preparation for static_call and variable size jump_label support,
> teach text_poke_bp() to emulate instructions, namely:
> 
>   JMP32, JMP8, CALL, NOP2, NOP_ATOMIC5, INT3
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

...

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

You probably should switch those to have the name prefix come first and
make them even shorter:

OPCODE_CALL
INSN_SIZE_CALL
OPCODE_JMP32
INSN_SIZE_JMP32
OPCODE_JMP8
...

This way you have the opcodes prefixed with OPCODE_ and the insn sizes
with INSN_SIZE_. I.e., what they actually are.

> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c

...

> @@ -1027,9 +1046,9 @@ NOKPROBE_SYMBOL(poke_int3_handler);
>   */
>  void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
>  {
> -	int patched_all_but_first = 0;
> -	unsigned char int3 = 0xcc;
> +	unsigned char int3 = INT3_INSN_OPCODE;
>  	unsigned int i;
> +	int do_sync;
>  
>  	lockdep_assert_held(&text_mutex);
>  
> @@ -1053,16 +1072,16 @@ void text_poke_bp_batch(struct text_poke
>  	/*
>  	 * Second step: update all but the first byte of the patched range.
>  	 */
> -	for (i = 0; i < nr_entries; i++) {
> +	for (do_sync = 0, i = 0; i < nr_entries; i++) {
>  		if (tp[i].len - sizeof(int3) > 0) {
>  			text_poke((char *)tp[i].addr + sizeof(int3),
> -				  (const char *)tp[i].opcode + sizeof(int3),
> +				  (const char *)tp[i].text + sizeof(int3),
>  				  tp[i].len - sizeof(int3));
> -			patched_all_but_first++;
> +			do_sync++;
>  		}
>  	}
>  
> -	if (patched_all_but_first) {
> +	if (do_sync) {
>  		/*
>  		 * According to Intel, this core syncing is very likely
>  		 * not necessary and we'd be safe even without it. But
> @@ -1075,10 +1094,17 @@ void text_poke_bp_batch(struct text_poke
>  	 * Third step: replace the first byte (int3) by the first byte of
>  	 * replacing opcode.
>  	 */
> -	for (i = 0; i < nr_entries; i++)
> -		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
> +	for (do_sync = 0, i = 0; i < nr_entries; i++) {

Can we have the do_sync reset outside of the loop?

> +		if (tp[i].text[0] == INT3_INSN_OPCODE)
> +			continue;

I'm guessing we preset the 0th byte to 0xcc somewhere.... I just can't
seem to find it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
