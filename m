Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A120656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfETJGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:06:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35863 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfETJGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:06:09 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so8463634vsp.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtXp1qUqcm3uZCNPXqEQ7xEuqH7F3Cd1oa/vGsVVX9M=;
        b=JzrKXmsSHYT/3Pbueww8hYrwL5xey0MdOwd+dzLtpQN4UP563o9EnECbmxpPRc02n7
         cQJKwpUJagV1SB20mRFqtumcFj0iC/nt22sXNavnBcO4tdW0tLHriYsnwBdcKfwWx/up
         iBg4DorCWjM9Vn+0l8PC53ZESijN6UJRkPMOTyUepyqVxU2txx+PaJo6C8M6v7oWpDYO
         eFiTdLVbjxHeuEkceoLmKL7k9ZsbjYuzBEtR6JzYFsq/wv/85K/3H2yfnbcwY54QgpXl
         kjwvOYpdgy/SyHACt9zJstXOm29LWI2fBSBpuxiskjMfGQ3c5VuuXaqdXsTEx4X3BGRC
         YanA==
X-Gm-Message-State: APjAAAVEOdyrY5oB/Fqgcg9u0J2SOa+Sw4XJIqfs09J9iy29JrRzJLw9
        ZiBkzq+3zwKJaP5PuJjyeyfyCCpyv5nIUZauPvg=
X-Google-Smtp-Source: APXvYqyUShVi/8PDt7r6nhmGOzPit4HgmJvzxn18tzzLapn32MIxpElZyBHIwWigYtyEy7flMfCjer/20VatpkU6+Bk=
X-Received: by 2002:a67:f303:: with SMTP id p3mr23011462vsf.166.1558343169054;
 Mon, 20 May 2019 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch> <20190520082216.26273-21-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-21-daniel.vetter@ffwll.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 May 2019 11:05:57 +0200
Message-ID: <CAMuHMdVuu062bkOb4sPv-m-WUF4L=K9Q5-hGPHTb8OhPbQdSEg@mail.gmail.com>
Subject: Re: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
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

On Mon, May 20, 2019 at 10:22 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> This seems to be entirely defunct:
>
> - The FB_EVEN_SUSPEND/RESUME events are only sent out by
>   fb_set_suspend. Which is supposed to be called by drivers in their
>   suspend/resume hooks, and not itself call into drivers. Luckily
>   sh_mob doesn't call fb_set_suspend, so this seems to do nothing
>   useful.
>
> - The notify hook calls sh_mobile_fb_reconfig() which in turn can
>   call into the fb notifier. Or attempt too, since that would
>   deadlock.
>
> So looks like leftover hacks from when this was originally introduced
> in
>
> commit 6011bdeaa6089d49c02de69f05980da7bad314ab
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date:   Wed Jul 21 10:13:21 2010 +0000
>
>     fbdev: sh-mobile: HDMI support for SH-Mobile SoCs
>
> So let's just remove it.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Display still works fine on Armadillo800-EVA, before and after system
suspend/resume, so:

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
