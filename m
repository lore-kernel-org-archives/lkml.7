Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46098C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AC205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEGXsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:48:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32812 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:48:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so9481108pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 16:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Xc5yB1zQ65A+bT/TEX7kwPlOeoH820lrDziLp7lmLpk=;
        b=NNe1TYzncf2AzJ0ANuIPs+/B/sGFXzx9ZtetP75ixWFN1g73WWCQsjLBMPTvdEYvLO
         tX/XlX79o1ME8k7O04p7kWDMkbPfZq9XG9JKK8C21ftS65DxtitCuGJZMl9gi3SCnuXS
         FFTzfvwEPYHQ9BeX4Ee5p5Ug+J77MucHPsUGi4L3RAok0kPD2FeF7sVp3nkTEJyZ3LLs
         SLh5K2q/EXWx8kVH2fwvY/QR/TuIAo4Vs8ovKbvkiW+ghiiELlUxt7Ern4btQfDDq/Mu
         PPGParDYvKTdQJgPxPobFIfByzYEcu3oS7m984k8t+ktDDpv4yXasLxKZHqw+3Bg1D4f
         1zzg==
X-Gm-Message-State: APjAAAX+Va/1Id69m8b35v51rVVd2JPGzoWV4hEwntqEqlPc1w2T3dwZ
        eYZABFoNO/Dy7hH5Jt3y6nIAHMjXY1o=
X-Google-Smtp-Source: APXvYqzxi+8s0kTgdE3wx6h+YyLz1JxmMhnAT4Dvn0eloXEXtiTyplpknHAhK/JvQQI++cJkR2huwA==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr45461551pfi.126.1557272884660;
        Tue, 07 May 2019 16:48:04 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q17sm35869266pfi.185.2019.05.07.16.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 16:48:03 -0700 (PDT)
Date:   Tue, 07 May 2019 16:48:03 -0700 (PDT)
X-Google-Original-Date: Tue, 07 May 2019 16:27:44 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix locking violation in page fault handler
In-Reply-To: <mvm5zqmu35d.fsf@suse.de>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     schwab@suse.de
Message-ID: <mhng-56794b7f-6cd4-4eb9-a962-83ad256ed3cd@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2019 00:36:46 PDT (-0700), schwab@suse.de wrote:
> When a user mode process accesses an address in the vmalloc area
> do_page_fault tries to unlock the mmap semaphore when it isn't locked.
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  arch/riscv/mm/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 88401d5125bc..c51878e5a66a 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -181,6 +181,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	up_read(&mm->mmap_sem);
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs)) {
> +bad_area_do_trap:
>  		do_trap(regs, SIGSEGV, code, addr, tsk);
>  		return;
>  	}
> @@ -230,7 +231,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  		int index;
>
>  		if (user_mode(regs))
> -			goto bad_area;
> +			goto bad_area_do_trap;
>
>  		/*
>  		 * Synchronize this task's top level page-table

I got lost with all the gotos, I think something like this is cleaner

    diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
    index 26293bc053a8..cec8be9e2d6a 100644
    --- a/arch/riscv/mm/fault.c
    +++ b/arch/riscv/mm/fault.c
    @@ -229,8 +229,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
                    pte_t *pte_k;
                    int index;
    
    +               /* User mode accesses just cause a SIGSEGV */
                    if (user_mode(regs))
    -                       goto bad_area;
    +                       return do_trap(regs, SIGSEGV, code, addr, tsk);
    
                    /*
                     * Synchronize this task's top level page-table

Unless anyone has a better idea?

Either way:

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

LMK if you, or anyone else, has a preference.  I'm assuming this will go in
through my tree, so I've picked up my version for now :)
