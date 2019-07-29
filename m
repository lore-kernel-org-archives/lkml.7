Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC7AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2416206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFIocFLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfG2Qf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:35:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44755 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfG2Qf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:35:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so28525853pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=csy/8OomwFVUg7SRyRLfvo8oboAYraDRiEDjE5dD+lQ=;
        b=kFIocFLxC455i4jRxXXYbr7oPuLy/ISI/icidZgi/lHk98qBlP2Z8jLygeg+dV60wu
         7Rvp2x4sQwKIu0YSBdvuQbFBbg3x1+cLo96LTzNdVoUVWpWuy+B/Tyfc/V9y6pUYOQ4t
         uOAclk8gAMV5BaTCADFxTmVpEWqVxiTSMovYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csy/8OomwFVUg7SRyRLfvo8oboAYraDRiEDjE5dD+lQ=;
        b=MrKrjexpQb2cQZnsxs0O/dVIzPu68WB92xgp8Gho9QwEgKTCrHOFHfHuvX6l2nP13W
         XZagr3VFXecLxoXRwSkFs+a7DwydH3sR5Eaw0I3pmN/944Cc2hQOd4PbIDA3ZpSuEQIu
         NrjQj6G4vGuyaruhqN3E02f/RIbnMt/d2a0FtVsOAc7fznYAct9yTzCtoUNPKs5IcLRG
         pSiT7Md5g1B1bItoOJ7DTXAdIL7i7FBB2/QDcqCg7PcU7/Vz4mncX4XN4QhIEGFVQFe4
         kkvGFHjxFUG8abeZf03urLxlZYLxphIEPYTKf8AN8JKh98abmLLSNLiUNca0UV2yhJXB
         AnHA==
X-Gm-Message-State: APjAAAWPh/EKRRYx4Z04V33E2H8J5ARk7SO3Frt0xurym7tOukCTtRse
        w2ho/09htyQ9yCMDaRAmjedAag==
X-Google-Smtp-Source: APXvYqzkiCoZJINOHjCqxo8dBE/Exx5+oW+y+VKHDSYAYoxcGcAMxDzu5ujXJKcPTy0sWl4YQa5NcA==
X-Received: by 2002:a17:90a:2767:: with SMTP id o94mr109284055pje.25.1564418126501;
        Mon, 29 Jul 2019 09:35:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s185sm94309720pgs.67.2019.07.29.09.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:35:25 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:35:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mfd: omap-usb-host: Mark expected switch fall-throughs
Message-ID: <201907290935.F99432D6@keescook>
References: <20190728235858.GA23755@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728235858.GA23755@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:58:58PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_resume':
> drivers/mfd/omap-usb-host.c:303:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!IS_ERR(omap->hsic480m_clk[i])) {
>        ^
> drivers/mfd/omap-usb-host.c:313:3: note: here
>    case OMAP_EHCI_PORT_MODE_TLL:
>    ^~~~
> drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_suspend':
> drivers/mfd/omap-usb-host.c:345:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (!IS_ERR(omap->hsic480m_clk[i]))
>        ^
> drivers/mfd/omap-usb-host.c:349:3: note: here
>    case OMAP_EHCI_PORT_MODE_TLL:
>    ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mfd/omap-usb-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 792b855a9104..4798d9f3f9d5 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -308,7 +308,7 @@ static int usbhs_runtime_resume(struct device *dev)
>  					 i, r);
>  				}
>  			}
> -		/* Fall through as HSIC mode needs utmi_clk */
> +		/* Fall through - as HSIC mode needs utmi_clk */
>  
>  		case OMAP_EHCI_PORT_MODE_TLL:
>  			if (!IS_ERR(omap->utmi_clk[i])) {
> @@ -344,7 +344,7 @@ static int usbhs_runtime_suspend(struct device *dev)
>  
>  			if (!IS_ERR(omap->hsic480m_clk[i]))
>  				clk_disable_unprepare(omap->hsic480m_clk[i]);
> -		/* Fall through as utmi_clks were used in HSIC mode */
> +		/* Fall through - as utmi_clks were used in HSIC mode */
>  
>  		case OMAP_EHCI_PORT_MODE_TLL:
>  			if (!IS_ERR(omap->utmi_clk[i]))
> -- 
> 2.22.0
> 

-- 
Kees Cook
