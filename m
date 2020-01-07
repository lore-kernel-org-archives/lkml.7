Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6FC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19D624656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h85BaclV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgAGO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:27:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35543 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgAGO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:27:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so54134532wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8hXh4qgKLVb1cQt44JgoaXWFkTPXCKeegQWam/p7R00=;
        b=h85BaclVvmvAi/c2nhi5Ll4N+2QBoE5gbIIzgMyLb+0XHQkV4zpbr9RrM0HUfJfh+C
         K4iWTlOMqCkjmSitg6eqslgTl+6yMZnq3Jsa6QEOGCSCuUVqsLjjmwZTaUp7hmE/4lL6
         iEbdcXTFCSUuc8xbfOx2IGyyjHPhD4pPBj0mS6O3ju6jLI0MkirgcqBiZ+fppfzCQ6Ci
         Mzvs4KwNLJETJpTBJWbQYRAzhUooX6AqUJyI8PrLxrybb62xZt1lAGyoonaULCOxYsgO
         PUT4vMd4V7ITjMNXPZgRy4EoIvhLGY6tPHM+9mY2Qyffj5TJK4LBCyJD9kbsdxqeEhlM
         dEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8hXh4qgKLVb1cQt44JgoaXWFkTPXCKeegQWam/p7R00=;
        b=Ud4yVcOMUq49m4c+oBa+tWcuinhqKbHWI11C2SgbomndwIpbKLEiiEEfyuTu7EGqFB
         Hgs+oNpsNg5Qn5V/tG7VRosP0HB7Tp/XQmzJKEALVU2wAUnzgdDAE6MLekF4wSP3Az5R
         1bKZyFccbb+4TDw48/N894CF6zMnIhVXei/O+LgtBc5zwDE3kkJB7JwyK3u9kQyyLf2r
         BgDegEXwK+ZrWSEicMbutkZV8NN2YE9TAkW3ersYI0stlSP2fC3gKHxXfMxoyzB6xYHv
         rzy1ZKq43urbHL/w6HgMMdUUC+IcK1OQgkOhBtxs9hldFg4kg+k4ACfwXCvS1MFNh+Y4
         uFiQ==
X-Gm-Message-State: APjAAAVj9ldQ4xx8xOWrSNehpfrL9jLP5JWbEaV2yvcmiPHFtqSNcnCN
        HIoA3xpBqHo3ld41PZWIIcIftXTxJYg=
X-Google-Smtp-Source: APXvYqyJRv77abbzDAGTq8+hH6cSw5cZIDLfCqIEhb+D3xL5GUx0+BiXs4sGGYXGVxsrY0+XR8WJKw==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr100752194wrx.147.1578407255722;
        Tue, 07 Jan 2020 06:27:35 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id a9sm25974878wmm.15.2020.01.07.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:27:35 -0800 (PST)
Date:   Tue, 7 Jan 2020 14:27:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] mfd: madera: Allow more time for hardware reset
Message-ID: <20200107142742.GN14821@dell>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jan 2020, Charles Keepax wrote:

> Both manual and power on resets have a brief period where the chip will
> not be accessible immediately afterwards. Extend the time allowed for
> this from a minimum of 1mS to 2mS based on newer evaluation of the
> hardware and ensure this reset happens in all reset conditions. Whilst
> making the change also remove the redundant NULL checks in the reset
> functions as the GPIO functions already check for this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index a8cfadc1fc01e..f41ce408259fb 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -238,6 +238,11 @@ static int madera_wait_for_boot(struct madera *madera)
>  	return ret;
>  }
>  
> +static inline void madera_reset_delay(void)
> +{
> +	usleep_range(2000, 3000);
> +}

Hmm ... We usually shy away from abstraction for the sake of
abstraction.  What's preventing you from using the preferred method of
simply calling the abstracted function from each of the call-sites?

I could understand (a little) if you needed to frequently change these
values, since changing them in once place is obviously simpler than
changing them in 3, but even then it's marginal.

>  static int madera_soft_reset(struct madera *madera)
>  {
>  	int ret;
> @@ -249,16 +254,13 @@ static int madera_soft_reset(struct madera *madera)
>  	}
>  
>  	/* Allow time for internal clocks to startup after reset */
> -	usleep_range(1000, 2000);
> +	madera_reset_delay();
>  
>  	return 0;
>  }
>  
>  static void madera_enable_hard_reset(struct madera *madera)
>  {
> -	if (!madera->pdata.reset)
> -		return;
> -
>  	/*
>  	 * There are many existing out-of-tree users of these codecs that we
>  	 * can't break so preserve the expected behaviour of setting the line
> @@ -269,11 +271,9 @@ static void madera_enable_hard_reset(struct madera *madera)
>  
>  static void madera_disable_hard_reset(struct madera *madera)
>  {
> -	if (!madera->pdata.reset)
> -		return;
> -
>  	gpiod_set_raw_value_cansleep(madera->pdata.reset, 1);
> -	usleep_range(1000, 2000);
> +
> +	madera_reset_delay();
>  }
>  
>  static int __maybe_unused madera_runtime_resume(struct device *dev)
> @@ -292,6 +292,8 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
>  	regcache_cache_only(madera->regmap, false);
>  	regcache_cache_only(madera->regmap_32bit, false);
>  
> +	madera_reset_delay();
> +
>  	ret = madera_wait_for_boot(madera);
>  	if (ret)
>  		goto err;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
