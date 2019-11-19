Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50ADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719D2222B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RDAaAMxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfKSPH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:07:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfKSPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:07:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so24258028wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0sOGULTxKGUas/n3eXVssiq7rC3j2ItfoQLTOVZlF3A=;
        b=RDAaAMxsitYbQpk+FHt0fm0cvrptMukdFgxDWsDiY2wP1w2/CYM2w9j4BJqkCfRYlb
         KoMZ3anOj4QwdznIDwB2DV1/GlCykLmoeGk4wPvC5nT0BQ7gwJKiAg4x7T1Cpa69wdiL
         5NwQYYFJaH4NRUSrjGG6Lw0cIZmnhyd6Wg/RlpLmyZNLiN/JM/JHqn6N57pY3fJ2EgaU
         fUBKQugVQDf7rg11izajPi//DIHhRrVmiSNktVjxPKVH7lyeuK8OUyRJsOyREaAtsNqg
         e2K0PKDnRIrYbYGTOHqLogvPzrW0P3Jp1HhNeXx9KgSXZSARQZ7bZS7ymdIpVejaOFKL
         36Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0sOGULTxKGUas/n3eXVssiq7rC3j2ItfoQLTOVZlF3A=;
        b=hWxLb9U19JiqhD7uxryEcaDq2MjJOx8waSRNXj4QygM4+qwXlN/t/eja4Mjt5PJIbX
         c2IQuG+9UMNWMa2sATpR8SSAOCXbAdMdK29nCHhkEzNOdp4Fmx6uUKp5bCU42pvnSD51
         ahsVRwvQfjVwb+YSF7IIhiwsU/e7y2xdv6YXn34KPUtCfaIElW8gkVBLUl9VUcOCuVsE
         JIosgui+TI0YGXGY4/mBNzKF0IdjaO2R3qV0UPkYhlylEen1ZL0PITqdtOZ+KqlQyO/s
         lVOckNJjIL6QCgwQpfJofzsqv6Lxg5iW4vamYCEbXUOSi/yxt9lKMDd4VjMaD2onZsCd
         GFDg==
X-Gm-Message-State: APjAAAV6p2H0HvljmBVXHTqyGlrm65c7C+t3thh7xSDPC6H3iT4RmWGW
        3RFpOgx6jOP9qDci3Bj6DaoYig==
X-Google-Smtp-Source: APXvYqwOzHtK7WEaMSazsJpj5LXWd/QnPIMVNqwwEW18JZLpY/0Jbc/ZswjWAFgmJfsm9R0jzo7fQw==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr29016460wru.312.1574176073903;
        Tue, 19 Nov 2019 07:07:53 -0800 (PST)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 17sm3319113wmg.19.2019.11.19.07.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:07:53 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: meson-g12a: add missed regulator_disable
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20191118114135.25666-1-hslester96@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <cdb697db-fde4-a109-7e15-c52e7d706d67@baylibre.com>
Date:   Tue, 19 Nov 2019 16:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118114135.25666-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2019 12:41, Chuhong Yuan wrote:
> The driver forgets to disable the regulator in probe failure and remove.
> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Fixes: f90db10779ad ("usb: dwc3: meson-g12a: Add support for IRQ based OTG switching")

> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 8a3ec1a951fe..d9723d1ad8eb 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -458,7 +458,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>  						dwc3_meson_g12a_irq_thread,
>  						IRQF_ONESHOT, pdev->name, priv);
>  		if (ret)
> -			return ret;
> +			goto err_regulator_disable;
>  	}
>  
>  	dwc3_meson_g12a_usb_init(priv);
> @@ -467,7 +467,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>  	for (i = 0 ; i < PHY_COUNT ; ++i) {
>  		ret = phy_init(priv->phys[i]);
>  		if (ret)
> -			return ret;
> +			goto err_regulator_disable;
>  	}
>  
>  	/* Set PHY Power */
> @@ -517,7 +517,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>  err_phys_exit:
>  	for (i = 0 ; i < PHY_COUNT ; ++i)
>  		phy_exit(priv->phys[i]);
> -
> +err_regulator_disable:
> +	if (priv->vbus)
> +		regulator_disable(priv->vbus);
>  	return ret;
>  }
>  
> @@ -536,6 +538,9 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
>  		phy_exit(priv->phys[i]);
>  	}
>  
> +	if (priv->vbus)
> +		regulator_disable(priv->vbus);
> +
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_set_suspended(dev);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
