Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8824C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D75F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393890AbfIJPQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:16:09 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47511 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfIJPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:16:08 -0400
X-Originating-IP: 148.69.85.38
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 684E51C0004;
        Tue, 10 Sep 2019 15:16:06 +0000 (UTC)
Date:   Tue, 10 Sep 2019 17:16:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH 1/2] clk: at91: fix update bit maps on CFG_MOR write
Message-ID: <20190910151603.GZ21254@piout.net>
References: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2019 15:30:31+0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The regmap update bits call was not selecting the proper mask, considering
> the bits which was updating.
> Update the mask from call to also include OSCBYPASS.
> Removed MOSCEN which was not updated.
> 
> Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> index f607ee7..ebe9b99 100644
> --- a/drivers/clk/at91/clk-main.c
> +++ b/drivers/clk/at91/clk-main.c
> @@ -152,7 +152,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
>  	if (bypass)
>  		regmap_update_bits(regmap,
>  				   AT91_CKGR_MOR, MOR_KEY_MASK |
> -				   AT91_PMC_MOSCEN,
> +				   AT91_PMC_OSCBYPASS,
>  				   AT91_PMC_OSCBYPASS | AT91_PMC_KEY);
>  
>  	hw = &osc->hw;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
