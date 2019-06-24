Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECBBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ACD20449
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JR+0Pofk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfFXP6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:58:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41016 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFXP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:58:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so7112706pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJnEi1YXeUUZLNDz6H66DhAhyTf27C4w0UFUWB0nSNo=;
        b=JR+0PofkIPb42rXZ0k4D1jhgYRpVXf4D1DZj7Vzg62hYuln3n7kOpSb+72F3aHg6GJ
         l31NjIe4IHGgEOmUuZdmpt1xSJNmKAu9H1dc4Th+TRnH9TcVeIH4rpDLYAR3nnJUanzS
         u8VfIxMgsz5WT8qUOcdlnua9ePr0qN5/TEYdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJnEi1YXeUUZLNDz6H66DhAhyTf27C4w0UFUWB0nSNo=;
        b=EDZEtdZEvFuemb+e+E3JutNC1URSF3bCghHM7KnvJ4rLh+sqQ1P5S4MQM3l4ghGZYb
         lxJJbsHalPZONZrU3b3rX6dD7bEhtxiCcf7yiaBpQZrITMnItXeoNDwco+w/KztUmfkI
         wBevYrBxrE/x+uT68AZaX1MQfFBk3MLG6mXrZS2yqaGF5Z2IPmQlAAmPOwLy/LNq4SRG
         IL06XqGLZkTOwK7ljOtcgZscjtyyo5DHEbIVpCooV0qqGoYgNRsxQvJ+SDpqfzD+uLYF
         11sxAGhhbfp8kAvXXVdmRV3bZ+n7XANyAdCTvPgubT8DAhWZqJNQm0PXSHRO43vroJYf
         GN8w==
X-Gm-Message-State: APjAAAWBT7mjF/FU6ngwMy1Dvy9WRQmX4+ktN2n6DpzHjJB/WrkB7zg7
        p8nKtpECIA+rfGjb2iTiIPdtKQ==
X-Google-Smtp-Source: APXvYqyrlPNh2D7rvrEuRlTDMSipBjo8BKKPyMY23jseHGJ/KfMrjragNNhq/D8Fgg4PJS9Ar17qjg==
X-Received: by 2002:a17:902:4e25:: with SMTP id f34mr7421058ple.305.1561391883819;
        Mon, 24 Jun 2019 08:58:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w132sm12678681pfd.78.2019.06.24.08.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 08:58:03 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:58:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Drew Davenport <ddavenport@chromium.org>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bug: Fix "cut here" for WARN_ON for __WARN_TAINT
 architectures
Message-ID: <201906240856.0A82D562C@keescook>
References: <20190624154831.163888-1-ddavenport@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624154831.163888-1-ddavenport@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:48:31AM -0600, Drew Davenport wrote:
> For architectures using __WARN_TAINT, the WARN_ON macro did not
> print out the "cut here" string. The other WARN_XXX macros would
> print "cut here" inside __warn_printk, which is not called for
> WARN_ON since it doesn't have a message to print.
> 
> Fixes: a7bed27af194 ("bug: fix "cut here" location for __WARN_TAINT architectures")
> Cc: stable@vger.kernel.org
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>

Whoops, yes; thanks for catching this!

Acked-and-Tested-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/asm-generic/bug.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index c21ff2712803..79feb1a3081b 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -94,8 +94,10 @@ extern void warn_slowpath_null(const char *file, const int line);
>  	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
>  #else
>  extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
> -#define __WARN()		__WARN_TAINT(TAINT_WARN)
> -#define __WARN_printf(arg...)	do { __warn_printk(arg); __WARN(); } while (0)
> +#define __WARN() do { \
> +	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
> +} while (0)
> +#define __WARN_printf(arg...)	__WARN_printf_taint(TAINT_WARN, arg)
>  #define __WARN_printf_taint(taint, arg...)				\
>  	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
>  #endif
> -- 
> 2.20.1
> 

-- 
Kees Cook
