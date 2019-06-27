Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D23C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75EE2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZ8UBz2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfF0R22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:28:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38097 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0R22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:28:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id 9so883575ple.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OQen2ezFLvGlY5YY2wOeplKvt6lesrbg+a5IZq1voZU=;
        b=UZ8UBz2rwp9uCPm/XWOWstqPk6guuL7vFbYt+hTU+3oAUdZ+KJW1UI6WNQjROfu/rT
         YwiYbghhgbL2rP1xFoxyA/69RcI9H6khyVMUE75v93HYh5nrsUO+Uc+KQLL3SxvYnUQi
         xlaQXXboV5bZfkvYs++Ed0XP5Tpln34eObYds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OQen2ezFLvGlY5YY2wOeplKvt6lesrbg+a5IZq1voZU=;
        b=Kq38euOgP0zsCNIxicrhC6QzxXqPJxDmQMCuKYgDu4gFafJLxsX8GE73BY9MaDv6ba
         suhKF1WeZbBGiwoMsOHqlB0YdB9cVSU16liTNtg6kEd2IN1OpAQn/zKd6A+Ke9CcrtqA
         ZLRoLQGllgodhvBH7rFiyN5gqwKOOcGa7klnJCSB8QBJumbZ4Y90h8spnz1WkCUtU3YG
         vAQN+Cls0ldJt5sNK50ZJ9kSEjgqZxgSIw6tIlJm8SyqQj6yzO3IyDTbFlTCTlJhtDso
         4QG4lKKM845krFvlwOAVvLz8MrhQgBeIdV4apHuExFBCtHKKoXnDrgYjZ9FWkviVWjnv
         9b3g==
X-Gm-Message-State: APjAAAWemOdJE43JYqrgRTunkAb0aNkuyFNZA2TvIw/cMxVqgyD9tJF5
        TDzugq1eXzXVS8RdsppLl3Nw0w==
X-Google-Smtp-Source: APXvYqwpeS85FeXRmIPlVVSP7QWKH4tvGJ6nJ90QbxQII2vd1YPE9YG+2ED59z5CL0tAOcqEADxIGg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr5865146plz.191.1561656507785;
        Thu, 27 Jun 2019 10:28:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm2508402pgg.35.2019.06.27.10.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:28:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:28:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 3/8] x86/vsyscall: Show something useful on a read
 fault
Message-ID: <201906271028.E2A4538@keescook>
References: <cover.1561610354.git.luto@kernel.org>
 <8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:45:04PM -0700, Andy Lutomirski wrote:
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/entry/vsyscall/vsyscall_64.c | 19 ++++++++++++++++++-
>  arch/x86/include/asm/vsyscall.h       |  6 ++++--
>  arch/x86/mm/fault.c                   | 11 +++++------
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
> index fedd7628f3a6..9c58ab807aeb 100644
> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> @@ -117,7 +117,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
>  	}
>  }
>  
> -bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
> +bool emulate_vsyscall(unsigned long error_code,
> +		      struct pt_regs *regs, unsigned long address)
>  {
>  	struct task_struct *tsk;
>  	unsigned long caller;
> @@ -126,6 +127,22 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
>  	long ret;
>  	unsigned long orig_dx;
>  
> +	/* Write faults or kernel-privilege faults never get fixed up. */
> +	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
> +		return false;
> +
> +	if (!(error_code & X86_PF_INSTR)) {
> +		/* Failed vsyscall read */
> +		if (vsyscall_mode == EMULATE)
> +			return false;
> +
> +		/*
> +		 * User code tried and failed to read the vsyscall page.
> +		 */
> +		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
> +		return false;
> +	}
> +
>  	/*
>  	 * No point in checking CS -- the only way to get here is a user mode
>  	 * trap to a high address, which means that we're in 64-bit user code.
> diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
> index b986b2ca688a..ab60a71a8dcb 100644
> --- a/arch/x86/include/asm/vsyscall.h
> +++ b/arch/x86/include/asm/vsyscall.h
> @@ -13,10 +13,12 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
>   * Called on instruction fetch fault in vsyscall page.
>   * Returns true if handled.
>   */
> -extern bool emulate_vsyscall(struct pt_regs *regs, unsigned long address);
> +extern bool emulate_vsyscall(unsigned long error_code,
> +			     struct pt_regs *regs, unsigned long address);
>  #else
>  static inline void map_vsyscall(void) {}
> -static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
> +static inline bool emulate_vsyscall(unsigned long error_code,
> +				    struct pt_regs *regs, unsigned long address)
>  {
>  	return false;
>  }
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 46df4c6aae46..288a5462076f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1369,16 +1369,15 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  #ifdef CONFIG_X86_64
>  	/*
> -	 * Instruction fetch faults in the vsyscall page might need
> -	 * emulation.  The vsyscall page is at a high address
> -	 * (>PAGE_OFFSET), but is considered to be part of the user
> -	 * address space.
> +	 * Faults in the vsyscall page might need emulation.  The
> +	 * vsyscall page is at a high address (>PAGE_OFFSET), but is
> +	 * considered to be part of the user address space.
>  	 *
>  	 * The vsyscall page does not have a "real" VMA, so do this
>  	 * emulation before we go searching for VMAs.
>  	 */
> -	if ((hw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
> -		if (emulate_vsyscall(regs, address))
> +	if (is_vsyscall_vaddr(address)) {
> +		if (emulate_vsyscall(hw_error_code, regs, address))
>  			return;
>  	}
>  #endif
> -- 
> 2.21.0
> 

-- 
Kees Cook
