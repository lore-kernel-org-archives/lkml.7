Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A01C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900CA20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFi1N8xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfFLMVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:21:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44917 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfFLMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:21:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so16655075wrq.11;
        Wed, 12 Jun 2019 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Bo1caLR1G0jnn9weiBquvmZo/dmE0TTjp0/Q1T2tn0c=;
        b=JFi1N8xj9jc7EGt3dXYhe49EKdtE3DcBG0tPAqv/odNRVqgvDAYtJOkGl/is4rLkno
         qrIYV0T3rczLo4nLU2cGmw0R+bTmdOGpCpcB046hYqC9AbWNBkMJuC0/Ttwk4EYOjUyn
         zuZrrNOQWW9CoHidFBJo7aMsaM+u0Ggm+3cHuSoeuI8fhHtwOruPMM4cZ1F1G76/vur+
         /CnbP9/REqmAcJXPJ5V6GZC3Eem0ua7evVOrGmb+ELGYd3Iaa/uAu1NyPpieV8OLvWq7
         XzYELkY87g5j/tpWHrs0/Dy6J8ikzY0s/gQZyL6DVUotyWJDtiXhg+jb+WgazeYOO53B
         i9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Bo1caLR1G0jnn9weiBquvmZo/dmE0TTjp0/Q1T2tn0c=;
        b=UvQA8xVOlMDFC4i63FmhZfmVbdaK5A2hRS2gt2m8FoCIXcqcvapsSr0nPVx0gPeqDl
         f/JH/ICDQbDovMTWYFGCkjnJT2lLH64VcfSgs3MhG+rCxdjDsdO22OuWw8beWNzoyOje
         PPp/ncHdWkagFSKctGxTwGtHa5as76IThNMglh6vSTWo6tYOqEUUCqu7/aHhm609Zfnc
         cPRf9GtHcIGI+oc2xynOf9lNC2mYkZe7b38B2ax8SuO6m3CiP1F2dQH3z1DrZ17HtwWp
         KkYJ/pFGvNMg1vRCq/bYJ472H687gEQ/oJIuwHO5pHd2vKc0ut/xyy4g8w37VkWhxRA2
         O5sQ==
X-Gm-Message-State: APjAAAUzS4MkR/i8gQmD5r291ZVyDm+VHFCAJ3zFzDVaZwI/cTpUUOIB
        KUHbV6yBeexzHe7QWrgeWfI=
X-Google-Smtp-Source: APXvYqwuKom3R5s3HocfcJaXt+t+v/LMyRIzyqp14MaRVsULZ7zz5V+0DzTSxXUiVxkMMk17YKzaIw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr54907769wrn.165.1560342067900;
        Wed, 12 Jun 2019 05:21:07 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u6sm1372445wml.9.2019.06.12.05.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 05:21:06 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:21:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dvhart@infradead.org, andy@infradead.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] platform: x86: dell-laptop: no need to check return
 value of debugfs_create functions
Message-ID: <20190612122105.miyyfkmae24kddwt@pali>
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
 <20190612121258.19535-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612121258.19535-3-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 June 2019 14:12:53 Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: "Pali Rohár" <pali.rohar@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/platform/x86/dell-laptop.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index a561f653cf13..94a2f259031c 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2176,9 +2176,8 @@ static int __init dell_init(void)
>  	kbd_led_init(&platform_device->dev);
>  
>  	dell_laptop_dir = debugfs_create_dir("dell_laptop", NULL);
> -	if (dell_laptop_dir != NULL)
> -		debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> -				    &dell_debugfs_fops);
> +	debugfs_create_file("rfkill", 0444, dell_laptop_dir, NULL,
> +			    &dell_debugfs_fops);

Hi!

So... debugfs_create_dir() can return NULL, right?

And it is then OK to call
debugfs_create_file("rfkill", 0444, dell_laptop_dir, ...) with
dell_laptop_dir = NULL?

Where would be that "rfkill" file created?

>  
>  	dell_laptop_register_notifier(&dell_laptop_notifier);
>  

-- 
Pali Rohár
pali.rohar@gmail.com
