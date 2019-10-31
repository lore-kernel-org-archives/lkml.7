Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA61CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434B208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dkwyQgWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJaP6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:58:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35462 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfJaP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:58:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6so2884642pln.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tNvlzAm3gfpJfZsRGUo9jJZ/vY/4iXl5KVOhYMqSiL0=;
        b=dkwyQgWV/YhS6kyje6q4s/b7juq3J2jbBtklAjsIJF8xpCtIhACAVjICh3nArZupNR
         7SGswhXPc7KcrLJ60dwVJ2JEcnJbjD5damVVMIyz6tzZYf4aP/rQokvvwcoWBk6ZN72/
         cOewys1t51tDbgZBC4unrdSrlxQuEwcjHdyeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNvlzAm3gfpJfZsRGUo9jJZ/vY/4iXl5KVOhYMqSiL0=;
        b=fXpws2lb965QKeArhIrRgBkurcCafjy+avuAboM5cfOBuF9Z2rczXoxv7BwPQZtpiG
         sTkLFbuH09h03Jlc8DDzNzGdQwSlqMXnQL0T91XP6qp9qzKC6MQiNQZdlN+otuQpGADb
         9CklcTNeaST52yXR8hk6Nwgm+V9EKYe4w9ieoEEST2OS3VhAcPtUxGKq9EpY4pz+lyIH
         vEhDw0fQ2ViOz3b//oulHKfNXs9Qf9hy+0ciGjlJggxg7sckDJE1lUypSAl6vXh3rNyy
         5b3oLSuQLLd08Awhvq72lKIJs0K2A0rqBX+zckZbMBtIN/XGlSZZkRa4D2jzW1zpSqIb
         KUcA==
X-Gm-Message-State: APjAAAWJ7IE6eKjH9G0MjoGSQMyX7iavVUQTY0PvEjOwh+slDB7TpC6m
        mZeUno+oQ1vWUdOFV/quVqrnSw==
X-Google-Smtp-Source: APXvYqxGOzaYTE5AAvD6fBlWwRERuAOtTWtWv6RCE4Jpy4HzOWL7KpK8I23QTwvN/f/gDZ6u5Ie6+g==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr7504691plt.30.1572537515013;
        Thu, 31 Oct 2019 08:58:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j22sm3469799pff.42.2019.10.31.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 08:58:34 -0700 (PDT)
Date:   Thu, 31 Oct 2019 08:58:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org,
        Jun Takahashi <takahashi.jun_s@aa.socionext.com>
Subject: Re: [BUGFIX PATCH] selftests: breakpoints: Fix a typo of function
 name
Message-ID: <201910310857.81DFF3A6@keescook>
References: <157252457993.20908.6741530756091861014.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157252457993.20908.6741530756091861014.stgit@devnote2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:23:00PM +0900, Masami Hiramatsu wrote:
> Since commit 5821ba969511 ("selftests: Add test plan API to kselftest.h
> and adjust callers") accidentally introduced 'a' typo in the front of
> run_test() function, breakpoint_test_arm64.c became not able to be
> compiled.
> 
> Remove the 'a' from arun_test().
> 
> Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
> Reported-by: Jun Takahashi <takahashi.jun_s@aa.socionext.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>

Argh, apologies! Yes, thank you for catching this.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../selftests/breakpoints/breakpoint_test_arm64.c  |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index 58ed5eeab709..ad41ea69001b 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
>  	return false;
>  }
>  
> -static bool arun_test(int wr_size, int wp_size, int wr, int wp)
> +static bool run_test(int wr_size, int wp_size, int wr, int wp)
>  {
>  	int status;
>  	siginfo_t siginfo;
> 

-- 
Kees Cook
