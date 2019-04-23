Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2682C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96410218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QF6BbRgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfDWPJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:09:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51586 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:09:58 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so720289itk.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9neL1j0Rbt1ZUGEcCqqes9cirIMR5HjjKEnb4pzCv3s=;
        b=QF6BbRgLZSPX+I5JZUs8Nx+TMu525y8IB2pApGkNmcfEyZTe0FWZHbCIwCYnvRH1B7
         9xvALN/NU+ApRyNaXxAyiu5sn+373mWNYn9IKwhDcOuKQUuieiMSpcDQgkDuBd2pdQK3
         Hgu6wzO31Vl6IGsp0QfyUpOlkx6cBGBojo+0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9neL1j0Rbt1ZUGEcCqqes9cirIMR5HjjKEnb4pzCv3s=;
        b=kdDtN62Ugns6kMrSlTKAa5bHVmFHD5d5BGayxMyRWFfQ2Wk7XBpmzuaHcnQDZf3CC2
         b0ctUft9eZ+tKrMAYuiYuQ7ung0ef653c6uf2GScCNsS+u2R5M9FSzmGMweN1Ho396/4
         ofi6co+1j6S71XzxOYii//qU5zaTGXFmXOn2LOLeOSWbXNc9ijgRNK6PbZj6trux1P60
         UQjwrxGUadLllWOpnUraHyEkXjlQF+9p5DlPGcE7ayLRZrVlQ+hjBaka9n+p0cUo+9iE
         xU0XubYHZTwX06GC/pzNvwpT/XF0smTmqHu9WSzRAbf4Zno3JZxhSeMqkWn6luy81n2o
         mnNw==
X-Gm-Message-State: APjAAAVJMQVSVfpgTg3bXXqIkoXGDirvKrBz3kXweqI2I+IMsIS0WZqm
        fzC2V+ux4BDO6NzVji5SSDAswQmLc2ATF80nescZaA==
X-Google-Smtp-Source: APXvYqzcMvjr1dkbVYDyc1fdwyhYiTFQ50bgqYZQigTH9HrC3/qbODRPv5msxfvVuCSjlcTH7pNtn9iBRM+eeF4iltM=
X-Received: by 2002:a24:9197:: with SMTP id i145mr2432803ite.117.1556032196794;
 Tue, 23 Apr 2019 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local> <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea> <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
 <20190420224045.GY4964@pendragon.ideasonboard.com> <20190423073026.GX13337@phenom.ffwll.local>
 <f288e1d29277fcd79b251d99f84fb9b165364fac.camel@bootlin.com> <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
In-Reply-To: <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Apr 2019 17:09:44 +0200
Message-ID: <CAKMK7uG=Mgn11nvNZWEBHhW3wQa57Vup+tjXE4Umyb8CHSTr2g@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 4:28 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mardi 23 avril 2019 =C3=A0 14:33 +0200, Paul Kocialkowski a =C3=A9crit=
 :
> > Hi,
> >
> > On Tue, 2019-04-23 at 09:30 +0200, Daniel Vetter wrote:
> > > On Sun, Apr 21, 2019 at 01:40:45AM +0300, Laurent Pinchart wrote:
> > > > Hi Paul,
> > > >
> > > > On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wrote:
> > > > > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > > > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > > > > > And a lot of people pushed for the "fourcc is a standard", wh=
en
> > > > > > > really it's totally not.
> > > > > >
> > > > > > Even if it's not a standard, having consistency would be a good=
 thing.
> > > > > >
> > > > > > And you said yourself that DRM fourcc is now pretty much an aut=
hority
> > > > > > for the fourcc, so it definitely looks like a standard to me.
> > > > >
> > > > > I think trying to make the V4L2 and DRM fourccs converge is a los=
t
> > > > > cause, as it has already significantly diverged. Even if we coord=
inate
> > > > > an effort to introduce new formats with the same fourcc on both s=
ides,
> > > > > I don't see what good that would be since the formats we have now=
 are
