Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3072C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30921556
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:32:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44186 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfLIMcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:32:41 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ieIDP-0000Ql-D2; Mon, 09 Dec 2019 13:32:39 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rk808: Always use poweroff when requested
Date:   Mon, 09 Dec 2019 13:32:38 +0100
Message-ID: <6655566.N6zq5d2jo2@diego>
In-Reply-To: <20191209115746.12953-1-smoch@web.de>
References: <20191209115746.12953-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Dezember 2019, 12:57:46 CET schrieb Soeren Moch:
> With the device tree property "rockchip,system-power-controller" we
> explicitly request to use this PMIC to power off the system. So always
> register our poweroff function, even if some other handler (probably
> PSCI poweroff) was registered before.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>

Sounds very sensible
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mfd/rk808.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index a69a6742ecdc..616e44e7ef98 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -550,7 +550,7 @@ static int rk808_probe(struct i2c_client *client,
>  	const struct mfd_cell *cells;
>  	int nr_pre_init_regs;
>  	int nr_cells;
> -	int pm_off = 0, msb, lsb;
> +	int msb, lsb;
>  	unsigned char pmic_id_msb, pmic_id_lsb;
>  	int ret;
>  	int i;
> @@ -674,16 +674,9 @@ static int rk808_probe(struct i2c_client *client,
>  		goto err_irq;
>  	}
> 
> -	pm_off = of_property_read_bool(np,
> -				"rockchip,system-power-controller");
> -	if (pm_off && !pm_power_off) {
> +	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
>  		rk808_i2c_client = client;
>  		pm_power_off = rk808->pm_pwroff_fn;
> -	}
> -
> -	if (pm_off && !pm_power_off_prepare) {
> -		if (!rk808_i2c_client)
> -			rk808_i2c_client = client;
>  		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
>  	}
> 
> --
> 2.17.1
> 




