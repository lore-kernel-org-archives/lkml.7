Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F65C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC25218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfDWUgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:36:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWUgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F82866991;
        Tue, 23 Apr 2019 20:36:31 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 007335D704;
        Tue, 23 Apr 2019 20:36:28 +0000 (UTC)
Date:   Tue, 23 Apr 2019 15:36:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Message-ID: <20190423203627.mwnaknit7cvr3l5l@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-4-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 23 Apr 2019 20:36:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:52:40PM +0100, Raphael Gault wrote:
> Since the way the initial stack frame when entering a function is different that what is done
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

I get the feeling there might be a better way to do this, but I can't
figure out what this function is actually doing.  It looks like it
searches backwards in the function for an instruction which has
stack_op.src.reg != ADR_SOURCE -- what does that mean?  And why doesn't
it do anything with the instruction after it finds it?

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
> +}

All x86 instructions are sibling calls?

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

We should just fix the root cause instead, presumably:

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index b9f8d787eea9..e9e6b81e3eb4 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -71,7 +71,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	ALTINSTR_ENTRY(feature,cb)					\
 	".popsection\n"							\
 	" .if " __stringify(cb) " == 0\n"				\
-	".pushsection .altinstr_replacement, \"a\"\n"			\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\


>  
>  		if (strcmp(sec->name, ".altinstr_replacement") &&
> @@ -297,10 +299,22 @@ static int decode_instructions(struct objtool_file *file)
>  				WARN_FUNC("invalid instruction type %d",
>  					  insn->sec, insn->offset, insn->type);
>  				ret = -1;
> -				goto err;
> +				free(insn);
> +				continue;

What's the purpose of this change?  If it's really needed then it looks
like it should be a separate patch.

>  			}
> -
> -			hash_add(file->insn_hash, &insn->hash, insn->offset);
> +			/*
> +			 * For arm64 architecture, we sometime split instructions so that
> +			 * we can track the state evolution (i.e. load/store of pairs of registers).
> +			 * We thus need to take both into account and not erase the previous ones.
> +			 */

Ew...  Is this an architectural thing, or just a quirk of the arm64
decoder?

