Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1789C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A522F2176D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDanjmi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLGSsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:48:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38323 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:48:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id o8so4087985pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 10:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gIYTvT9Yg0a3HYHkSd1eqhNX0DVUa1na6x4qIySAj/s=;
        b=kDanjmi2KTqwcxU+vWAA6MY44bNeH/m6+LJ+PXBtyz8m0/IEd5Id3ctmrutsjQlWol
         nzRhS9ee3BeqtPgZQwsptPbKTwka3iyzO+GMbTS5U45YPei2BeQ4m1/Obijuy1h6PjDR
         Fs/96o+Lq/d1RGFXUVbM7TUzvcWvzYHi/YCHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gIYTvT9Yg0a3HYHkSd1eqhNX0DVUa1na6x4qIySAj/s=;
        b=LNJWl/LG1u5TMFsAZUZMW8ChHFPj7nlpYzLeGTYj8/ki9l2IaNJ7/oDB2wplZpHU4b
         qXQzb99+IZOsebe/dHyKA89FSotK1zwRgvT/xH1OXpVKBYAQnHuW5E22JqZgsTYcno/P
         XIORo2Oko4KeJO0gynBye9NtAMNZJLm2Szhx82DsryB+TdfPo2zVw0d533/H+Jl5WlF0
         rn8F8+XvTpdQWksFXCHyi0eAANPbD77/EryeDip0NnnVpkrbC0m5VeURCwyjVxjCoXuD
         /zFJwhRrB65wm5z4nidtf1Kdpms+NX1OE+74sSLApjeoB9oSi2/QaKNDtu986IZjdGDC
         zZ0g==
X-Gm-Message-State: APjAAAXElAixDuL40U9IlV27Isr/2PukMyw4PI37aaaPWszF5ONCa/Ai
        746pRbR224kk6UbwnyKvl8LgXyTqvfA=
X-Google-Smtp-Source: APXvYqx3yu/c68zUTI1LPwAt2andskVpfvUBqNZ+i7uTa0sh9iba5RR78nUbCHT0uaN7c89V1ukSBw==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr23575494pjz.116.1575744481553;
        Sat, 07 Dec 2019 10:48:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm18140868pfi.13.2019.12.07.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:48:00 -0800 (PST)
Date:   Sat, 7 Dec 2019 10:47:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj38.park@gmail.com,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 2/2] kselftest: Support old perl versions
Message-ID: <201912071047.D7BDF3DD9F@keescook>
References: <20191202114221.827-1-sjpark@amazon.com>
 <20191202114221.827-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202114221.827-2-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 12:42:21PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> On an old perl such as v5.10.1, `kselftest/prefix.pl` gives below error
> message:
> 
>     Can't locate object method "autoflush" via package "IO::Handle" at kselftest/prefix.pl line 10.
> 
> This commit fixes the error by explicitly specifying the use of the
> `IO::Handle` package.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Good catch!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/kselftest/prefix.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
> index ec7e48118183..31f7c2a0a8bd 100755
> --- a/tools/testing/selftests/kselftest/prefix.pl
> +++ b/tools/testing/selftests/kselftest/prefix.pl
> @@ -3,6 +3,7 @@
>  # Prefix all lines with "# ", unbuffered. Command being piped in may need
>  # to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
>  use strict;
> +use IO::Handle;
>  
>  binmode STDIN;
>  binmode STDOUT;
> -- 
> 2.17.1
> 

-- 
Kees Cook
