Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0662075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eWzzE7nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfHFRZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:25:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46741 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfHFRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:25:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so4735102pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=++FX/M76MkJ77Wmy6ZQS0b99NlwKRsO0LdWt36B9bDo=;
        b=eWzzE7nuUqqomzdRaZM4fbGQAsQ9CcWdhoShx2noBZxcc1DJ+7oJERIsTVprpW6Ium
         WrK9ML+WKEOGF8KZ2XARf7QTUspWfLJiYS6PVQNpGSTeE2Gy74nWuBYVKF4ILLL5h2Qz
         aJRG4k9Ueidxzse3Rx0HUDSIgNWEYBB6UbOMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=++FX/M76MkJ77Wmy6ZQS0b99NlwKRsO0LdWt36B9bDo=;
        b=Ud4FNSBb8hF/0xrRm1DDfJQ0vbPwEMmSA7NIglAT8r2f7pjkITlNGX1HjF0peuC5jH
         TfK39YBngM6Tpj/BAamJ73yj5wt2JYu2qs9DsplZW7QsIhuXdxq5C1Kbwpbu7dzp1ZIv
         LrggKff7cx9dNFzXUQy0IJu1yCO/yyNprIaGP8u3sGXt5Ln4RE7LVRXx9D/4Bw6dPNCQ
         iwU6H/2uEgNBWu76qJyjySP9oRQIyXW0cMLT5ugYG9G+SIUWu32M8YrvZNVbjQNgVfwe
         LmcqEZbD4zkpcQ0/Nh9xPVlahrbrrKErnTd/+Fie9KdTNo5D3Q94yBL8Da+I2yqtNhWU
         OyHw==
X-Gm-Message-State: APjAAAV4SyG2QeQH45HGGAg3DEcXxMVoMwipvJg+l9QN04F7jCjt6+Eg
        RXUPFKaEClsaSHA9RhYPWVvs9g==
X-Google-Smtp-Source: APXvYqw7Yw+KCFeiI9FmWSl0UyWUYpyMNgU2fLsmddKSC41C0ESHrwbVq/zDVWULTJrLPuI9SAg/jA==
X-Received: by 2002:a63:6fc9:: with SMTP id k192mr3981375pgc.20.1565112321645;
        Tue, 06 Aug 2019 10:25:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r75sm112195247pfc.18.2019.08.06.10.25.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:25:20 -0700 (PDT)
Date:   Tue, 6 Aug 2019 13:25:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] tracing: Function stack size and its name mismatch in
 arm64
Message-ID: <20190806172519.GD39951@google.com>
References: <20190802094103.163576-1-jiping.ma2@windriver.com>
 <20190802112259.0530a648@gandalf.local.home>
 <20190802120920.3b1f4351@gandalf.local.home>
 <20190802121124.6b41f26a@gandalf.local.home>
 <20190806154811.GB39951@google.com>
 <20190806123455.487ac02b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806123455.487ac02b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:34:55PM -0400, Steven Rostedt wrote:
