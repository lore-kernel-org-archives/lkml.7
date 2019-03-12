Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED3C2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="h4Okru7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCLSgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:36:41 -0400
Received: from vern.gendns.com ([98.142.107.122]:56604 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=85h4gBEV7nQw3cKXv1BtTUbQD8JmJx1V+D4HNt/7l+Q=; b=h4Okru7EjBNWlZvyEkpYkDLbtT
        KohUiphnn5a6By1ZdsYotVg5azyurcmJ2C/KfOIGS8f6q9qdPLTgpex9ECqYE8EEixFVjJ8OPbwwY
        RVnpuS1VU/K9JiqctN3dr+llvqdZqUFovm6F4IOw2m5Mr+ML/Jwd0AFKAjacg9XNxYZry0k9/qgMc
        O2IY/X+rksvT16vmpS3/Vc7xuAR9d8G+SIaEnaVI0L8XoSF8i3lMACl0eIQdETordDqUdMMWnlKgm
        XBlP18QUd9HZbFNTckXsusp6rqF9RX/TgAwXdbSn26LfdRdqwvDfgRRXe24iUsQehBVs/8etdE1qV
        qIYZztKQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37214 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1h3mFR-00067A-Af; Tue, 12 Mar 2019 14:35:33 -0400
Subject: Re: [PATCH v3 04/11] ARM: davinci: da850: switch to using the
 clocksource driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190226120633.18200-1-brgl@bgdev.pl>
 <20190226120633.18200-5-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <8c8cfed0-f52b-06c7-21e2-38039dc99a71@lechnology.com>
Date:   Tue, 12 Mar 2019 13:36:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226120633.18200-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 6:06 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have a proper clocksource driver for davinci. Switch the da850
> platform to using it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

>   arch/arm/mach-davinci/da850.c | 41 ++++++++++-------------------------
>   1 file changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 72d64d39d42a..5ce58ae0d764 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -34,7 +34,8 @@
>   #include <mach/cputype.h>
>   #include <mach/da8xx.h>
>   #include <mach/pm.h>
> -#include <mach/time.h>
> +
> +#include <clocksource/timer-davinci.h>
>   
>   #include "irqs.h"
>   #include "mux.h"
> @@ -332,38 +333,17 @@ static struct davinci_id da850_ids[] = {
>   	},
>   };
>   
> -static struct davinci_timer_instance da850_timer_instance[4] = {
> -	{
> -		.base		= DA8XX_TIMER64P0_BASE,
> -		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
> -		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
> -	},
> -	{
> -		.base		= DA8XX_TIMER64P1_BASE,
> -		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
> -		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
> -	},
> -	{
> -		.base		= DA850_TIMER64P2_BASE,
> -		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_2),
> -		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_2),
> -	},
> -	{
> -		.base		= DA850_TIMER64P3_BASE,
> -		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_3),
> -		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_3),
> -	},
> -};
> -
>   /*
>    * T0_BOT: Timer 0, bottom		: Used for clock_event
>    * T0_TOP: Timer 0, top			: Used for clocksource
>    * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer

It looks like we could drop the mention of the watchdog timer here.
And T0_BOT/T0_TOP don't really have a meaning anymore.

>    */
> -static struct davinci_timer_info da850_timer_info = {
> -	.timers		= da850_timer_instance,
> -	.clockevent_id	= T0_BOT,
> -	.clocksource_id	= T0_TOP,
> +static const struct davinci_timer_cfg da850_timer_cfg = {
> +	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
> +	.irq = {
> +		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
> +		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0)),
> +	},
>   };
