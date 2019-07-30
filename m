Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1422FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD3B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L+7PVbck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfG3ITX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:19:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfG3ITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F2rnQ0Lr6CdhFqGeczn802S4cDwdKEyLRCWMxDYq+OY=; b=L+7PVbckmPhZKViRTgrJ8zaXz
        uOW2wrawT+hMgtM2vuPOXuznz7rgf97Js+m6VBrgyf1GICTh3taoKNu7TfC4XUUwx4NwibQHEynun
        35Nuy51xhjNQUduXwnsBBQHA2eaf/8YeOW7O9kSrFgVlDnm9ckApA758cm4/V7t5e4jCPATfEOroX
        4DLUB9ewWYOEStda9Lh9KWHTCxzDt3JpbaI8UiMgKrF0jhZEa1aYvaXaTp4YjF6ioHi7+qpQtOtFl
        yJZQzQHx+9WjGOuJtaITKKke+VkjhpJgVhWZtSEIqlvFB7/IzmU4Q/PHWnUnQU/YK2ULc9TtKs1Ln
        tb6xYlBIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNLt-0006dI-AE; Tue, 30 Jul 2019 08:19:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FC3220D27EAB; Tue, 30 Jul 2019 10:19:19 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:19:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Santosh Sivaraj <santosh@fossix.org>
Cc:     x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] x86/mce: Remove redundant irq work
Message-ID: <20190730081919.GI31381@hirez.programming.kicks-ass.net>
References: <20190730061520.19953-1-santosh@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730061520.19953-1-santosh@fossix.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:45:20AM +0530, Santosh Sivaraj wrote:
> IRQ work currently only does a schedule work to process the mce
> events. Since irq work does no other function, remove it.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

NAK this is broken. MCE is NMI like.

> ---
>  arch/x86/kernel/cpu/mce/core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 743370ee4983..658da808c031 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -119,7 +119,7 @@ DEFINE_PER_CPU(mce_banks_t, mce_poll_banks) = {
>  mce_banks_t mce_banks_ce_disabled;
>  
>  static struct work_struct mce_work;
> -static struct irq_work mce_irq_work;
> +static void mce_schedule_work(void);
>  
>  static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
>  
> @@ -154,7 +154,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
>  void mce_log(struct mce *m)
>  {
>  	if (!mce_gen_pool_add(m))
> -		irq_work_queue(&mce_irq_work);
> +		mce_schedule_work();
>  }
>  
>  void mce_inject_log(struct mce *m)
> @@ -472,11 +472,6 @@ static void mce_schedule_work(void)
>  		schedule_work(&mce_work);
>  }
>  
> -static void mce_irq_work_cb(struct irq_work *entry)
> -{
> -	mce_schedule_work();
> -}
> -
>  /*
>   * Check if the address reported by the CPU is in a format we can parse.
>   * It would be possible to add code for most other cases, but all would
> @@ -1333,7 +1328,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  		mce_panic("Fatal machine check on current CPU", &m, msg);
>  
>  	if (worst > 0)
> -		irq_work_queue(&mce_irq_work);
> +		mce_schedule_work();
>  
>  	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
>  
> @@ -1984,7 +1979,6 @@ int __init mcheck_init(void)
>  	mcheck_vendor_init_severity();
>  
>  	INIT_WORK(&mce_work, mce_gen_pool_process);
> -	init_irq_work(&mce_irq_work, mce_irq_work_cb);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 
