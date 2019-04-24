Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F4AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20821773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfDXKgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:36:23 -0400
Received: from foss.arm.com ([217.140.101.70]:41278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfDXKgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:36:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4FFFA78;
        Wed, 24 Apr 2019 03:36:22 -0700 (PDT)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0CE03F5AF;
        Wed, 24 Apr 2019 03:36:20 -0700 (PDT)
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
To:     Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <d285770e-0ba1-2812-1a3a-1dd892095722@arm.com>
Date:   Wed, 24 Apr 2019 11:36:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190409135243.12424-4-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphaël,

I think you could split the patch in at least 3:

- Handling the split instructions
- Handling the jump offset
- Dynamic jumps/switch table


On 09/04/2019 14:52, Raphael Gault wrote:
> Since the way the initial stack frame when entering a function is different that what is done

Nit: "different from what is done"

> in the x86_64 architecture, we need to add some more check to support the different cases.
> As opposed as for x86_64, the return address is not stored by the call instruction but is instead
> loaded in a register. The initial stack frame is thus empty when entering a function and 2 push
> operations are needed to set it up correctly. All the different combinations need to be
> taken into account.
> 
> On arm64, the .altinstr_replacement section is not flagged as containing executable instructions
> but we still need to process it.
> 
> Switch tables are alse stored in a different way on arm64 than on x86_64 so we need to be able

Nit: also

> to identify in which case we are when looking for it.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/objtool/arch.h              |  2 +
>  tools/objtool/arch/arm64/decode.c | 27 +++++++++
>  tools/objtool/arch/x86/decode.c   |  5 ++
>  tools/objtool/check.c             | 95 +++++++++++++++++++++++++++----
>  tools/objtool/elf.c               |  3 +-
>  5 files changed, 120 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index 0eff166ca613..f3bef3f2cef3 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -88,4 +88,6 @@ unsigned long arch_compute_jump_destination(struct instruction *insn);
>  
>  unsigned long arch_compute_rela_sym_offset(int addend);
>  
> +bool arch_is_insn_sibling_call(struct instruction *insn);
> +
>  #endif /* _ARCH_H */
> diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
> index 0feb3ae3af5d..8b293eae2b38 100644
> --- a/tools/objtool/arch/arm64/decode.c
> +++ b/tools/objtool/arch/arm64/decode.c
> @@ -105,6 +105,33 @@ unsigned long arch_compute_rela_sym_offset(int addend)
>  	return addend;
>  }
>  
> +/*
> + * In order to know if we are in presence of a sibling
> + * call and not in presence of a switch table we look
> + * back at the previous instructions and see if we are
> + * jumping inside the same function that we are already
> + * in.
> + */
> +bool arch_is_insn_sibling_call(struct instruction *insn)
> +{
> +	struct instruction *prev;
> +	struct list_head *l;
> +	struct symbol *sym;
> +	list_for_each_prev(l, &insn->list) {
> +		prev = (void *)l;

Please use list_entry() instead of casting, this only happens to work
because list is the first member of the struct instruction.

> +		if (!prev->func
> +			|| prev->func->pfunc != insn->func->pfunc)
> +			return false;
> +		if (prev->stack_op.src.reg != ADR_SOURCE)
> +			continue;
> +		sym = find_symbol_containing(insn->sec, insn->immediate);
> +		if (!sym || sym->type != STT_FUNC
> +			|| sym->pfunc != insn->func->pfunc)
> +			return true;
> +		break;
> +	}
> +	return true;
> +}
>  static int is_arm64(struct elf *elf)
>  {
>  	switch(elf->ehdr.e_machine){
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 1af7b4996307..88c3d99c76be 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -85,6 +85,11 @@ unsigned long arch_compute_rela_sym_offset(int addend)
>  	return addend + 4;
>  }
>  
> +bool arch_is_insn_sibling_call(struct instruction *insn)
> +{
> +	return true;

The naming and what the function returns does seem to be really fitting.
Makes it seem like every x86 instruction is a sibling call, which is
unlikely to be the case.

> +}
> +
>  int arch_orc_read_unwind_hints(struct objtool_file *file)
>  {
>  	struct section *sec, *relasec;
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 17fcd8c8f9c1..fa6106214318 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -261,10 +261,12 @@ static int decode_instructions(struct objtool_file *file)
>  	unsigned long offset;
>  	struct instruction *insn;
>  	int ret;
> +	static int composed_insn = 0;
>  
>  	for_each_sec(file, sec) {
>  
> -		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
> +		if (!(sec->sh.sh_flags & SHF_EXECINSTR)
> +			&& (strcmp(sec->name, ".altinstr_replacement") || !IGNORE_SHF_EXEC_FLAG))
>  			continue;
>  
>  		if (strcmp(sec->name, ".altinstr_replacement") &&
> @@ -297,10 +299,22 @@ static int decode_instructions(struct objtool_file *file)
>  				WARN_FUNC("invalid instruction type %d",
>  					  insn->sec, insn->offset, insn->type);
>  				ret = -1;
> -				goto err;
> +				free(insn);
> +				continue;
>  			}
> -
> -			hash_add(file->insn_hash, &insn->hash, insn->offset);
> +			/*
> +			 * For arm64 architecture, we sometime split instructions so that
> +			 * we can track the state evolution (i.e. load/store of pairs of registers).
> +			 * We thus need to take both into account and not erase the previous ones.
> +			 */
> +			if (composed_insn > 0)
> +				hash_add(file->insn_hash, &insn->hash, insn->offset + composed_insn);
> +			else
> +				hash_add(file->insn_hash, &insn->hash, insn->offset);

composed_insn has no reason to be negative, right? So this if is
equivalent to:

	hash_add(file->insn_hash, &insn->hash,
		 insn->offset + composed_insn);


Also, that means that this only works because all arm64 instructions are
4 bytes long. Otherwise you could have an overlap between the "second"
part of the composed instruction and the instruction that follows it.

It feels a bit too hackish for the arch independent code.

If we want to use that trick, maybe it should be the arm64 decode that
should return a length of 1 or 2 for composed insn, and when decoding an
instruction that isn't 4-bytes aligned, we would know to look 2 bytes
before to find what we were decoding, then return (4 - len) so that we
end up on the next instruction on the next itertation.

This way we don't have to change anything to the decode loop.

Also, I've got the impression that this hash table is most often use to
find the instruction at the starting offset of a function. Meaning it is
unlikely we'll end up looking up that composed instruction. Might be
worth checking whether this is the case and if so, maybe we can just add
the one real instruction to the hash table and focus on the instruction
list for our instruction splitting.

> +			if (insn->len == 0)
> +				composed_insn++;
> +			else
> +				composed_insn = 0;
>  			list_add_tail(&insn->list, &file->insn_list);
>  		}
>  

Thanks,

-- 
Julien Thierry
