Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A53C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F35B21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UpoguG/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKLWdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:33:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46443 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:33:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so12771257pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RGmt6PLbYhyeOnZp17n63ynPuJIi7itn37eXFbTZa0c=;
        b=UpoguG/CsW6TsG4IVXil0i6TSHAdvuHl9JI699WLgn0TaTR6HHhdh2RfBtlRO72r5p
         SO/wPeoR/reSgkIlqr33WVJe/fBdkCJstLVVRwO0cxVhMODzQEQuZrM/2sAKCFBVJ+D9
         1U6nsT6Q1wp4ozAu7GcSXNbLriw8trqg3jMPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGmt6PLbYhyeOnZp17n63ynPuJIi7itn37eXFbTZa0c=;
        b=kIIP5Q6cPgVM62TfOlYbgG/Z6a2tzDqeHVLS3LFgLMHHhhjDcr0L6m8S23iSg028Ob
         1JbAqo+Pe0gCkB0fS8jka/flvVQXnegbBP1arrg74dnDMEUHuJfeqNpA8iyDkwJAXITM
         Y9ayZ2D91g4DmkVwDaqQmKHTMSh69dFQp9jQgfQLTGb2pL77e9QWbBNlFhZ+Po3mLUlr
         xby5b/LxMizgB/PSkrJ3MwQ5K1feTI4+p81gQjOrE4kIgoCOCcqb93HHw6ReSzc8fx9y
         j9kf2I7T2xG/1fQrwPJ68kt5aZ13vPfCaxp3wbj4+CzoKUHAafaJJv+tf5JyCpPoK5nz
         hG7g==
X-Gm-Message-State: APjAAAWRy3Bl2slq0gp9KksQAV+KilhUqUv9Ek5RV3QPPw2nkehur+lJ
        AagH4fxAT3u5X4d9EseP36lSRQ==
X-Google-Smtp-Source: APXvYqyptVIgzatO0wTXSYEPo9fnfbtnf2weW93XN7BYrwcmuIToOghzrleKzVKQ98E64Tsx9I7TRg==
X-Received: by 2002:a17:90a:3651:: with SMTP id s75mr273648pjb.30.1573597985024;
        Tue, 12 Nov 2019 14:33:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f26sm19941pgf.22.2019.11.12.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:33:04 -0800 (PST)
Date:   Tue, 12 Nov 2019 14:33:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: use the correct callback type for
 bus_find_device
Message-ID: <201911121422.DD3A022@keescook>
References: <20191112214156.3430-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112214156.3430-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:41:56PM -0800, Sami Tolvanen wrote:
> platform_find_device_by_driver calls bus_find_device and passes
> platform_match as the callback function. Casting the function to a
> mismatching type trips indirect call Control-Flow Integrity (CFI) checking.

Specifically, the mismatch is between these two places:

struct device *bus_find_device(struct bus_type *bus,
                               struct device *start, const void *data,
                               int (*match)(struct device *dev, const void *data))

struct bus_type {
	...
        int (*match)(struct device *dev, struct device_driver *drv);

against the function itself, which needs to match the prototype for the
initializer assignment:

static int platform_match(struct device *dev, struct device_driver *drv)

I'm surprised this is the only place in the kernel where this happens,
but a grep for other bus_find_device() users shows that they don't also
have struct bus_type helpers; everything else uses the "const void
*data" second argument.

> This change adds a callback function with the correct type and instead
> of casting the function, explicitly casts the second parameter to struct
> device_driver* as expected by platform_match.
> 
> Fixes: 36f3313d6bff9 ("platform: Add platform_find_device_by_driver() helper")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  drivers/base/platform.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index b230beb6ccb4..3c0cd20925b7 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1278,6 +1278,11 @@ struct bus_type platform_bus_type = {
>  };
>  EXPORT_SYMBOL_GPL(platform_bus_type);
>  
> +static inline int __platform_match(struct device *dev, const void *drv)
> +{
> +	return platform_match(dev, (struct device_driver *)drv);
> +}
> +

So, this makes sense to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  /**
>   * platform_find_device_by_driver - Find a platform device with a given
>   * driver.
> @@ -1288,7 +1293,7 @@ struct device *platform_find_device_by_driver(struct device *start,
>  					      const struct device_driver *drv)
>  {
>  	return bus_find_device(&platform_bus_type, start, drv,
> -			       (void *)platform_match);
> +			       __platform_match);
>  }
>  EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
>  
> 
> base-commit: 100d46bd72ec689a5582c2f5f4deadc5bcb92d60
> -- 
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 

-- 
Kees Cook
