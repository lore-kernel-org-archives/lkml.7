Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE27C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA562080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvFOoymH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfFLKV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:21:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55740 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfFLKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:21:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so5948361wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TqpQfNrIY2SpB5jRuIghaLMN98QjpgnwAtCKC7E1c4Y=;
        b=yvFOoymHNRSw3LFLpbLHeLylxjqjH/FhSo8kjTGZzsNd2rtG9abw0Z/tWTPasqiBcA
         CFac/28if66zb8Dx9+2wcZPPgiqen78KiIZUyqcyS3TSpTc4ffIvj3wDKhGscMRhtgEw
         zsshAfe23zdRQDOSwiYiiOkaM9MGLon59ehCWPfRe+MNnJn2SlkEJwwJUPWIgVyCe7Au
         HJSPJVYg6NU3Fm4tHfy7y5P3E3D6oK1IZFrRYr5HHJzQpP164VZkZ8dLZMNbbIEye1aX
         mHSt+B7te8yWViuDseSk+zARKCBocsPH0wlpsWOk4tdngvDfP12g+NcXx2gRElgu+eNp
         eDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TqpQfNrIY2SpB5jRuIghaLMN98QjpgnwAtCKC7E1c4Y=;
        b=DPg+DRHNN7hgdvoptQzwNOtkJA3r4XFgxgGHE1igefalep+uLjrmmdV8jIAnIWPdZc
         Xa27L9OD8RaL7qt76akYhagyLucDUlPnkjzd57p3WM2y7ARONL+je5QsTsNLyIe0/iNf
         ud0Y2YZBvePrDhPp3ZELyvSaaSeR49CmA/oyDY/FbK+1Ez9IjY5IUV2qhFAx3F0UaUuP
         v+cCMISFIWK8K//IiIeQR71LgCn1DYa90ZTULNCAwyTfcujxO4EIr+vZBelWUJUCftpp
         pU35LSzzUkpIwvtDfX8h5hDEypOsBdvpwJvPKazIZaAkwrepq5r8zivv3UUlwdtCvVXD
         4vOA==
X-Gm-Message-State: APjAAAVEEpwdvf6hnN45ZJ2uQ4zsQHaiXXTtsaEqQxRUQGjRtBBLfkRW
        iqybe1A3Vwfi0otL79HtG+HLHD2TDu4=
X-Google-Smtp-Source: APXvYqxyDQWxQ96bD1/Ai73GBF3kQdI0dhkARnEuycMbStRCquki8XeU3gijJKvKoFd6lEO73WuKiQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr21264282wmk.9.1560334883924;
        Wed, 12 Jun 2019 03:21:23 -0700 (PDT)
Received: from dell ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id v7sm831500wrv.71.2019.06.12.03.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 03:21:22 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:21:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: mfd: 88pm800: fix warning same module names
Message-ID: <20190612102121.GI4797@dell>
References: <20190612081203.1477-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612081203.1477-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Anders Roxell wrote:

> When building with CONFIG_MFD_88PM800 and CONFIG_REGULATOR_88PM800
> enabled as loadable modules, we see the following warning:
> 
> warning: same module names found:
>   drivers/regulator/88pm800.ko
>   drivers/mfd/88pm800.ko
> 
> Rework so the names matches the config fragment.

Please detail what this actually changes.

I.e. what the new modules names will be.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/mfd/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 52b1a90ff515..5e870eef6a20 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -5,8 +5,11 @@
>  
>  88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
>  obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
> -obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
> -obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
> +obj-$(CONFIG_MFD_88PM800)	+= mfd-88pm800.o mfd-88pm80x.o
> +mfd-88pm800-objs		:= 88pm800.o
> +obj-$(CONFIG_MFD_88PM805)	+= mfd-88pm805.o mfd-88pm80x.o
> +mfd-88pm805-objs		:= 88pm805.o
> +mfd-88pm80x-objs		:= 88pm80x.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
