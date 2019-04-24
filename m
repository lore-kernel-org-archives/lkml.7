Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3A206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDGA4m+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfDXURF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:17:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44829 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDXURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:17:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id s10so11074339qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oW3C4eILX/D7yCsVDIg4l1MywdHMYp40Vcl2f9Ap1v4=;
        b=KDGA4m+uPoZjhiLYsUmBc2H8uOgr2APJ1aGl4CtY+vUrv2OKfsBSjQzTqr7+nDuKuv
         pVdmQQ2a+TFndViqYMHzFbHhv5iw1mcthHxomTxOUeFjrhEKBAEh2F/tRUY/CzfRI44W
         0XpJEowIGuWyjddXT/UWaU1EkdD+U/rU8+BY3wwuOs1anrtZWqvk6VyunhAXfhk6MO6x
         LUdPvoF73lslB7FzLN9cwKnFIhtgj/fovMcMvqraRoDHGjxi52xUYj7k0L726PihwoAi
         1w4wdZ4uRdCDVxrpYDw7C1FJ8isr6+8eArVluvLQ+26ZI0S85s7Qm7T12BUOCWR+uxBW
         Qr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oW3C4eILX/D7yCsVDIg4l1MywdHMYp40Vcl2f9Ap1v4=;
        b=Fkd1oolAb9tltcxL6FAdUDwOloSpTg8BrCMfG2HgGWxyoT6J1LyZoPD6uC22c5AGyM
         iYRqdFF+JeuLGvoEgRdDP45zH1w8ffHFv3srUqLQfTFwCK2xJRwCymICLnoho7Q4hwg4
         fYKJ+22M67/qbxuEG/iJ3L4bfXYBCRgbx8sbCeRw5rWcnIqlwc3UZZWgMYETWL+9snVv
         QEK4Eom32Na+7nVotFBcbkL04cvy7pB8Uf5+EgXNFnr42bMYGja40UZWS7g4/d29cE3k
         CzbaftdDL2oSQpS7e/Aj4FGgx1F6aM043tWPbEHkalbWhIJgCRLOeoBCzFJL8k9HUvrV
         VN6g==
X-Gm-Message-State: APjAAAUIqpQ+cbjQ4mO2gald/Q7VOXv1q69bJN/cqbMmOKJ6qA5mkUkX
        XKK0iTox0y8Ga4tbWRmGms47YQ0Pox4MFTl11Z0=
X-Google-Smtp-Source: APXvYqw+2EBAxx86xE1kdPxhigvekKbp/rGqQO8yoFWvM/wPs2DtoPDmyNg547QBH5jUBKhGxbXlzLzYJq/Ari18KIE=
X-Received: by 2002:ac8:2728:: with SMTP id g37mr3573549qtg.264.1556137023524;
 Wed, 24 Apr 2019 13:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190424185617.16865-1-eric@anholt.net> <20190424193548.GT9857@phenom.ffwll.local>
In-Reply-To: <20190424193548.GT9857@phenom.ffwll.local>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 25 Apr 2019 06:16:50 +1000
Message-ID: <CAPM=9tw59Z7FRM-7-_VChOO__1+ahNhSs6=AceV7biasHjWKqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/doc: Allow new UAPI to be used once it's in the
 driver's -next.
To:     Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 05:35, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Apr 24, 2019 at 11:56:16AM -0700, Eric Anholt wrote:
> > I was trying to figure out if it was permissible to merge the Mesa
> > side of V3D's CSD support yet while it's in drm-misc-next but not
> > drm-next, and developers on #dri-devel IRC had differing opinions of
> > what the requirement was.  Propose a clarification here to see if Dave
> > Airlie agrees.
> >
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> > ---
> >
> > Personally, I thought the rule was "has to be in drm-next", but
> > assuming our review processes aren't totally broken, this should be
> > enough.
>
> Yeah if you end up with a revert on your hands the process failed much
> harder and you get to keep the pieces no matter what. Not sure we should
> clarify whether you need a stable sha1 or not (helps with cross
> referencing uapi header updates), but imo good as is. And matches what
> I've been doing/recommending past few years.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> >
> >  Documentation/gpu/drm-uapi.rst | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> > index c9fd23efd957..8e5545dfbf82 100644
> > --- a/Documentation/gpu/drm-uapi.rst
> > +++ b/Documentation/gpu/drm-uapi.rst
> > @@ -92,8 +92,9 @@ leads to a few additional requirements:
> >    requirements by doing a quick fork.
> >
> >  - The kernel patch can only be merged after all the above requirements are met,
> > -  but it **must** be merged **before** the userspace patches land. uAPI always flows
> > -  from the kernel, doing things the other way round risks divergence of the uAPI
> > +  but it **must** be merged to the driver's -next tree (as documented in
> > +  MAINTAINERS) **before** the userspace patches land. uAPI always flows from
> > +  the kernel, doing things the other way round risks divergence of the uAPI
> >    definitions and header files.

I'd rather restrict this to drm-next and drm-misc-next, I frankly
don't trust driver trees here to have the review practices in place.

I trust drm-misc-next to have at least had someone unrelated look over
the new api.

Dave.
