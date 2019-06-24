Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfFXSXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:23:45 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47681 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfFXSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:23:45 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2B0DC1C0005;
        Mon, 24 Jun 2019 18:23:34 +0000 (UTC)
Date:   Mon, 24 Jun 2019 20:23:33 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab+samsung@kernel.org,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] thermal: sun8i: support ahb clocks
Message-ID: <20190624182333.di7avywtdvzwukms@flea>
References: <20190623164206.7467-1-tiny.windzz@gmail.com>
 <20190623164206.7467-9-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623164206.7467-9-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 12:42:03PM -0400, Yangtao Li wrote:
> H3 has extra clock, so introduce something in ths_thermal_chip/ths_device
> and adds the process of the clock.
>
> This is pre-work for supprt it.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/thermal/sun8i_thermal.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
> index ed1c19bb27cf..04f53ffb6a14 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -54,6 +54,7 @@ struct tsensor {
>  };
>
>  struct ths_thermal_chip {
> +	bool            has_ahb_clk;
>  	int		sensor_num;
>  	int		offset;
>  	int		scale;
> @@ -69,6 +70,7 @@ struct ths_device {
>  	struct regmap				*regmap;
>  	struct reset_control			*reset;
>  	struct clk				*bus_clk;
> +	struct clk                              *ahb_clk;

Hmm, thinking a bit about this, the name of those two clocks doesn't
make sense. AHB is the bus being used to access that device, so the
bus clock is the AHB clock.

What is that clock being used for?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
