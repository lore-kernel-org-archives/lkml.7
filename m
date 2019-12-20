Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C9CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2A02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G64k8noT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLTSJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:09:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38423 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLTSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:09:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so5628449pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NoYeCvzhEf2ThmFbvrz2tyjWvGOYahfq+FFDczVt3k=;
        b=G64k8noTQfo52NnZSStBp4byZlOS2XeDgJ4imbftROkrulALEygiIYb1pRSKCdbG1S
         8d0B7yLoYnzw/lHrZkSdQgbnutH+wIICxJliskMoYCqQJ0SZV6y7fW2FC9aY3vsXu8IH
         x0fBdXM7i8UDYPF1e+OYcSNx7D8v0wqQm3uHoOQ3swGp2LDEEZRsDK/xSJ/FSej6CDvr
         vewMxURaqh4vqbtLiC7rX/NZdaw8RaqsVUxY6T7+ll4e+fagxenkEwuCklykqXaIYCmC
         EI4m/qm6ESlDwz2EP+UT7a7d41VRkt4JiOQC8DQZcoKW7EPK67pJVWVUzoIQ7kGAHK6O
         Ok+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NoYeCvzhEf2ThmFbvrz2tyjWvGOYahfq+FFDczVt3k=;
        b=V0CEwCGBF5WEjrOPfNTblQEggyIa9cv68WP0gxdOAhHHX9f5tCWlZbJpeB3Nb29KH5
         jb8ossSBFbwmnzWyk2ZNxkJdJdItVwjI1mJP+/c/hx91uknntT7a1HcIc3Qq5qFZ+RlH
         UwblBZUTNOk9KhjGTCagPvNX2JHRmHLsWEkD2t3rsz4/RDEWG7gKfSPYPmEJh+qLqcYp
         ZvJ8NxdIqfl6/HPuDux05zn/4DYiHiKz7hoXZ2lCFWJoi0q6jfvRylxsBjrrinKeMa4U
         rM25hG+atJTd8wAEOPbOlTr/+PYPQEgqx7EggOL/jkJFyS9W0ogtGecoQvTLzUx+ULV3
         SQyA==
X-Gm-Message-State: APjAAAVrGoYlQKy/uKqDEUE4tthvFg1acoeizC7m/cPkDw6pziNeOz/Z
        T26mt4Qzj8Zos8HcMFjUYrNJI2WwT0pF77VxdnwzEQ==
X-Google-Smtp-Source: APXvYqyQqxrvt9MqS1V+wSCAIwQ8mrA8vpt+5ti4yyobuNNh3cA/iDEG6Da1zNuN4ot+7zz3CDCWpMjliCcjY9zAJf0=
X-Received: by 2002:a63:590e:: with SMTP id n14mr15983487pgb.10.1576865394047;
 Fri, 20 Dec 2019 10:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20191218030025.10064-1-natechancellor@gmail.com>
In-Reply-To: <20191218030025.10064-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Dec 2019 10:09:43 -0800
Message-ID: <CAKwvOdk0hz-Eu00yRwRT6MFDmxPWdgnuYZWxGxASicCq68NivQ@mail.gmail.com>
Subject: Re: [PATCH] fbmem: Adjust indentation in fb_prepare_logo and fb_blank
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 7:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/video/fbdev/core/fbmem.c:665:3: warning: misleading
> indentation; statement is not part of the previous 'else'
> [-Wmisleading-indentation]
>         if (fb_logo.depth > 4 && depth > 4) {
>         ^
> ../drivers/video/fbdev/core/fbmem.c:661:2: note: previous statement is
> here
>         else
>         ^
> ../drivers/video/fbdev/core/fbmem.c:1075:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         return ret;
>         ^
> ../drivers/video/fbdev/core/fbmem.c:1072:2: note: previous statement is
> here
>         if (!ret)
>         ^
> 2 warnings generated.
>
> This warning occurs because there are spaces before the tabs on these
> lines. Normalize the indentation in these functions so that it is
> consistent with the Linux kernel coding style and clang no longer warns.
>
> Fixes: 1692b37c99d5 ("fbdev: Fix logo if logo depth is less than framebuffer depth")
> Link: https://github.com/ClangBuiltLinux/linux/issues/825
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/video/fbdev/core/fbmem.c | 36 ++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0662b61fdb50..bf63cc0e6b65 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -662,20 +662,20 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
>                 fb_logo.depth = 1;
>
>
> -       if (fb_logo.depth > 4 && depth > 4) {
> -               switch (info->fix.visual) {
> -               case FB_VISUAL_TRUECOLOR:
> -                       fb_logo.needs_truepalette = 1;
> -                       break;
> -               case FB_VISUAL_DIRECTCOLOR:
> -                       fb_logo.needs_directpalette = 1;
> -                       fb_logo.needs_cmapreset = 1;
> -                       break;
> -               case FB_VISUAL_PSEUDOCOLOR:
> -                       fb_logo.needs_cmapreset = 1;
> -                       break;
> -               }
> -       }
> +       if (fb_logo.depth > 4 && depth > 4) {
> +               switch (info->fix.visual) {
> +               case FB_VISUAL_TRUECOLOR:
> +                       fb_logo.needs_truepalette = 1;
> +                       break;
> +               case FB_VISUAL_DIRECTCOLOR:
> +                       fb_logo.needs_directpalette = 1;
> +                       fb_logo.needs_cmapreset = 1;
> +                       break;
> +               case FB_VISUAL_PSEUDOCOLOR:
> +                       fb_logo.needs_cmapreset = 1;
> +                       break;
> +               }
> +       }
>
>         height = fb_logo.logo->height;
>         if (fb_center_logo)
> @@ -1060,19 +1060,19 @@ fb_blank(struct fb_info *info, int blank)
>         struct fb_event event;
>         int ret = -EINVAL;
>
> -       if (blank > FB_BLANK_POWERDOWN)
> -               blank = FB_BLANK_POWERDOWN;
> +       if (blank > FB_BLANK_POWERDOWN)
> +               blank = FB_BLANK_POWERDOWN;
>
>         event.info = info;
>         event.data = &blank;
>
>         if (info->fbops->fb_blank)
> -               ret = info->fbops->fb_blank(blank, info);
> +               ret = info->fbops->fb_blank(blank, info);
>
>         if (!ret)
>                 fb_notifier_call_chain(FB_EVENT_BLANK, &event);
>
> -       return ret;
> +       return ret;
>  }
>  EXPORT_SYMBOL(fb_blank);
>
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191218030025.10064-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
