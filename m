Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04967C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5E20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DHDWmi6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbfHFPsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:48:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHFPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:48:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so35585955pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3PRJIP91/AQ/oyHrXd4NPkQ8KybghYi4upuqcJUjSbQ=;
        b=DHDWmi6dSuFjRnennVT95S4pXEJ37oOBjcfvuwJF56/1dOiRdLLJ+qxk198MtfGcAv
         27dc158ZXVmSzEUSDiFJkkcdy9kW+jPXcaujqMWSpJs5pyYQGcMSSF+8sAIRFJE4oLip
         AoqvDJ71rBS6FAf9wA+jadrC45BYOJUa/z1KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PRJIP91/AQ/oyHrXd4NPkQ8KybghYi4upuqcJUjSbQ=;
        b=tAHe0gtVcyf6aI74kgGU8Fp8DdwiN3w6gj15zCR3rWgeeg2PdaAS/P42lvaNOr78Wq
         +RFek/Hp+6A96hns6+2cx2gkYkmLgfoLe5pCLB0bJtowK2HSi6udtuJzmVZJfigMo7n6
         whDfsEgCM7EajPhMLyiwoHpmRvFYfyqy0PflwmncrQ5uQkPd/6di/HM7M0inruEqw0ff
         8Qd9bXT9tRYjAcrQVGJr/Ehs8p5KpRLMyMUBcFylTd2dalj9yfetdNJJF+6LmAG2vqOQ
         JSUxmlDfBDoLl1n0RvnLzBql81IW/cgEhW385rm1zxhyHG8Sde7rcapS1y9YktaHKR2U
         2ezQ==
X-Gm-Message-State: APjAAAVM0mS5BJh55bQr0fStdhon+/TV4cTkrdeKH/Jj6idu0Z74u3iW
        Tgw9jE/oqu6DFPiUrUo8dqHmZw==
X-Google-Smtp-Source: APXvYqwRBTUwdJjZqywEVj3R4ki4ntt43ZMkU8pP14OJ3NdosvZLrmuW9LtRkaKzaK3TaSfW6a4Iag==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr4520097pfa.90.1565106493576;
        Tue, 06 Aug 2019 08:48:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t96sm20287354pjb.1.2019.08.06.08.48.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:48:12 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:48:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch in
 arm64
Message-ID: <20190806154811.GB39951@google.com>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
 <20190802112259.0530a648@gandalf.local.home>
 <20190802120920.3b1f4351@gandalf.local.home>
 <20190802121124.6b41f26a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802121124.6b41f26a@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 12:11:24PM -0400, Steven Rostedt wrote:
> On Fri, 2 Aug 2019 12:09:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 2 Aug 2019 11:22:59 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I think you are not explaining the issue correctly. From looking at the
> > > document, I think what you want to say is that the LR is saved *after*
> > > the data for the function. Is that correct? If so, then yes, it would
> > > cause the stack tracing algorithm to be incorrect.
> > > 
> > 
> > [..]
> > 
> > > Can someone confirm that this is the real issue?
> > 
> > Does this patch fix your issue?
> >
> 
> Bah, I hit "attach" instead of "insert" (I wondered why it didn't
> insert). Here's the patch without the attachment.
> 
> -- Steve
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 5ab5200b2bdc..13a4832cfb00 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -13,6 +13,7 @@
>  #define HAVE_FUNCTION_GRAPH_FP_TEST
>  #define MCOUNT_ADDR		((unsigned long)_mcount)
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
>  
>  #ifndef __ASSEMBLY__
>  #include <linux/compat.h>
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..050c6bd9beac 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -158,6 +158,18 @@ static void check_stack(unsigned long ip, unsigned long *stack)
>  			i++;
>  	}
>  
> +#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
> +	/*
> +	 * Most archs store the return address before storing the
> +	 * function's local variables. But some archs do this backwards.
> +	 */
> +	if (x > 1) {
> +		memmove(&stack_trace_index[0], &stack_trace_index[1],
> +			sizeof(stack_trace_index[0]) * (x - 1));
> +		x--;
> +	}
> +#endif
> +
>  	stack_trace_nr_entries = x;
>  
>  	if (task_stack_end_corrupted(current)) {


I am not fully understanding the fix :(. If the positions of the data and
FP/LR are swapped, then there should be a loop of some sort where the FP/LR
are copied repeatedly to undo the mess we are discussing. But in this patch
I see only one copy happening. May be I just don't understand this code well
enough. Are there any more clues for helping understand the fix?

Also, this stack trace loop (original code) is a bit hairy :) It appears
there is a call to stack_trace_save() followed by another loop that goes
through the returned entries from there and tries to generate a set of
indexes. Isn't the real issue that the entries returned by stack_trace_save()
are a out of whack? I am curious also if other users of stack_trace_save()
will suffer from the same issue.

thanks,

 - Joel

