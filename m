Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507ABC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA62077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfLLHnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:43:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36604 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:43:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id i4so779705otr.3;
        Wed, 11 Dec 2019 23:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYxRd099Dsy2rLtiJAv53Vqdx+5cG7B/L3QNd2QLeR0=;
        b=K0LUpbTMxLHdjQH8m1CqETdhPUEgaQh4dR1LxZIoiCVgmgBu63wlPdz25YQKzK8uHv
         n4rV5xUnB70mSRwNB55b32j9XYebxdLxzr5cu7GC/uNPR/gK7VIg9TfRq65nf4ObXP5C
         mf8N5sYq560dhfk9HkGrRKluiZ7SFP+xqDuIdRjNvwmMPkt5qCcYcTAgU9P0xLW3JFJ5
         QZ19AqqFipvzg2AAzU8LFQEW+d2BmeGKlu1tmrdO4pZcHutoFdYDsQfxpMiq2IUAWv5Z
         +c9K/yQ+ABZmjqZrV3sN2rUiTi+62vpLLGTL4QG0GtearIgjDy2kl2ixl1Sc7n4nPTkY
         F/uA==
X-Gm-Message-State: APjAAAUSIb7zbwwJatT0hm0P+Ln+s9P0W+HlqalE9rb2QpVJoFqdLvgu
        12eagjmIptD017xo1rU4h2PYTuEalcjljYr9HkadaoB2
X-Google-Smtp-Source: APXvYqz0/aRJNePZTaN28GC3gs1ZKqIb3EyouE4dO1Hm13o7WMzPw3pQ47FF46YBikLzRsnDBY4VG8mhj6ccBAu1rqQ=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr6612378ota.145.1576136595771;
 Wed, 11 Dec 2019 23:43:15 -0800 (PST)
MIME-Version: 1.0
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Dec 2019 08:43:04 +0100
Message-ID: <CAMuHMdWb_ipn7FVHbz8=PTdGod=MW+2xHY7yuq3yJcWwNnDvcg@mail.gmail.com>
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Thu, Dec 12, 2019 at 3:38 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
>
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>                 : "0" (loops)
>                 : "t");
>  }
> +EXPORT_SYMBOL(__delay);
>
>  inline void __const_udelay(unsigned long xloops)
>  {

I believe the correct fix is make drivers/net/phy/mdio-cavium.c use one
of [nmu]delay() instead.

Cfr.
https://lore.kernel.org/lkml/CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=pt0Yy=HOeRiL25Q@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
