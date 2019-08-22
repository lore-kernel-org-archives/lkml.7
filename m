Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F2CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03FB23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392463AbfHVUDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732184AbfHVUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB34910F23E5;
        Thu, 22 Aug 2019 20:03:50 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACA9160603;
        Thu, 22 Aug 2019 20:03:49 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:03:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 06/18] objtool: arm64: Adapt the stack frame checks for
 arm architecture
Message-ID: <20190822200347.hmgvyeersdyqtcxh@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-7-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-7-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 20:03:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:51PM +0100, Raphael Gault wrote:
> diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
> index 395c5777afab..be3d2eb10227 100644
> --- a/tools/objtool/arch/arm64/decode.c
> +++ b/tools/objtool/arch/arm64/decode.c
> @@ -106,6 +106,34 @@ unsigned long arch_dest_rela_offset(int addend)
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
> +		prev = list_entry(l, struct instruction, list);
> +		if (!prev->func ||
> +		    prev->func->pfunc != insn->func->pfunc)
> +			return false;
> +		if (prev->stack_op.src.reg != ADR_SOURCE)
> +			continue;
> +		sym = find_symbol_containing(insn->sec, insn->immediate);
> +		if (!sym || sym->type != STT_FUNC)
> +			return false;
> +		else if (sym->type == STT_FUNC)
> +			return true;
> +		break;
> +	}
> +	return false;
> +}

As Peter said, going backwards is going to be fragile:

  https://lkml.kernel.org/r/20190425083320.GK4038@hirez.programming.kicks-ass.net

Now that there's the GCC plugin for annotating switch tables, can we use
information from the plugin to distinguish sibling calls from switch
tables?

Or if that doesn't work for some reason, you may need some logic in
validate_branch() to do the above properly.

> +++ b/tools/objtool/arch/x86/decode.c
> @@ -72,6 +72,11 @@ unsigned long arch_dest_rela_offset(int addend)
>  	return addend + 4;
>  }
>  
> +bool arch_is_insn_sibling_call(struct instruction *insn)
> +{
> +	return true;
> +}
> +

The semantics still aren't right -- not all instructions are sibling
calls on x86.

