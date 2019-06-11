Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03387C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1044217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPzvz8KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392014AbfFKSo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:44:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfFKSoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:44:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so7437452pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Etra+AHO4zcdS2DInBS7WLjC1KJ3vqfHkZBwr0AdbDs=;
        b=WPzvz8KP4N4OsaYPxseiuZd3s/Ls+oFzEwz4kKA+nl43eiXtx3bXracBWLbvER2q7s
         wOhI1I5bDSofH8IMocb7L8gTUxSmicRveLTNPFRNIRy/+I/7LQYCtYYO8buAQ5LDz5yO
         926Ogfz5/NLPFenrEKNn/RBUgL4UBiLbl7KQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Etra+AHO4zcdS2DInBS7WLjC1KJ3vqfHkZBwr0AdbDs=;
        b=idfl3lgfu8f+deWte8ryFF4MGINZ/2oJvDBREYxBSUUExxMaT05Q2JsMB4Cp7nkVNT
         Ux2M5O/E9Vtkv4PKGueG9ceMC4wBS3J0fwTdsPGekFCmFLuGptEJjdRbmrfo+0wgHTOz
         Tr1VrjMrOS1wt7VvlI8VlgN4J5mUlftx8KMc31CDNjw2t+1HZ1oPphS9QVorGlfay5m/
         3w0VC9q3zoHb6r5AvbhPSaGOkP2KMNbrq20gQaNxryrA/VuMIHorR75OEPYXER4cINc8
         UtuEKWqb4SYh3LlR/7ub6QMVMsQQjDGgJZZs5CqN+5l61bpFOolQLBOWjLZwTVX9hruB
         AhqQ==
X-Gm-Message-State: APjAAAVQa06DB4Ythn2oL+nfT42n/MDGAreG7+94gPtydPR/Zom+Iov3
        32yz91yVuC/d3DNffWF6QJJAaA==
X-Google-Smtp-Source: APXvYqwajD2TTecx4ms6AM1drd9sxvgjZCluWJNXUF7O3uWxQbNNjxm5g8X9VWrwLnlQO5nl61GnOw==
X-Received: by 2002:aa7:82d6:: with SMTP id f22mr83534583pfn.151.1560278695132;
        Tue, 11 Jun 2019 11:44:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v5sm14778297pfm.22.2019.06.11.11.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 11:44:54 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:44:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <201906111144.3E05EAA80@keescook>
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

What is the user-visible feedback when, say, debugfs_create_file()
fails? And what happens when debugfs_create_file() passes in a NULL
root?

-Kees

> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
