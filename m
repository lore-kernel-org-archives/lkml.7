Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D51C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61892072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyhKRq6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgAHAC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:02:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34917 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:02:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so673052pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 16:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EhOU2mXy3w6Ms6WyKoaoTniVlM5WpRm1pdDaDz1WxiI=;
        b=TyhKRq6hpZ7tLJCEith6uia0IEmGXI4GqW9xiHAuFv4t4Wo4AywaM5g6KYTbq1ZMVz
         YMT/GwA7RP2JTqYW1JClgmLmP1M/mvEoNkxMSAwC1aL25YS7TamKYcR+52M+v5ZRbbrK
         Di+WS+GrkRXm5CBEp1YJtD7q59eFsEPAJPUJ1pV9oSXPmNACFwiM0nDlWkETAL4gMHxP
         EG8Q/Jbf0oqTXFmMi7OylK4WiYooa6wS7pDwhZlrixqqleT1tGj/+IDhJMD4F4asdO9/
         LupqKn9TI8+z0BbAydJ2JD3r+lcCKeHpQhQJc7Z+Hafuwv/bsGBrTvKXk+YyghCR5dHl
         us3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EhOU2mXy3w6Ms6WyKoaoTniVlM5WpRm1pdDaDz1WxiI=;
        b=O0bZwUWruJDslQc47HPXaQekycid52dXhcmHIJ0+dwxBhFfl7IcLaymRRUr7Iv9fAb
         n/Wd2Mmtefzd8yvRDHNFqQ8oq6fsckl1IlgdfbbX1Be4JfxEN9oSssjCvRXK5ob1w9kq
         C6ETulUAPulS7NIzpO3c3Lq8K2Bv7dHmAhrwJuzKpgE8Uz0H+3+vebeytF5skQ1XPuv2
         hj8ioUmKvW805Ldgv0+aPCKfTewJVoFB6kHrHyQHJuIzMmZNtrwGTwHbai0rCSYoXO3Q
         u+Td3s7dSYLTuBnwpC3pPDzDhNuaHGWmPj6YYTPcpV/CFWOmV0ROj1cvl4xNi9c1+HX0
         hr1Q==
X-Gm-Message-State: APjAAAUtu239e1+gxNM7yhHMBvMlPa4l99AaDxCMGhW4X+zc+3qmjle3
        PqKB0/UPMFkoHvF6HgOC7cNNjA==
X-Google-Smtp-Source: APXvYqzqiJKTu1+5/l04D1jYqqaj8E1M4Ohj0fZHP+vZsSiiA1fku95PIzEVVv9aO6NRfnx6sOIrVA==
X-Received: by 2002:aa7:9d9c:: with SMTP id f28mr2066173pfq.20.1578441776960;
        Tue, 07 Jan 2020 16:02:56 -0800 (PST)
Received: from yoga ([2607:fb90:2847:68b5:4ce0:3dff:fe1c:88ba])
        by smtp.gmail.com with ESMTPSA id q6sm705972pfh.127.2020.01.07.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:02:56 -0800 (PST)
Date:   Tue, 7 Jan 2020 16:02:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be
 a tristate
Message-ID: <20200108000251.GE738324@yoga>
References: <20200107191331.8930-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107191331.8930-1-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 11:13 PST 2020, John Stultz wrote:

> Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
> to allow for the driver to be loaded from a modules.
> 
> Also replaces the builtin_platform_driver() line with
> module_platform_driver()
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Fix builtin_platform_driver line in driver code
> ---
>  drivers/reset/Kconfig           | 2 +-
>  drivers/reset/reset-qcom-aoss.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3ad7817ce1f0..45e70524af36 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,7 +99,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_QCOM_AOSS
> -	bool "Qcom AOSS Reset Driver"
> +	tristate "Qcom AOSS Reset Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  This enables the AOSS (always on subsystem) reset driver
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
> index 36db96750450..76367f17fc73 100644
> --- a/drivers/reset/reset-qcom-aoss.c
> +++ b/drivers/reset/reset-qcom-aoss.c
> @@ -127,7 +127,7 @@ static struct platform_driver qcom_aoss_reset_driver = {
>  	},
>  };
>  
> -builtin_platform_driver(qcom_aoss_reset_driver);
> +module_platform_driver(qcom_aoss_reset_driver);

Thought we had this covered already, sorry for missing it yesterday.

In addition to module_platform_driver() you also need a
MODULE_DEVICE_TABLE(of, qcom_aoss_reset_of_match), or the driver won't
be loaded automatically.

Regards,
Bjorn
