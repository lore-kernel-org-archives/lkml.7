Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31147C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AFA21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbfJAObw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:31:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35320 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbfJAObu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:31:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so14613253oig.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7cxKPjo/PvG1UNiRWmiEKE/lxVRyaTuSLEWIdqzaCU=;
        b=a5R2ssbEV4g3gQuY2f6196U7qki48f/8kaxYHwiegvGKIwepf0get9hKHfXDzOyrPt
         HC+atojCUe8rsdfndU7FT/RT2x7wBZzhqG4zwJr4aD4Tua/HT+ZSJo/WUXw+QgtgfacG
         cESPlZvWo/3Svbo68xx5JPMEztjeownXgY3F/SDjq5e4ceHp0zLM50tMlxE64to/SF7c
         5HPJVoc0IqCFlGAmDBwwiWRkMzpivVJETe6n3qKl0UFTM1GZXAHqPvD8T8Y2YSFjpH8v
         pbLkLpQEL2H+L6OWPRX9u4lOmoP5n+i3ggnnKtVioeH8QChFkfWrBI57sJJFp9etOPvK
         fmSw==
X-Gm-Message-State: APjAAAXSZLjyWLGGJR8Lb9HEpKG9k8ncYs4i5zYQmU0tXZ4y1NPOgffm
        6Gd9JhhN/0HEnsPFiJ0AJcE9ITJCaLYWPCovdhE=
X-Google-Smtp-Source: APXvYqwJTdQ3J23yqLD9IsxmZHAe9BY6F/AoiAtNW1vaU3DJz+mxyoEhrOEAhR9EmxA3Gw72+RrX2A1t40L2sMjC9Kw=
X-Received: by 2002:aca:3908:: with SMTP id g8mr4044723oia.54.1569940309623;
 Tue, 01 Oct 2019 07:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190906154706.2449696-1-arnd@arndb.de>
In-Reply-To: <20190906154706.2449696-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Oct 2019 16:31:37 +0200
Message-ID: <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: don't export unused return_address()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Without the frame pointer enabled, return_address() is an inline
> function and does not need to be exported, as shown by this warning:
>
> WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
>
> Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/kernel/return_address.c
> +++ b/arch/arm/kernel/return_address.c
> @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
>                 return NULL;
>  }
>

Checkpatch doesn't like the empty line above:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable

> +EXPORT_SYMBOL_GPL(return_address);
> +
>  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
>
> -EXPORT_SYMBOL_GPL(return_address);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
