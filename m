Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8ACC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6477C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/7TeWJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDHMkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:40:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42104 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfDHMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:40:41 -0400
Received: by mail-io1-f68.google.com with SMTP id c4so10838275ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUANg+8j54E0RIqDCLUw+JfX1e6NfXq0OWLeJPjqIuk=;
        b=L/7TeWJj4fqtSawPm3l3ECRPImHsl2JQ8VV9qQGEOHJejNoy9WClQmLReXFzY/9ZjU
         mlG09ybkl3E9+W9m7b+Q9R4BHmTkLFM+QyXlOar19R1uSKHw+n+fjsSO9PlO3WQUUCMD
         khIZCvWX4aad8rdHEnIEFxWJFHytBreoJ/afYNEE/kmI6+jCVY+Et/xKycAY3cnTdo1l
         N+vTl4Ow/mIZFdoI/4c8CJ3+IP/dU8cOPsUrDKP0vpVCY+/M5YWURZ6uByXIY5ejUsjQ
         3pfI9nrvgWxZT4JBnTc/1tCkBrAYSQOnBI/bWvXxYfWcIuDe4GDgsiBUktG7sCODuwJj
         6PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUANg+8j54E0RIqDCLUw+JfX1e6NfXq0OWLeJPjqIuk=;
        b=M6Wgl+ETijNTbk8Mp4GYhu3ae30mHzIV64pQKC8DdShrJEwuTCCnBIGE7P5/VDQB3T
         7wR365QRc0Uq5eDrST1B6+DMl9FAljGUUSkRhV6j15NzN1efahcyLk3BzlJPD0rfZZow
         +7LN8OXHy43HDZ3ZGaInN8G4dSQ6gXUR9lOM21NrE2WpdBU49i/rkltJtQwpmaBKlDoJ
         rOVPamhlkt94ClK37jYKr/056cMg5xEuJG2sqSMChgp6bAehhtX4k1nrXmnJi2boEvCQ
         4bBgIigeN9KEz+bGNEJXQHoEnYqmVfiJtSRO3F5tKLtEmqaw4vSTjpHAmUdS/5VAUaxg
         l1Rg==
X-Gm-Message-State: APjAAAXqCahqlTKlb0yp8VYXYV46obiiAjc3Kyeb936VJ5yA18bOVDys
        VvhyDTle1shfen4f/LAdt79ISfQFNsZ9KLLuGOQ=
X-Google-Smtp-Source: APXvYqziVzlyuojPzDXC5pPVI9hdolce9tYf1hQNo2iaqrNMMlen9bO19EqnnuHSEJCQDOVHkK9bJfulJvdUzKBXfRU=
X-Received: by 2002:a5e:8a07:: with SMTP id d7mr18458013iok.194.1554727241172;
 Mon, 08 Apr 2019 05:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
 <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com> <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
In-Reply-To: <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 20:40:30 +0800
Message-ID: <CAKGbVbtpNKxUDRM9nE05gBuS5jwO68wHh0Uq2NsdYX6pdFtxYw@mail.gmail.com>
Subject: Re: [Lima] [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a question first time I use command:
dim push-branch drm-misc-next

I see it updates both drm-misc-next and for-linux-next branch, is this
expected? What's the difference between drm-misc-next/drm-misc-next-fixes
and for-linux-next/for-linux-next-fixes?

Thanks,
Qiang

On Mon, Apr 8, 2019 at 8:26 PM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 8:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > On 08/04/2019 03:37, Qiang Yu wrote:
> > > Looks good for me, patch is:
> > > Reviewed-by: Qiang Yu <yuq825@gmail.com>
> >
> > Also:
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> >
> > >
> > > Should I apply this patch to drm-misc in this case? Or this patch will be
> > > submitted in other kernel tree and back merged to drm-misc?
> >
> > You can push it yourself on the drm-misc-next branch now.
> >
> > (Then you can reply to the original patch when you applied it)
>
> Thanks for the guidance. I'll push it soon.
>
> Regards,
> Qiang
>
> >
> > Neil
> >
> > >
> > > Regards,
> > > Qiang
> > >
> > > On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > >>
> > >> From: Randy Dunlap <rdunlap@infradead.org>
> > >>
> > >> Note that the lima mailing list is moderated.
> > >>
> > >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > >> Cc: Qiang Yu <yuq825@gmail.com>
> > >> Cc: dri-devel@lists.freedesktop.org
> > >> Cc: lima@lists.freedesktop.org
> > >> ---
> > >>  MAINTAINERS |    2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> --- mmotm-2019-0405-1828.orig/MAINTAINERS
> > >> +++ mmotm-2019-0405-1828/MAINTAINERS
> > >> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
> > >>  DRM DRIVERS FOR LIMA
> > >>  M:     Qiang Yu <yuq825@gmail.com>
> > >>  L:     dri-devel@lists.freedesktop.org
> > >> -L:     lima@lists.freedesktop.org
> > >> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
> > >>  S:     Maintained
> > >>  F:     drivers/gpu/drm/lima/
> > >>  F:     include/uapi/drm/lima_drm.h
> > >>
> > >>
> > > _______________________________________________
> > > lima mailing list
> > > lima@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/lima
> > >
> >
