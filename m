Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E14C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888B021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NuafK1iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfG2Vrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:47:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35619 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfG2Vry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:47:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so28704412pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XLND97VJqxRGNRPkPJlee12ZiV4Pa0PqINHbyj3L9qI=;
        b=NuafK1iUNbvpkdCGy+I/VAbbNtK2QFUpJvgqoxHuOj60i9aitSiIaF8+fL1/P1C1W4
         2wE/9eqPhOw84SOnnNxOpCQfAEpNvU7pedpJyQcUVMCcKh0rJ88m8vw5x9CfoUp2Bap4
         IoZOWqat+V4QcxdoMlrVnJelk+ocqFxjhMWeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XLND97VJqxRGNRPkPJlee12ZiV4Pa0PqINHbyj3L9qI=;
        b=pKxJU+xLakcpgU8EnIn6HqHSxCOSW15N0h8kaqcQGuWyUZs71XmuaNG60veXCrKQLi
         turccp5urRJL9YWdymQGR7BflHmBhdp7NkgtlLPgBX55fkfObxoFTGoBecOSyGAgTD8b
         8QMp+fPfh8FPA9DsIRsILBU3WPBPw4yPbKX5PzFmpYdqsexB52jjryJ4Im7sqnh9JhEh
         m+kdJPRy1MTKO2Bc+qnxr2wmNuB+DkfktSIg2uwWNPC7X3pCX2aBzxEqXZv8/CDtc7zp
         jIHfrK7u2HUdO6MgX9h/JDtHlrCYf6SEOOoEE7IcYhLh+14IrN9WKKTlgZy5ETw62Zm8
         83qQ==
X-Gm-Message-State: APjAAAWV4m8zxSyMAra+BqXviathMtK9aRt0haXOsBm/6+Rkr4wRhK6I
        pZLTpR63Uoy3EpdTOKpr5YdWIQ==
X-Google-Smtp-Source: APXvYqzEODFFburSUpBiyJGkJcA1avidySxsHUY0dCaesN0aG++Mx9veA1Ui7EDkYXiCFCp8x/h3xw==
X-Received: by 2002:a62:764d:: with SMTP id r74mr40203960pfc.110.1564436874284;
        Mon, 29 Jul 2019 14:47:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg3sm61476695pjb.9.2019.07.29.14.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 14:47:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:47:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: scx200_wdt: Mark expected switch fall-through
Message-ID: <201907291447.7A0E3EF23A@keescook>
References: <20190729200602.GA6854@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729200602.GA6854@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 03:06:02PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning (Building: i386):
> 
> drivers/watchdog/scx200_wdt.c: In function ‘scx200_wdt_ioctl’:
> drivers/watchdog/scx200_wdt.c:188:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    scx200_wdt_ping();
>    ^~~~~~~~~~~~~~~~~
> drivers/watchdog/scx200_wdt.c:189:2: note: here
>   case WDIOC_GETTIMEOUT:
>   ^~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/watchdog/scx200_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
> index efd7996694de..46268309ee9b 100644
> --- a/drivers/watchdog/scx200_wdt.c
> +++ b/drivers/watchdog/scx200_wdt.c
> @@ -186,6 +186,7 @@ static long scx200_wdt_ioctl(struct file *file, unsigned int cmd,
>  		margin = new_margin;
>  		scx200_wdt_update_margin();
>  		scx200_wdt_ping();
> +		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
>  		if (put_user(margin, p))
>  			return -EFAULT;
> -- 
> 2.22.0
> 

-- 
Kees Cook
