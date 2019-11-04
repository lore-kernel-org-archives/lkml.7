Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B87CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A4221744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfKDIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:12:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44045 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:12:06 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXSw-0007k4-NO; Mon, 04 Nov 2019 09:11:58 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXSv-0007lA-Q7; Mon, 04 Nov 2019 09:11:57 +0100
Date:   Mon, 4 Nov 2019 09:11:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/7] pwm: sun4i: Add an optional probe for reset line
Message-ID: <20191104081157.373v22atswsaktbe@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191103203334.10539-3-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

adding Philipp Zabel (= reset controller maintainer) to Cc: and so I'm
not stripping the uncommented parts of the patch.

On Sun, Nov 03, 2019 at 09:33:29PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM core needs deasserted reset line in order to work.
> 
> Add an optional probe for it.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6f5840a1a82d..d194b8ebdb00 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/time.h>
> @@ -78,6 +79,7 @@ struct sun4i_pwm_data {
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> +	struct reset_control *rst;
>  	void __iomem *base;
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
> @@ -365,6 +367,20 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> +	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(pwm->rst)) {
> +		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
> +			return PTR_ERR(pwm->rst);
> +		dev_info(&pdev->dev, "no reset control found\n");

I would degrade this to a dev_dbg. Otherwise this spams the log for all
unaffected machines. devm_reset_control_get_optional() is defined in a
section that has a comment "These inline function calls will be removed
once all consumers have been moved over to the new explicit API.", so I
guess you want devm_reset_control_get_optional_exclusive or even
devm_reset_control_get_optional_shared here.

@Philipp: maybe a check in checkpatch that warns about introduction of
such new instances would be good?!

> +	}
> +
> +	/* Deassert reset */
> +	ret = reset_control_deassert(pwm->rst);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot deassert reset control\n");
> +		return ret;
> +	}
> +
>  	pwm->chip.dev = &pdev->dev;
>  	pwm->chip.ops = &sun4i_pwm_ops;
>  	pwm->chip.base = -1;
> @@ -377,19 +393,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	ret = pwmchip_add(&pwm->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> -		return ret;
> +		goto err_pwm_add;
>  	}
>  
>  	platform_set_drvdata(pdev, pwm);
>  
>  	return 0;
> +
> +err_pwm_add:
> +	reset_control_assert(pwm->rst);
> +
> +	return ret;
>  }
>  
>  static int sun4i_pwm_remove(struct platform_device *pdev)
>  {
>  	struct sun4i_pwm_chip *pwm = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&pwm->chip);
> +	if (ret)
> +		return ret;
> +
> +	reset_control_assert(pwm->rst);
>  
> -	return pwmchip_remove(&pwm->chip);
> +	return 0;
>  }
>  
>  static struct platform_driver sun4i_pwm_driver = {

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
