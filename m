Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F61C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115D320862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H66g4a+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389285AbfEXPGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:06:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36592 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388995AbfEXPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:06:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id y124so7278581oiy.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuXnHXnARocKH8HijbJcxjfEu2tYcY3pVOJ3Oz7W/sQ=;
        b=H66g4a+DcNiSgeDhyvL7X4qPXZbwUSLGwaTggHUe/aIVtRXP8up6aSaSn0FzJJUam9
         UM+0VKttVbJ+SjPpacuGRowi/ZTeFP2yMM2mX3sFYmRgKqXO0CmxozAredJ/8oaT72In
         W52fjd5ogOfYGYOabjo9gLpvvekUMe0K4y9rf4P1kFOBzGx3LOdeaRVvIkifu8DjBnQW
         wpiFHp/ZeB+0DEkvfDSaqxyWyghZI71dfus6ZBdl2EEVjbhKR4naRf4zN8dCvlahWirB
         eUJPlngLwZ34zvnmY8ShtTvmwpKddkOsSLW2tJAK9aTJECJ1OSkOKaOQiAKokajQYdtH
         h64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=yuXnHXnARocKH8HijbJcxjfEu2tYcY3pVOJ3Oz7W/sQ=;
        b=Ad6YckVA7xi2aKinM4R1QmvtfqKt2qPnD9z0sV4x1iflXS9RGc2+tlIJu0aukaxw0T
         CJkzf8SiO9oBnQQKFZ1/ywBWYiGPYCybqgCCuGkrAFczsu0b8Mw6iDqaGzZI3CDMADL6
         bpoPs0u59thcfpEIawnfxNIO9izj8EGI4KPiQ/Zf28Fs5G+eo3s9o8Vuxg3ZxT3A8ow5
         J7M1K0BsPYcEKG6u9SZk2fATvmXeiVgQA1NV4CU+vNa2DCmjcpcAMuG87nn3yYD26NHN
         Ak2q7+mVwhG6t4Quw6tse6b5WsslJscNcvV5SQJhtgiGCjvAqagJSXl7eAv15bmESiez
         jU9w==
X-Gm-Message-State: APjAAAXeBULkiVioon/SsuS5toNjVa5Su2pYMPDGP+9dKOUj1BKB/erw
        DS7Uqj8HAEk4O8kDo+MeVqqteIM=
X-Google-Smtp-Source: APXvYqy6UBJPpmdsaKeqRplCkPk4LOTV0Mg+W2FYpR+Hxn2yWnJNIiAI5xm43HEtwAG+KZueNoixgQ==
X-Received: by 2002:aca:aace:: with SMTP id t197mr6217017oie.149.1558710370712;
        Fri, 24 May 2019 08:06:10 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id b9sm918580oti.43.2019.05.24.08.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 08:06:09 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:4484:d79a:f88b:8863])
        by serve.minyard.net (Postfix) with ESMTPSA id 4119A1818F3;
        Fri, 24 May 2019 15:06:09 +0000 (UTC)
Date:   Fri, 24 May 2019 10:06:07 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ipmi_ssif: fix unexpected driver unregister warning
Message-ID: <20190524150607.GD2742@minyard.net>
Reply-To: minyard@acm.org
References: <20190524143724.43218-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524143724.43218-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:37:24PM +0800, Kefeng Wang wrote:
> If platform_driver_register() fails from init_ipmi_ssif(),
> platform_driver_unregister() called unconditionally will
> trigger following warning,

Yep, same as the ipmi_si change before.  Thanks, it's in my
next tree queued for the next cycle.

-corey

> 
> ipmi_ssif: Unable to register driver: -12
> ------------[ cut here ]------------
> Unexpected driver unregister!
> WARNING: CPU: 1 PID: 6305 at drivers/base/driver.c:193 driver_unregister+0x60/0x70 drivers/base/driver.c:193
> 
> Fix it by adding platform_registered variable, only unregister platform
> driver when it is already successfully registered.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index cf8156d6bc07..305fa5054274 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -303,6 +303,7 @@ struct ssif_info {
>  	((unsigned int) atomic_read(&(ssif)->stats[SSIF_STAT_ ## stat]))
>  
>  static bool initialized;
> +static bool platform_registered;
>  
>  static void return_hosed_msg(struct ssif_info *ssif_info,
>  			     struct ipmi_smi_msg *msg);
> @@ -2088,6 +2089,8 @@ static int init_ipmi_ssif(void)
>  		rv = platform_driver_register(&ipmi_driver);
>  		if (rv)
>  			pr_err("Unable to register driver: %d\n", rv);
> +		else
> +			platform_registered = true;
>  	}
>  
>  	ssif_i2c_driver.address_list = ssif_address_list();
> @@ -2111,7 +2114,7 @@ static void cleanup_ipmi_ssif(void)
>  
>  	kfree(ssif_i2c_driver.address_list);
>  
> -	if (ssif_trydmi)
> +	if (ssif_trydmi && platform_registered)
>  		platform_driver_unregister(&ipmi_driver);
>  
>  	free_ssif_clients();
> -- 
> 2.20.1
> 
