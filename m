Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C944C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BE218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCTSSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCTSSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:18:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E980218A3;
        Wed, 20 Mar 2019 18:18:49 +0000 (UTC)
Date:   Wed, 20 Mar 2019 14:18:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH 02/25] tracing: Improve "if" macro code generation
Message-ID: <20190320141847.0fd9a832@gandalf.local.home>
In-Reply-To: <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
References: <20190318153840.906404905@infradead.org>
        <20190318155140.058627431@infradead.org>
        <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
        <CAHk-=wiALN3jRuzARpwThN62iKd476Xj-uom+YnLZ4=eqcz7xQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 10:26:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


>  - Steven has this crazy model of "more underscores are better". They
> aren't. They don't help if things nest anyway, but what does help is
> meaningful names. Both when things don't nest, and when looking at
> generated asm files.

Note, at the time I had Ingo as a mentor ;-)

>  include/linux/compiler.h | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 445348facea9..8aaf7cd026b0 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -53,23 +53,24 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * "Define 'is'", Bill Clinton
>   * "Define 'if'", Steven Rostedt
>   */
> -#define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
> -#define __trace_if(cond) \
> -	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
> -	({								\
> -		int ______r;						\
> -		static struct ftrace_branch_data			\
> -			__aligned(4)					\
> -			__section("_ftrace_branch")			\
> -			______f = {					\
> -				.func = __func__,			\
> -				.file = __FILE__,			\
> -				.line = __LINE__,			\
> -			};						\
> -		______r = !!(cond);					\
> -		______f.miss_hit[______r]++;					\
> -		______r;						\
> -	}))
> +#define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
> +
> +#define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> +
> +#define __trace_if_value(cond) ({			\
> +	static struct ftrace_branch_data		\
> +		__aligned(4)				\
> +		__section("_ftrace_branch")		\
> +		__if_trace = {				\
> +			.func = __func__,		\
> +			.file = __FILE__,		\
> +			.line = __LINE__,		\
> +		};					\
> +	(cond) ?					\
> +		(__if_trace.miss_hit[1]++,1) :		\
> +		(__if_trace.miss_hit[0]++,0);		\

Probably want to add a space between the comma and the numbers.

But other than that.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> +})
> +
>  #endif /* CONFIG_PROFILE_ALL_BRANCHES */
>  
>  #else
