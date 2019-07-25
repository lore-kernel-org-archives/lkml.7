Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B3AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14ACE22BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuNqE/NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfGYJtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:49:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37419 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfGYJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:49:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so24965928wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ujml4/mJ0MyIJxWWY8Xw5VZRsjX7zZKg2q4taAzvM/c=;
        b=VuNqE/NY+xkhpIiYamvpZsvoQFiBCE3wxC7mksjIRfdbeMGmFna25bkqhkjb44XsAy
         TqccR8asVu2KTiszeyVdgNj08Zfgh2V5+G7z7LP/zmKwZ2VJue3RWqbjHyviRERyGx2P
         FmjKBbI29vUi4HuccBNNNZ+OLEr3AOJCEJwn8Q7c8JGXrLEI06dEpLRWqu4TLEAKfz69
         W8f8EhmQFptIkojB+aRSgULsjceeR4OJfHeqzAIsOsh0DqFTHwBTk87WpWeeNLMOb7gt
         xXnNp3sfzEE3BXmfaHS45Y/HGg6mgJc7t3quha3SG1JNKhLs6kSY3pQRNFx+hVk03bmX
         W7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ujml4/mJ0MyIJxWWY8Xw5VZRsjX7zZKg2q4taAzvM/c=;
        b=Pj1ezHV0FkneUz0I8vkffmo4rsaUzItpXHFvjsLGl/e8frv01RONQCRr5Kn6R22MZO
         av52tnk+SrA0WcvLX7F88mHtM0fCAn7wIjCz3R76pJhdaTfOurJZ+R5CD8FvbTprSOhR
         hEFB0ZvVf1VDs/Dz5i6Gzvvnb4p6yZ52l7iNFnE517ag+XY09qID9Tdj0Qq41xRIXSM0
         uCnzOBLGLNDEusbFiIRtGs9zVE5/o+IRsbWJLRfgoGBEmNBPGZME1qg1/70R/X+2LiT9
         TyQtWkrIbPtSHpPN5WpjoBWKqyXBKPH21fl5B3XK38UEmDn/FyBvN5z0VSa60bdb3EtG
         qRKg==
X-Gm-Message-State: APjAAAUEowyfNH36lLBV9JZlmlBKeKLAsG9tQQX7fLqF0yfV8lzkNhaY
        pFI+JjaGCeBS8kGrqxXOrlUseA==
X-Google-Smtp-Source: APXvYqxwv81BIV5RMSww0ZNPDfXsKTb2cQCw57D4xuzbghZTfN7520eIoXJkR8KoKO7DJIthWIGKpg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr82173869wrn.313.1564048173775;
        Thu, 25 Jul 2019 02:49:33 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a81sm49660430wmh.3.2019.07.25.02.49.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 02:49:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 10:49:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: lms283gf05: Fix a typo in the description
 passed to 'devm_gpio_request_one()'
Message-ID: <20190725094931.biqd3pkt4kuaujaq@holly.lan>
References: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724213828.16916-1-christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:38:28PM +0200, Christophe JAILLET wrote:
> The description passed to 'devm_gpio_request_one()' should be related to
> LMS283GF05, not LMS285GF05.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/lms283gf05.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
> index 4237aaa7f269..4b62ed7e58c0 100644
> --- a/drivers/video/backlight/lms283gf05.c
> +++ b/drivers/video/backlight/lms283gf05.c
> @@ -161,7 +161,7 @@ static int lms283gf05_probe(struct spi_device *spi)
>  		ret = devm_gpio_request_one(&spi->dev, pdata->reset_gpio,
>  				GPIOF_DIR_OUT | (!pdata->reset_inverted ?
>  				GPIOF_INIT_HIGH : GPIOF_INIT_LOW),
> -				"LMS285GF05 RESET");
> +				"LMS283GF05 RESET");
>  		if (ret)
>  			return ret;
>  	}
> -- 
> 2.20.1
> 
