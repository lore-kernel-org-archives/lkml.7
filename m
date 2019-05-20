Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE26C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8247320675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XhAgVCfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfETJTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:19:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47072 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfETJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:19:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so9416739oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26qzizuvow48Xzf0mvcO4dXWRF3h0YYiGVUKw+vGork=;
        b=XhAgVCfpg+LZqqWAlefw8B8o6jjpLKy77SAcw6yz9yOGQoo6GMWeQXdEEuC6mdzOpL
         JzhAeLd9MeT3gv7/FzSuX3V+WAgIt9F4AP4WlebIP2ILHibj5k0J+t7YNwSdmo3vDK1X
         2bytoUhFRNUaRJVhvusj7XOgXC5DsVMB0h2tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26qzizuvow48Xzf0mvcO4dXWRF3h0YYiGVUKw+vGork=;
        b=RA+ICm4WAxTOfLnXHKXLig8qajuVYzQauhgGoI2j6G3o+JSKl3OXQmzaAryKHJCl4O
         Ov7qzBCeAwAVz9OJTrrb8PMaC0jLW6FTdDfWbaAcma5OvhO71s1p2IxUzOim59FnYvr5
         Ec4XjpJkjc2hUXMWYmtTGQ7QCs2My1XqaLEkJ+eXbLfDh9fipOMUH7Vpj6bCdFbIvvfW
         TC+4txuqD09LWGb5JuLJEMqXsdmblg2UexCObr/aUtXSJ2ohNkrLP1IhJblob02ATwSz
         6exYGFNHZe5uo6DQGQgGT/tOaWaIGtql6J720wT5mbxUHYTyJgRccPVXBs5suFlkWoSf
         n0AA==
X-Gm-Message-State: APjAAAX8fPMLVJxJCJOyBlC7dH9QpyUOiU3IzZGYEKyuTIS7K69RDDKi
        AWdrausPLWy0Z1ABo0txY80vgXEeQCYbyOBmDhe+zA==
X-Google-Smtp-Source: APXvYqx6gV2i8yLCBLSS6Xce0gF4sIDhYOXx+llnio3aigAWnajjawlUTjqRvm8jW3Gl3I5stpM0sAcuIS8Gcue8PJM=
X-Received: by 2002:aca:31cf:: with SMTP id x198mr2881468oix.132.1558343991215;
 Mon, 20 May 2019 02:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
 <20190520082216.26273-21-daniel.vetter@ffwll.ch> <CAMuHMdVuu062bkOb4sPv-m-WUF4L=K9Q5-hGPHTb8OhPbQdSEg@mail.gmail.com>
In-Reply-To: <CAMuHMdVuu062bkOb4sPv-m-WUF4L=K9Q5-hGPHTb8OhPbQdSEg@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 20 May 2019 11:19:39 +0200
Message-ID: <CAKMK7uE19LvpDLrZ7Kjk0yrZe1x1q5yyMuy5ScAWzf8u-RbNgA@mail.gmail.com>
Subject: Re: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:06 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Mon, May 20, 2019 at 10:22 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > This seems to be entirely defunct:
> >
> > - The FB_EVEN_SUSPEND/RESUME events are only sent out by
> >   fb_set_suspend. Which is supposed to be called by drivers in their
> >   suspend/resume hooks, and not itself call into drivers. Luckily
> >   sh_mob doesn't call fb_set_suspend, so this seems to do nothing
> >   useful.
> >
> > - The notify hook calls sh_mobile_fb_reconfig() which in turn can
> >   call into the fb notifier. Or attempt too, since that would
> >   deadlock.
> >
> > So looks like leftover hacks from when this was originally introduced
> > in
> >
> > commit 6011bdeaa6089d49c02de69f05980da7bad314ab
> > Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Date:   Wed Jul 21 10:13:21 2010 +0000
> >
> >     fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
> >
> > So let's just remove it.
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Display still works fine on Armadillo800-EVA, before and after system
> suspend/resume, so:
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'm impressed, I honestly think I do not fully understand what the
shmob driver is doing here, so thank you very much for giving this a
spin!

Cheers, Daniel

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