> > > > > still plagued by the inconsistency.
> > > > >
> > > > > I think we always need an explicit translation step from either v=
4l2 or
> > > > > drm to the internal representation and back, without ever assumin=
g that
> > > > > formats might be compatible because they share the same fourcc.
> > > >
> > > > I don't agree. APIs evolve, and while we can't switch from one set =
of
> > > > 4CCs to another in existing APIs, we could in new APIs. Boris is wo=
rking
> > > > on new ioctls to handle formats in V4L2, and while 4CC unification =
could
> > > > be impopular from a userspace developers point of view there, I don=
't
> > > > think we have ruled it out completely. The move to the request API =
is
> > > > also an area where a common set of 4CCs could be used, as it will d=
epart
> > > > from the existing V4L2 ioctls. To summarize my opinion, we're not t=
here
> > > > yet, but I wouldn't rule it out completely for the future.
> > > >
> > > > > It looks like so far, V4L2 pixel formats describe a DRM pixel for=
mat +
> > > > > modifier.
> > > >
> > > > DRM modifiers are mostly about tiling and compression, and we hardl=
y
> > > > support these in V4L2. What are the modifiers you think are hardcod=
ed in
> > > > 4CCs in V4L2 ?
> > >
> > > Hm maybe it was a drm one that didn't come from v4l or anywhere else
> > > really, but the NV12MT one is nv12 + some tiling. I think we managed =
to
> > > uapi-bend that one into shape in at least drm.
> >
> > The one I had in mind is V4L2_PIX_FMT_SUNXI_TILED_NV12 which translates
> > to DRM_FORMAT_NV12 + DRM_FORMAT_MOD_ALLWINNER_TILED. Seems to be a
> > pretty similar case to the Mediatek one indeed.
> >
> > In our cause, that's because the video decoding engine produces its
> > destination buffers in a specific tiled format, that the display engine
> > can take in directly.
>
> We also have the Samsung tiling (Z pattern) as mentioned here, but also
> linear 16x16 tile placement (also from Samsung ?) and I believe Amlogic
> CODEC patches is bringing another tiling (unavoidable on older Meson8,
> with 64bytes swaps). All these should be expressed as NV12 + mod in DRM
> space.
>
> What is very often not enabled, but affect the performance on mainline
> media drivers is the ARM frame buffer compression. I know that RK chips
> have support for this, and that you can't achieve the maximum
> throughput without that. This one is not documented anywhere, but I
> understand that there is multiple variants that HW vendor licence.
> Though, in general, each SoC are likely running a single variant, so a
> single mod would make sense.

We have AFBC modifiers now in drm_fourcc.h, jointly developed by
display engineers from ARM and mali gpu reverse engineer people doing
the panfrost driver. So should be covered.

> So all this to say that V4L2 equally needs supports for these. What I
> understood through DRM API is that a buffer allocated for let's say
> NV12 + mod, is compatible with linear NV12. That could be used to
> simplify some code, but at the same time, a common API that deals with
> the padding and alignment of each format + mod independently would do
> that same as long as this is not variable depending on which target HW
> uses that same format.

Not sure why you mean with NV12 + mod is compatible with linear NV12.
In general fourcc + modifier !=3D fourcc =3D linear modifier, size, number
of planes, alignment constraints and everything else can be changed by
a modifier (and there's examples for all of these, maybe not yet in
all cases for NV12, but I think NV12 + AFBC modifiers gives some
pretty interesting results). In generally you need to think of the
(drm fourcc, modifier) as the pair identified the pixel format, each
part individually is fairly meanigless. We have lots of modifiers
where the exact tiling mode/layout changes depending upon the fourcc
code.

The only exception is legacy interfaces, i.e. when you create a
framebuffer with only the drm fourcc and not a modifier. In that case
you get driver specific behaviour, but modifier aware drivers tend to
change that into a specific (fourcc, modifier) pair again (at least
i915.ko, and it's what I recommend).

Oh and we have some legacy modifiers that depend upon the target hw,
but it's very much not recommended (we did it in i915 to make things
easier on really old platforms, on some of them we don't even know the
exact tiling mode since it's not documented nor correctly
reverse-engineered).