>  int arch_decode_instruction(struct elf *elf, struct section *sec,
>  			    unsigned long offset, unsigned int maxlen,
>  			    unsigned int *len, enum insn_type *type,
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4af6422d3428..519569b0329f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -566,10 +566,10 @@ static int add_jump_destinations(struct objtool_file *file)
>  			dest_off = arch_jump_destination(insn);
>  		} else if (rela->sym->type == STT_SECTION) {
>  			dest_sec = rela->sym->sec;
> -			dest_off = rela->addend + 4;
> +			dest_off = arch_dest_rela_offset(rela->addend);
>  		} else if (rela->sym->sec->idx) {
>  			dest_sec = rela->sym->sec;
> -			dest_off = rela->sym->sym.st_value + rela->addend + 4;
> +			dest_off = rela->sym->sym.st_value + arch_dest_rela_offset(rela->addend);

These changes should be in patch 1.

>  		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
>  			/*
>  			 * Retpoline jumps are really dynamic jumps in
> @@ -1368,8 +1368,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
>  
>  static void restore_reg(struct insn_state *state, unsigned char reg)
>  {
> -	state->regs[reg].base = CFI_UNDEFINED;
> -	state->regs[reg].offset = 0;
> +	state->regs[reg].base = initial_func_cfi.regs[reg].base;
> +	state->regs[reg].offset = initial_func_cfi.regs[reg].offset;
>  }
>  
>  /*
> @@ -1525,8 +1525,32 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  
>  				/* add imm, %rsp */
>  				state->stack_size -= op->src.offset;
> -				if (cfa->base == CFI_SP)
> +				if (cfa->base == CFI_SP) {
>  					cfa->offset -= op->src.offset;
> +					if (state->stack_size == 0 &&
> +					    initial_func_cfi.cfa.base == CFI_CFA) {
> +						cfa->base = CFI_CFA;
> +						cfa->offset = 0;
> +					}
> +				}
> +				/*
> +				 * on arm64 the save/restore of sp into fp is not automatic
> +				 * and the first one can be done without the other so we
> +				 * need to be careful not to invalidate the stack frame in such
> +				 * cases.
> +				 */
> +				else if (cfa->base == CFI_BP) {
> +					if (state->stack_size == 0 &&
> +					    initial_func_cfi.cfa.base == CFI_CFA) {
> +						cfa->base = CFI_CFA;
> +						cfa->offset = 0;
> +						restore_reg(state, CFI_BP);
> +					}
> +				} else if (cfa->base == CFI_CFA) {
> +					cfa->base = CFI_SP;
> +					if (state->stack_size >= 16)
> +						cfa->offset = 16;
> +				}
>  				break;
>  			}
>  
> @@ -1537,6 +1561,15 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  				break;
>  			}
>  
> +			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
> +			    cfa->base == CFI_SP &&
> +			    regs[CFI_BP].base == CFI_CFA &&
> +			    regs[CFI_BP].offset == -cfa->offset) {
> +				/* mov %rsp, %rbp */
> +				cfa->base = op->dest.reg;
> +				state->bp_scratch = false;
> +				break;
> +			}
>  			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
>  
>  				/* drap: lea disp(%rsp), %drap */
> @@ -1629,6 +1662,22 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  			state->stack_size -= 8;
>  			if (cfa->base == CFI_SP)
>  				cfa->offset -= 8;
> +			if (cfa->base == CFI_SP &&
> +			    cfa->offset == 0 &&
> +			    initial_func_cfi.cfa.base == CFI_CFA)
> +				cfa->base = CFI_CFA;
> +
> +			if (op->extra.used) {
> +				if (regs[op->extra.reg].offset == -state->stack_size)
> +					restore_reg(state, op->extra.reg);
> +				state->stack_size -= 8;
> +				if (cfa->base == CFI_SP)
> +					cfa->offset -= 8;
> +				if (cfa->base == CFI_SP &&
> +				    cfa->offset == 0 &&
> +				    initial_func_cfi.cfa.base == CFI_CFA)
> +					cfa->base = CFI_CFA;
> +			}
>  
>  			break;
>  
> @@ -1648,12 +1697,22 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  				/* drap: mov disp(%rbp), %reg */
>  				restore_reg(state, op->dest.reg);
>  
> +				if (op->extra.used &&
> +				    op->src.reg == CFI_BP &&
> +				    op->extra.offset == regs[op->extra.reg].offset)
> +					restore_reg(state, op->extra.reg);
> +
>  			} else if (op->src.reg == cfa->base &&
>  			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
>  
>  				/* mov disp(%rbp), %reg */
>  				/* mov disp(%rsp), %reg */
>  				restore_reg(state, op->dest.reg);
> +
> +				if (op->extra.used &&
> +				    op->src.reg == cfa->base &&
> +				    op->extra.offset == regs[op->extra.reg].offset + cfa->offset)
> +					restore_reg(state, op->extra.reg);
>  			}
>  
>  			break;
> @@ -1669,6 +1728,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  	case OP_DEST_PUSH:
>  	case OP_DEST_PUSHF:
>  		state->stack_size += 8;
> +		if (cfa->base == CFI_CFA)
> +			cfa->base = CFI_SP;
>  		if (cfa->base == CFI_SP)
>  			cfa->offset += 8;
>  
> @@ -1702,6 +1763,21 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  			save_reg(state, op->src.reg, CFI_CFA, -state->stack_size);
>  		}
>  
> +		if (op->extra.used) {
> +			state->stack_size += 8;
> +			if (cfa->base == CFI_CFA)
> +				cfa->base = CFI_SP;
> +			if (cfa->base == CFI_SP)
> +				cfa->offset += 8;
> +			if (!state->drap ||
> +			    (!(op->extra.reg == cfa->base &&
> +			       op->extra.reg == state->drap_reg) &&
> +			     !(op->extra.reg == CFI_BP &&
> +			       cfa->base == state->drap_reg) &&
> +			     regs[op->extra.reg].base == CFI_UNDEFINED))
> +			save_reg(state, op->extra.reg, CFI_CFA,
> +				 -state->stack_size);
> +		}
>  		/* detect when asm code uses rbp as a scratch register */
>  		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
>  		    cfa->base != CFI_BP)
> @@ -1720,11 +1796,19 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  				/* save drap offset so we know when to restore it */
>  				state->drap_offset = op->dest.offset;
>  			}
> +			if (op->extra.used && op->extra.reg == cfa->base &&
> +			    op->extra.reg == state->drap_reg) {
> +				cfa->base = CFI_BP_INDIRECT;
> +				cfa->offset = op->extra.offset;
> +			}
>  
>  			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
>  
>  				/* drap: mov reg, disp(%rbp) */
>  				save_reg(state, op->src.reg, CFI_BP, op->dest.offset);
> +				if (op->extra.used)
> +					save_reg(state, op->extra.reg, CFI_BP,
> +						 op->extra.offset);
>  			}
>  
>  		} else if (op->dest.reg == cfa->base) {
> @@ -1733,8 +1817,12 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  			/* mov reg, disp(%rsp) */
>  			save_reg(state, op->src.reg, CFI_CFA,
>  				 op->dest.offset - state->cfa.offset);
> +			if (op->extra.used)
> +				save_reg(state, op->extra.reg, CFI_CFA,
> +					 op->extra.offset - state->cfa.offset);
>  		}
>  
> +
>  		break;
>  
>  	case OP_DEST_LEAVE:

TBH, all these update_insn_state() changes make me nervous, as this code
was already a bit rickety and magical.  I'll need to review this much
more carefully at some point.

If it would be feasible to split the changes up somehow in separate
patches, with a description behind the reasoning for each change, that
may help a lot.

> @@ -1857,7 +1945,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
>  
>  static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
>  {
> -	if (has_modified_stack_frame(state)) {
> +	if (arch_is_insn_sibling_call(insn) && has_modified_stack_frame(state)) {
>  		WARN_FUNC("sibling call from callable instruction with modified stack frame",
>  				insn->sec, insn->offset);
>  		return 1;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index edba4745f25a..c6ac0b771b73 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -62,7 +62,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>  	struct symbol *sym;
>  
>  	list_for_each_entry(sym, &sec->symbol_list, list)
> -		if (sym->type != STT_SECTION &&
> +		if (sym->type != STT_NOTYPE &&
> +		    sym->type != STT_SECTION &&
>  		    sym->offset == offset)
>  			return sym;

Here's another one that I think belongs in a separate patch.

-- 
Josh
