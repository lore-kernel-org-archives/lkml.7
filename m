Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DBDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4029121655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mZGupuQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfG2Qde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:33:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38199 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbfG2Qdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:33:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so27700464plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZSRVaoM+0+WmVEymEml5vQPpYtYXaF0mFy6wxL1q74=;
        b=mZGupuQMoQYHI+QnKYUZdMKrRhU3YvfrCNNs6q6RO4lI2b5TDHy+xIzq6HsrC0/IA+
         0EXUwzeCErYJ4pWYl5ih/unhL3xIc4hwKGc2lCX1jP190DhVD0a0eX/06alHjUbtVRWk
         HkCm0cSpCmBNddCI6mRINbdIO4KoWEKeV+gi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZSRVaoM+0+WmVEymEml5vQPpYtYXaF0mFy6wxL1q74=;
        b=l2Lv1yztcN/8y80kWHEn0aQz/UmFfpbzNYXv5Znaup8bBuWrQcluT58LPxfYNwRhT9
         fljEtG6LWVcaps8D4cO+9zeKkYBIWMX3/Jfgv+IPsdN3JT+tFivOsFAOIQobk6nsqcMN
         n0kXUh3NoJ11JUVLmQrZlrHsSFqF6Ohp8OgBOw5X1F3p1ql4wbSlbQ2ya3mOQunKdBxh
         SPTmuisjUuL9ez1g9F7eF9BPcplPRTLRCLmYdfb+4iCtwhhlYCuQVRKmuvD8eVPWtU8U
         +4evtvEXoF7jgQg7KJy1w9W1tocvD0R4bWiQby2Bprrsm+6h4XsD1v1vRvF3Hzr4hsSG
         dW2w==
X-Gm-Message-State: APjAAAUia3A7qCzcFj774xGNMu4TvDv6Hr5WXTENnnKv0eRRfvl5fFRQ
        NWVAoe5uek3IG5+F5AaG2CcN4g==
X-Google-Smtp-Source: APXvYqzFZvyeg4iqQvDoi5IW5U+rEL+TBAqu8DV6miguhTKiPv/OQfHqkaRDVvNhv1RWGgk5GEEHnw==
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr105224391plb.230.1564418010852;
        Mon, 29 Jul 2019 09:33:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cx22sm51949300pjb.25.2019.07.29.09.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:33:30 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:33:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM: tegra: Mark expected switch fall-through
Message-ID: <201907290933.7D54BDAB@keescook>
References: <20190728231526.GA22066@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728231526.GA22066@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 06:15:26PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> arch/arm/mach-tegra/reset.c: In function 'tegra_cpu_reset_handler_enable':
> arch/arm/mach-tegra/reset.c:72:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    tegra_cpu_reset_handler_set(reset_address);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm/mach-tegra/reset.c:74:2: note: here
>   case 0:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/mach-tegra/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
> index 5a67a71f80cc..76a65df42d10 100644
> --- a/arch/arm/mach-tegra/reset.c
> +++ b/arch/arm/mach-tegra/reset.c
> @@ -70,7 +70,7 @@ static void __init tegra_cpu_reset_handler_enable(void)
>  	switch (err) {
>  	case -ENOSYS:
>  		tegra_cpu_reset_handler_set(reset_address);
> -		/* pass-through */
> +		/* fall through */
>  	case 0:
>  		is_enabled = true;
>  		break;
> -- 
> 2.22.0
> 

-- 
Kees Cook
