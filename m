Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD566C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AC820717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQf1ByAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfLPPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:31:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34815 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfLPPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:31:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so7812269wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F7qxJLY2B0q2S9xWqYQhOGVkpLg1b0U2h68SKIpYOSM=;
        b=ZQf1ByAmTqQWYrXd/L/q1azTVA3vCJAg4DgVgTEvElv+S0USzhiaovMwqkHiVWz5Zr
         kdgo2xjU2VKrukZA2Y3G9F0BaJn1cGMlJHEbLcD/rfdgsk5qcSjvrDsgDpMXwNMl0xcj
         IU5RiIoHNXVOhpsLIlFmT2Sd8Loyb1APb+nlzEk2uTINsYuL/wN+ktFD6wOFMwpzmfAN
         E97qqYqiPMia2UzBfFzaQl2jvKP0phVv34LdrbErwwjPr+5eIJ+n3CSC2vNG2MuT2ziB
         R9Ke340k9MtgEAJmAX6liOEadzi90oEM4LsBju+Xywo1SHhrdCDn9Nq5dOd4vBSBk1V0
         AhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=F7qxJLY2B0q2S9xWqYQhOGVkpLg1b0U2h68SKIpYOSM=;
        b=RxKLUT37WRRUu2NCeXlJr5p7eOmF8XrDKhTGPmDaEJWL7IZOc9Bx1FZhpbRtXyncoh
         vLnp0JbsqJBtniKo3hRaj7KPDiK7+rB79MqNSdiOIId7mXhmi2JcJ8jxUwA/cpMKbjte
         pWPUacnGe6G2LIp+8R+Pz8w9OVoy4gNSwekzV3yd+5C7A1OMsuuo8/EvznvayZPDxBCx
         vTD4GOgb/Yz0m/pPFk9l0V0UACxmEfOtIbjlKOIdlFrTF3ji7NnZQbxqMaR6/HJjrt0C
         DgxSAOGXkC5Xoq5P5cJ08dBhEMjvC5GRKFjB4Ylzi/KbFmA/ZYupmJuzfnPJvv9qFULh
         NTcw==
X-Gm-Message-State: APjAAAW3xTaOYv38czmKMSCjC/6Gj5gHPynurZI2EBxaB2PzZHsTcAvK
        /54bYh6l1uheeK4Uw/F/KuMRkQ==
X-Google-Smtp-Source: APXvYqzXaCm+VcadKjSIjeuwTuxX1mlnsuNzVNjfB1+gqraaFYRglw7XZsHB6451b/EXWV+RRXhjaw==
X-Received: by 2002:adf:e887:: with SMTP id d7mr29983243wrm.162.1576510267203;
        Mon, 16 Dec 2019 07:31:07 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id u24sm14478768wml.10.2019.12.16.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:31:06 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:31:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        stefan@agner.ch, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v4 4/5] mfd: rn5t618: add more subdevices
Message-ID: <20191216153106.GK2369@dell>
References: <20191211215409.32764-1-andreas@kemnade.info>
 <20191211215409.32764-5-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211215409.32764-5-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Andreas Kemnade wrote:

> The RC5T619 has a RTC which is missing in the
> RN5T618. Add it as subdevice to prepare for their implementation
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
> - alignment cleanup
>  drivers/mfd/rn5t618.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index d78eb29b94a4..18d56a732b20 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -22,6 +22,12 @@ static const struct mfd_cell rn5t618_cells[] = {
>  	{ .name = "rn5t618-wdt" },
>  };
>  
> +static const struct mfd_cell rc5t619_cells[] = {
> +	{ .name = "rn5t618-regulator" },
> +	{ .name = "rc5t619-rtc" },
> +	{ .name = "rn5t618-wdt" },
> +};
> +
>  static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -173,8 +179,14 @@ static int rn5t618_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> -	ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
> -				   ARRAY_SIZE(rn5t618_cells), NULL, 0, NULL);
> +	if (priv->variant == RC5T619)
> +		ret = devm_mfd_add_devices(&i2c->dev, -1, rc5t619_cells,

Ref: The "-1", please use this as an opportunity to use the defines.

> +					   ARRAY_SIZE(rc5t619_cells),
> +					   NULL, 0, NULL);
> +	else

Are you sure it's not possible for 'variant' to be an unsupported
device?

> +		ret = devm_mfd_add_devices(&i2c->dev, -1, rn5t618_cells,
> +					   ARRAY_SIZE(rn5t618_cells),
> +					   NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(&i2c->dev, "failed to add sub-devices: %d\n", ret);
>  		return ret;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
