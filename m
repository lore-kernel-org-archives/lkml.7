Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC24C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D226822CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVuz+pt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHTQce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:32:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbfHTQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:32:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so13058140wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wzFwBxJwNYVFz8c23UR6EVA4QWVFqmII5gU+JmWuczE=;
        b=UVuz+pt2vpL53mRHNmJ1TU5lEwmqvpAXHYMHYAuJ3MR3nGicW67xSDcxejCOHaChSn
         UxPNWcr4L2TAJk3Xipd3O7/xHpg9t/yJmTmR0/aPF3QIWtv9tg2DqcIQ4EJ3jZm4wsUV
         hFlG7wocFSEg6zjiqAtU5WUmZyezDVH1mXwTQfJwrUzEaePzW4+vK+A9jfOiTJebaG6b
         S+w4UblzXJLp/M4k/NYD40/x7Smfg5Op6MQqThvRO34g37kPVzeRGySFW+FXGMZ5PSQs
         8J19gTKqWWZ3Irun4ynV1p8TuMjnmYBhBDtY/aWQHNSFyJpmyHiQFtj/gueWk1khKcSa
         BmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wzFwBxJwNYVFz8c23UR6EVA4QWVFqmII5gU+JmWuczE=;
        b=Yqyrgt8zoCYkWTEl67kykHPml3e8e1MMtbOVoI97CaiiyxrfRwcCIQNKMouPWfCiid
         LfSMrxdf+WLc58jG7DBLWm9ZkYjTn+sDpF5QUKJJRzr6f2BJd6jpbs/2mmF4kKgneTHm
         El4u5VPmBcr98xgsGZqW4D4psP73LkGeLRtq0Q2ZDT1due0IzVSOyXF4UC40UmpAHiit
         p6E+XrAB4vStpTWjYG5pOvg8UO5ubCI9u1O2Yx4bwL8if0OugRBrk05t3G+kALi0CD4L
         bymKYfS1CeyGMa0eMHodl0ZDyZEdF+aRMFXAVoQGTlnfmoAey0Cg2Kca1FqgPzVu5MVI
         NeIg==
X-Gm-Message-State: APjAAAUAlPB09uwDngkPV1sU2vcyrmDl3yZ5ydooMdqZ56gzJ+GA9B3L
        CT+wU78vFxdimUdUYwjbRYsPzg==
X-Google-Smtp-Source: APXvYqxZeEQOGmvTSeY3NAXBX2ijAVwVyFh7cjQfFiojdkB4QWK59zEazcrFVniEAzKjEwyVc8J9Qw==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr35124310wrx.180.1566318751477;
        Tue, 20 Aug 2019 09:32:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g12sm20431627wrv.9.2019.08.20.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 09:32:30 -0700 (PDT)
Date:   Tue, 20 Aug 2019 17:32:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: tosa_lcd: drop check because
 i2c_unregister_device() is NULL safe
Message-ID: <20190820163228.xuz7su6psovp6pkp@holly.lan>
References: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:34:39PM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/video/backlight/tosa_lcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
> index 65cb7578776f..29af8e27b6e5 100644
> --- a/drivers/video/backlight/tosa_lcd.c
> +++ b/drivers/video/backlight/tosa_lcd.c
> @@ -222,8 +222,7 @@ static int tosa_lcd_remove(struct spi_device *spi)
>  {
>  	struct tosa_lcd_data *data = spi_get_drvdata(spi);
>  
> -	if (data->i2c)
> -		i2c_unregister_device(data->i2c);
> +	i2c_unregister_device(data->i2c);
>  
>  	tosa_lcd_tg_off(data);
>  
> -- 
> 2.20.1
> 
