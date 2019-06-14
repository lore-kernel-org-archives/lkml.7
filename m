Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F2FC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F69320850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UgUE3/10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfFNFUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:20:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33167 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfFNFUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:20:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so513433plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaKV7EziIjndV6AC+P0Sj4AtYTr8nO2QSc+wtuDvkUw=;
        b=UgUE3/10eslkNJLEV8hF7ZLG4ONsqW43pl12koi4wIm54HP6r9Srh8N6xE3arEvqKY
         bQHE6BgI2k0MjeMk6m2a8QxdCa+0roxNFBco4POjtlHM8aRCN2dYHqFvzWKGrNrQhwrr
         YBHjPW6i27j6mOfTr37z4CA6/5iwbosmGOY1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaKV7EziIjndV6AC+P0Sj4AtYTr8nO2QSc+wtuDvkUw=;
        b=Yner1tGpbk7GkBpcawTNzo3JVmRI0DvYRw2zmzV8yxD377F/e31o09Dnopzgu0o7ea
         Hv733cjt3AsQFsGtCKtVCyIty79gmKfxrRyl1dfcO7Fojj2GKjkaQUgVcosMNNTmcDWc
         tYuQqIhQQZeqKg+RkJBoH1mHvRFP7PutogxScCWIVmkwuiAy9UI3mwejWR3oJ2w+o8gi
         ukwdaQP7XD3MN/SDXtOkVrmHNNneBcCmf05fTfgBmKV3wh4DGovFNekSKLgzffRLCyrs
         fnajje70Zi92eSQh2//K7E6Pi6zaimxSDmAIMYVRZOclHBK71vpd+zT6eiYQyZpL9vMr
         9U5Q==
X-Gm-Message-State: APjAAAWHoolyFQjYcgP7qVRigY+Id2idAA3HmXAhORBbFXnM+1ckHMhs
        /ySGGCLQrej/Cbr6Jae9eCOQog==
X-Google-Smtp-Source: APXvYqxDGSylSjnaigTsBxyOXmi2MqnO4PIGOjYHINb+UawkNtJvXscNF6WEwrqh88lY/IGNUBEbFw==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr19043580plk.321.1560489639574;
        Thu, 13 Jun 2019 22:20:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11sm1382699pfn.170.2019.06.13.22.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 22:20:38 -0700 (PDT)
