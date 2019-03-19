Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401E206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCSQpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:45:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42299 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:45:14 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6HrS-0006lW-Rb; Tue, 19 Mar 2019 17:45:10 +0100
Message-ID: <1553013910.6482.11.camel@pengutronix.de>
Subject: Re: [PATCH 5/5] drm/tegra: sor: Implement acquire/release for reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 17:45:10 +0100
In-Reply-To: <20190221152557.8534-5-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
         <20190221152557.8534-5-thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 16:25 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> By implementing the acquire/release protocol, the SOR reset can be
> shared with other drivers that also adhere to this protocol, such as the
> PMC driver that uses the same reset as part of the powergate and -ungate
> implementation using generic power domains.
> 
> Runtime PM makes sure that the operations are executed in the right
> order, and the reset core has error handling and WARNs in place to make
> sure the acquire/release protocol is followed.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpu/drm/tegra/sor.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 40057106f5f3..5be5a0817dfe 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -2871,6 +2871,13 @@ static int tegra_sor_init(struct host1x_client *client)
>  	 * kernel is possible.
>  	 */
>  	if (sor->rst) {
> +		err = reset_control_acquire(sor->rst);
> +		if (err < 0) {
> +			dev_err(sor->dev, "failed to acquire SOR reset: %d\n",
> +				err);
> +			return err;
> +		}
> +
>  		err = reset_control_assert(sor->rst);
>  		if (err < 0) {
>  			dev_err(sor->dev, "failed to assert SOR reset: %d\n",
> @@ -2894,6 +2901,8 @@ static int tegra_sor_init(struct host1x_client *client)
>  				err);
>  			return err;
>  		}
> +
> +		reset_control_release(sor->rst);
>  	}
>  
>  	err = clk_prepare_enable(sor->clk_safe);
> @@ -3331,7 +3340,7 @@ static int tegra_sor_probe(struct platform_device *pdev)
>  		goto remove;
>  	}
>  
> -	sor->rst = devm_reset_control_get(&pdev->dev, "sor");
> +	sor->rst = devm_reset_control_get_exclusive_released(&pdev->dev, "sor");
>  	if (IS_ERR(sor->rst)) {
>  		err = PTR_ERR(sor->rst);
>  
> @@ -3519,6 +3528,8 @@ static int tegra_sor_suspend(struct device *dev)
>  			dev_err(dev, "failed to assert reset: %d\n", err);
>  			return err;
>  		}
> +
> +		reset_control_release(sor->rst);
>  	}
>  
>  	usleep_range(1000, 2000);
> @@ -3542,9 +3553,17 @@ static int tegra_sor_resume(struct device *dev)
>  	usleep_range(1000, 2000);
>  
>  	if (sor->rst) {
> +		err = reset_control_acquire(sor->rst);
> +		if (err < 0) {
> +			dev_err(dev, "failed to acquire reset: %d\n", err);
> +			clk_disable_unprepare(sor->clk);
> +			return err;
> +		}
> +
>  		err = reset_control_deassert(sor->rst);
>  		if (err < 0) {
>  			dev_err(dev, "failed to deassert reset: %d\n", err);
> +			reset_control_release(sor->rst);
>  			clk_disable_unprepare(sor->clk);
>  			return err;
>  		}

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
