Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A687DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DB72147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqk/oe+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDHNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:19:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35095 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:19:29 -0400
Received: by mail-it1-f196.google.com with SMTP id w15so20890026itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q59Z/HXo+KS0BoALFM5gu0DWchqCS112R+ex2Vjmfcs=;
        b=Pqk/oe+lSy8kBIXfVarUwTmD2Vo/YxDl5w8LnKR2G56RGvFaGMpT1S7GyxFOCIrXvt
         ZQt+TYh3Hh19mu2ztUz1kcKhA0ONWYEu2bIU06G/Op12U+zUJ5ckkVTlowyB6FliQPgu
         IpWsoxFhtjE8YWgJ2RHtTNbsk2yb1551+bR3L4GOagThHVhDkjvA8jab6uP9nT0DlXes
         4NG76mJXKKnlm0+uMTAEughQRFGbHA6wbMrPkhxnznN3yO2mcfibyAbKXS/ynphVRTH0
         tL3NWeymIvRf23bzsJe30AZ9psj4JdsqJrmHlj+Ly5HXCTZ7EA0MioMKaYMNBFG6xxSo
         TUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q59Z/HXo+KS0BoALFM5gu0DWchqCS112R+ex2Vjmfcs=;
        b=or1uFdiCd5M3Swbu4RxiARPPPXWsUqwWFKDXecKjoBXFW64j35eqj6dxA3XFWF7XpV
         4uy1lVuEPvqJ//UJRgKxEzswcQ3saSwLEKLPNelSk+PtP78unB06Xzsz5JaGPacVTB5U
         n+IktJ7mnTVrNNsaBFgjG//v/fiW8FPKg85nc5/ywzgBgBEQ4JTlcruv4DEvQnNkD+C+
         ig57uinQHkT10mHGp73pW55S24szMLnqnSTyN2k1Vpfne41SW5GAy/8i1jEj0On3dGqK
         VaG46UCqZQKaJcZtrKOGv/2EgEi3vZn4K+hS9jIYuzRrfL1XZhkAP2WI3gie5acFprNp
         MDYw==
X-Gm-Message-State: APjAAAUCRo7l27MzjtYW5qDWJUBNHXTjUtH5fGoJ1pEH5XPB7OoCMFLA
        atoZe8Nk7OgYTOB1EpICpYrU4//YGb/D1YFItTM=
X-Google-Smtp-Source: APXvYqzyFBD7Wa3NYiu8c8j74waBeCYWIsMy4/6AZgg3haDpwVWNJkNOfeydrTqnEjjFbD5jOxIvBbJpe/Hb7YPIH8U=
X-Received: by 2002:a24:78c8:: with SMTP id p191mr17636187itc.58.1554729569078;
 Mon, 08 Apr 2019 06:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
 <054b9d43-cf4e-057d-132d-7c1758956595@baylibre.com> <CAKGbVbtok8RUzDqw=WShAHoiLqWLaKA8coKhcW5EPrsHCO89pA@mail.gmail.com>
 <CAKGbVbtpNKxUDRM9nE05gBuS5jwO68wHh0Uq2NsdYX6pdFtxYw@mail.gmail.com>
In-Reply-To: <CAKGbVbtpNKxUDRM9nE05gBuS5jwO68wHh0Uq2NsdYX6pdFtxYw@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 8 Apr 2019 21:19:17 +0800
Message-ID: <CAKGbVbuT84tS=H9BeOC7OQ8usopqcYjBy5hoMDTzJbCy7KJStw@mail.gmail.com>
Subject: Re: [Lima] [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I'm really sorry if I did something wrong to use:
dim push-branch drm-misc-next
(Should the committer just use "git push" not the "dim push-branch
drm-misc-next"?)

Because I found the drm-tip repo has been updated also with
a few commits that I can't find similar ones in the history.

Could any maintainer help with this?

Thanks,
Qiang

On Mon, Apr 8, 2019 at 8:40 PM Qiang Yu <yuq825@gmail.com> wrote:
>
> Here's a question first time I use command:
> dim push-branch drm-misc-next
>
> I see it updates both drm-misc-next and for-linux-next branch, is this
> expected? What's the difference between drm-misc-next/drm-misc-next-fixes
> and for-linux-next/for-linux-next-fixes?
>
> Thanks,
> Qiang
>
> On Mon, Apr 8, 2019 at 8:26 PM Qiang Yu <yuq825@gmail.com> wrote:
> >
> > On Mon, Apr 8, 2019 at 8:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >
> > > On 08/04/2019 03:37, Qiang Yu wrote:
> > > > Looks good for me, patch is:
> > > > Reviewed-by: Qiang Yu <yuq825@gmail.com>
> > >
> > > Also:
> > > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> > >
> > > >
> > > > Should I apply this patch to drm-misc in this case? Or this patch will be
> > > > submitted in other kernel tree and back merged to drm-misc?
> > >
> > > You can push it yourself on the drm-misc-next branch now.
> > >
> > > (Then you can reply to the original patch when you applied it)
> >
> > Thanks for the guidance. I'll push it soon.
> >
> > Regards,
> > Qiang
> >
> > >
> > > Neil
> > >
> > > >
> > > > Regards,
> > > > Qiang
> > > >
> > > > On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > >>
> > > >> From: Randy Dunlap <rdunlap@infradead.org>
> > > >>
> > > >> Note that the lima mailing list is moderated.
> > > >>
> > > >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > >> Cc: Qiang Yu <yuq825@gmail.com>
> > > >> Cc: dri-devel@lists.freedesktop.org
> > > >> Cc: lima@lists.freedesktop.org
> > > >> ---
> > > >>  MAINTAINERS |    2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> --- mmotm-2019-0405-1828.orig/MAINTAINERS
> > > >> +++ mmotm-2019-0405-1828/MAINTAINERS
> > > >> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
> > > >>  DRM DRIVERS FOR LIMA
> > > >>  M:     Qiang Yu <yuq825@gmail.com>
> > > >>  L:     dri-devel@lists.freedesktop.org
> > > >> -L:     lima@lists.freedesktop.org
> > > >> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
> > > >>  S:     Maintained
> > > >>  F:     drivers/gpu/drm/lima/
> > > >>  F:     include/uapi/drm/lima_drm.h
> > > >>
> > > >>
> > > > _______________________________________________
> > > > lima mailing list
> > > > lima@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/lima
> > > >
> > >
