Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A42C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090CD20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHMto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:49:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B7FC89C45;
        Mon,  8 Apr 2019 12:49:44 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF8BB3DA4;
        Mon,  8 Apr 2019 12:49:42 +0000 (UTC)
Date:   Mon, 8 Apr 2019 07:49:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net,
        keescook@chromium.org, jannh@google.com, enrico.perla@intel.com,
        mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        peterz@infradead.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190408124940.hb4d2mvwue7aydjj@treble>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408061358.21288-1-elena.reshetova@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 08 Apr 2019 12:49:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 7bc105f47d21..38ddc213a5e9 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -35,6 +35,12 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +#include <linux/random.h>
> +
> +void *alloca(size_t size);
> +#endif
> +
>  #ifdef CONFIG_CONTEXT_TRACKING
>  /* Called on entry from user mode with IRQs off. */
>  __visible inline void enter_from_user_mode(void)
> @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  {
>  	struct thread_info *ti;
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> +	size_t offset = ((size_t)prandom_u32()) % 256;
> +	char *ptr = alloca(offset);
> +
> +	asm volatile("":"=m"(*ptr));
> +#endif
> +
>  	enter_from_user_mode();
>  	local_irq_enable();
>  	ti = current_thread_info();

Would it make sense to also do this for the compat syscalls
(do_fast_syscall_32, do_int80_syscall_32)?

-- 
Josh
