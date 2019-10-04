Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E951215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5xAhDi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbfJDOeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:34:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfJDOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:34:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so6100685wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RQJh9hvK7qALdXSAmt00zw7fon92emAdLHkzgMEfZAU=;
        b=A5xAhDi4VxeW70QhY5FJe+8RmSvwZMyHEsszULCP3W83MMkQu6R8WecCVtslsj6Hbl
         8ixZAjkhHQyM7pGmRK64/u0qBgVFZNkipFoRcXJ1+7OwaI5gC9D+9WiwoKt73IaloA0E
         E951Gimb5ld2eDmFJ0PVTd/SNHoHMrTfeiBnVMelgwzwfx1X2qJ8rRU/Hg4LPQOvoIgt
         MyZOzb9rt02XQOgtY7ImVqI1e7S51KsrtGfAjqmQvsqU62rWaswtv3nY8Z4wR/K2B1wY
         WFQ6tvfkOYyYAt2vpjG8KznLvXJV1fvnXjsIX/Yawkj27W3IV6QqUAqDAL03QWqe9lhB
         TYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RQJh9hvK7qALdXSAmt00zw7fon92emAdLHkzgMEfZAU=;
        b=IaAQE2uApZAaMfcxOJ5AOaUsDGL+vrwbXyM38U/Vd6JsLq5zq0T2daj4IWnzM1ueJy
         Mto9qhqI99x1jFcRQxQJn8Sp+QEqeVJdZ9cZeC6rUjeNxC3uCvWCyyXgzi207NXlpsN3
         SAw/Ck5s01t8+M0VtKvTRzdJHtmF8M/5aEmmrrGt+Kl8WFf52bc3XZG+o6O+Hvrq+oIm
         dpQc9kZtdZdsB2Cb1db03xE1l+oIWIDK2c0NOzXIK52/rcZ8skaa29os9abKrWoBzL+I
         GcHc7lVi6d+d5wgqK/cliK29xT/MfcEnRFPoLfmAbVuSChPqi3zvD2nyiB89TRYc6CJJ
         wCNg==
X-Gm-Message-State: APjAAAX1srUlDTJXqvjP/AFsjwv669VA+kZCMp2Jrk5vhxVDzWRlZz/9
        mXUOO7GXKwSAJEOfc6xYPh1GCRniFz4=
X-Google-Smtp-Source: APXvYqys+RSbYX+JuRrYPwaOgyHiXn90FgRVEBpkF/Fx+THn0V1divQz33rNrvMJYu+E0K0qBI+Okw==
X-Received: by 2002:a1c:3946:: with SMTP id g67mr11865974wma.52.1570199652841;
        Fri, 04 Oct 2019 07:34:12 -0700 (PDT)
Received: from dell ([2.27.167.122])
        by smtp.gmail.com with ESMTPSA id e18sm8432541wrv.63.2019.10.04.07.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:34:12 -0700 (PDT)
Date:   Fri, 4 Oct 2019 15:34:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 3/3] mfd: madera: Add support for requesting the
 supply clocks
Message-ID: <20191004143410.GJ18429@dell>
References: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
 <20191001134617.12093-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001134617.12093-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Oct 2019, Charles Keepax wrote:

> Add the ability to get the clock for each clock input pin of the chip
> and enable MCLK2 since that is expected to be a permanently enabled
> 32kHz clock.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Use new devm_clk_bulk_get_optional API
> 
> Thanks,
> Charles
> 
>  drivers/mfd/madera-core.c       | 27 ++++++++++++++++++++++++++-
>  include/linux/mfd/madera/core.h | 11 +++++++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index 29540cbf75934..88d904eb016ea 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -450,6 +450,21 @@ int madera_dev_init(struct madera *madera)
>  		       sizeof(madera->pdata));
>  	}
>  
> +	madera->mclk[MADERA_MCLK1].id = "mclk1";
> +	madera->mclk[MADERA_MCLK2].id = "mclk2";
> +	madera->mclk[MADERA_MCLK3].id = "mclk3";
> +
> +	ret = devm_clk_bulk_get_optional(madera->dev, ARRAY_SIZE(madera->mclk),
> +					 madera->mclk);
> +	if (ret) {
> +		dev_err(madera->dev, "Failed to get clocks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Not using devm_clk_get to prevent breakage of existing DTs */
> +	if (!madera->mclk[MADERA_MCLK2].clk)
> +		dev_warn(madera->dev, "Missing MCLK2, requires 32kHz clock\n");
> +
>  	ret = madera_get_reset_gpio(madera);
>  	if (ret)
>  		return ret;
> @@ -660,13 +675,19 @@ int madera_dev_init(struct madera *madera)
>  	}
>  
>  	/* Init 32k clock sourced from MCLK2 */
> +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2].clk);
> +	if (ret != 0) {

Nit: Why is this not 'if (ret)' like in the rest of the file?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
