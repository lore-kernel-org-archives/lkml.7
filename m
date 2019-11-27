Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14BA2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y3gBej2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfK0RpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:45:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32856 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0RpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:45:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so6698114pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTwVNHGfaslmzIOZLky3qVmqZLhSuuddPt+3vhSrt20=;
        b=Y3gBej2pMAYaD135FmDz7wFd7CKGnPhq2UTsznJ4G4NRkUC/4EcBYtTw8E5IPxcoER
         K0KlpmIxhtAv3XIL/PWz6hESe7un5DV/xFeK2XtzMnuCAo/kLSROivitXUZUVk0k2VYK
         i+8WNUaBz6md3cdIzzmfWsssffOF/uxi7Zrsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vTwVNHGfaslmzIOZLky3qVmqZLhSuuddPt+3vhSrt20=;
        b=Af0VGqS0Cw5R9OTEj0/oDebRunML6BqkfaVbpww622w/5tYdZ4e8VDxiaWF2nQvoPT
         5hHmdsTf4jgFTCB/NX2zIxbAane6+4ppKWmPdyphuVvqCQmwxJZUn3NqDJAegDDBEFYO
         hWaeAT2y6omBjKh9O9JoZt5pFDBInqz7HwEtE82nwlxUZmRjwgOOjbUULPXcPKUEVPHC
         gpSz9MqS01dBqYrflIjNRvrHmxSrSvtnYeRwZO5t3PyqxvLMgB25hx8xZYcwORFOtVjs
         9uFpFssZAcBlQaVgoGOrVsYEKAcMIEn7PSoXZ3d9ZP6onZOfQzmrKZs2HgUZBdEFoeEF
         JpMQ==
X-Gm-Message-State: APjAAAWoFgpD08ifMfCkNrtgGGkQQS32hL5kelDLa3BPORi48HZDv8FE
        UouB8ec89RQj87VubEOXN9CVow==
X-Google-Smtp-Source: APXvYqzbGSwKUJ4Noau1bQM4eNgbwqA6hn7o9JrHTNxVF5DVVi7DHYmfOkLXN+C7ZQwdjV/oYCLKSQ==
X-Received: by 2002:a63:da13:: with SMTP id c19mr6164709pgh.435.1574876701803;
        Wed, 27 Nov 2019 09:45:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f26sm16293199pgf.22.2019.11.27.09.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:45:00 -0800 (PST)
Date:   Wed, 27 Nov 2019 09:44:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: x86/urgent] lkdtm: Add a DOUBLE_FAULT crash type on x86
Message-ID: <201911270942.0F120BF82@keescook>
References: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 08:19:30AM -0000, tip-bot2 for Andy Lutomirski wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     b09511c253e5c739a60952b97c071a93e92b2e88
> Gitweb:        https://git.kernel.org/tip/b09511c253e5c739a60952b97c071a93e92b2e88
> Author:        Andy Lutomirski <luto@kernel.org>
> AuthorDate:    Sun, 24 Nov 2019 21:18:04 -08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00
> 
> lkdtm: Add a DOUBLE_FAULT crash type on x86
> 
> The DOUBLE_FAULT crash does INT $8, which is a decent approximation
> of a double fault.  This is useful for testing the double fault
> handling.  Use it like:
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c  | 39 +++++++++++++++++++++++++++++++++++++-
>  drivers/misc/lkdtm/core.c  |  3 +++-
>  drivers/misc/lkdtm/lkdtm.h |  3 +++-
>  3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 7284a22..a4fdad0 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -12,6 +12,10 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/uaccess.h>
>  
> +#ifdef CONFIG_X86_32
> +#include <asm/desc.h>
> +#endif
> +
>  struct lkdtm_list {
>  	struct list_head node;
>  };
> @@ -337,3 +341,38 @@ void lkdtm_UNSET_SMEP(void)
>  	pr_err("FAIL: this test is x86_64-only\n");
>  #endif
>  }
> +
> +#ifdef CONFIG_X86_32
> +void lkdtm_DOUBLE_FAULT(void)
> +{
> +	/*
> +	 * Trigger #DF by setting the stack limit to zero.  This clobbers
> +	 * a GDT TLS slot, which is okay because the current task will die
> +	 * anyway due to the double fault.
> +	 */
> +	struct desc_struct d = {
> +		.type = 3,	/* expand-up, writable, accessed data */
> +		.p = 1,		/* present */
> +		.d = 1,		/* 32-bit */
> +		.g = 0,		/* limit in bytes */
> +		.s = 1,		/* not system */
> +	};
> +
> +	local_irq_disable();
> +	write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
> +			GDT_ENTRY_TLS_MIN, &d, DESCTYPE_S);
> +
> +	/*
> +	 * Put our zero-limit segment in SS and then trigger a fault.  The
> +	 * 4-byte access to (%esp) will fault with #SS, and the attempt to
> +	 * deliver the fault will recursively cause #SS and result in #DF.
> +	 * This whole process happens while NMIs and MCEs are blocked by the
> +	 * MOV SS window.  This is nice because an NMI with an invalid SS
> +	 * would also double-fault, resulting in the NMI or MCE being lost.
> +	 */
> +	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
> +		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
> +
> +	panic("tried to double fault but didn't die\n");

I'll modify this in some later patches, but I prefer the #ifdef inside
the function so that all tests are visible on all
architectures/configurations. And it should not panic on a test failure,
it should continue (see the others) with something like:

	pr_err("FAIL: did not double fault!\n");

E.g. an external system monitor would see the double-fault and the panic as
both causing a system reboot, but only the double-fault should do that.

> +}
> +#endif
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index cbc4c90..ee0d6e7 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -171,6 +171,9 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(USERCOPY_KERNEL_DS),
>  	CRASHTYPE(STACKLEAK_ERASING),
>  	CRASHTYPE(CFI_FORWARD_PROTO),
> +#ifdef CONFIG_X86_32
> +	CRASHTYPE(DOUBLE_FAULT),
> +#endif

And then ifdefs aren't needed here either.

>  };
>  
>  
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index ab446e0..c56d23e 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -28,6 +28,9 @@ void lkdtm_CORRUPT_USER_DS(void);
>  void lkdtm_STACK_GUARD_PAGE_LEADING(void);
>  void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
>  void lkdtm_UNSET_SMEP(void);
> +#ifdef CONFIG_X86_32
> +void lkdtm_DOUBLE_FAULT(void);
> +#endif

Same.

>  
>  /* lkdtm_heap.c */
>  void __init lkdtm_heap_init(void);

-- 
Kees Cook