Another fun case are some of the recent non-byte-aligned formats, for
which you need to have a modifier to be able to use them with anything
- there's not really a real linear layout for them, they just serve as
an index/parameter into the modifier space.

> I think DRM + mod reduce the amount of dedicated formats that needs to
> be added, and simplify the documentation of each formats. I was looking
> at the Amlogic Axi configurations on Amlogic S905x recently, and for
> each well known format, there is a bitmask that let you do arbitrary
> swapping of bits, so effectively if we start exposing all these with
> V4L2 style, the list would become very long and hard to maintained.

See above, modifiers aren't really simple ...
-Daniel

> >
> > Cheers,
> >
> > Paul
> >
> > > -Daniel
> > >
> > > > > I think Boris (CCed) is working to change that by allowing to
> > > > > pass a DRM modifier through V4L2. With that, we'd be in a situati=
on
> > > > > where some formats are described by the v4l2 pixfmt alone and som=
e
> > > > > formats are also described a modifier (but I looked at it from a
> > > > > distance so might have misunderstod). That feels better since it =
avoids
> > > > > the combinatory explosion from describing each format + modifier
> > > > > individually.
> > > > >
> > > > > What do you think?
> > > > >
> > > > > > > v4l tends to conflate pixel format with stuff that we tend to=
 encode
> > > > > > > in modifiers a lot more.
> > > > > >
> > > > > > Boris is working on adding the modifiers concept to v4l2, so we=
're
> > > > > > converging here, and we can totally have a layer in v4l2 to con=
vert
> > > > > > between old v4l2 "format+modifiers" formats, and DRM style form=
ats.
> > > > > >
> > > > > > > There's a bunch of reasons we can't just use v4l, and they're=
 as
> > > > > > > valid as ever:
> > > > > > >
> > > > > > > - We overlap badly in some areas, so even if fourcc codes mat=
ch, we
> > > > > > >   can't use them and need a duplicated DRM_FOURCC code.
> > > > > >
> > > > > > Do yo have an example of one of those areas?
> > > > > >
> > > > > > > - v4l encodes some metadata into the fourcc that we encode el=
sewhere,
> > > > > > >   e.g. offset for planar yuv formats, or tiling mode
> > > > > >
> > > > > > As I was saying, this changes on the v4l2 side, and converging =
to
> > > > > > what DRM is doing.
> > > > > >
> > > > > > > - drm fourcc code doesn't actually define the drm_format_info
> > > > > > >   uniquely, drivers can override that (that's an explicit des=
ign
> > > > > > >   intent of modifiers, to allow drivers to add another plane =
for
> > > > > > >   e.g. compression information). You'd need to pull that driv=
er
> > > > > > >   knowledge into your format library.
> > > > > >
> > > > > > I'm not sure how my patches are changing anything here. This is
> > > > > > litterally the same code, with the functions renamed.
> > > > > >
> > > > > > If drivers want to override that, then yeah, fine, we can let t=
hem do
> > > > > > that. Just like any helper this just provides a default that co=
vers
> > > > > > most of the cases.
> > > > > >
> > > > > > > Iow there's no way we can easily adopt v4l fourcc, except if =
we do
> > > > > > > something like a new addfb flag.
> > > > > >
> > > > > > For the formats that would be described as a modifier, sure. Fo=
r all
> > > > > > the others (that are not yet supported by DRM), then I don't re=
ally
> > > > > > see why not.
> > > > > >
> > > > > > > > And given how the current state is a mess in this regard, I=
'm not too
> > > > > > > > optimistic about keeping the formats in their relevant fram=
eworks.
> > > > > > > >
> > > > > > > > Having a shared library, governed by both, will make this f=
ar easier,
> > > > > > > > since it will be easy to discover the formats that are alre=
ady
> > > > > > > > supported by the other subsystem.
> > > > > > >
> > > > > > > I think a compat library that (tries to, best effort) convert=
 between
