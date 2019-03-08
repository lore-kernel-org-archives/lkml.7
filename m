Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E42C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E368220851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCHUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:22:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfCHUWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:22:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E794C4ECC;
        Fri,  8 Mar 2019 20:22:14 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6473D5C1A1;
        Fri,  8 Mar 2019 20:22:08 +0000 (UTC)
Date:   Fri, 8 Mar 2019 14:22:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 17/20] objtool: Fix sibling call detection
Message-ID: <20190308202205.ogmlgougwxzpqcp2@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.605521081@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307115200.605521081@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 08 Mar 2019 20:22:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:45:28PM +0100, Peter Zijlstra wrote:
> It turned out that we failed to detect some sibling calls;
> specifically those without relocation records; like:
> 
> $ ./objdump-func.sh defconfig-build/mm/kasan/generic.o __asan_loadN
> 0000 0000000000000840 <__asan_loadN>:
> 0000  840:      48 8b 0c 24             mov    (%rsp),%rcx
> 0004  844:      31 d2                   xor    %edx,%edx
> 0006  846:      e9 45 fe ff ff          jmpq   690 <check_memory_region>
> 
> So extend the cross-function jump to also consider those that are not
> between known (or newly detected) parent/child functions, as
> sibling-cals when they jump to the start of the function.
> 
> The second part of that condition is to deal with random jumps to the
> middle of other function, as can be found in
> arch/x86/lib/copy_user_64.S for example.
> 
> This then (with later patches applied) makes the above recognise the
> sibling call:
> 
> mm/kasan/generic.o: warning: objtool: __asan_loadN()+0x6: call to check_memory_region() with UACCESS enabled
> 
> Also make sure to set insn->call_dest for sibling calls so we can know
> who we're calling.

and we need to know who we're calling because...

>  		if (insn->func && insn->jump_dest->func &&
> -		    insn->func != insn->jump_dest->func &&
> -		    !strstr(insn->func->name, ".cold.") &&
> -		    strstr(insn->jump_dest->func->name, ".cold.")) {
> -			insn->func->cfunc = insn->jump_dest->func;
> -			insn->jump_dest->func->pfunc = insn->func;
> +		    insn->func != insn->jump_dest->func) {
> +
> +			/*
> +			 * For GCC 8+, create parent/child links for any cold
> +			 * subfunctions.  This is _mostly_ redundant with a
> +			 * similar initialization in read_symbols().
> +			 *
> +			 * If a function has aliases, we want the *first* such
> +			 * function in the symbol table to be the subfunction's
> +			 * parent.  In that case we overwrite the
> +			 * initialization done in read_symbols().
> +			 *
> +			 * However this code can't completely replace the
> +			 * read_symbols() code because this doesn't detect the
> +			 * case where the parent function's only reference to a
> +			 * subfunction is through a switch table.
> +			 */
> +			if (!strstr(insn->func->name, ".cold.") &&
> +			    strstr(insn->jump_dest->func->name, ".cold.")) {
> +				insn->func->cfunc = insn->jump_dest->func;
> +				insn->jump_dest->func->pfunc = insn->func;
> +
> +			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
> +				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
> +
> +				/* sibling class */

s/class/call/

> +				insn->call_dest = insn->jump_dest->func;
> +				insn->jump_dest = NULL;
> +			}
>  		}
>  	}
>  
> @@ -1935,9 +1949,16 @@ static int validate_branch(struct objtoo
>  
>  		case INSN_JUMP_CONDITIONAL:
>  		case INSN_JUMP_UNCONDITIONAL:
> -			if (insn->jump_dest &&
> -			    (!func || !insn->jump_dest->func ||
> -			     insn->jump_dest->func->pfunc == func)) {
> +			if (func && !insn->jump_dest) {
> +do_sibling_call:
> +				if (has_modified_stack_frame(&state)) {
> +					WARN_FUNC("sibling call from callable instruction with modified stack frame",
> +							sec, insn->offset);
> +					return 1;
> +				}
> +			} else if (insn->jump_dest &&
> +				   (!func || !insn->jump_dest->func ||
> +				    insn->jump_dest->func->pfunc == func)) {
>  				ret = validate_branch(file, insn->jump_dest,
>  						      state);
>  				if (ret) {
> @@ -1945,25 +1966,17 @@ static int validate_branch(struct objtoo
>  						BT_FUNC("(branch)", insn);
>  					return ret;
>  				}
> -
> -			} else if (func && has_modified_stack_frame(&state)) {
> -				WARN_FUNC("sibling call from callable instruction with modified stack frame",
> -					  sec, insn->offset);
> -				return 1;
>  			}
>  
> -			if (insn->type == INSN_JUMP_UNCONDITIONAL)
> +			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
> +			    insn->type == INSN_JUMP_DYNAMIC)
>  				return 0;
>  
>  			break;
>  
>  		case INSN_JUMP_DYNAMIC:
> -			if (func && list_empty(&insn->alts) &&
> -			    has_modified_stack_frame(&state)) {
> -				WARN_FUNC("sibling call from callable instruction with modified stack frame",
> -					  sec, insn->offset);
> -				return 1;
> -			}
> +			if (func && list_empty(&insn->alts))
> +				goto do_sibling_call;

I would rather have 2-3 duplicated lines of code than complicating the
control flow like this.

-- 
Josh
