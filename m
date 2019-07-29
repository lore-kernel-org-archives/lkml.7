Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDF9C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D760A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAPu5y1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfG2QhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:37:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbfG2QhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:37:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so28330520pfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ga/2Rkys4OBxKwHmDa/SO5A/WN+qG4IZH9LzNl034NY=;
        b=kAPu5y1+60CFh1JFFlnoQg73UgCHnpsTo+iLEEVCWtZwSzq3w0cQBTP1h1/03TAzuK
         4JXE+UoZR/qgpfzDhY5ZPT2X9mF8EBv+MBXoUOiVHeiGpuTMMTYsooH1YDqvjSJqW4wc
         mWM3ddIv9b9cnkjINoRwHjp3lNMiVZaTZDm6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ga/2Rkys4OBxKwHmDa/SO5A/WN+qG4IZH9LzNl034NY=;
        b=oK/yX2jzPIUytnJ8u0+OFetN4zH6wWK/YVtoSZ8AYrKbDCKXUT1p32T0SVxua+L2Xc
         V278lHrxZhOuXIiP4MLkJRBIx2ZJi6kwiAkycpT+W5SmC+bUDZAI8hatMDkNpq0WOHK8
         cNnd2q+PtKStjPR2a0TafQhZiKDPbDLeOGJ2i+//L3kY0A/Angp+OH31qeHIkIyTujQT
         y5nova87/JIiJd89IB0ht1CFBzQiL+fmYqIKbseEbsRE0gH/KN+eyZ8IgW2QY3DE6LmI
         79heM7pDPkKe9/mFdCPl0sbURp4xWRlecT443lMUN8ZD+/zNLTGrxxnN1fwjHZTzuMH6
         0fYQ==
X-Gm-Message-State: APjAAAVmOTJZKU7jvdWP019mFu7h8uL0QIm3iPlMr3C8JGkhW3kmVj0E
        BMCCSplR6DsJhMVWZUDS6pjxLMXJlb4=
X-Google-Smtp-Source: APXvYqyuX0Yp3tC+fV6lYhk93Oy6w8OfbTFSHTwrGb3WhPwYPa6zOVpIAuhc6drCsY3nbo7pgCxmSA==
X-Received: by 2002:aa7:9ab5:: with SMTP id x21mr37092909pfi.139.1564418219913;
        Mon, 29 Jul 2019 09:36:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h11sm62978340pfn.120.2019.07.29.09.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:36:59 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:36:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ARM: signal: Mark expected switch fall-through
Message-ID: <201907290936.C5887FA6A7@keescook>
References: <20190729001314.GA24747@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729001314.GA24747@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:13:14PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> arch/arm/kernel/signal.c: In function 'do_signal':
> arch/arm/kernel/signal.c:598:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     restart -= 2;
>     ~~~~~~~~^~~~
> arch/arm/kernel/signal.c:599:3: note: here
>    case -ERESTARTNOHAND:
>    ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/arm/kernel/signal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index 09f6fdd41974..ab2568996ddb 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -596,6 +596,7 @@ static int do_signal(struct pt_regs *regs, int syscall)
>  		switch (retval) {
>  		case -ERESTART_RESTARTBLOCK:
>  			restart -= 2;
> +			/* Fall through */
>  		case -ERESTARTNOHAND:
>  		case -ERESTARTSYS:
>  		case -ERESTARTNOINTR:
> -- 
> 2.22.0
> 

-- 
Kees Cook
