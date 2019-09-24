Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D96C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A113214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dgGTrUTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409466AbfIXKaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:30:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37297 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfIXKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:30:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so1438158wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1dDcm1KlH4ckqLpZpvP3m+lSr0e+KppO9076XPTH12A=;
        b=dgGTrUTo/RR3ZjEfLciHO+p36NRTPJrzOss0TNrSfGd/IZbHbGmmg6lkR5lF8Z+qPh
         bH4hKabgQBFJ2N0f9CXOUFMUy/xbMUK6AzTYH7m9fzf2/cl89aKnahJlzTyhwoU4p2xi
         7AP4Fisw3QiFH60O05FagC18cjaoSX3fA1kYd4TFkLPPfIc/awiHe6iFYB7XEVTM2ZPn
         1aPf3/6iDvI1YhGW3PDe3ae0gzdLpOBRntE5C+vVePci5a1i8LBoD81liOTNtOXj2nj2
         ngH/Ll9Da+QrIDmu35+ngBytW/PpjOmbt4aTGQ3VU8hCXzNWqUMzs+J3RENSb0VkWA8z
         L1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1dDcm1KlH4ckqLpZpvP3m+lSr0e+KppO9076XPTH12A=;
        b=t/UAxzR6np6GBYGcsIVH2BbPQ0PyUzQxUvN/6cG98fGGvns4/7loILIi+TJ9mNpCr0
         piUNWSrhNaV6wkTRLl69gpQOCdAX7Qu+M2kbEtKpVEOma8sl4VNb6lh9obB3RkKhUdtn
         StoRq0NkpodAyIVgHs3w2pPPEca8BNPb2FeS8bBz0moPygDIeeQ1REZq8Ow7UQVv0l12
         cLP8CDfKt7aal4KksZ65QchTCW9k/lJH4DY3KHMpOhQgBWNYVL7yI9VMApxv5jvgMdIw
         wS8hGWqktv9wDs+xXUpSQIwRSD2Pb5KGv1Y5LIJcH0N8ZL5SKvcfLYworeWjSU6hWqBT
         0s2Q==
X-Gm-Message-State: APjAAAVZLOEFR4rA0RsFjjIvDv4pU/NmjyANZ4Q/8MnG3tJ7f9+5Ur9C
        MTR5sh5qE7ID/SdF7bA8AT+A97O198NXRQ==
X-Google-Smtp-Source: APXvYqzICaVlop/bOo0XAWLVnr11124npNH4TW6Oy+kCHxEOnOW/vI6Xa7Rr8RRNXC7wM9G7fxQOBw==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr2013163wml.157.1569321008526;
        Tue, 24 Sep 2019 03:30:08 -0700 (PDT)
Received: from [108.177.15.109] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id 3sm1412791wmo.22.2019.09.24.03.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:30:07 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] microblaze: entry: Remove unneeded need_resched()
 loop
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190923143620.29334-1-valentin.schneider@arm.com>
 <20190923143620.29334-6-valentin.schneider@arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <feebf264-a311-9777-cd9b-5d227e8f6d3c@monstr.eu>
Date:   Tue, 24 Sep 2019 12:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923143620.29334-6-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 09. 19 16:36, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/kernel/entry.S | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
> index 4e1b567becd6..de7083bd1d24 100644
> --- a/arch/microblaze/kernel/entry.S
> +++ b/arch/microblaze/kernel/entry.S
> @@ -738,14 +738,9 @@ no_intr_resched:
>  	andi	r5, r5, _TIF_NEED_RESCHED;
>  	beqi	r5, restore /* if zero jump over */
>  
> -preempt:
>  	/* interrupts are off that's why I am calling preempt_chedule_irq */
>  	bralid	r15, preempt_schedule_irq
>  	nop
> -	lwi	r11, CURRENT_TASK, TS_THREAD_INFO;	/* get thread info */
> -	lwi	r5, r11, TI_FLAGS;		/* get flags in thread info */
> -	andi	r5, r5, _TIF_NEED_RESCHED;
> -	bnei	r5, preempt /* if non zero jump to resched */
>  restore:
>  #endif
>  	VM_OFF /* MS: turn off MMU */
> 

Looks reasonable and also tested on HW. I expect you want me to take it
via microblaze tree that's why applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