> +			if (composed_insn > 0)
> +				hash_add(file->insn_hash, &insn->hash, insn->offset + composed_insn);
> +			else
> +				hash_add(file->insn_hash, &insn->hash, insn->offset);
> +			if (insn->len == 0)
> +				composed_insn++;
> +			else
> +				composed_insn = 0;
>  			list_add_tail(&insn->list, &file->insn_list);
>  		}
>  
> @@ -510,10 +524,10 @@ static int add_jump_destinations(struct objtool_file *file)
>  			dest_off = arch_compute_jump_destination(insn);
>  		} else if (rela->sym->type == STT_SECTION) {
>  			dest_sec = rela->sym->sec;
> -			dest_off = rela->addend + 4;
> +			dest_off = arch_compute_rela_sym_offset(rela->addend);
>  		} else if (rela->sym->sec->idx) {
>  			dest_sec = rela->sym->sec;
> -			dest_off = rela->sym->sym.st_value + rela->addend + 4;
> +			dest_off = rela->sym->sym.st_value + arch_compute_rela_sym_offset(rela->addend);
>  		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
>  			/*
>  			 * Retpoline jumps are really dynamic jumps in
> @@ -663,7 +677,7 @@ static int handle_group_alt(struct objtool_file *file,
>  		last_orig_insn = insn;
>  	}
>  
> -	if (next_insn_same_sec(file, last_orig_insn)) {
> +	if (last_orig_insn && next_insn_same_sec(file, last_orig_insn)) {

This might belong in a separate patch which explains the reason for the
change.

>  		fake_jump = malloc(sizeof(*fake_jump));
>  		if (!fake_jump) {
>  			WARN("malloc failed");
> @@ -976,6 +990,17 @@ static struct rela *find_switch_table(struct objtool_file *file,
>  		if (find_symbol_containing(rodata_sec, table_offset))
>  			continue;
>  
> +		/*
> +		 * If we are on arm64 architecture, we now that we

"know"

> +		 * are in presence of a switch table thanks to
> +		 * the `br <Xn>` insn. but we can't retrieve it yet.
> +		 * So we just ignore unreachable for this file.
> +		 */
> +		if (JUMP_DYNAMIC_IS_SWITCH_TABLE) {
> +			file->ignore_unreachables = true;
> +			return NULL;
> +		}
> +

I think this means switch table reading is not yet supported?  If so
then maybe the flag should be called SWITCH_TABLE_NOT_SUPPORTED.

But really this needs to be fixed anyway before merging the code.

>  		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
>  		if (rodata_rela) {
>  			/*
> @@ -1258,8 +1283,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
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
> @@ -1415,8 +1440,33 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  
>  				/* add imm, %rsp */
>  				state->stack_size -= op->src.offset;
> -				if (cfa->base == CFI_SP)
> +				if (cfa->base == CFI_SP) {
>  					cfa->offset -= op->src.offset;
> +					if (state->stack_size == 0
> +							&& initial_func_cfi.cfa.base == CFI_CFA) {
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
> +					if (state->stack_size == 0
> +							&& initial_func_cfi.cfa.base == CFI_CFA) {
> +						cfa->base = CFI_CFA;
> +						cfa->offset = 0;
> +						restore_reg(state, CFI_BP);
> +					}
> +				}
> +				else if (cfa->base == CFI_CFA) {
> +					cfa->base = CFI_SP;
> +					if (state->stack_size >= 16)
> +						cfa->offset = 16;
> +				}
>  				break;
>  			}
>  
> @@ -1427,6 +1477,16 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  				break;
>  			}
>  
> +			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
> +			    cfa->base == CFI_SP &&
> +			    regs[CFI_BP].base == CFI_CFA &&
> +			    regs[CFI_BP].offset == -cfa->offset) {
> +
> +				/* mov %rsp, %rbp */
> +				cfa->base = op->dest.reg;
> +				state->bp_scratch = false;
> +				break;
> +			}
>  			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
>  
>  				/* drap: lea disp(%rsp), %drap */
> @@ -1518,6 +1578,9 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  			state->stack_size -= 8;
>  			if (cfa->base == CFI_SP)
>  				cfa->offset -= 8;
> +			if (cfa->base == CFI_SP && cfa->offset == 0
> +					&& initial_func_cfi.cfa.base == CFI_CFA)
> +				cfa->base = CFI_CFA;
>  
>  			break;
>  
> @@ -1557,6 +1620,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
>  
>  	case OP_DEST_PUSH:
>  		state->stack_size += 8;
> +		if (cfa->base == CFI_CFA)
> +			cfa->base = CFI_SP;
>  		if (cfa->base == CFI_SP)
>  			cfa->offset += 8;
>  
> @@ -1728,7 +1793,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  	insn = first;
>  	sec = insn->sec;
>  
> -	if (insn->alt_group && list_empty(&insn->alts)) {
> +	if (!insn->visited && insn->alt_group && list_empty(&insn->alts)) {

Why?  This looks like another one that might belong in a separate patch.

>  		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
>  			  sec, insn->offset);
>  		return 1;
> @@ -1871,6 +1936,14 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  		case INSN_JUMP_DYNAMIC:
>  			if (func && list_empty(&insn->alts) &&
>  			    has_modified_stack_frame(&state)) {
> +				/*
> +				 * On arm64 `br <Xn>` insn can be used for switch-tables
> +				 * but it cannot be distinguished in itself from a sibling
> +				 * call thus we need to have a look at the previous instructions
> +				 * to determine which it is
> +				 */
> +				if (!arch_is_insn_sibling_call(insn))
> +					break;
>  				WARN_FUNC("sibling call from callable instruction with modified stack frame",
>  					  sec, insn->offset);
>  				return 1;
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index b8f3cca8e58b..136f9b9fb1d1 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -74,7 +74,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>  	struct symbol *sym;
>  
>  	list_for_each_entry(sym, &sec->symbol_list, list)
> -		if (sym->type != STT_SECTION &&
> +		if (sym->type != STT_NOTYPE &&
> +		    sym->type != STT_SECTION &&

Why?  Another potential separate patch.

>  		    sym->offset == offset)
>  			return sym;
>  
> -- 
> 2.17.1
> 

-- 
Josh
