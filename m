Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B21CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C0121D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSvtfixY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438118AbfJYI43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:56:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37699 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393338AbfJYI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:56:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so1369902wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Za+k390P96EYSItDepM5dTHhQrr03QyXzfLr1/CgGOk=;
        b=LSvtfixYphn1xvmJLPG4xBTjQ7hqgGvgq1+mPntlD8fi5f4h8YKYgCwpXkbFX6/fe+
         fRf9pY1fyyidqk0Xkvx4W+3xLBGvFWcZzFXra7cW0QAyx4PSmXKg4XC1X57hCTWJVzEI
         hYXRzBOKNHUPFZ7zeE9/x3KMFLn6BkkIN7oGtfrukb2ELldOfeyQ0+Jg/NAvg0cZDbz5
         dbXDybMmt5ptDPiDoIyXUDaPFwJBRBHSCAH3h28TXK0e85Mssz1DYVvqDzRLqZj2HS8s
         517Yn8K4zb3+8o9PMEFcixmTiiRzLbqQ0T5vpPX6Z5kF3M5TeYtpGQ4ILJZGGFLGAu1G
         vJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Za+k390P96EYSItDepM5dTHhQrr03QyXzfLr1/CgGOk=;
        b=SnPrhrZS58im8BaQo8ME9IRHrzkG/38x2b/WPnLyekwDffL5Mm9nHhtQVnEmNK4fzc
         RK9DE2dgJvA+9bRjuhd73NP3lkLEAgl8Reiw18xkRIh6V6otNU5JdmyY2/xubQn002Ys
         0FP4nxCjffDeyEVCd32wQ+6WfaPvDw1mp6DBB9LRbTfhRRTmrTJ00ZNeAo4XtbfmDQI2
         SS8R/NDUWA7Y++mmiLlyd5PLV+AipiJeRNLxLEqusZDsaS9M7IPw2kQ3zuTpeORApS+h
         UeJyU7+BJexeMg4jwtQDKQlUJ1qIVJOJpZVgbYvCuFoLJfRA8dt7MU4SSdxuLlqf6Cxz
         eBbw==
X-Gm-Message-State: APjAAAUkpE/WmEzRS8hWRzZZNPNgEI0Z/o4ZJ1HM2oj34cnC89OZjs6I
        o3TJDSIbTXWAXVcggN8Yyywrmw==
X-Google-Smtp-Source: APXvYqwVzxvbTRKbXJBqofPICUZqHUpZWS5OByE8bfHop6pOmKVSBV0+6k4fVzLoIWf1HYnMBXh9hg==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr1843678wrn.67.1571993784357;
        Fri, 25 Oct 2019 01:56:24 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c16sm1918320wrw.32.2019.10.25.01.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 01:56:23 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:56:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v3 10/10] mfd: mfd-core: Move pdev->mfd_cell creation
 back into mfd_add_device()
Message-ID: <20191025085622.7gdfbaesiwgnrfd3@holly.lan>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-11-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-11-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:38:32PM +0100, Lee Jones wrote:
> Most of the complexity of mfd_platform_add_cell() has been removed. The
> only functionality left duplicates cell memory into the child's platform
> device. Since it's only a few lines, moving it to the main thread and
> removing the superfluous function makes sense.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/mfd/mfd-core.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 2535dd3605c0..cb3e0a14bbdd 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -49,19 +49,6 @@ int mfd_cell_disable(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL(mfd_cell_disable);
>  
> -static int mfd_platform_add_cell(struct platform_device *pdev,
> -				 const struct mfd_cell *cell)
> -{
> -	if (!cell)
> -		return 0;
> -
> -	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
> -	if (!pdev->mfd_cell)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
>  #if IS_ENABLED(CONFIG_ACPI)
>  static void mfd_acpi_add_device(const struct mfd_cell *cell,
>  				struct platform_device *pdev)
> @@ -141,6 +128,10 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (!pdev)
>  		goto fail_alloc;
>  
> +	pdev->mfd_cell = kmemdup(cell, sizeof(*cell), GFP_KERNEL);
> +	if (!pdev->mfd_cell)
> +		goto fail_device;
> +
>  	res = kcalloc(cell->num_resources, sizeof(*res), GFP_KERNEL);
>  	if (!res)
>  		goto fail_device;
> @@ -183,10 +174,6 @@ static int mfd_add_device(struct device *parent, int id,
>  			goto fail_alias;
>  	}
>  
> -	ret = mfd_platform_add_cell(pdev, cell);
> -	if (ret)
> -		goto fail_alias;
> -
>  	for (r = 0; r < cell->num_resources; r++) {
>  		res[r].name = cell->resources[r].name;
>  		res[r].flags = cell->resources[r].flags;
> -- 
> 2.17.1
> 