> > > > > > > v4l and drm fourcc would make sense. Somewhere in drivers/vid=
eo, next
> > > > > > > to the conversion functions for videomode <-> drm_display_mod=
e
> > > > > > > perhaps. That should be useful for drivers.
> > > > > >
> > > > > > That's not really what this series is about though. That series=
 is
> > > > > > about sharing the (image|pixels) formats database across everyo=
ne so
> > > > > > that everyone can benefit from it.
> > > > > >
> > > > > > > Unifying the formats themselves, and all the associated metad=
ata is
> > > > > > > imo a no-go, and was a pretty conscious decision when we impl=
emented
> > > > > > > drm_fourcc a few years back.
> > > > > > >
> > > > > > > > If we want to keep the current library in DRM, we have two =
options
> > > > > > > > then:
> > > > > > > >
> > > > > > > >   - Support all the v4l2 formats in the DRM library, which =
is
> > > > > > > >     essentially what I'm doing in the last patches. However=
, that
> > > > > > > >     would require to have the v4l2 developpers also reviewi=
ng stuff
> > > > > > > >     there. And given how busy they are, I cannot really see=
 how that
> > > > > > > >     would work.
> > > > > > >
> > > > > > > Well, if we end up with a common library then yes we need cro=
ss
> > > > > > > review. There's no way around that. Doesn't matter where exac=
tly that
> > > > > > > library is in the filesystem tree, and adding a special MAINT=
AINERS
> > > > > > > entry for anything related to fourcc (both drm and v4l) to ma=
ke sure
> > > > > > > they get cross-posted is easy. No file renaming needed.
> > > > > >
> > > > > > That would create some governing issues as well. For example, i=
f you
> > > > > > ever have a patch from one fourcc addition (that might or might=
 not be
> > > > > > covered by v4l2), will you wait for any v4l2 developper to revi=
ew it?
> > > > > >
> > > > > > If it's shared code, then it should be shared, and every client
> > > > > > framework put on an equal footing.
> > > > > >
> > > > > > > >   - Develop the same library from within v4l2. That is real=
ly a poor
> > > > > > > >     solution, since the information would be greatly duplic=
ated
> > > > > > > >     between the two, and in terms of maintainance, code, an=
d binary
> > > > > > > >     size that would be duplicated too.
> > > > > > >
> > > > > > > It's essentially what we decided to do for drm years back.
> > > > > >
> > > > > > And it was probably the right solution back then, but I'm reall=
y not
> > > > > > convinced it's still the right thing to do today.
> > > > > >
> > > > > > > > Having it shared allows to easily share, and discover forma=
ts from the
> > > > > > > > other subsystem, and to have a single, unique place where t=
his is
> > > > > > > > centralized.
> > > > > > >
> > > > > > > What I think could work as middle ground:
> > > > > > > - Put drm_format stuff into a separate .ko
> > > > > > > - Add a MAINTAINERS entry to make sure all things fourcc are =
cross
> > > > > > > posted to both drm and v4l lists. Easy on the drm side, since=
 it's all
> > > > > > > separate files. Not sure it's so convenient for v4l uapi.
> > > > > > > - Add a conversion library that tries to best-effort map betw=
een drm
> > > > > > > and v4l formats. On the drm side that most likely means you n=
eed
> > > > > > > offsets for planes, and modifiers too (since those are implie=
d in some
> > > > > > > v4l fourcc). Emphasis on "best effort" i.e. only support as m=
uch as
> > > > > > > the drivers that use this library need.
> > > > > > > - Add drm_fourcc as-needed by these drivers that want to use =
a unified
> > > > > > > format space.
> > > > > > >
> > > > > > > Forcing this unification on everyone otoh is imo way too much=
.
> > > > > >
> > > > > > v4l2 is starting to converge with DRM, and we're using the DRM =
API
> > > > > > pretty much untouched for that library, so I'm not really sure =
how
> > > > > > anyone is hurt by that unification.
> > > >
> > > > --
> > > > Regards,
> > > >
> > > > Laurent Pinchart



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
