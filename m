Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8902C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F132238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGAaSCwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfGYRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:18:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34532 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGYRSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:18:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so23086260pfo.1;
        Thu, 25 Jul 2019 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJap+dnh5S9ROruerU1qhQPjtGzCUlM8yURyg5DcndQ=;
        b=HGAaSCwd118cJMLiOTflCU2hHAG1cdmLwVE36gRdKeM2iPQ+EDOaGCSvmGnPD5t+Fl
         FMxEYDi1bzvu2ne0PRqMsD7g4Ks/bhz/IfTdx7tJElpTq2v1Jsi7X/67r5B8biL4UuKO
         fLfeN+8nIYCscbeykDM6+yh1MLO8VZQV8AghqWjmf3RYz7cwVj0TEKlmK/+xXLpHYCIW
         WmuYygn4nlmL/wsWUIqBsCqGzQXarWuUTG26YQbkAbLX5AcFzSQ6Rhgd79LClUKlXjey
         kK2B88jBY830WQ7NlxBkfj1t66U4kcATbScZx2zcsTata2iEyFQ8Frj1BnOjjILw6go5
         noDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJap+dnh5S9ROruerU1qhQPjtGzCUlM8yURyg5DcndQ=;
        b=GYXuOFNqQfrmMo5jN/8IEidEbeqFJ80dxPsxdjSDzwzo3bnraJbzSvF5F87p8oFedF
         uGsWcIFGOcIGelTZy+K/+2WtWHo940bki5+OhMtgFIUaEyzkivmj9vH3xFK0GdBVczuH
         1m+EcGquodJJjmRnZHwGVXk3t63iMvLw6PnwlHtieLVlI5GtEYVSwHI+C3+AZrA831C+
         zU20XctlE90cetuaql8+F/gvUqD4v+Yh+woSUYtYFHD8ED20/e5o4vpS4s0NAQmcTNS8
         p1Z9cvqvSF2LowDSaHSUXBPAPaEYugAWIIoY6qMcbYsoQlwcXLhELIyEW0eVgbd+itNA
         8pIQ==
X-Gm-Message-State: APjAAAXstG56ablcYCcrgCA1jx7Y+6+mDUpLAVOgXyPsdSVdEoPyb8OD
        7STemz4rdopjTEF3jL9s4MXaEe32RIgB/AAjytpGStuP
X-Google-Smtp-Source: APXvYqzr0fWKCsmymejb+p3P9kguT5isHBN3phbe3xEYH22AnzhCPCqyhDIBy/zgmQ2ZjOaP9MKLwC/sYPUNJadHPSY=
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr94315604pjb.20.1564075088344;
 Thu, 25 Jul 2019 10:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <1563795379-7521-1-git-send-email-info@metux.net>
In-Reply-To: <1563795379-7521-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:17:57 +0300
Message-ID: <CAHp75Vch3KNCkwp69a_fBtMy3B3k=NEbAmPZE2cn5HSn577HOw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: use KEY_RESTART for front button
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 2:36 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> From: Enrico Weigelt <info@metux.net>
>
> The keycode KEY_RESTART is more appropriate for the front button,
> as most people use it for things like restart or factory reset.
>

Should it go as Fixes?

> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/platform/x86/pcengines-apuv2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index b0d3110..4138007c 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -93,7 +93,7 @@
>
>  static struct gpio_keys_button apu2_keys_buttons[] = {
>         {
> -               .code                   = KEY_SETUP,
> +               .code                   = KEY_RESTART,
>                 .active_low             = 1,
>                 .desc                   = "front button",
>                 .type                   = EV_KEY,
> --
> 1.9.1
>


-- 
With Best Regards,
Andy Shevchenko
