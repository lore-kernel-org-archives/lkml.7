Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BE9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDvJyUbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfG2QfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:35:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfG2QfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:35:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so24313778pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LosA34Pi06t550ndfWq1HZ2X46u/LpML1Ea5fccWC7E=;
        b=NDvJyUbd4FPZnEzvHlG0+LLOrnWEIWl8T1uF/R3sM9rTbDL1xgrMCms2SH12h3QByl
         jQzeedo8qh7F1CKOkRgu6JO8CNoHChExWpJqfPHUx0yYX43YkvvT/cT8HfLH3HdVawEM
         TZ0YrjtHl/lRT++4pspAHq2IqXkmm/X0gjEg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LosA34Pi06t550ndfWq1HZ2X46u/LpML1Ea5fccWC7E=;
        b=iqjV5Xz5UnFl1fcTp0U14/NXYCyfSsV3MlCiclpTrRXdsaFSQr2Rpk8E6otRFP6loC
         9b4sj8YwElQFOP6k6LFBhT8LPQDKj7YspqSRZnR8B+q3gOC1re62eTr2L3EydeK5S/Uu
         QEVQU48y7YRFTvvzjoF9/2EOchV4AtfUYxXw04fE+nfYjSlVnC2xjlD1JpTqy56PS8WX
         D/vr2aLvrxOGQu73cYza7DHbGMoLUddLY0xwT4rgIBkOT1e24lx01x0g4/X4o3l8GNlL
         VRUgfLbGk97VVMhALTM5JXMEBk+dVmk7/xoo5MODZnBniNm+G/CApPm+KGpLJDxFm7WD
         re0A==
X-Gm-Message-State: APjAAAU9TKFOodXz5J4OlOCK050PoMY/lkT/G0bSdkU1Mu/Rb8OoiEH/
        jodtIx12mplPIK9izjGZ3pB8Sg==
X-Google-Smtp-Source: APXvYqxiO8pf2kEJ5WYkyipUkk47CIU4vFX7JK7bgUojD7XXorF+A7b4LosOiyjpsDE+ksy35reuqQ==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr36133516pfh.56.1564418115354;
        Mon, 29 Jul 2019 09:35:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2sm53553878pgc.32.2019.07.29.09.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:35:14 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:35:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mfd: db8500-prcmu: Mark expected switch fall-throughs
Message-ID: <201907290935.B02CE809F@keescook>
References: <20190728235614.GA23618@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728235614.GA23618@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:56:14PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mfd/db8500-prcmu.c: In function 'dsiclk_rate':
> drivers/mfd/db8500-prcmu.c:1592:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1593:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI_2:
>   ^~~~
> drivers/mfd/db8500-prcmu.c:1594:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1595:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mfd/db8500-prcmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
> index 3f21e26b8d36..90e0f21bc49c 100644
> --- a/drivers/mfd/db8500-prcmu.c
> +++ b/drivers/mfd/db8500-prcmu.c
> @@ -1590,8 +1590,10 @@ static unsigned long dsiclk_rate(u8 n)
>  	switch (divsel) {
>  	case PRCM_DSI_PLLOUT_SEL_PHI_4:
>  		div *= 2;
> +		/* Fall through */
>  	case PRCM_DSI_PLLOUT_SEL_PHI_2:
>  		div *= 2;
> +		/* Fall through */
>  	case PRCM_DSI_PLLOUT_SEL_PHI:
>  		return pll_rate(PRCM_PLLDSI_FREQ, clock_rate(PRCMU_HDMICLK),
>  			PLL_RAW) / div;
> -- 
> 2.22.0
> 

-- 
Kees Cook
