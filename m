Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC54C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855F62073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UpyrP3YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfKZREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:04:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36145 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKZREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:04:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id p19so72362otc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0aRqjubVebGkfF0Se7BSThAXYeQQXVaR/wxZsEbt0q8=;
        b=UpyrP3YA6tguIzdLA7TVi9RB4XydlLBFFWdnNBuzbspnU1ZjNvXrgfsuXbY99Roizt
         lg7ffuqfaTVeRlmXWIPImxwH59yWclys3ymaIZUo+TPLThcHHCPmmPsGRVonwKq+akkr
         2QSNGsHYfVT0M3IT4B7mpvGAhowY2QbFgQye8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0aRqjubVebGkfF0Se7BSThAXYeQQXVaR/wxZsEbt0q8=;
        b=hLuWFiOr4ovTyb22/RgJQ+A3Dfk5qt28Z4Ela3mjgV6Lbjh81hBEOE2VhRfSXNTfzI
         dY2W+7oJ9fp5969omRWLEnRk0M7j83dn/mQ3oLjjj7aLhtvMAZ0uisAgKLqcLughlxdm
         OpRBW8hQt4upnetGfB43VE+1nu630C4AEn8n9LTmLjpEGAbh1kGZ0wFRdACUCKPr4zUx
         Tn+B/eosSu0vW7fIei51i9EjoyrbmLXOjpyMa7sZc2Y7rTcg00yJcKfwkHOV8HpfpGFo
         VuBhZqy9+9v0uOsWAQ7DfYmNMcNyqyCRPxMsN3GoJiNhlhsoFEOq8WtYVXMWE4MnWw+W
         dUWw==
X-Gm-Message-State: APjAAAVUbQsLWmu6d0/sKRavFw3lIkB56bjDIpopZsLKQNOhp48lq30e
        MKOISm13MQroH9j2/0mrg3NRTmh790UlV2sVd6OomDGn
X-Google-Smtp-Source: APXvYqxtz3LsMLPp3CWwV+HNab1glWV5rUdJ9ZIXotQRmAG1CFu2i2k6ws4D3fy3+3bB4CkNSsTgBuipWG5XuBEIOj8=
X-Received: by 2002:a9d:1b4b:: with SMTP id l69mr3042854otl.303.1574787875817;
 Tue, 26 Nov 2019 09:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-2-mihail.atanassov@arm.com> <20191126142610.GV29965@phenom.ffwll.local>
 <11447519.fzG14qnjOE@e123338-lin>
In-Reply-To: <11447519.fzG14qnjOE@e123338-lin>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 26 Nov 2019 18:04:24 +0100
Message-ID: <CAKMK7uG2T9hPCsQ6yLekGoz5qA2-ePa2_MmsmQRBH5je+7Kaow@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 4:55 PM Mihail Atanassov
<Mihail.Atanassov@arm.com> wrote:
>
> Hi Daniel,
>
> Thanks for the quick review.
>
> On Tuesday, 26 November 2019 14:26:10 GMT Daniel Vetter wrote:
> > On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> > > A simple convenience function to initialize the struct drm_bridge.
> > >
> > > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> >
> > The commit message here leaves figuring out why we need this to the
> > reader. Reading ahead the reasons seems to be to roll out bridge->dev
> > setting for everyone, so that we can set the device_link. Please explain
> > that in the commit message so the patch is properly motivated.
>
> Ack, but with one caveat: bridge->dev is the struct drm_device that is
> the bridge client, we need to add a bridge->device (patch 29 in this
> series) which is the struct device that will manage the bridge lifetime.

Ah yes, ->dev is for drm_bridge_attach.

> >
> > > ---
> > >  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
> > >  include/drm/drm_bridge.h     |  4 ++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > > index cba537c99e43..cbe680aa6eac 100644
> > > --- a/drivers/gpu/drm/drm_bridge.c
> > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
> > >  }
> > >  EXPORT_SYMBOL(drm_bridge_remove);
> > >
> > > +/**
> > > + * drm_bridge_init - initialise a drm_bridge structure
> > > + *
> > > + * @bridge: bridge control structure
> > > + * @funcs: control functions
> > > + * @dev: device
> > > + * @timings: timing specification for the bridge; optional (may be NULL)
> > > + * @driver_private: pointer to the bridge driver internal context (may be NULL)
> >
> > Please also sprinkle some links to this new function to relevant places,
> > I'd add at least:
> >
> > "Drivers should call drm_bridge_init() first." to the kerneldoc for
> > drm_bridge_add. drm_bridge_add should also mention drm_bridge_remove as
> > the undo function.
> >
> > And perhaps a longer paragraph to &struct drm_bridge:
> >
> > "Bridge drivers should call drm_bridge_init() to initialized a bridge
> > driver, and then register it with drm_bridge_add().
> >
> > "Users of bridges link a bridge driver into their overall display output
> > pipeline by calling drm_bridge_attach()."
>
> Will do.
>
> >
> > > + */
> > > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > > +                const struct drm_bridge_funcs *funcs,
> > > +                const struct drm_bridge_timings *timings,
> > > +                void *driver_private)
> > > +{
> > > +   WARN_ON(!funcs);
> > > +
> > > +   bridge->dev = NULL;
> >
> > Given that the goal here is to get bridge->dev set up, why not
> >
> >       WARN_ON(!dev);
> >       bridge->dev = dev;
>
> See above struct device vs struct drm_device. I add a
>
>         bridge->device = dev;
>
> in patch 29, which takes care of that. I skipped the warn since
> there's a dereference of dev, but I now realized it's behind CONFIG_OF,
> so I'll add it in for v2.

Ok, sounds good. Having the WARN_ON in patch 1 should also help making
sure all the conversion patches dtrt (and any future users).
-Daniel

> Yes, 'device' isn't the best of names, but I took Russell's patch
> almost as-is, I didn't have any better ideas for bikeshedding.
>
> >
> > That should help us to really move forward with all this.
> > -Daniel
> >
> > > +   bridge->encoder = NULL;
> > > +   bridge->next = NULL;
> > > +
> > > +#ifdef CONFIG_OF
> > > +   bridge->of_node = dev->of_node;
> > > +#endif
> > > +   bridge->timings = timings;
> > > +   bridge->funcs = funcs;
> > > +   bridge->driver_private = driver_private;
> > > +}
> > > +EXPORT_SYMBOL(drm_bridge_init);
> > > +
> > >  /**
> > >   * drm_bridge_attach - attach the bridge to an encoder's chain
> > >   *
> > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > index c0a2286a81e9..d6d9d5301551 100644
> > > --- a/include/drm/drm_bridge.h
> > > +++ b/include/drm/drm_bridge.h
> > > @@ -402,6 +402,10 @@ struct drm_bridge {
> > >
> > >  void drm_bridge_add(struct drm_bridge *bridge);
> > >  void drm_bridge_remove(struct drm_bridge *bridge);
> > > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > > +                const struct drm_bridge_funcs *funcs,
> > > +                const struct drm_bridge_timings *timings,
> > > +                void *driver_private);
> > >  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> > >  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> > >                   struct drm_bridge *previous);
> >
> >
>
>
> --
> Mihail
>
>
>


--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
