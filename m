Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E335C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417FF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fsE7LC3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFZT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:59:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35091 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:59:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2014908plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJrm4UyKgvoevmBE4eZPkQ/+kkY70KZGEQ0Q2cnjCFc=;
        b=fsE7LC3omCGhexX9SxhYLu3osDjmI5IO1mcikyIyBAs6zALQQUP8jP37oWiKt5Z0UL
         9QFM5YXuvbppFfsfhQIrW7neyfgexnYYBO0IzrrU3APhRiyqKvLrFxLflkCmPoj0EApW
         yIMuMW8aARU2MWuFHH2/6QwZOvcCaxhWQlJgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJrm4UyKgvoevmBE4eZPkQ/+kkY70KZGEQ0Q2cnjCFc=;
        b=jNP3QnM2KF8j3xPnAZEbINK4HXS1tL8kxudeZmTWsRu6LtQU2pTPsy6fvIUJ3yXT7S
         OnlyutRfxcp8YjiIEDo5p9ls8pH0d4GTbt95VGilQyyG30sTlLrhLzHpdEwoHNbE8fDe
         Vqhh8csGni6t1f9vr7UlNrCmONWW3Rte8umXs1UT9fQ9ER9UFKKgQuP0aB+8hQJowIBv
         U17xpKUnU216SryZa5q7UpMrY8jOS7rZfJtHoO8IWASWdOczqYTEHEEj5St+AtgRuvYn
         S9U6t3bSXmztCHZBU9hr52jfLH7ics/IggnrHvzgeXbw7k10crJFxttRQNZw+aDirFCH
         CY7A==
X-Gm-Message-State: APjAAAVXl9yKmTmT6Yv5Y4glNw/xn2IqnL5vowl4TY7Gkb+F5Xw+HwyV
        nrBSBNlDQtMdT5Vx5md/burcaw==
X-Google-Smtp-Source: APXvYqzFMKnWTXmF+17dsuclaAZ/vYLU8FRyvzEYjwf+Z7iMzF+jmOZhMCafJuUIe4LUhngbX9tXtg==
X-Received: by 2002:a17:902:788e:: with SMTP id q14mr7551852pll.234.1561579190689;
        Wed, 26 Jun 2019 12:59:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm37148pfu.179.2019.06.26.12.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 12:59:49 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:59:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Emese Revfy <re.emese@gmail.com>
Subject: Re: [PATCH] docs: move gcc_plugins.txt to core-api and rename to .rst
Message-ID: <201906261259.34343CC@keescook>
References: <4937ff4f93282ed57c9859de4300b4d835880ebb.1561556794.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4937ff4f93282ed57c9859de4300b4d835880ebb.1561556794.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:47:46AM -0300, Mauro Carvalho Chehab wrote:
> 
> 
> The gcc_plugins.txt file is already a ReST file. Move it
> to the core-api book while renaming it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} | 0
>  Documentation/core-api/index.rst                            | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/{gcc-plugins.txt => core-api/gcc-plugins.rst} (100%)
> 
> diff --git a/Documentation/gcc-plugins.txt b/Documentation/core-api/gcc-plugins.rst
> similarity index 100%
> rename from Documentation/gcc-plugins.txt
> rename to Documentation/core-api/gcc-plugins.rst
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 2466a4c51031..d1e5b95bf86d 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -35,7 +35,7 @@ Core utilities
>     boot-time-mm
>     memory-hotplug
>     protection-keys
> -
> +   gcc-plugins
>  
>  Interfaces for kernel debugging
>  ===============================
> -- 
> 2.21.0
> 
> 

-- 
Kees Cook
