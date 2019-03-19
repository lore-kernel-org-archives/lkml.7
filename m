Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BA1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC602206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCSQpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:45:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54507 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:45:11 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6HrQ-0006lN-OA; Tue, 19 Mar 2019 17:45:08 +0100
Message-ID: <1553013908.6482.10.camel@pengutronix.de>
Subject: Re: [PATCH 4/5] soc/tegra: pmc: Implement acquire/release for resets
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 17:45:08 +0100
In-Reply-To: <20190221152557.8534-4-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
         <20190221152557.8534-4-thierry.reding@gmail.com>
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
> By implementing the acquire/release protocol, the resets can be shared
> with other drivers that also adhere to this protocol. This will be used
> for example by the SOR driver to put hardware into a known good state,
> irrespective of whether or not the power domain can be reset.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 0df258518693..0c5f79528e5f 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -656,10 +656,15 @@ static int tegra_genpd_power_on(struct generic_pm_domain *domain)
>  	int err;
>  
>  	err = tegra_powergate_power_up(pg, true);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to turn on PM domain %s: %d\n",
>  			pg->genpd.name, err);
> +		goto out;
> +	}
>  
> +	reset_control_release(pg->reset);
> +
> +out:
>  	return err;
>  }
>  
> @@ -669,10 +674,18 @@ static int tegra_genpd_power_off(struct generic_pm_domain *domain)
>  	struct device *dev = pg->pmc->dev;
>  	int err;
>  
> +	err = reset_control_acquire(pg->reset);
> +	if (err < 0) {
> +		pr_err("failed to acquire resets: %d\n", err);
> +		return err;
> +	}
> +
>  	err = tegra_powergate_power_down(pg);
> -	if (err)
> +	if (err) {
>  		dev_err(dev, "failed to turn off PM domain %s: %d\n",
>  			pg->genpd.name, err);
> +		reset_control_release(pg->reset);
> +	}
>  
>  	return err;
>  }
> @@ -937,20 +950,34 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
>  	struct device *dev = pg->pmc->dev;
>  	int err;
>  
> -	pg->reset = of_reset_control_array_get_exclusive(np);
> +	pg->reset = of_reset_control_array_get_exclusive_released(np);
>  	if (IS_ERR(pg->reset)) {
>  		err = PTR_ERR(pg->reset);
>  		dev_err(dev, "failed to get device resets: %d\n", err);
>  		return err;
>  	}
>  
> -	if (off)
> +	err = reset_control_acquire(pg->reset);
> +	if (err < 0) {
> +		pr_err("failed to acquire resets: %d\n", err);
> +		goto out;
> +	}
> +
> +	if (off) {
>  		err = reset_control_assert(pg->reset);
> -	else
> +	} else {
>  		err = reset_control_deassert(pg->reset);
> +		if (err < 0)
> +			goto out;
>  
> -	if (err)
> +		reset_control_release(pg->reset);
> +	}
> +
> +out:
> +	if (err) {
> +		reset_control_release(pg->reset);
>  		reset_control_put(pg->reset);
> +	}
>  
>  	return err;
>  }

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
