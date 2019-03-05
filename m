Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09702C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9455206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtRQFInj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCEAeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:34:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCEAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rh/f1hTexU+yxm6S3Ylqpof6qWIK8SB2LJhSZirAoE4=; b=EtRQFInjtlQWc9PZwmQtAL0LA
        C65IXG0NJSJxWi2n9NlWHfW45oFZsyHuA0/6uXtfrH1bV+Im9G1dPObQ08KAILGjoTW8O+/t8GPbI
        ZNJ1LnU+bOHVQork4tYbR2UtL510UXSXTAW7fz1uaTx38B7iRM8a5y4ItMbhThExtHylMme/ccDP0
        a7s+uAAe5jLMO4+a2p1iK+/gQaTZM3JyISKPjKx/s/kdeKnj1OJs5oxDyZnTtmKbPGQJh8Wj+o7JI
        6p7Mbi2NmeTQqh0ihxZmJWYXZZi1k23kk0JaCBt5BzV5taniI3GDo1gECgVrVTJij1lZnUzyWqf+j
        yOVlnkCwg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0y26-0008S1-Nr; Tue, 05 Mar 2019 00:34:10 +0000
Subject: Re: [PATCH] drivers: x86: pcengines-apuv2: fix dependencies
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, arnd@arndb.de
References: <1551745499-6687-1-git-send-email-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <14e2b3bd-b3cd-54f2-e8c6-73c81e89e456@infradead.org>
Date:   Mon, 4 Mar 2019 16:34:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1551745499-6687-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 4:24 PM, Enrico Weigelt, metux IT consult wrote:
> pcengines-apuv2 board driver needs to explicitly select LEDS_CLASS,
> INPUT, INPUT_KEYBOARD, so these are automatically defined correctly
> (eg. LEDS_CLASS=y if PCENGINES_APU2=y)
> 
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: andy.shevchenko@gmail.com
> Cc: arnd@arndb.de
> Cc: rdunlap@infradead.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: arnd@arndb.de
> Reported-by: rdunlap@infradead.org
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/platform/x86/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 851ea92..7d53380 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1307,7 +1307,10 @@ config PCENGINES_APU2
>  	tristate "PC Engines APUv2/3 front button and LEDs driver"
>  	select GPIO_AMD_FCH
>  	select KEYBOARD_GPIO_POLLED
> +	select LEDS_CLASS
>  	select LEDS_GPIO
> +	select INPUT

Nak.  We don't select entire subsystems.  You should do:

	depends on INPUT
	select INPUT_KEYBOARD

> +	select INPUT_KEYBOARD


>  	help
>  	  This driver provides support for the front button and LEDs on
>  	  PC Engines APUv2/APUv3 board.
> 


-- 
~Randy
