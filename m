Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB03C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C292086A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCHVCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfCHVCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:02:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 137995944A;
        Fri,  8 Mar 2019 21:02:14 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B338B600C1;
        Fri,  8 Mar 2019 21:02:11 +0000 (UTC)
Date:   Fri, 8 Mar 2019 15:02:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190308210209.usq2rpedccz25va5@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307115200.697533978@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 08 Mar 2019 21:02:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:29PM +0100, Peter Zijlstra wrote:
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -369,7 +369,19 @@ int arch_decode_instruction(struct elf *
>  
>  	case 0x0f:
>  
> -		if (op2 >= 0x80 && op2 <= 0x8f) {
> +		if (op2 == 0x01) {
> +
> +			if (modrm == 0xca) {
> +
> +				*type = INSN_CLAC;
> +
> +			} else if (modrm == 0xcb) {
> +
> +				*type = INSN_STAC;
> +
> +			}

Style nit, no need for all those brackets and newlines.

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -442,6 +442,81 @@ static void add_ignores(struct objtool_f
>  	}
>  }
>  
> +static const char *uaccess_safe_builtin[] = {
> +	/* KASAN */

A short comment would be good here, something describing why a function
might be added to the list.

> +	"memset_orig", /* XXX why not memset_erms */
> +	"__memset",
> +	"kasan_poison_shadow",
> +	"kasan_unpoison_shadow",
> +	"__asan_poison_stack_memory",
> +	"__asan_unpoison_stack_memory",
> +	"kasan_report",
> +	"check_memory_region",
> +	/* KASAN out-of-line */
> +	"__asan_loadN_noabort",
> +	"__asan_load1_noabort",
> +	"__asan_load2_noabort",
> +	"__asan_load4_noabort",
> +	"__asan_load8_noabort",
> +	"__asan_load16_noabort",
> +	"__asan_storeN_noabort",
> +	"__asan_store1_noabort",
> +	"__asan_store2_noabort",
> +	"__asan_store4_noabort",
> +	"__asan_store8_noabort",
> +	"__asan_store16_noabort",
> +	/* KASAN in-line */
> +	"__asan_report_load_n_noabort",
> +	"__asan_report_load1_noabort",
> +	"__asan_report_load2_noabort",
> +	"__asan_report_load4_noabort",
> +	"__asan_report_load8_noabort",
> +	"__asan_report_load16_noabort",
> +	"__asan_report_store_n_noabort",
> +	"__asan_report_store1_noabort",
> +	"__asan_report_store2_noabort",
> +	"__asan_report_store4_noabort",
> +	"__asan_report_store8_noabort",
> +	"__asan_report_store16_noabort",
> +	/* KCOV */
> +	"write_comp_data",
> +	"__sanitizer_cov_trace_pc",
> +	"__sanitizer_cov_trace_const_cmp1",
> +	"__sanitizer_cov_trace_const_cmp2",
> +	"__sanitizer_cov_trace_const_cmp4",
> +	"__sanitizer_cov_trace_const_cmp8",
> +	"__sanitizer_cov_trace_cmp1",
> +	"__sanitizer_cov_trace_cmp2",
> +	"__sanitizer_cov_trace_cmp4",
> +	"__sanitizer_cov_trace_cmp8",
> +	/* UBSAN */
> +	"ubsan_type_mismatch_common",
> +	"__ubsan_handle_type_mismatch",
> +	"__ubsan_handle_type_mismatch_v1",
> +	/* misc */
> +	"csum_partial_copy_generic",
> +	"__memcpy_mcsafe",
> +	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
> +	NULL
> +};
> +
> +static void add_uaccess_safe(struct objtool_file *file)
> +{
> +	struct symbol *func;
> +	const char **name;
> +
> +	if (!uaccess)
> +		return;
> +
> +	for (name = uaccess_safe_builtin; *name; name++) {
> +		func = find_symbol_by_name(file->elf, *name);
> +		if (!func)
> +			continue;

This won't work if the function name changes due to IPA optimizations.
I assume these are all global functions so maybe it's fine?

> @@ -1914,6 +2008,16 @@ static int validate_branch(struct objtoo
>  		switch (insn->type) {
>  
>  		case INSN_RETURN:
> +			if (state.uaccess && !func_uaccess_safe(func)) {
> +				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
> +				return 1;
> +			}
> +
> +			if (!state.uaccess && func_uaccess_safe(func)) {
> +				WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function", sec, insn->offset);
> +				return 1;
> +			}
> +
>  			if (func && has_modified_stack_frame(&state)) {
>  				WARN_FUNC("return with modified stack frame",
>  					  sec, insn->offset);
> @@ -1929,17 +2033,32 @@ static int validate_branch(struct objtoo
>  			return 0;
>  
>  		case INSN_CALL:
> -			if (is_fentry_call(insn))
> -				break;
> +		case INSN_CALL_DYNAMIC:
> +do_call:
> +			if (state.uaccess && !func_uaccess_safe(insn->call_dest)) {
> +				WARN_FUNC("call to %s() with UACCESS enabled",
> +					  sec, insn->offset, insn_dest_name(insn));
> +				return 1;
> +			}
>  
> -			ret = dead_end_function(file, insn->call_dest);
> -			if (ret == 1)
> +			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
> +			    insn->type == INSN_JUMP_DYNAMIC)
>  				return 0;
> -			if (ret == -1)
> -				return 1;
>  
> -			/* fallthrough */
> -		case INSN_CALL_DYNAMIC:
> +			if (insn->type == INSN_JUMP_CONDITIONAL)
> +				break;
> +
> +			if (insn->type == INSN_CALL) {
> +				if (is_fentry_call(insn))
> +					break;
> +
> +				ret = dead_end_function(file, insn->call_dest);
> +				if (ret == 1)
> +					return 0;
> +				if (ret == -1)
> +					return 1;
> +			}
> +
>  			if (!no_fp && func && !has_valid_stack_frame(&state)) {
>  				WARN_FUNC("call without frame pointer save/setup",
>  					  sec, insn->offset);
> @@ -1956,6 +2075,8 @@ static int validate_branch(struct objtoo
>  							sec, insn->offset);
>  					return 1;
>  				}
> +				goto do_call;
> +

These gotos make my head spin.  Again I would much prefer a small amount
of code duplication over this.

> +++ b/tools/objtool/special.c
> @@ -42,6 +42,7 @@
>  #define ALT_NEW_LEN_OFFSET	11
>  
>  #define X86_FEATURE_POPCNT (4*32+23)
> +#define X86_FEATURE_SMAP   (9*32+20)
>  
>  struct special_entry {
>  	const char *sec;
> @@ -107,8 +108,15 @@ static int get_alt_entry(struct elf *elf
>  		 * It has been requested that we don't validate the !POPCNT
>  		 * feature path which is a "very very small percentage of
>  		 * machines".
> +		 *
> +		 * Also, unconditionally enable SMAP; this avoids seeing paths
> +		 * that pass through the STAC alternative and through the CLAC
> +		 * NOPs.

Why is this a problem?

> +		 *
> +		 * XXX: We could do this for all binary NOP/single-INSN
> +		 * alternatives.

Same question here.

>  		 */
> -		if (feature == X86_FEATURE_POPCNT)
> +		if (feature == X86_FEATURE_POPCNT || feature == X86_FEATURE_SMAP)
>  			alt->skip_orig = true;
>  	}
>  
> 
> 

-- 
Josh
