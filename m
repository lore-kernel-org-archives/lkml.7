Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA5C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D152184E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfHGXJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:09:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42270 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfHGXJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:09:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so1602301qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=UET7SY8fA8PxxfxiGjhHIWC769osh0HwkIUA8kcq50A=;
        b=fZg43sYUUc9YWVSpf1REeIlVU0dNJrpIOsBTHTAGW3LePtdisOcmBCgaM5hJHpL4Jp
         I92ssLwIQBhijjvDQH/Tnn0z8izsMHCYesDmqTZ4TistoX4Vr2XOEW3bpCZkj6o0NrGo
         zfTt3ngoqhlWLOAS09hSDjQA8Ph445QgpBsWVJRFaNhOPHHlkve6ZWonf9Q39b7LW4WE
         cByVjVjLzx5vAhuIXwbTRlu+UHlRGJ9VgELWy4jceEGx2Uinr5HXhE2TAOZEwUwR1ChL
         VzlLzbvlfQiVpJ8ZJQlMkfEDagk6KhNbF5W8yijsxeP52Sfdb3LjmyxMkjujELO92da1
         e5tg==
X-Gm-Message-State: APjAAAXUWZWw7WQe5Q0KDHm2FiQGpGg4hNBYm6lN5aJdhawJojASWmRu
        hpwncAeZmffQHj4XcviBTszsJVtNy0U=
X-Google-Smtp-Source: APXvYqyPb2sxJrEPwD0S5bbm/JsGXpzEjIDHe5rBlBUk8ad3O/wvpazANeOwyUwov8yRaZ2XTtoH8A==
X-Received: by 2002:ac8:1750:: with SMTP id u16mr10024185qtk.90.1565219389278;
        Wed, 07 Aug 2019 16:09:49 -0700 (PDT)
Received: from whitewolf.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id z19sm41926894qkg.28.2019.08.07.16.09.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 16:09:48 -0700 (PDT)
Message-ID: <2a454d971a6c2bc3da730333aacaa420ecddefd6.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/dispnv04: Grab/put runtime PM refs on
 DPMS on/off
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Ilia Mirkin <imirkin@alum.mit.edu>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 07 Aug 2019 19:09:47 -0400
In-Reply-To: <CAKb7UviCg7jeEyWqsHxygfPuqTg4ybFgTH8cRdx2O==tTEUD9Q@mail.gmail.com>
References: <20190807213304.9255-1-lyude@redhat.com>
         <20190807213304.9255-2-lyude@redhat.com>
         <20190807215508.GK7444@phenom.ffwll.local>
         <CAKb7UviCg7jeEyWqsHxygfPuqTg4ybFgTH8cRdx2O==tTEUD9Q@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 19:06 -0400, Ilia Mirkin wrote:
> On Wed, Aug 7, 2019 at 5:55 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Aug 07, 2019 at 05:33:00PM -0400, Lyude Paul wrote:
> > > The code claims to grab a runtime PM ref when at least one CRTC is
> > > active, but that's not actually the case as we grab a runtime PM ref
> > > whenever a CRTC is enabled regardless of it's DPMS state. Meaning that
> > > we can end up keeping the GPU awake when there are no screens enabled,
> > > something we don't really want to do.
> > > 
> > > Note that we fixed this same issue for nv50 a while ago in:
> > > 
> > > commit e5d54f193572 ("drm/nouveau/drm/nouveau: Fix runtime PM leak in
> > > nv50_disp_atomic_commit()")
> > > 
> > > Since we're about to remove nouveau_drm->have_disp_power_ref in the next
> > > commit, let's also simplify the RPM code here while we're at it: grab a
> > > ref during a modeset, grab additional RPM refs for each CRTC enabled by
> > > said modeset, and drop an RPM ref for each CRTC disabled by said
> > > modeset. This allows us to keep the GPU awake whenever screens are
> > > turned on, without needing to use nouveau_drm->have_disp_power_ref.
> > > 
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 18 ++++--------------
> > >  1 file changed, 4 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > > b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > > index f22f01020625..08ad8e3b9cd2 100644
> > > --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > > +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> > > @@ -183,6 +183,10 @@ nv_crtc_dpms(struct drm_crtc *crtc, int mode)
> > >               return;
> > > 
> > >       nv_crtc->last_dpms = mode;
> > > +     if (mode == DRM_MODE_DPMS_ON)
> > > +             pm_runtime_get_noresume(dev->dev);
> > > +     else
> > > +             pm_runtime_put_noidle(dev->dev);
> > 
> > it's after we filter out duplicate operations, so that part looks good.
> > But not all of nouveau's legacy helper crtc callbacks go throuh ->dpms I
> > think: nv_crtc_disable doesn't, and crtc helpers use that in preference
> > over ->dpms in some cases.
> > 
> > I think the only way to actually hit that path is if you switch an active
> > connector from an active CRTC to an inactive one. This implicitly disables
> > the crtc (well, should, nv_crtc_disable doesn't seem to shut down hw), and
> > I think would leak your runtime PM reference here. At least temporarily.
> > 
> > No idea how to best fix that. Aside from "use atomic" :-)
> 
> Not sure if this is relevant to the discussion at hand, but I'd like
> to point out that dispnv04 is for pre-nv50 things, which definitely
> didn't support any kind of ACPI-based runtime suspend.

I thought it was really suspicious that such an old chipset had any kind of
runtime PM, but didn't question the code lol. I guess a more appropriate patch
would be to just remove runtime PM support entirely for pre-nv50. Will respin
soon and do this.

> 
>   -ilia

