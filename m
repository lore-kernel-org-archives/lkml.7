Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630552186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hnMZlylC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfH3Fkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:40:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40899 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfH3Fko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:40:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so3850428pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eVvtzN7Igkuh4Imleg3djnnr5OtlI8MGXuQLQiEidZU=;
        b=hnMZlylCor+dZUvWVSWYiA8UIOvAlApi2I0f+Ywdk+k9sW5KnRJJeMF1IJd3tX7vkU
         oaZHglBJbWbFB/jvIbYVjQaAnporW/L9dZx1dWJmGIbQMgt5u8KzMnu0pZMZ3WsDg/DF
         ut4lcjfTVbUwEvfyvTQgRkFXWxUnAhD0nSlEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVvtzN7Igkuh4Imleg3djnnr5OtlI8MGXuQLQiEidZU=;
        b=HSwr2YnuqcEBNynd0uU2zZFikJL/RXyPwzqkezlqk2JW1kQiDAZFQWDnWUF9kARgyv
         t5vfuTTkVK6dOolB6NxbJ9EO4V3qQjQj+fsxeDSZExU+RsTXEqrn1Fh3uFFjXphdHYfB
         FGvV4rSYxd5MXWnfgacE5f5oNZiGruH8aCAFfL00fO4Urh1+MWgEud/NpaommrT0a3Va
         ZgBqfu6xvMc7Ty6GbylNLy4bS0WbLnkN48CebRRGSs+m8b2bhJBAwL7Ra42btA/KyqeU
         AfL8st+xdCoslqd25C2qzLBE25KiymhK4IxZnMyqCgv2PH6DOf9nF3wmrgC+QTa7OlCs
         eldA==
X-Gm-Message-State: APjAAAVhPVU4+2OvspxyxD72+4MX5xu4hL4VodZ1JAzFQwEtl9UpQCmg
        1xMdFNLsj0v24l5yQB/Ieerx30la9Ko=
X-Google-Smtp-Source: APXvYqw+F5l2dLUHf4clL+wuN5FTwsCCkJfTv4z/xD76/v2pwtskdDaZ43oFaBVsm56JgOyDMxNNfQ==
X-Received: by 2002:a17:90a:a40e:: with SMTP id y14mr13342365pjp.83.1567143643954;
        Thu, 29 Aug 2019 22:40:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm4937379pfh.186.2019.08.29.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:40:43 -0700 (PDT)
Date:   Thu, 29 Aug 2019 22:40:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: pwm: Use struct_size() helper
Message-ID: <201908292240.E0C345D884@keescook>
References: <20190830005320.GA15267@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830005320.GA15267@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 07:53:20PM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct led_pwm_priv {
> 	...
>         struct led_pwm_data leds[0];
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following function:
> 
> static inline size_t sizeof_pwm_leds_priv(int num_leds)
> {
>        return sizeof(struct led_pwm_priv) +
>                      (sizeof(struct led_pwm_data) * num_leds);
> }
> 
> with:
> 
> struct_size(priv, leds, count)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/leds/leds-pwm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index d0e1f2710351..8b6965a563e9 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -65,12 +65,6 @@ static int led_pwm_set(struct led_classdev *led_cdev,
>  	return 0;
>  }
>  
> -static inline size_t sizeof_pwm_leds_priv(int num_leds)
> -{
> -	return sizeof(struct led_pwm_priv) +
> -		      (sizeof(struct led_pwm_data) * num_leds);
> -}
> -
>  static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
>  		       struct led_pwm *led, struct fwnode_handle *fwnode)
>  {
> @@ -174,7 +168,7 @@ static int led_pwm_probe(struct platform_device *pdev)
>  	if (!count)
>  		return -EINVAL;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof_pwm_leds_priv(count),
> +	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
>  			    GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> -- 
> 2.23.0
> 

-- 
Kees Cook
