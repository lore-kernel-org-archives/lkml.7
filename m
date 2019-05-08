Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAD_CREDIT,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4DC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED1D205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpAMFlCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfEHAWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:22:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEHAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWO/9ptkBLOrl8A8NUi53jiFeyN64qGSfvbgrndrtbo=; b=SpAMFlCH6K4M7bsqb08ihwS/N
        Yl0CXJty8JhbqTLyJFC9QapOrD/iWLCbbDba9U4FC/w6YOd6CzCe9RTbkizzqHIGHPhjd4R8fLFxR
        X6jD9PlM1BD79uYPMpSJ+rtZdeOnbAysA0QbnAeRyc5eXb3zZ+OB4zftlOy8iXDkTaRG1n5YvATrH
        PEb9AYNBgVmNKWPUQKQMb+bZaiOj7rdytquLA4GAAGkjJLWXp9CHbgf8SVtAGCWj6bkuCd9BBspfP
        IVaiad05KG4CALD5zwknX1xG1ypOY9NAflJTvDyebYOVFVjG5A7Xsu0nFVv08H4mXo3pDULVy2e1c
        cw0XaVbPA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOAM0-0003wn-MB; Wed, 08 May 2019 00:22:36 +0000
Subject: Re: [PATCH] watchdog: fix watchdog_pretimeout.c build error when no
 default gov. is set
To:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <ec5a2b04-2649-e527-bcfd-4e708808e681@infradead.org>
 <aace995d-a076-2fc5-8456-1e2638e4faa6@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9fa3055a-a666-021c-6e3e-2d3b6ba4e542@infradead.org>
Date:   Tue, 7 May 2019 17:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aace995d-a076-2fc5-8456-1e2638e4faa6@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 5:07 PM, Guenter Roeck wrote:
> On 5/7/19 4:33 PM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build error when
>> CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
>> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP is not set
>> # CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
>>
>> Fixes this build error:
>>
>> ../drivers/watchdog/watchdog_pretimeout.c: In function ‘watchdog_register_governor’:
>> ../drivers/watchdog/watchdog_pretimeout.c:139:26: error: ‘WATCHDOG_PRETIMEOUT_DEFAULT_GOV’ undeclared (first use in this function)
>>    if (!strncmp(gov->name, WATCHDOG_PRETIMEOUT_DEFAULT_GOV,
>>
> 
> Ah, I knew I missed something. The following would be a better fix,
> though, since it enforces that at least one pretimeout governor is enabled
> (matching the old code):
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e19960ace0c0..4a3461afa96f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -71,6 +71,12 @@ config WATCHDOG_PRETIMEOUT_GOV
>         help
>           The option allows to select watchdog pretimeout governors.
> 
> +config WATCHDOG_PRETIMEOUT_GOV_SEL
> +       tristate
> +       depends on WATCHDOG_PRETIMEOUT_GOV
> +       default m
> +       select WATCHDOG_PRETIMEOUT_GOV_PANIC if WATCHDOG_PRETIMEOUT_GOV_NOOP=n
> +
>  if WATCHDOG_PRETIMEOUT_GOV
> 
> Can you send v2 with the above, or do you want me to send it and give you credit ?
> 
> Thanks,
> Guenter

Hi Guenter,
That's your patch.  You can send it.  :)
No credit needed.

cheers.
-- 
~Randy
