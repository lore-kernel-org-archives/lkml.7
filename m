Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E604C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC49320989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCRRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfCRRly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:41:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AB32070D;
        Mon, 18 Mar 2019 17:41:52 +0000 (UTC)
Date:   Mon, 18 Mar 2019 13:41:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190318134151.4398b2e2@gandalf.local.home>
In-Reply-To: <20190318155140.058627431@infradead.org>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 16:38:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> With CONFIG_PROFILE_ALL_BRANCHES, the "if" macro converts the
> conditional to an array index.  This can cause GCC to create horrible
> code.  When there are nested ifs, the generated code uses register
> values to encode branching decisions.
> 
> Make it easier for GCC to optimize by keeping the conditional as a
> conditional rather than converting it to an integer.  This shrinks the
> generated code quite a bit, and also makes the code sane enough for
> objtool to understand.
> 
> Cc: rostedt@goodmis.org
> Cc: valentin.schneider@arm.com
> Cc: luto@amacapital.net
> Cc: brgerst@gmail.com
> Cc: catalin.marinas@arm.com
> Cc: mingo@kernel.org
> Cc: dvlasenk@redhat.com
> Cc: will.deacon@arm.com
> Cc: julien.thierry@arm.com
> Cc: torvalds@linux-foundation.org
> Cc: dvyukov@google.com
> Cc: bp@alien8.de
> Cc: tglx@linutronix.de
> Cc: james.morse@arm.com
> Cc: luto@kernel.org
> Cc: hpa@zytor.com
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble
> ---
>  include/linux/compiler.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_
>  				.line = __LINE__,			\
>  			};						\
>  		______r = !!(cond);					\
> -		______f.miss_hit[______r]++;					\
> +		______r ? ______f.miss_hit[1]++ : ______f.miss_hit[0]++;\
>  		______r;						\
>  	}))
>  #endif /* CONFIG_PROFILE_ALL_BRANCHES */
> 

