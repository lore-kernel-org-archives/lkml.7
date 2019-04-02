Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9349A20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPvnESYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDBGNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:13:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44718 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:13:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so5703023pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dz17Svx6bg3Gnk30n6q9lv7bR4duyZjbUHTC6z2nKcI=;
        b=mPvnESYyZMOKXQVgUykQDdLbIXgpyMtlmxu6Hgt//VrRNn8L5prIus+zqjGwhemE6R
         9SPV6pJKPayOkugI60m3sXjIyooC9YoiKP4AWIoqzmlGAkF8SxPjvLU3MnudMaI2pgMu
         VSW4wlJTvZI7BK691aL/OeK3lg5UGTuCkxaUQic98XVRKRralOJvKbnpCNruGLFSxrbO
         ZlF9DadweJJb+/h4FXWyT86tNc7GOAsCe1PWaGWHvXpbfwpttx0iwRk2fmU66GZwRWuL
         /rq25n523RbipdSNXFjs2COuXGKKU0F46dx5FPQs/jLISoO6ufpS+w55h2oSoAEe6mnV
         bLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dz17Svx6bg3Gnk30n6q9lv7bR4duyZjbUHTC6z2nKcI=;
        b=rfvg1Nuei6+Kn5pYNfYqT8H9wLidBF/2NQl6p9GaVg/nVrxOATlr2NfuFeE6ZzlU+Z
         zdT0IcZTwTHpvPVv/g5Uaiy1YIZfB5M4brdLAy4+zUdQ+SG0AGIzFEY9zg+dJbsYwLEM
         y+qd0Bds534xyVtsKrSXVW5DMiM5Dcx9rekDDvTPIZpHNCsN5eyTeg108IeW02H5LGxL
         VXWAC05UwHL1rzLceJx/XB2dtiNh0Q8ArnpCnWvUdojQ3S22DdbqahTC602hAi+lhgGF
         mG7yiXY7RaVw7dalreWMUBNacwwy5uHZeX7cUtiCPHXA21hK05Z17CTiKhhW0Gbw/Es6
         3hCw==
X-Gm-Message-State: APjAAAVmnjjPdYe950OXSthiIkVvfvu3w8y+kawgpf7Qua4hzNMS0RBW
        AoneOy9K8ePe6yHhRSmSwAY70A==
X-Google-Smtp-Source: APXvYqzcpkihW1S1tHVqVpy/boNhCaWztaoL+PutQNTiX3b2Dmcx2aJQRdXJP2+8V3Pg8gMFIZ1n5g==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr40718646pls.82.1554185634082;
        Mon, 01 Apr 2019 23:13:54 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id c134sm24429341pfc.87.2019.04.01.23.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:13:53 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:13:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: mc13xxx: i2c/spi Fix to avoid NULL pointer
 dereference
Message-ID: <20190402061348.GT4187@dell>
References: <20190318231554.8862-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318231554.8862-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Aditya Pakki wrote:

> of_match_device can return NULL if no matching device is found. The patches
> avoids a scenario causing null pointer dereference.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/mfd/mc13xxx-i2c.c | 2 ++
>  drivers/mfd/mc13xxx-spi.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
> index 67e4c9aa7d18..1fbc9713bb9a 100644
> --- a/drivers/mfd/mc13xxx-i2c.c
> +++ b/drivers/mfd/mc13xxx-i2c.c
> @@ -80,6 +80,8 @@ static int mc13xxx_i2c_probe(struct i2c_client *client,
>  	if (client->dev.of_node) {
>  		const struct of_device_id *of_id =
>  			of_match_device(mc13xxx_dt_ids, &client->dev);
> +		if (!of_id)
> +			return -ENODEV;

Are you sure this can happen?

I don't think this is possible if client->dev.of_node is non-NULL.

The 'if (client->dev.of_node)' above should see to that.

>  		mc13xxx->variant = of_id->data;
>  	} else {
>  		mc13xxx->variant = (void *)id->driver_data;
> diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
> index ee3411cc5ce4..c044a02bdb64 100644
> --- a/drivers/mfd/mc13xxx-spi.c
> +++ b/drivers/mfd/mc13xxx-spi.c
> @@ -158,6 +158,8 @@ static int mc13xxx_spi_probe(struct spi_device *spi)
>  	if (spi->dev.of_node) {
>  		const struct of_device_id *of_id =
>  			of_match_device(mc13xxx_dt_ids, &spi->dev);
> +		if (!of_id)
> +			return -ENODEV;
>  
>  		mc13xxx->variant = of_id->data;
>  	} else {

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
