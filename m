Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFD220449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698705;
	bh=TWHAWZg1oz+onYqFOauH5y08DI3/Kwu7W8Otd0JRnoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gd6svGMnA8t+KBvYbFjiGl8M6eleXKHZfWi+E3DkvQ4ctLRY/FrpXlBXM8grJHHD9
	 1n53Wyr1fTQBaGPO7Yp245vvraC++6UQgzRIkoHCfO4cwMP8z4fBAjO1bVAToVhP/6
	 i/0Va2H6F1NnocwHeoIj4qH0PflO98Qx7Y9TY4S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfDSSbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4610A2190B;
        Fri, 19 Apr 2019 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555672710;
        bh=TWHAWZg1oz+onYqFOauH5y08DI3/Kwu7W8Otd0JRnoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLxccr+4s21gR0deaKtlBKCkRwMYGYQGd6IGNBTzB0bX6NJ+/X4GgBFtcHcKoAmL7
         qtbT5xKb4GUavH9L+F4znp+rn3oVBT/wTUWDTQwc0P9F7g8jcVgC/mTR4cxLoRQdQc
         Vq2HGzU73zKdbCutfiLuFuTRfyzuO1LGjwR6Zg7g=
Date:   Fri, 19 Apr 2019 19:18:25 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] csky: add page fault perf event support
Message-ID: <20190419111825.GA20554@guoren-Inspiron-7460>
References: <46349332f41f16896afde240973764c385d78cd3.1555568371.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46349332f41f16896afde240973764c385d78cd3.1555568371.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, nice Job, Maomao

On Thu, Apr 18, 2019 at 02:20:40PM +0800, Mao Han wrote:
> This patch add support for page fault count, major fault count
> and minorfault count. Without this patch page faults are not
> sampled for perf event.
> 
>  Performance counter stats for '/usr/lib/perf-test/callchain_test':
>                  0      page-faults               #    0.000 K/sec
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> ---
>  arch/csky/mm/fault.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index e1725f8..d07141d 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -17,6 +17,7 @@
>  #include <linux/vt_kern.h>
>  #include <linux/extable.h>
>  #include <linux/uaccess.h>
> +#include <linux/perf_event.h>
>  
>  #include <asm/hardirq.h>
>  #include <asm/mmu_context.h>
> @@ -106,6 +107,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>  		return;
>  	}
>  #endif
> +
> +	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  	/*
>  	 * If we're in an interrupt or have no user
>  	 * context, we must not take the fault..
> @@ -153,10 +156,15 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
>  			goto bad_area;
>  		BUG();
>  	}
> -	if (fault & VM_FAULT_MAJOR)
> +	if (fault & VM_FAULT_MAJOR) {
>  		tsk->maj_flt++;
> -	else
> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
> +			      address);
> +	} else {
>  		tsk->min_flt++;
> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
> +			      address);
> +	}
>  
>  	up_read(&mm->mmap_sem);
>  	return;
> -- 
> 2.7.4
> 
