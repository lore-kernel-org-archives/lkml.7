Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,TVD_APPROVED,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB5C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698E42070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559094529;
	bh=vrJ0W39LlG7QS5h27M0BRcOjwjgHf4WOVaNRp/uxMo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M1H6GVSS8TChbbwv/nYRvueonlmMtU+g0hQ+zvyHX9f29s/e9iboGvHZ0q3qrVyzY
	 W0b607Ot+oTP6zxqwweZDeVt3/1E6Su2fag4r4n5ok8uVLHu2imouwUfBrRSAkGbkO
	 BcQca3P58P9Sn8Kqe+dsjmiaLvXMewvaHtXZU46Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfE2Bss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfE2Bss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:48:48 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C31D206E0;
        Wed, 29 May 2019 01:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559094527;
        bh=vrJ0W39LlG7QS5h27M0BRcOjwjgHf4WOVaNRp/uxMo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yTAbpzhQLYPsy9Tqzk3Q/Z+scgI3dgLvt5ETgxG8sUxf1xhXdfP7TcgK7JVXqUDTO
         YNDaI32lVW5DDFetDCcNfVO24fl2uQXXaGSq4q1oDEtk9FFJM8mno+MNAid9bligWB
         50eHMqm57FXTZ5meiT3+q26HM8Qu0aS5GqGrX4bQ=
Date:   Wed, 29 May 2019 09:48:41 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/7] csky: entry: Remove unneeded need_resched()
 loop
Message-ID: <20190529014841.GA23749@guoren-Inspiron-7460>
References: <20190528104848.13160-1-valentin.schneider@arm.com>
 <20190528104848.13160-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528104848.13160-3-valentin.schneider@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Valentin,

You are right, Approved.

Best Regards
 Guo Ren

On Tue, May 28, 2019 at 11:48:43AM +0100, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/csky/kernel/entry.S | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index a7e84ccccbd8..679afbcc2001 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -292,11 +292,7 @@ ENTRY(csky_irq)
>  	ldw	r8, (r9, TINFO_FLAGS)
>  	btsti	r8, TIF_NEED_RESCHED
>  	bf	2f
> -1:
>  	jbsr	preempt_schedule_irq	/* irq en/disable is done inside */
> -	ldw	r7, (r9, TINFO_FLAGS)	/* get new tasks TI_FLAGS */
> -	btsti	r7, TIF_NEED_RESCHED
> -	bt	1b			/* go again */
>  #endif
>  2:
>  	jmpi	ret_from_exception
> -- 
> 2.20.1
> 
