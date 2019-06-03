Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E32C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FC82810B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slkSxFTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfFCMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:45:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36173 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfFCMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:45:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so8864523wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ohIbsv3z1lKkrrdnDFjM2W9vIokFxXA3vkQRstsmaEE=;
        b=slkSxFTdyq+yqZtFmqzTYUUw3TvG4cgGkZs1YBmcAqyDqFM2ZyhWkEhUvGIMhcCJTv
         nbSnmaHm65eEPvxsYx90YQUHsjR7t9fc0PZvQjFNzjtiXBUccvGQ2hmXQAL18ylhL4ez
         ot1TqXSL6eLYTzHLtCJjAJMznp2HCgNkwJDIQarL3cxQYENWygLVaJ3/evUaNAIKJjwS
         4vNNzqWU9MGwqLTPRolB0ZgRbfPl27/AvUyOOraqHUIDvlcKAw5CiAS7pdFLD4qYVfT0
         xUYMHbnhuxKidIFfAmcwwYqt0zJK1GcSGGaVC0uSoXL4WETQMElzDKJObUGQEbfTfg6T
         fpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ohIbsv3z1lKkrrdnDFjM2W9vIokFxXA3vkQRstsmaEE=;
        b=pY7H/qFl7agWxluhnLnkWqFhZAs5tNV4+SusMXOqG86AW9RuEVZNB/3TqjcuZ6fIzD
         1ZIsKj8kbWocAYu+xH3uWvA+vBzptdm9f3MNndnm+oqUSqikLxZEUTf8C4NbJgsdhnNm
         XugQNKH6IoWgqBPYC1GV/3GUfdMxbYaUIQuFwJokJk9yOgiH+l4oeB6muCPhmrkMc4lh
         kIEVDAK+UkJZGSicMOLDs/8Ec/tmykAVCSVOSmQKCvO1Z8Hhcb5cPi6ntxnse40A+gAn
         f+RojhTsLaCbTtsma+6/ivqfW3X0smHQojqIIgxGURVY/1Qezgcyz0OutKVRD35Mlfji
         4V7w==
X-Gm-Message-State: APjAAAVYyfX+qtpjy3Uabi9RrkerEhL9Q/Ls6JQIn2IbQukypk7qto09
        jtHcumvEayWhgQlpM/b/VZJHsw==
X-Google-Smtp-Source: APXvYqyhF6LwJHDLqUb0ExmgiI8+ohdkuXJzzdsEuantb3QfJ0ZlgkmWWXRoaqjdRu5HFeDTgQKsGQ==
X-Received: by 2002:a5d:5747:: with SMTP id q7mr15472311wrw.226.1559565918085;
        Mon, 03 Jun 2019 05:45:18 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id u5sm12949124wmc.32.2019.06.03.05.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 05:45:17 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:45:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: rk808: Check pm_power_off pointer
Message-ID: <20190603124516.GP4797@dell>
References: <20190521062449.29410-1-stefan@olimex.com>
 <20190521062449.29410-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521062449.29410-2-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Stefan Mavrodiev wrote:

> The function pointer pm_power_off may point to function from other
> module (PSCI for example). If rk808 is removed, pm_power_off is
> overwritten to NULL and the system cannot be powered off.
> 
> This patch checks if pm_power_off points to a module function.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Changes in v2:
>  - Initial release actually
> 
>  drivers/mfd/rk808.c       | 13 +++++++------
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 94377782d208..c0b179792bbf 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -438,7 +438,6 @@ static int rk808_probe(struct i2c_client *client,
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
>  	const struct mfd_cell *cells;
> -	void (*pm_pwroff_fn)(void);
>  	int nr_pre_init_regs;
>  	int nr_cells;
>  	int pm_off = 0, msb, lsb;
> @@ -475,7 +474,7 @@ static int rk808_probe(struct i2c_client *client,
>  		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
>  		cells = rk805s;
>  		nr_cells = ARRAY_SIZE(rk805s);
> -		pm_pwroff_fn = rk805_device_shutdown;
> +		rk808->pm_pwroff_fn = rk805_device_shutdown;
>  		break;
>  	case RK808_ID:
>  		rk808->regmap_cfg = &rk808_regmap_config;
> @@ -484,7 +483,7 @@ static int rk808_probe(struct i2c_client *client,
>  		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
>  		cells = rk808s;
>  		nr_cells = ARRAY_SIZE(rk808s);
> -		pm_pwroff_fn = rk808_device_shutdown;
> +		rk808->pm_pwroff_fn = rk808_device_shutdown;
>  		break;
>  	case RK818_ID:
>  		rk808->regmap_cfg = &rk818_regmap_config;
> @@ -493,7 +492,7 @@ static int rk808_probe(struct i2c_client *client,
>  		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
>  		cells = rk818s;
>  		nr_cells = ARRAY_SIZE(rk818s);
> -		pm_pwroff_fn = rk818_device_shutdown;
> +		rk808->pm_pwroff_fn = rk818_device_shutdown;
>  		break;
>  	default:
>  		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
> @@ -548,7 +547,7 @@ static int rk808_probe(struct i2c_client *client,
>  				"rockchip,system-power-controller");
>  	if (pm_off && !pm_power_off) {
>  		rk808_i2c_client = client;
> -		pm_power_off = pm_pwroff_fn;
> +		pm_power_off = rk808->pm_pwroff_fn;
>  	}
>  
>  	return 0;
> @@ -563,7 +562,9 @@ static int rk808_remove(struct i2c_client *client)
>  	struct rk808 *rk808 = i2c_get_clientdata(client);
>  
>  	regmap_del_irq_chip(client->irq, rk808->irq_data);
> -	pm_power_off = NULL;
> +
> +	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
> +		pm_power_off = NULL;

The idea seems sound, but I think you should comment this statement.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
