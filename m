Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB7C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92921655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFOOf1pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfG2Qfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:35:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39457 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbfG2Qfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:35:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so28527366pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IEddiYi3k/QkBC5cxfQW5fAN4XjjJLsCvTR0ynzn9xQ=;
        b=PFOOf1pY2vYwMTBzCHhJbt6J3OJX9kEF5fPBmfilOEVHC7yfX6C8vdygMvSnG/ORXJ
         +ubu/CTvk6N9l3Hpyyd3g4nctPRzdxe6Wq1t3Eb4eDZho2NwHODoNKaBeWPkSiWF672+
         wwNrEzYzu+TH35C5nW4a1HvCbhiXC4sOnUUAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IEddiYi3k/QkBC5cxfQW5fAN4XjjJLsCvTR0ynzn9xQ=;
        b=IVczJGCz8Q157xgDT1eqXTkb18OgBKWdPnqPAykBeLuYSFVaUMfv/WLjnAJq/Q5MAI
         48o1rwsw2nEipp97Yh+TFwKEyFhsg/FLKI6apoo/YByWse6qJgWbiJgpq49unUWI9xIV
         tuKGseT2wuO60GmjkY3WpgcRLReMb5fIYTn0KJB682mVbq4icjR1TioHf+dRUKYbmDOb
         NtoGppovzjMUtteRfUYhIfp9O/2bS2+/Djb/kaoBYaxWZILCucT/lFgmxXs3tymT8s2U
         pegSngv7p5lvv3TuO8Ywo2CcoqlBDUTMBXePK2/29GaqM1U1s3cvSP1RXTiC3dqCjSHk
         FPMg==
X-Gm-Message-State: APjAAAVuJVWLgnlGeDgmiSJOiM7OXUg8rp6Nm8AHZ7TX8H8yXb+gIx6h
        LKFgPZpz59MjKV8yATzl4Yx4IQ==
X-Google-Smtp-Source: APXvYqzgPp1ai8L1U1DHi9sD7NWNDjDbn+/ShCDM00cHu0bZrIrBVGOukCtp85AANTBOMAzU8Deeyg==
X-Received: by 2002:aa7:81ca:: with SMTP id c10mr37907100pfn.185.1564418142347;
        Mon, 29 Jul 2019 09:35:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l26sm63883324pgb.90.2019.07.29.09.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:35:41 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:35:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Message-ID: <201907290935.2B95CBC@keescook>
References: <20190729000123.GA23902@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729000123.GA23902@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:01:23PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/mmc/host/atmel-mci.c: In function 'atmci_get_cap':
> drivers/mmc/host/atmel-mci.c:2415:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_odd_clk_div = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2416:2: note: here
>   case 0x400:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2422:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.has_highspeed = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2423:2: note: here
>   case 0x200:
>   ^~~~
> drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->caps.need_notbusy_for_read_ops = 1;
>    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/mmc/host/atmel-mci.c:2427:2: note: here
>   case 0x100:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mmc/host/atmel-mci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9ee0bc0ce6d0..c26fbe5f2222 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2413,6 +2413,7 @@ static void atmci_get_cap(struct atmel_mci *host)
>  	case 0x600:
>  	case 0x500:
>  		host->caps.has_odd_clk_div = 1;
> +		/* Fall through */
>  	case 0x400:
>  	case 0x300:
>  		host->caps.has_dma_conf_reg = 1;
> @@ -2420,13 +2421,16 @@ static void atmci_get_cap(struct atmel_mci *host)
>  		host->caps.has_cfg_reg = 1;
>  		host->caps.has_cstor_reg = 1;
>  		host->caps.has_highspeed = 1;
> +		/* Fall through */
>  	case 0x200:
>  		host->caps.has_rwproof = 1;
>  		host->caps.need_blksz_mul_4 = 0;
>  		host->caps.need_notbusy_for_read_ops = 1;
> +		/* Fall through */
>  	case 0x100:
>  		host->caps.has_bad_data_ordering = 0;
>  		host->caps.need_reset_after_xfer = 0;
> +		/* Fall through */
>  	case 0x0:
>  		break;
>  	default:
> -- 
> 2.22.0
> 

-- 
Kees Cook
