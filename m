Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A1D2148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCKXNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:13:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKXNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:13:16 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7320314C7307F;
        Mon, 11 Mar 2019 16:13:15 -0700 (PDT)
Date:   Mon, 11 Mar 2019 16:13:13 -0700 (PDT)
Message-Id: <20190311.161313.458909688496508375.davem@davemloft.net>
To:     valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 12/14] sparc64: rtrap: Remove unneeded need_resched()
 loop
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190311224752.8337-13-valentin.schneider@arm.com>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
        <20190311224752.8337-13-valentin.schneider@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 16:13:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>
Date: Mon, 11 Mar 2019 22:47:50 +0000

> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> We seem to be looping back somewhere much higher than the usual
> preempt/need_resched checks, but AFAICT we would just branch to
> 'rtrap_no_irq_enable' and then back to 'to_kernel', which is
> a need_resched() loop with a few extra steps.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/sparc/kernel/rtrap_64.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
> index 29aa34f11720..57fb75686957 100644
> --- a/arch/sparc/kernel/rtrap_64.S
> +++ b/arch/sparc/kernel/rtrap_64.S
> @@ -322,7 +322,6 @@ to_kernel:
>  		 nop
>  		call			preempt_schedule_irq
>  		 nop
> -		ba,pt			%xcc, rtrap
>  #endif
>  kern_fpucheck:	ldub			[%g6 + TI_FPDEPTH], %l5
>  		brz,pt			%l5, rt_continue
> -- 
> 2.20.1
> 

We must re-evaluate the %tstate value stored in ptregs, you cannot
make this change.
