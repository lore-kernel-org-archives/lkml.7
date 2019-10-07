Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0CCECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68172070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtfturaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfJGPNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:13:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53899 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:13:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so13092193wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zZhWwemYig8kkhxldGf4LKemMdD16O7Dc8IYXL4Z9nQ=;
        b=TtfturaR8liADnZGl/3TkUOAnWRUKqPN60ooxnYYL6Va4SHdSH7tCSecNi7Y8dNBVv
         Sih8Zsx/P0NdmRovUTDJe4OefM0M3fYYZkH4Ua62ocK1kMsPnqFa7Jd7GlevAYguTp8W
         XGGqQNl9SfdSzxtH9TLnymc2P6hPk/2NiYyKUnEGd4D/dnQH8a7AYyfhHKZ+gSY2rhs0
         f+Kp+YX+VBKSaaD4RCxkq1pJfGPNK5hjrT6zv/Q2jqxp3rScWis3JE7VYfsz9L5mpSK3
         AJIWz6NA29ya4ZFpE6PfdJ1qGWzJ1SRoQjz583M8TK5FJWxbHjLuKCHxNOdeu1MiCL7R
         Cc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zZhWwemYig8kkhxldGf4LKemMdD16O7Dc8IYXL4Z9nQ=;
        b=FbS1WNAOwKVhn5di1Wd3leObQoNmq1BFgz3fOi1P694oB/Gyg9d/8TBPYyDk4Oz+zU
         AjbqxUgLCYjRRdT+0uaTmk2yAb625oipGR20xVLJQckx3F4BZNn3dp80Lb2GMcgQ9PPD
         kL1z5TBAXMDbneJoK+9P19zMoLm2Mov9cqDiuWhfV27k0jMUdcsKAifu87Br1H3xO5xy
         RwqkKQpJcsp1jMtN6ofUA4GWn/aGTKBbvAjVQdv0YJz3NVxgIJTWTbsDnQw/KAicJPOn
         NPHwyLgFZw2sZaIoLtU7eUwwrcwURO9HrgwZ/AL5SIyCb7MtFxwmDQvT80k7S66x4jCJ
         W6bw==
X-Gm-Message-State: APjAAAVbRdP/Z9V9cvhPWzA3OQk/zNgj7FIHeq6LY04WRckfDUkektzg
        2Ah4PwhpqjtHnsS8w653cx5WMg==
X-Google-Smtp-Source: APXvYqyoB84wgf2m2ZiN/nCRXnW//WyCx1S1jxPL+K+bYrlRxCFhQyVxnrvMqqjqFYdzzvEJ6AVRAA==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr12606425wmi.95.1570461201869;
        Mon, 07 Oct 2019 08:13:21 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a3sm28051120wmc.3.2019.10.07.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:13:21 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:13:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] backlight: pwm_bl: eliminate a 64/32 division
Message-ID: <20191007151319.de6ko7n5dypqgyce@holly.lan>
References: <20190919140620.32407-1-linux@rasmusvillemoes.dk>
 <20190919140620.32407-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919140620.32407-2-linux@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 04:06:17PM +0200, Rasmus Villemoes wrote:
> lightness*1000 is nowhere near overflowing 32 bits, so we can just use
> an ordinary 32/32 division, which is much cheaper than the 64/32 done
> via do_div().
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index be36be1cacb7..9252d51f31b9 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -177,7 +177,7 @@ static u64 cie1931(unsigned int lightness, unsigned int scale)
>  	 */
>  	lightness *= 100;
>  	if (lightness <= (8 * scale)) {
> -		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9033);
> +		retval = DIV_ROUND_CLOSEST(lightness * 10, 9033);
>  	} else {
>  		retval = int_pow((lightness + (16 * scale)) / 116, 3);
>  		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
> -- 
> 2.20.1
