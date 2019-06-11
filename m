Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C2C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A2F204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YJdPFYUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406640AbfFKUn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:43:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38131 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406514AbfFKUn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:43:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id a186so8162724pfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1eDHmgODZAwW/Fhw2Cp8ZhdVZsQA7q4YnUsS2FGTTA=;
        b=YJdPFYULSEVttU+RZo1T4Y/muDKbVhhlMin96CvvKUlEIu3lxR/UoTH+vEqoNGYUr2
         kA9n+9fmD/6UvtMGlV5Q+egXWtnQ0PEY6dALDF4H1V6FLq++ux1wwqMJVOKkeiBUyD7O
         9vIpFTN0qMM2XPC1o7o4C8jhE962EDR5jsGxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1eDHmgODZAwW/Fhw2Cp8ZhdVZsQA7q4YnUsS2FGTTA=;
        b=Y41suOu8kUcizSq1bmmvBNE7xqCTFxW//LW/jNs927k9HkptGvi+B/yhO/ZS3yvvPp
         VcAJR5mjV0JFULkzBPohRZqGSTam2pjvs/bJ7gHG3fmbRcon8y7fexiaUOhfDb21FIsJ
         SlCgRvjfUreuSHWnK81R2hrIIk9V/LlkxebDCL8ZtiRQCl+hkOiGsHb5x2zbvvM9wzQm
         bmVWOcOtEAay5YAn3Pl8YxmrfTSI4hZQ+s/9rX7KNaxi0Cr+M+S3S84IswALMEbphLUd
         MQRSo0hj+v1bcVPytIAI/Ih5B++v0mCAPji+74vwy5H0DmHRQbHjmvdYY4h46NqJr/MD
         Jbvw==
X-Gm-Message-State: APjAAAUa+ayp+byrMLRM6tDVlWa71TG9wHnp3Yl90yKf9g/hf1ZslS3u
        19bwrxDkgEY4el5Rj/1etdhJSg==
X-Google-Smtp-Source: APXvYqw0UIfo+xmBEIt8T6Z6t+/+imewhUUV6dYQhB2DakOY+VStrXyTraU+owaNFXaIU0Ug+jT3gQ==
X-Received: by 2002:a65:6648:: with SMTP id z8mr21605839pgv.303.1560285838473;
        Tue, 11 Jun 2019 13:43:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 133sm15275978pfa.92.2019.06.11.13.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 13:43:57 -0700 (PDT)
Date:   Tue, 11 Jun 2019 13:43:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <201906111343.5961D3B@keescook>
References: <20190611183213.GA31645@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611183213.GA31645@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:32:13PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/lkdtm/core.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 1972dad966f5..bae3b3763f3e 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -429,22 +429,13 @@ static int __init lkdtm_module_init(void)
>  
>  	/* Register debugfs interface */
>  	lkdtm_debugfs_root = debugfs_create_dir("provoke-crash", NULL);
> -	if (!lkdtm_debugfs_root) {
> -		pr_err("creating root dir failed\n");
> -		return -ENODEV;
> -	}
>  
>  	/* Install debugfs trigger files. */
>  	for (i = 0; i < ARRAY_SIZE(crashpoints); i++) {
>  		struct crashpoint *cur = &crashpoints[i];
> -		struct dentry *de;
>  
> -		de = debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root,
> -					 cur, &cur->fops);
> -		if (de == NULL) {
> -			pr_err("could not create crashpoint %s\n", cur->name);
> -			goto out_err;
> -		}
> +		debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root, cur,
> +				    &cur->fops);
>  	}
>  
>  	/* Install crashpoint if one was selected. */
> -- 
> 2.22.0
> 

-- 
Kees Cook
