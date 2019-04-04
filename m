Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FEAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5949214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvEDaAMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfDDHHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:07:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46092 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfDDHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:06:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so675401pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 00:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=gIu1x+mW1ir5iF7JpPsqOImZuIQnF/0zUJnFMQ0zgOI=;
        b=XvEDaAMb+Nu/iRu6vQJ4RSQqxMHTmPSawG6QOLFPl/skcZekhRuvQJ0c4y8uLKaUlQ
         KAp2hR6Xm8dvSN30W1Rp0TBywBTWiM8FIiTRqLoSgjrPT3cSAOhHMYKR59nkDnj9ld3j
         8ATdxGVDrkElsvvgKx/kRPxX6DUCLLpyhYLMLxN4JDCb8LnnOndX+DqdkmgNZ1F6VgUj
         yfcMnH2jlVbpz73gdTz9BOBVks+gM0sSleCiWIrN4qnHY1LR+CjUM2BlhjpCJW9V5ZdG
         9NZ+yppdR72MJo+yS3lGwAXLF5ZX3LOjoz9xgISgjenTfK8BvBynqOb0FuuZxuyxD0HL
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=gIu1x+mW1ir5iF7JpPsqOImZuIQnF/0zUJnFMQ0zgOI=;
        b=Fh8LFAY/6YNVwtpt2h68QoaCOsd6QAcAmZnPfU/IEJ19cwoi30ZxdepYeHhVMd8kbF
         5V4Z9lOLWTnqDDaARmM9UQvGs0l3CHGu8iZcuob3xDsaOC0jxe89AVMMlbcfjJ3pyVq2
         XaqIJBYAb9M1CZTN+KTnsH8BsuHu9K3wiqMype1AZAzlM8bCiBWgKtkJIDHDQGLhrbbZ
         vxqmMocMVE7SV+LZd3fxPw2lciPpglgrFmpGT9B1KlH35zI9WL0TOvphJF4tcrEopMV1
         KmUICzVw+tNyVkGLghr5bwCd28b1HeJEegqdtRveUxJwmRBuM0EJjNjZFHnXmLsCWcab
         K2+Q==
X-Gm-Message-State: APjAAAWtLcA5RnUz6WHMe2JJNKZqsH/k0XQPl9Cfl6bolvhNBr49aRQJ
        ED89iCTftfyKqUPCZZQLMCakfQ==
X-Google-Smtp-Source: APXvYqxSsDMrY3z1uaiFmPgDGLE7zhg0r9s5Uq+dcE/70kcAv+KvBfKLCe9bRCE8doW6O0v5hZTRsg==
X-Received: by 2002:a17:902:768c:: with SMTP id m12mr4670072pll.160.1554361618828;
        Thu, 04 Apr 2019 00:06:58 -0700 (PDT)
Received: from arch-late ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id 17sm36102624pfw.65.2019.04.04.00.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 00:06:58 -0700 (PDT)
References: <20190404065330.12382-1-johan@kernel.org>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] staging: greybus: power_supply: fix prop-descriptor request size
In-reply-to: <20190404065330.12382-1-johan@kernel.org>
Date:   Thu, 04 Apr 2019 08:06:53 +0100
Message-ID: <m38swqp7ua.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,
Thanks for the patch.

On Thu 04 Apr 2019 at 07:53, Johan Hovold wrote:
> Since moving the message buffers off the stack, the dynamically
> allocated get-prop-descriptor request buffer is incorrectly 
> sized due to
> using the pointer rather than request-struct size when creating 
> the
> operation.
>
> Fortunately, the pointer size is always larger than this 
> one-byte
> request, but this could still cause trouble on the remote end 
> due to the
> unexpected message size.
>
> Fixes: 9d15134d067e ("greybus: power_supply: rework get 
> descriptors")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Nice catch. LGTM.

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

---
Cheers,
	Rui


> ---
>  drivers/staging/greybus/power_supply.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/power_supply.c 
> b/drivers/staging/greybus/power_supply.c
> index 0529e5628c24..ae5c0285a942 100644
> --- a/drivers/staging/greybus/power_supply.c
> +++ b/drivers/staging/greybus/power_supply.c
> @@ -520,7 +520,7 @@ static int 
> gb_power_supply_prop_descriptors_get(struct gb_power_supply 
> *gbpsy)
>  
>  	op = gb_operation_create(connection,
>  				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
> -				 sizeof(req), sizeof(*resp) + 
> props_count *
> +				 sizeof(*req), sizeof(*resp) + 
> props_count *
>  				 sizeof(struct 
>  gb_power_supply_props_desc),
>  				 GFP_KERNEL);
>  	if (!op)

