Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBB8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94D12073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfG2Gkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:40:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60109 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfG2Gkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:40:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzKh-0006rA-Ca; Mon, 29 Jul 2019 08:40:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hrzKg-0003NX-Tb; Mon, 29 Jul 2019 08:40:30 +0200
Date:   Mon, 29 Jul 2019 08:40:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, kernel@pengutronix.de
Subject: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Message-ID: <20190729064030.7uenld2kbof45zti@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726184045.14669-5-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> Now that sun4i PWM driver supports deasserting reset line and enabling
> bus clock, support for H6 PWM can be added.
> 
> Note that while H6 PWM has two channels, only first one is wired to
> output pin. Second channel is used as a clock source to companion AC200
> chip which is bundled into same package.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/pwm/pwm-sun4i.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 7d3ac3f2dc3f..9e0eca79ff88 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data sun4i_pwm_single_bypass = {
>  	.npwm = 1,
>  };
>  
> +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst = {
> +	.has_bus_clock = true,
> +	.has_prescaler_bypass = true,
> +	.has_reset = true,
> +	.npwm = 2,
> +};
> +
>  static const struct of_device_id sun4i_pwm_dt_ids[] = {
>  	{
>  		.compatible = "allwinner,sun4i-a10-pwm",
> @@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
>  	}, {
>  		.compatible = "allwinner,sun8i-h3-pwm",
>  		.data = &sun4i_pwm_single_bypass,
> +	}, {
> +		.compatible = "allwinner,sun50i-h6-pwm",
> +		.data = &sun50i_pwm_dual_bypass_clk_rst,

If you follow my suggestion for the two previous patches, you can just
use:

	compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";

and drop this patch.

Best regards
Uwe

>  	}, {
>  		/* sentinel */
>  	},
> -- 
> 2.22.0
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
