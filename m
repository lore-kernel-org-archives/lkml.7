Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77EC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF82073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLINeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:34:17 -0500
Received: from foss.arm.com ([217.140.110.172]:60694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfLINeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:34:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E694328;
        Mon,  9 Dec 2019 05:34:14 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B0F3F718;
        Mon,  9 Dec 2019 05:34:12 -0800 (PST)
Subject: Re: [RFCv1 2/8] mfd: rk808: use syscore for RK805 PMIC shutdown
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191206184536.2507-1-linux.amoon@gmail.com>
 <20191206184536.2507-3-linux.amoon@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f1327196-66c9-d152-c0ca-914d43d6f55e@arm.com>
Date:   Mon, 9 Dec 2019 13:34:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206184536.2507-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 6:45 pm, Anand Moon wrote:
> Use common syscore_shutdown for RK805 PMIC to do
> clean I2C shutdown, drop the unused pm_pwroff_prep_fn
> and pm_pwroff_fn function pointers.

Coincidentally, I've also been looking at RK805 for the sake of trying 
to get suspend to behave on my RK3328 box, and I've ended up with some 
slightly different cleanup patches - I'll tidy them up and post them for 
comparison as soon as I can.

> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/mfd/rk808.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index e637f5bcc8bb..713d989064ba 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -467,16 +467,6 @@ static void rk808_update_bits(unsigned int reg, unsigned int mask,
>   			"can't write to register 0x%x: %x!\n", reg, ret);
>   }
>   
> -static void rk805_device_shutdown(void)
> -{
> -	rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);
> -}
> -
> -static void rk805_device_shutdown_prepare(void)
> -{
> -	rk808_update_bits(RK805_GPIO_IO_POL_REG, SLP_SD_MSK, SHUTDOWN_FUN);
> -}
> -
>   static void rk808_device_shutdown(void)
>   {
>   	rk808_update_bits(RK808_DEVCTRL_REG, DEV_OFF_RST, DEV_OFF_RST);
> @@ -491,10 +481,23 @@ static void rk8xx_syscore_shutdown(void)
>   {
>   	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>   
> -	if (system_state == SYSTEM_POWER_OFF &&
> -	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
> -		rk808_update_bits(RK817_SYS_CFG(3), RK817_SLPPIN_FUNC_MSK,
> -				SLPPIN_DN_FUN);
> +	if (system_state == SYSTEM_POWER_OFF) {
> +		dev_info(&rk808_i2c_client->dev, "System Shutdown Event\n");
> +
> +		switch (rk808->variant) {
> +		case RK805_ID:
> +			rk808_update_bits(RK805_GPIO_IO_POL_REG,
> +					SLP_SD_MSK, SHUTDOWN_FUN);
> +			rk808_update_bits(RK805_DEV_CTRL_REG, DEV_OFF, DEV_OFF);

Why this change? Shutdown via the SLEEP pin is working just fine on my 
box :/

Robin.

> +			break;
> +		case RK809_ID:
> +		case RK817_ID:
> +			rk808_update_bits(RK817_SYS_CFG(3),
> +					RK817_SLPPIN_FUNC_MSK, SLPPIN_DN_FUN);
> +			break;
> +		default:
> +			break;
> +		}
>   	}
>   }
>   
> @@ -565,8 +568,6 @@ static int rk808_probe(struct i2c_client *client,
>   		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
>   		cells = rk805s;
>   		nr_cells = ARRAY_SIZE(rk805s);
> -		rk808->pm_pwroff_fn = rk805_device_shutdown;
> -		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
>   		break;
>   	case RK808_ID:
>   		rk808->regmap_cfg = &rk808_regmap_config;
> 