Date:   Thu, 13 Jun 2019 22:20:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     corbet@lwn.net, federico.vaga@vaga.pv.it,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: stop suggesting strlcpy
Message-ID: <201906132220.F12C1111@keescook>
References: <20190613162548.19792-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613162548.19792-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 06:25:48PM +0200, Stephen Kitt wrote:
> Since strlcpy is deprecated, the documentation shouldn't suggest using
> it. This patch fixes the examples to use strscpy instead. It also uses
> sizeof instead of underlying constants as far as possible, to simplify
> future changes to the corresponding data structures.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Yes please!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/hid/hid-transport.txt                         | 6 +++---
>  Documentation/i2c/instantiating-devices                     | 2 +-
>  Documentation/i2c/upgrading-clients                         | 4 ++--
>  Documentation/kernel-hacking/locking.rst                    | 6 +++---
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 6 +++---
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/hid/hid-transport.txt b/Documentation/hid/hid-transport.txt
> index 3dcba9fd4a3a..4f41d67f1b4b 100644
> --- a/Documentation/hid/hid-transport.txt
> +++ b/Documentation/hid/hid-transport.txt
> @@ -194,9 +194,9 @@ with HID core:
>  		goto err_<...>;
>  	}
>  
> -	strlcpy(hid->name, <device-name-src>, 127);
> -	strlcpy(hid->phys, <device-phys-src>, 63);
> -	strlcpy(hid->uniq, <device-uniq-src>, 63);
> +	strscpy(hid->name, <device-name-src>, sizeof(hid->name));
> +	strscpy(hid->phys, <device-phys-src>, sizeof(hid->phys));
> +	strscpy(hid->uniq, <device-uniq-src>, sizeof(hid->uniq));
>  
>  	hid->ll_driver = &custom_ll_driver;
>  	hid->bus = <device-bus>;
> diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
> index 0d85ac1935b7..8bc7d99133e3 100644
> --- a/Documentation/i2c/instantiating-devices
> +++ b/Documentation/i2c/instantiating-devices
> @@ -137,7 +137,7 @@ static int usb_hcd_nxp_probe(struct platform_device *pdev)
>  	(...)
>  	i2c_adap = i2c_get_adapter(2);
>  	memset(&i2c_info, 0, sizeof(struct i2c_board_info));
> -	strlcpy(i2c_info.type, "isp1301_nxp", I2C_NAME_SIZE);
> +	strscpy(i2c_info.type, "isp1301_nxp", sizeof(i2c_info.type));
>  	isp1301_i2c_client = i2c_new_probed_device(i2c_adap, &i2c_info,
>  						   normal_i2c, NULL);
>  	i2c_put_adapter(i2c_adap);
> diff --git a/Documentation/i2c/upgrading-clients b/Documentation/i2c/upgrading-clients
> index ccba3ffd6e80..96392cc5b5c7 100644
> --- a/Documentation/i2c/upgrading-clients
> +++ b/Documentation/i2c/upgrading-clients
> @@ -43,7 +43,7 @@ static int example_attach(struct i2c_adapter *adap, int addr, int kind)
>  	example->client.adapter = adap;
>  
>  	i2c_set_clientdata(&state->i2c_client, state);
> -	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +	strscpy(client->i2c_client.name, "example", sizeof(client->i2c_client.name));
>  
>  	ret = i2c_attach_client(&state->i2c_client);
>  	if (ret < 0) {
> @@ -138,7 +138,7 @@ can be removed:
>  -	example->client.flags   = 0;
>  -	example->client.adapter = adap;
>  -
> --	strlcpy(client->i2c_client.name, "example", I2C_NAME_SIZE);
> +-	strscpy(client->i2c_client.name, "example", sizeof(client->i2c_client.name));
>  
>  The i2c_set_clientdata is now:
>  
> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
> index 519673df0e82..dc698ea456e0 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -451,7 +451,7 @@ to protect the cache and all the objects within it. Here's the code::
>              if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
>                      return -ENOMEM;
>  
> -            strlcpy(obj->name, name, sizeof(obj->name));
> +            strscpy(obj->name, name, sizeof(obj->name));
>              obj->id = id;
>              obj->popularity = 0;
>  
> @@ -660,7 +660,7 @@ Here is the code::
>       }
>  
>      @@ -63,6 +94,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      +        obj->refcnt = 1; /* The cache holds a reference */
> @@ -774,7 +774,7 @@ the lock is no longer used to protect the reference count itself.
>       }
>  
>      @@ -94,7 +76,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      -        obj->refcnt = 1; /* The cache holds a reference */
> diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
> index 0ef31666663b..5fd8a1abd2be 100644
> --- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
> +++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
> @@ -468,7 +468,7 @@ e tutti gli oggetti che contiene. Ecco il codice::
>              if ((obj = kmalloc(sizeof(*obj), GFP_KERNEL)) == NULL)
>                      return -ENOMEM;
>  
> -            strlcpy(obj->name, name, sizeof(obj->name));
> +            strscpy(obj->name, name, sizeof(obj->name));
>              obj->id = id;
>              obj->popularity = 0;
>  
> @@ -678,7 +678,7 @@ Ecco il codice::
>       }
>  
>      @@ -63,6 +94,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      +        obj->refcnt = 1; /* The cache holds a reference */
> @@ -792,7 +792,7 @@ contatore stesso.
>       }
>  
>      @@ -94,7 +76,7 @@
> -             strlcpy(obj->name, name, sizeof(obj->name));
> +             strscpy(obj->name, name, sizeof(obj->name));
>               obj->id = id;
>               obj->popularity = 0;
>      -        obj->refcnt = 1; /* The cache holds a reference */
> -- 
> 2.11.0
> 

-- 
Kees Cook
