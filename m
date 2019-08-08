Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951C6C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD3216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="K0fHDV/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404616AbfHHURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:17:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33178 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404505AbfHHURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:17:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so43907593plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5f4CqgEOBdU1sAWH2G9u22gyRYPbta1aig+V48mAphg=;
        b=K0fHDV/c6bvsC0qLSvpocXZbNgQfks/MdnquDqwksf7dhTD98RI4nANdKdU4EkY24x
         0olhK/GhPbPPex9HnYXSj8j7OF0HgwYuSQJmcgDQq/Uj5scHAI+ui2G2tvoM9Lzudw5h
         5XilgXJpwsOHsGXXb4xvQbuSxUu1T3VWv/b6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5f4CqgEOBdU1sAWH2G9u22gyRYPbta1aig+V48mAphg=;
        b=MO487P9vzMdUBs8MGkApLRFMTRWE8AU6eMTsw4bocEtACyx2dee00S7oSrKX6utHl1
         vgN7/w5YE3e2mh2uvOJ/ItSoZU0bVlOZrXTz8v9YCY+RH7jdXhAkxLRAcVmIGOT99DhQ
         ZBB7DcBdqLtuJ+9YqUIMXOR6aW6pgFxdaH7OHYn2Jx64uubOT2j4C/Pa686Bsk/IEru3
         yf+J2RgBUFogb6xDMGYf3SEfP1HyAXYpKuYzT7PURRdkKsnl6Xh1BLDYkRNn6Pwrkzcs
         yq/IlxXr+7PQ/P4hUuQOCRflLYVkkJeavmFotSIfHBb85oBR0g+QC0BzAK/FmDIbyYmW
         ElGA==
X-Gm-Message-State: APjAAAXz3mwNka/JganudaXuajkwo3on/UdLBERNspcRYxqUp5rXrvU+
        jpGo8pozrPHFz3o3CqMZUmXZSQ==
X-Google-Smtp-Source: APXvYqws/0AbAFRQrpc39ivMkiU/nNnCNzDeEutw3lh4sdHQxYIsAE9EYG1zanM54XVWwO1sxMytHg==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr15566437plp.109.1565295424221;
        Thu, 08 Aug 2019 13:17:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id cx22sm2915882pjb.25.2019.08.08.13.17.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:17:03 -0700 (PDT)
Date:   Thu, 8 Aug 2019 16:17:02 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jiping Ma <jiping.ma2@windriver.com>,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2 v2] tracing: Document the stack trace algorithm in
 the comments
Message-ID: <20190808201702.GF261256@google.com>
References: <20190807172826.352574408@goodmis.org>
 <20190807172907.310138647@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807172907.310138647@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:28:28PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As the max stack tracer algorithm is not that easy to understand from the
> code, add comments that explain the algorithm and mentions how
> ARCH_RET_ADDR_AFTER_LOCAL_VARS affects it.
> 
> Link: http://lkml.kernel.org/r/20190806123455.487ac02b@gandalf.local.home
> 

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks!!

- Joel


> Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_stack.c | 98 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 40e4a88eea8f..f94a2fc567de 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -53,6 +53,104 @@ static void print_max_stack(void)
>  	}
>  }
>  
> +/*
> + * The stack tracer looks for a maximum stack at each call from a function. It
> + * registers a callback from ftrace, and in that callback it examines the stack
> + * size. It determines the stack size from the variable passed in, which is the
> + * address of a local variable in the stack_trace_call() callback function.
> + * The stack size is calculated by the address of the local variable to the top
> + * of the current stack. If that size is smaller than the currently saved max
> + * stack size, nothing more is done.
> + *
> + * If the size of the stack is greater than the maximum recorded size, then the
> + * following algorithm takes place.
> + *
> + * For architectures (like x86) that store the function's return address before
> + * saving the function's local variables, the stack will look something like
> + * this:
> + *
> + *   [ top of stack ]
> + *    0: sys call entry frame
> + *   10: return addr to entry code
> + *   11: start of sys_foo frame
> + *   20: return addr to sys_foo
> + *   21: start of kernel_func_bar frame
> + *   30: return addr to kernel_func_bar
> + *   31: [ do trace stack here ]
> + *
> + * The save_stack_trace() is called returning all the functions it finds in the
> + * current stack. Which would be (from the bottom of the stack to the top):
> + *
> + *   return addr to kernel_func_bar
> + *   return addr to sys_foo
> + *   return addr to entry code
> + *
> + * Now to figure out how much each of these functions' local variable size is,
> + * a search of the stack is made to find these values. When a match is made, it
> + * is added to the stack_dump_trace[] array. The offset into the stack is saved
> + * in the stack_trace_index[] array. The above example would show:
> + *
> + *        stack_dump_trace[]        |   stack_trace_index[]
> + *        ------------------        +   -------------------
> + *  return addr to kernel_func_bar  |          30
> + *  return addr to sys_foo          |          20
> + *  return addr to entry            |          10
> + *
> + * The print_max_stack() function above, uses these values to print the size of
> + * each function's portion of the stack.
> + *
> + *  for (i = 0; i < nr_entries; i++) {
> + *     size = i == nr_entries - 1 ? stack_trace_index[i] :
> + *                    stack_trace_index[i] - stack_trace_index[i+1]
> + *     print "%d %d %d %s\n", i, stack_trace_index[i], size, stack_dump_trace[i]);
> + *  }
> + *
> + * The above shows
> + *
> + *     depth size  location
> + *     ----- ----  --------
> + *  0    30   10   kernel_func_bar
> + *  1    20   10   sys_foo
> + *  2    10   10   entry code
> + *
> + * Now for architectures that might save the return address after the functions
> + * local variables (saving the link register before calling nested functions),
> + * this will cause the stack to look a little different:
> + *
> + * [ top of stack ]
> + *  0: sys call entry frame
> + * 10: start of sys_foo_frame
> + * 19: return addr to entry code << lr saved before calling kernel_func_bar
> + * 20: start of kernel_func_bar frame
> + * 29: return addr to sys_foo_frame << lr saved before calling next function
> + * 30: [ do trace stack here ]
> + *
> + * Although the functions returned by save_stack_trace() may be the same, the
> + * placement in the stack will be different. Using the same algorithm as above
> + * would yield:
> + *
> + *        stack_dump_trace[]        |   stack_trace_index[]
> + *        ------------------        +   -------------------
> + *  return addr to kernel_func_bar  |          30
> + *  return addr to sys_foo          |          29
> + *  return addr to entry            |          19
> + *
> + * Where the mapping is off by one:
> + *
> + *   kernel_func_bar stack frame size is 29 - 19 not 30 - 29!
> + *
> + * To fix this, if the architecture sets ARCH_RET_ADDR_AFTER_LOCAL_VARS the
> + * values in stack_trace_index[] are shifted by one to and the number of
> + * stack trace entries is decremented by one.
> + *
> + *        stack_dump_trace[]        |   stack_trace_index[]
> + *        ------------------        +   -------------------
> + *  return addr to kernel_func_bar  |          29
> + *  return addr to sys_foo          |          19
> + *
> + * Although the entry function is not displayed, the first function (sys_foo)
> + * will still include the stack size of it.
> + */
>  static void check_stack(unsigned long ip, unsigned long *stack)
>  {
>  	unsigned long this_size, flags; unsigned long *p, *top, *start;
> -- 
> 2.20.1
> 
> 