> On Tue, 6 Aug 2019 11:48:11 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > > index 5ab5200b2bdc..13a4832cfb00 100644
> > > --- a/arch/arm64/include/asm/ftrace.h
> > > +++ b/arch/arm64/include/asm/ftrace.h
> > > @@ -13,6 +13,7 @@
> > >  #define HAVE_FUNCTION_GRAPH_FP_TEST
> > >  #define MCOUNT_ADDR		((unsigned long)_mcount)
> > >  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> > > +#define ARCH_RET_ADDR_AFTER_LOCAL_VARS 1
> > >  
> > >  #ifndef __ASSEMBLY__
> > >  #include <linux/compat.h>
> > > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > > index 5d16f73898db..050c6bd9beac 100644
> > > --- a/kernel/trace/trace_stack.c
> > > +++ b/kernel/trace/trace_stack.c
> > > @@ -158,6 +158,18 @@ static void check_stack(unsigned long ip, unsigned long *stack)
> > >  			i++;
> > >  	}
> > >  
> > > +#ifdef ARCH_RET_ADDR_AFTER_LOCAL_VARS
> > > +	/*
> > > +	 * Most archs store the return address before storing the
> > > +	 * function's local variables. But some archs do this backwards.
> > > +	 */
> > > +	if (x > 1) {
> > > +		memmove(&stack_trace_index[0], &stack_trace_index[1],
> > > +			sizeof(stack_trace_index[0]) * (x - 1));
> > > +		x--;
> > > +	}
> > > +#endif
> > > +
> > >  	stack_trace_nr_entries = x;
> > >  
> > >  	if (task_stack_end_corrupted(current)) {  
> > 
> > 
> > I am not fully understanding the fix :(. If the positions of the data and
> > FP/LR are swapped, then there should be a loop of some sort where the FP/LR
> > are copied repeatedly to undo the mess we are discussing. But in this patch
> > I see only one copy happening. May be I just don't understand this code well
> > enough. Are there any more clues for helping understand the fix?
> 
> Here's the best way to explain this. The code is using the stack trace
> to figure out which function is the stack hog. Or perhaps a serious of
> stack hogs. On x86, a call stores the return address as it calls the
> next function. Then that function allocates its stack frame for its
> local variables and saving of registers.

This makes perfect sense, (probably also makes sense to push this whole
explanation into either the changelog or the kernel documentation)

Thanks a lot, Steve!

 - Joel



> on x86:
> 
> [ top of stack ]
>  0: sys call entry frame
> 10: return addr to entry code
> 11: start of sys_foo frame
> 20: return addr to sys_foo
> 21: start of kernel_func_bar frame
> 30: return addr to kernel_func_bar
> 31: [ do trace stack here ]
> 
> 
> Then we do a save_stack_trace which returns the addresses of the
> functions it finds. Which would be (from the bottom of the stack to the
> top)
> 
>   return addr to kernel_func_bar
>   return addr to sys_foo
>   return addr to entry code
> 
> What we do here is try to figure out how much stack each of theses
> functions have. So we loop through the stack looking for the addresses
> returned by the save_stack trace, and see where on the stack this is.
> This gives us:
> 
>   return addr to kernel_func_bar [ 30 ]
>   return addr to sys_foo         [ 20 ]
>   return addr to entry frame     [ 10 ]
> 
> From this, we can conclude (on x86) that the size of the stack used for
> kernel_func_bar is 30 - 20 = 10. Because on the stack we have:
> 
> 20: return addr to sys_foo
> 21: start of kernel_func_bar frame  <<-- kernel_func_bar stack frame
> 30: return addr to kernel_func_bar
> 
> 
> Now, what Jiping reported, is that on arm64, it saves the link register
> (the return address) when it is needed to, which is after the stack
> frame for the current function has been saved. That means we have
> something that looks like this:
> 
> on arm64:
> 
> [ top of stack ]
>  0: sys call entry frame
> 10: start of sys_foo_frame
> 19: return addr to entry code << lr saved before calling kern_func_bar
> 20: start of kernel_func_bar frame
> 29: return addr to sys_foo_frame << lr saved before calling next function
> 30: [ do trace stack here ]
> 
> Now, I have a question. To call the mcount code (ftrace and the stack
> tracing), you need to save the return address of kern_func_bar
> somewhere, otherwise the call to mcount will overwrite the lr. But
> let's say it does and then forgets it, so we have:
> 
> 30: return addr of kernel_func_bar frame
> 31: [ do trace stack here ]
> 
> Now save_stack_trace gives us the same result:
> 
>  return addr to kernel_func bar
>  return addr to sys_foo
>  return addr to entry frame
> 
> But we get a different result when finding them in the location of the
> stack.
> 
>  return addr to kernel_func_bar [ 30 ]
>  return addr to sys foo         [ 29 ]
>  return addr to entry frame     [ 19 ]
> 
> The simple subtractions will be off:
> 
> kernel_func_bar stack size = 30 - 29 = 1
> Or even, sys_foo 29 - 19 = 10, but if we look at the stack:
> 
> 10: start of sys_foo_frame
> 19: return addr to entry_code
> 20: start of kernel_func_bar frame
> 29: return addr to sys_foo
> 
> We are measuring the kernel_func_bar frame for sys_foo!
> 
> We are off by one here.
> 
> stack_trace_index[] is an array of the offsets mapping to the function
> return addresses found. If we shift it by one, then we then sync the
> functions found with their frames:
> 
> stack_trace_index[0] = 30
> stack_trace_index[1] = 29
> stack_trace_index[2] = 19
> 
> 		memmove((&stack_trace_index[0], &stack_trace_index[1],
> 			sizeof(stack_trace_index[0]) * (x - 1));
> 
> Makes that:
> 
> stack_trace_index[0] = 29
> stack_trace_index[1] = 19
> 
> And we do x-- to lose the last frame.
> 
> With the stack_dump_trace being:
> 
> stack_dump_trace[0] = return addr kernel_func_bar
> stack_dump_trace[1] = return addr sys_foo
> 
> we then match which frame size belongs to which function better.
> 
> 
> > 
> > Also, this stack trace loop (original code) is a bit hairy :) It appears
> > there is a call to stack_trace_save() followed by another loop that goes
> > through the returned entries from there and tries to generate a set of
> > indexes. Isn't the real issue that the entries returned by stack_trace_save()
> > are a out of whack? I am curious also if other users of stack_trace_save()
> > will suffer from the same issue.
> 
> No, the order is fine. The issue is that we are using the location of
> the return address in the stack to find out what function has the
> biggest stack usage, and our assumption for arm64 is incorrect in that
> location.
> 
> -- Steve
