Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93FDC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9284C2339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFWgQ3ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfHTTLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:11:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40193 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTTLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:11:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so3600815wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vb3whGXfiiHwXLx0GBsKPRedv/L70OQIeLnBwUSPho4=;
        b=KFWgQ3ZYkhfnlCdgpjG/KUIv6XkDo2u0s/mnHp0J8Kpd6kZHVr83+f26mP6nDGIRZ0
         r8hojDqxQZj7VXAXcrRTIFFftM+teZGSZpI+U67uShnl+L1wc7/gvVwLZw+Y+uyIVTWs
         p0bm9OQp/6uGGOVbNzXO2Db9xrqnbltfX53gpCb7LVE/k7fJseKVOOk2ZQBLyDbteYTn
         RGo1+sumqhTdckmD4a6BpxGFH0QJBs5ZDYlrVQR9pe95GPKT6APv6kQbYPYYgOr4qDFL
         +N4YLGVBdzHpyrv3IJmMvQ7sPBgo2Yfu6ISYadaXVVSKP0hj/puKTXuyCWbN2A/wsvVF
         PyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vb3whGXfiiHwXLx0GBsKPRedv/L70OQIeLnBwUSPho4=;
        b=dViKb+rApxvdTGFwZwXQMMTrwKRgBtwQ6AP0C9mlTqTdtY2aWPmRiEEZFYXY1OESAQ
         1Gq5hOQV5lGlj9RruiDp1JaZAOvcZ1/jkYVEMEWPoNou+vj4HzPkRnCQp4Zxro4fKw7L
         q/Io0MHKrBdB3JUN4g1YGPui35gb7/n0VpioZEVKSAjJXE+B0atTSP7+g6KDCB2m+HNf
         W6MgUBu33iowGIcnS0o4pkeTVojwcxh1Yzb1CnKcFI8pcEyh+/2iTQWUC5hcV/BcJ1bh
         tKD92sLAD/jlC6gySsIQiyixkTU1xMZucAI9NZU1DM6h+MkSVBkiYl3CkJTELr5OrRP6
         Mwkw==
X-Gm-Message-State: APjAAAVblkg+sNlnNhHIsPrAqRLpRH+34e4163h7xEtrVyKN1y66vnOn
        TcVIpL45cIQrcHlsKQArSt6fcA==
X-Google-Smtp-Source: APXvYqwlqkgjEfxRupwJEmpErYjVtp/jSgAzIq6qKhRlt/3+LyV6g4u2P1JUo73tJP1oXG79+2JXyA==
X-Received: by 2002:a1c:dd43:: with SMTP id u64mr1604542wmg.92.1566328306760;
        Tue, 20 Aug 2019 12:11:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 74sm2025367wma.15.2019.08.20.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 12:11:45 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:11:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: add include guards to platform_lcd.h and
 ili9320.h
Message-ID: <20190820191143.hzl5je4wrbkhcyyz@holly.lan>
References: <20190721073940.11422-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721073940.11422-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 04:39:40PM +0900, Masahiro Yamada wrote:
> Add header include guards just in case.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
>  include/video/ili9320.h      | 4 ++++
>  include/video/platform_lcd.h | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/video/ili9320.h b/include/video/ili9320.h
> index 62f424f0bc52..b76a0b8f16fc 100644
> --- a/include/video/ili9320.h
> +++ b/include/video/ili9320.h
> @@ -9,6 +9,9 @@
>   * http://armlinux.simtec.co.uk/
>  */
>  
> +#ifndef _VIDEO_ILI9320_H
> +#define _VIDEO_ILI9320_H
> +
>  #define ILI9320_REG(x)	(x)
>  
>  #define ILI9320_INDEX			ILI9320_REG(0x00)
> @@ -196,3 +199,4 @@ struct ili9320_platdata {
>  	unsigned short	interface6;
>  };
>  
> +#endif /* _VIDEO_ILI9320_H */
> diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
> index 6a95184a28c1..c68f3f45b5c1 100644
> --- a/include/video/platform_lcd.h
> +++ b/include/video/platform_lcd.h
> @@ -7,6 +7,9 @@
>   * Generic platform-device LCD power control interface.
>  */
>  
> +#ifndef _VIDEO_PLATFORM_LCD_H
> +#define _VIDEO_PLATFORM_LCD_H
> +
>  struct plat_lcd_data;
>  struct fb_info;
>  
> @@ -16,3 +19,4 @@ struct plat_lcd_data {
>  	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
>  };
>  
> +#endif /* _VIDEO_PLATFORM_LCD_H */
> -- 
> 2.17.1
