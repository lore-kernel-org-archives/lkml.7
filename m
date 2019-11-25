Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C11C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCE42075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="M19DJm/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKYSiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:38:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45601 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:38:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so13492187otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxgGGumSV6ntEjsFXJnHRo8WdLLecc5bvGCAk5fSEjg=;
        b=M19DJm/dSMz1pRxTz6zAucGexsWwQ8NbSZ5oGr+FncqGNKcqOJvBgxap87yrei3ii+
         4tQrS7wIeo4lfzB1288Zb8ngf7iGoAtBXqjrPSS94+y/WGTRvqCvhD35QJJRIyXsGKW5
         2QZ5NpbLbXTlVui4zZAgG7iU2R1qwvZe6HwOTsGt72UdHJNodirBcQOvApgIldPf4ec7
         xMpe4VkL4akEx0YKqU055YaHQ2fMOlYt5KLFns4y0czgvovk1TkgHTUBpmIwNfhcUbGD
         KoQwJV2z8Vn/Ode4lPAyrc7httk/U+kKoI7LN0bJYOKT8q0kT9jkrFTW3ZU9x7Dew1zE
         DpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxgGGumSV6ntEjsFXJnHRo8WdLLecc5bvGCAk5fSEjg=;
        b=USssZTK3wHTY3aOin2cUTJ3u3JmXyHunZWL5lavKge+j97U0+fU/nGw4rWGtY+8jiE
         3pGiW/Tky0BRGU62DRGIuPHFJJKgqAnmRZrRN3NBDRbAwnWmorjgiVxPSmMW6qqQspKA
         2VXhzRLxfsg930qESZMsu0rILpPt3muG2uRuX6OqAsScrsWapFd18CdhAsCRL4/HkqN3
         lzfsT7khRpHCqTeeRbVy7pwC3ZAV6DQLHyHVVLIKSplviwxP77wbQg5cQdhFTb1Ydi0Y
         i3mdMi5kcPl6c463zebDUuXqIKjmftVG14xZX5plFvKntlUugAYZMML2IWS6hILeUr2i
         ECew==
X-Gm-Message-State: APjAAAXkHMn+OyKiwoYI+tHgxpzPH4e3wRSzfTFdF7SeL40t4BFx7ONR
        KDCKAMYbV/a2fj14TBfXY2/gPfKOZ8d4RvBonWskAw==
X-Google-Smtp-Source: APXvYqzJQjIj5BrFseNPQ56ZcGhTiGK4/maa3eWH0UOgyuya9zqWzUCNqDybRJJk37wXiRHGUxJp/oGydVNec9GD2Kw=
X-Received: by 2002:a05:6830:1f29:: with SMTP id e9mr20394786oth.272.1574707103099;
 Mon, 25 Nov 2019 10:38:23 -0800 (PST)
MIME-Version: 1.0
References: <1574617733-18151-1-git-send-email-wahrenst@gmx.net> <9df5fcd121b4456f1e2bd3c512c44cfb71b6b17b.camel@suse.de>
In-Reply-To: <9df5fcd121b4456f1e2bd3c512c44cfb71b6b17b.camel@suse.de>
From:   Eric Anholt <eric@anholt.net>
Date:   Mon, 25 Nov 2019 10:38:36 -0800
Message-ID: <CADaigPXUyBy=JG_2vp1wsZh6vLx8bk_7YHg6Wb5mN+TPOJ0-Fw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Make Nicolas Saenz Julienne the new bcm2835 maintainer
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 2:28 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Sun, 2019-11-24 at 18:48 +0100, Stefan Wahren wrote:
> > Eric isn't active any more and i don't have the necessary free time.
> > Nicolas already made contributions to bcm2835 and is pleased to take
> > over the maintainership. My thanks go to both of them.
> >
> > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 512e527..4285190 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3224,8 +3224,7 @@ N:      kona
> >  F:   arch/arm/mach-bcm/
> >
> >  BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> > -M:   Eric Anholt <eric@anholt.net>
> > -M:   Stefan Wahren <wahrenst@gmx.net>
> > +M:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >  L:   bcm-kernel-feedback-list@broadcom.com
> >  L:   linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
> >  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>
> I'm glad to take over.
>
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks to Stefan for all the hard work, and to Nicolas for stepping up!
