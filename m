Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD0C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233520663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oEEPl7PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfFZLyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:54:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42556 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfFZLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:54:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so2376921wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T1u8/nO2ihXA3qg4xnmoP2DlkB1dnveETSZSrMNRfSE=;
        b=oEEPl7PGp2yDGgQlpMIT9CDuA8EaBW2aDv4LKDx3jzAasANl+MgbubGI8TDqHbuRNy
         XfivoVJgBZ1Bep/dM5tMDxCu2yliu0Ff0UxJDZrHJ4xRmQYRga11k/qthaUoD2zgt2bC
         ceMy+Db8M+Lmut5drD8EUrPFy2Rb+kwGy2B3BV/YYU2egpNRi5myDVorKaXRBrEg62Su
         vPCNQoLMWtVv6nTfJseJmQR2w811Z+fiWY6MWZ7hM09+xLVsub4wmhCAtKivMnIUTkA6
         YRJL0JX+NuYiWCOy4/S6xgcC7Lt7BD/Apc6uiHhXtC36D2dvKZJRGAtc/LdEhtgmdIYj
         eioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T1u8/nO2ihXA3qg4xnmoP2DlkB1dnveETSZSrMNRfSE=;
        b=ZVIFjM6BcfZveSSfHcm1LNx2a2kg2CowKpNvgi4T8+B+It3UUHFS5ZrIyjnpk1jgX7
         ClQ41OD3WK6iLlcJ7rlIG+SFb7fywiowLVS/5cHwWpQf+OCBTMTFbziWuEe9iDi9h+4L
         LzD3LWGwSk9Ve2EkL5b/zbyUyh7BebVj32CpUW/N3x/K9UjSwxyzlaKkBl8uXAotxn71
         Fx3roIpY+SlRsJnPukD2sWvAKCRJak2V4LIHHcMCkKLa0z30Szz1DuJdl6P9fQ2xJRPc
         IRORx1+US9OceGXZ0COB4wSl2BX/JpDQOo1Y2jPVWBanvRt0AkarDgBHwqjB+FgcUCmK
         0r1w==
X-Gm-Message-State: APjAAAURVinHSg52aM2Oc+p2RaV8l7fA6ilDfXdJ0erfRo6N3r2sxCCN
        I0XWhqeLjmFut+oqQoAFFnrMIA==
X-Google-Smtp-Source: APXvYqwvxy0BQwbcO7zmMMj/LzCToTOsmyf+YRoJ7BmmuJFGLD3NT2IC/y1kE2vMhrdysj0lBqOPpw==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr3506614wrs.240.1561550040713;
        Wed, 26 Jun 2019 04:54:00 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id f12sm36496470wrg.5.2019.06.26.04.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 04:54:00 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:53:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v10 1/6] mfd: rk808: remove the id_table
Message-ID: <20190626115358.GS21119@dell>
References: <20190621103258.8154-1-tony.xie@rock-chips.com>
 <20190621103258.8154-2-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621103258.8154-2-tony.xie@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Tony Xie wrote:

> Remove the id_table because it's not used.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>  drivers/mfd/rk808.c | 9 ---------
>  1 file changed, 9 deletions(-)

Also, this patch already appears to be applied.

Once patches are taken from the set, you should avoid resending them.

> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 216fbf6adec9..94377782d208 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -568,14 +568,6 @@ static int rk808_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static const struct i2c_device_id rk808_ids[] = {
> -	{ "rk805" },
> -	{ "rk808" },
> -	{ "rk818" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(i2c, rk808_ids);
> -
>  static struct i2c_driver rk808_i2c_driver = {
>  	.driver = {
>  		.name = "rk808",
> @@ -583,7 +575,6 @@ static struct i2c_driver rk808_i2c_driver = {
>  	},
>  	.probe    = rk808_probe,
>  	.remove   = rk808_remove,
> -	.id_table = rk808_ids,
>  };
>  
>  module_i2c_driver(rk808_i2c_driver);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
