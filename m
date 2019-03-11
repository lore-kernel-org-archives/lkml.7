Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCBF206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCKSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfCKSBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6D8C3082E4B;
        Mon, 11 Mar 2019 18:01:44 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BBC918379;
        Mon, 11 Mar 2019 18:01:41 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:01:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190311180139.7mq4hkg6letzzono@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <20190308210209.usq2rpedccz25va5@treble>
 <20190310131046.GI2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190310131046.GI2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 11 Mar 2019 18:01:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 02:10:46PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 03:02:09PM -0600, Josh Poimboeuf wrote:
> 
> > These gotos make my head spin.  Again I would much prefer a small amount
> > of code duplication over this.
> 
> something like so then?

Yeah, that looks a lot nicer to me.  Thanks.

> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1888,6 +1888,23 @@ static inline const char *insn_dest_name
>  	return "{dynamic}";
>  }
>  
> +static int validate_call(struct instruction *insn, struct insn_state *state)
> +{
> +	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
> +		WARN_FUNC("call to %s() with UACCESS enabled",
> +				insn->sec, insn->offset, insn_dest_name(insn));
> +		return 1;
> +	}
> +
> +	if (state->df) {
> +		WARN_FUNC("call to %s() with DF set",
> +				insn->sec, insn->offset, insn_dest_name(insn));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Follow the branch starting at the given instruction, and recursively follow
>   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> @@ -2036,25 +2053,9 @@ static int validate_branch(struct objtoo
>  
>  		case INSN_CALL:
>  		case INSN_CALL_DYNAMIC:
> -do_call:
> -			if (state.uaccess && !func_uaccess_safe(insn->call_dest)) {
> -				WARN_FUNC("call to %s() with UACCESS enabled",
> -					  sec, insn->offset, insn_dest_name(insn));
> -				return 1;
> -			}
> -
> -			if (state.df) {
> -				WARN_FUNC("call to %s() with DF set",
> -					  sec, insn->offset, insn_dest_name(insn));
> -				return 1;
> -			}
> -
> -			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
> -			    insn->type == INSN_JUMP_DYNAMIC)
> -				return 0;
> -
> -			if (insn->type == INSN_JUMP_CONDITIONAL)
> -				break;
> +			ret = validate_call(insn, &state);
> +			if (ret)
> +				return ret;
>  
>  			if (insn->type == INSN_CALL) {
>  				if (is_fentry_call(insn))
> @@ -2077,13 +2078,15 @@ static int validate_branch(struct objtoo
>  		case INSN_JUMP_CONDITIONAL:
>  		case INSN_JUMP_UNCONDITIONAL:
>  			if (func && !insn->jump_dest) {
> -do_sibling_call:
> +				/* sibling call */
>  				if (has_modified_stack_frame(&state)) {
>  					WARN_FUNC("sibling call from callable instruction with modified stack frame",
>  							sec, insn->offset);
>  					return 1;
>  				}
> -				goto do_call;
> +				ret = validate_call(insn, &state);
> +				if (ret)
> +					return ret;
>  
>  			} else if (insn->jump_dest &&
>  				   (!func || !insn->jump_dest->func ||
> @@ -2104,8 +2107,17 @@ static int validate_branch(struct objtoo
>  			break;
>  
>  		case INSN_JUMP_DYNAMIC:
> -			if (func && list_empty(&insn->alts))
> -				goto do_sibling_call;
> +			if (func && list_empty(&insn->alts)) {
> +				/* sibling call */
> +				if (has_modified_stack_frame(&state)) {
> +					WARN_FUNC("sibling call from callable instruction with modified stack frame",
> +							sec, insn->offset);
> +					return 1;
> +				}
> +				ret = validate_call(insn, &state);
> +				if (ret)
> +					return ret;
> +			}
>  
>  			return 0;
>  
> 

-- 
Josh
