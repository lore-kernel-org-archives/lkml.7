Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAA820880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388637AbfHGXG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:06:58 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33146 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfHGXG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:06:58 -0400
Received: by mail-ua1-f67.google.com with SMTP id g11so8865136uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43Aq/YF2tIrtqKgn8oFkjtKlQy3xXtGroSwKLL+Qp8Y=;
        b=RSGVb23Bs6PTqhrjGx31obuC1fxUrcITEAp6DNnn2+bNNAGV3jZ91cxZmNzUG+hoQg
         K/ivdrqE4/BrYvW86PEgM4APFzswz7PZgoUQwKSf8SFSRHPhSRWrc1jUiqLAYTlUwpla
         l6FxHd99VZLC5Bq8CW3OmMZw0KWH70rUl0BlLn6GX9dPOlPvijSutxC6EdB7RmUfcxXX
         NLK1V6Nsg7ak3vhbQAwwMxte+PUIJUxOgVE9ZZ2OLckkabnbWTSoJi5f+/hLmtlRW7CA
         jyTfLzikcZ0ojj2pt37x+QJ7M2o6FItK5CQIaG88uV4q1Seax3+gBz2dU5agIaoikCOT
         5ang==
X-Gm-Message-State: APjAAAWMUVjUrtCcSw9uUeAylpALNtS1tHHw3mIb77MYV8pk+nPcw6Rw
        85EnByup5UWF0+qvioj8SIsgW7RsFA+lUE/vJ2Ap5A==
X-Google-Smtp-Source: APXvYqzl3orDNzE16cYGmE/BexM9QmyfXaTvVHHuwOpUJstgexY+yev1lKWaixib7dLSKn4WM7oScOY1S3ixUusR4VI=
X-Received: by 2002:ab0:7848:: with SMTP id y8mr7729807uaq.58.1565219217606;
 Wed, 07 Aug 2019 16:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213304.9255-1-lyude@redhat.com> <20190807213304.9255-2-lyude@redhat.com>
 <20190807215508.GK7444@phenom.ffwll.local>
In-Reply-To: <20190807215508.GK7444@phenom.ffwll.local>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 7 Aug 2019 19:06:46 -0400
Message-ID: <CAKb7UviCg7jeEyWqsHxygfPuqTg4ybFgTH8cRdx2O==tTEUD9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau/dispnv04: Grab/put runtime PM refs on
 DPMS on/off
To:     Lyude Paul <lyude@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 5:55 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Aug 07, 2019 at 05:33:00PM -0400, Lyude Paul wrote:
> > The code claims to grab a runtime PM ref when at least one CRTC is
> > active, but that's not actually the case as we grab a runtime PM ref
> > whenever a CRTC is enabled regardless of it's DPMS state. Meaning that
> > we can end up keeping the GPU awake when there are no screens enabled,
> > something we don't really want to do.
> >
> > Note that we fixed this same issue for nv50 a while ago in:
> >
> > commit e5d54f193572 ("drm/nouveau/drm/nouveau: Fix runtime PM leak in
> > nv50_disp_atomic_commit()")
> >
> > Since we're about to remove nouveau_drm->have_disp_power_ref in the next
> > commit, let's also simplify the RPM code here while we're at it: grab a
> > ref during a modeset, grab additional RPM refs for each CRTC enabled by
> > said modeset, and drop an RPM ref for each CRTC disabled by said
> > modeset. This allows us to keep the GPU awake whenever screens are
> > turned on, without needing to use nouveau_drm->have_disp_power_ref.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > index f22f01020625..08ad8e3b9cd2 100644
> > --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > @@ -183,6 +183,10 @@ nv_crtc_dpms(struct drm_crtc *crtc, int mode)
> >               return;
> >
> >       nv_crtc->last_dpms = mode;
> > +     if (mode == DRM_MODE_DPMS_ON)
> > +             pm_runtime_get_noresume(dev->dev);
> > +     else
> > +             pm_runtime_put_noidle(dev->dev);
>
> it's after we filter out duplicate operations, so that part looks good.
> But not all of nouveau's legacy helper crtc callbacks go throuh ->dpms I
> think: nv_crtc_disable doesn't, and crtc helpers use that in preference
> over ->dpms in some cases.
>
> I think the only way to actually hit that path is if you switch an active
> connector from an active CRTC to an inactive one. This implicitly disables
> the crtc (well, should, nv_crtc_disable doesn't seem to shut down hw), and
> I think would leak your runtime PM reference here. At least temporarily.
>
> No idea how to best fix that. Aside from "use atomic" :-)

Not sure if this is relevant to the discussion at hand, but I'd like
to point out that dispnv04 is for pre-nv50 things, which definitely
didn't support any kind of ACPI-based runtime suspend.

  -ilia
