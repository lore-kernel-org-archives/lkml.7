Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B44C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274FC2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="lPEWdCig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfDWRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:17:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34201 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfDWRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:17:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id 43so2879301qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=olBUa7m2fL5uP1eghSSZbt9rQXsdkIUAtj0+dmrBLwQ=;
        b=lPEWdCigyLHKaEXP1fciJvu5VvbJyE7Bsu1ayj0XdgpBPdVI86TJOhynGVJWcif8c4
         dKJT7NwWxuKmyISxagHgSBWFJ18n2xQJhMZXVBwIAhpEAzVxoOcfGanS/jDk1qk1wZz9
         utSJrAndOZhboVYS1YKkMwKR77iLCIU9yYjafCeDLLqhalCuDerZiaTtErtKGkxmaEk8
         cOFTeUtT0da0mn4j/wsGExDLN4zRMgHtzOQAx2KzQxRQw/iy+taJNR/40T5r9FZ6j/B/
         /CQ9smybxxeLtd2OOQpRWlWvhwP+d+tpldr0yynjRcPJr1KZwPjYnzN7EmlyqxaFvGEy
         MBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=olBUa7m2fL5uP1eghSSZbt9rQXsdkIUAtj0+dmrBLwQ=;
        b=Vx/NQZfPV4GL7OEQFze4TTSFku/AsYTN7y0u6HQLsPY29RYDVc+Y1eTYzWXCdX/k6u
         tNXL36bP8Xccg4BzBbHXDJceZixkms3BcRBWhkxIaSxtk6c1eaq7kkEHbiSaVycS0K1o
         +MNwLEAbPScyMfuj134S6zMhvbf8xtNrv0Dp3nwz/sQHGB6H6vb7VJVfbohFcJfM3xzB
         ePX1cy8yItEa2cMvhVztyIaivMLBnUE0uyDKMQ9ejdsftSpDK+sjZOqZqIHx8Emck7ml
         uICSo9MnenBMDdd1DWXhpPRT0O0zTN2NCScozU09dxgWBd2YsqQt4lqC5b0nbiMagqtU
         G0eA==
X-Gm-Message-State: APjAAAVM5jyTKAF8+J4JM0X9Ss7AtOh4btlnxmmhY5GkZgo7AL0yScYk
        a717GeK4xplztvqafPIaSvPO9Q==
X-Google-Smtp-Source: APXvYqyQA9kFVAOZVoF/V6jHYexodesddcbXpM9Du3UGN7WUbXeucOs+X/GPUsNNiJrtaLcdIpvQjQ==
X-Received: by 2002:ac8:4283:: with SMTP id o3mr1353640qtl.316.1556039821608;
        Tue, 23 Apr 2019 10:17:01 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id 6sm10961712qtt.8.2019.04.23.10.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 10:16:59 -0700 (PDT)
Message-ID: <f3e58f3b48c90b83143888c95acf8a886298da8c.camel@ndufresne.ca>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
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
Date:   Tue, 23 Apr 2019 13:16:57 -0400
In-Reply-To: <CAKMK7uG=Mgn11nvNZWEBHhW3wQa57Vup+tjXE4Umyb8CHSTr2g@mail.gmail.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <20190417154121.GJ13337@phenom.ffwll.local>
         <20190418062229.eyog4i62eg4pr6uf@flea>
         <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
         <20190418090221.e57dogn4yx5nwdni@flea>
         <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
         <20190420224045.GY4964@pendragon.ideasonboard.com>
         <20190423073026.GX13337@phenom.ffwll.local>
         <f288e1d29277fcd79b251d99f84fb9b165364fac.camel@bootlin.com>
         <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
         <CAKMK7uG=Mgn11nvNZWEBHhW3wQa57Vup+tjXE4Umyb8CHSTr2g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-SXe6P+m1+ReTTnHtr2bw"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SXe6P+m1+ReTTnHtr2bw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 23 avril 2019 =C3=A0 17:09 +0200, Daniel Vetter a =C3=A9crit :
> On Tue, Apr 23, 2019 at 4:28 PM Nicolas Dufresne <nicolas@ndufresne.ca> w=
rote:
> > Le mardi 23 avril 2019 =C3=A0 14:33 +0200, Paul Kocialkowski a =C3=A9cr=
it :
> > > Hi,
> > >=20
> > > On Tue, 2019-04-23 at 09:30 +0200, Daniel Vetter wrote:
> > > > On Sun, Apr 21, 2019 at 01:40:45AM +0300, Laurent Pinchart wrote:
> > > > > Hi Paul,
> > > > >=20
> > > > > On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wrote=
:
> > > > > > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > > > > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote=
:
> > > > > > > > And a lot of people pushed for the "fourcc is a standard", =
when
> > > > > > > > really it's totally not.
> > > > > > >=20
> > > > > > > Even if it's not a standard, having consistency would be a go=
od thing.
> > > > > > >=20
> > > > > > > And you said yourself that DRM fourcc is now pretty much an a=
uthority
> > > > > > > for the fourcc, so it definitely looks like a standard to me.
> > > > > >=20
> > > > > > I think trying to make the V4L2 and DRM fourccs converge is a l=
ost
> > > > > > cause, as it has already significantly diverged. Even if we coo=
rdinate
> > > > > > an effort to introduce new formats with the same fourcc on both=
 sides,
> > > > > > I don't see what good that would be since the formats we have n=
ow are
> > > > > > still plagued by the inconsistency.
> > > > > >=20
> > > > > > I think we always need an explicit translation step from either=
 v4l2 or
> > > > > > drm to the internal representation and back, without ever assum=
ing that
> > > > > > formats might be compatible because they share the same fourcc.
> > > > >=20
> > > > > I don't agree. APIs evolve, and while we can't switch from one se=
t of
> > > > > 4CCs to another in existing APIs, we could in new APIs. Boris is =
working
> > > > > on new ioctls to handle formats in V4L2, and while 4CC unificatio=
n could
> > > > > be impopular from a userspace developers point of view there, I d=
on't
> > > > > think we have ruled it out completely. The move to the request AP=
I is
> > > > > also an area where a common set of 4CCs could be used, as it will=
 depart
> > > > > from the existing V4L2 ioctls. To summarize my opinion, we're not=
 there
> > > > > yet, but I wouldn't rule it out completely for the future.
> > > > >=20
> > > > > > It looks like so far, V4L2 pixel formats describe a DRM pixel f=
ormat +
> > > > > > modifier.
> > > > >=20
> > > > > DRM modifiers are mostly about tiling and compression, and we har=
dly
> > > > > support these in V4L2. What are the modifiers you think are hardc=
oded in
> > > > > 4CCs in V4L2 ?
> > > >=20
> > > > Hm maybe it was a drm one that didn't come from v4l or anywhere els=
e
> > > > really, but the NV12MT one is nv12 + some tiling. I think we manage=
d to
> > > > uapi-bend that one into shape in at least drm.
> > >=20
> > > The one I had in mind is V4L2_PIX_FMT_SUNXI_TILED_NV12 which translat=
es
> > > to DRM_FORMAT_NV12 + DRM_FORMAT_MOD_ALLWINNER_TILED. Seems to be a
> > > pretty similar case to the Mediatek one indeed.
> > >=20
> > > In our cause, that's because the video decoding engine produces its
> > > destination buffers in a specific tiled format, that the display engi=
ne
> > > can take in directly.
> >=20
> > We also have the Samsung tiling (Z pattern) as mentioned here, but also
> > linear 16x16 tile placement (also from Samsung ?) and I believe Amlogic
> > CODEC patches is bringing another tiling (unavoidable on older Meson8,
> > with 64bytes swaps). All these should be expressed as NV12 + mod in DRM
> > space.
> >=20
> > What is very often not enabled, but affect the performance on mainline
> > media drivers is the ARM frame buffer compression. I know that RK chips
> > have support for this, and that you can't achieve the maximum
> > throughput without that. This one is not documented anywhere, but I
> > understand that there is multiple variants that HW vendor licence.
> > Though, in general, each SoC are likely running a single variant, so a
> > single mod would make sense.
>=20
> We have AFBC modifiers now in drm_fourcc.h, jointly developed by
> display engineers from ARM and mali gpu reverse engineer people doing
> the panfrost driver. So should be covered.
>=20
> > So all this to say that V4L2 equally needs supports for these. What I
> > understood through DRM API is that a buffer allocated for let's say
> > NV12 + mod, is compatible with linear NV12. That could be used to
> > simplify some code, but at the same time, a common API that deals with
> > the padding and alignment of each format + mod independently would do
> > that same as long as this is not variable depending on which target HW
> > uses that same format.
>=20
> Not sure why you mean with NV12 + mod is compatible with linear NV12.
> In general fourcc + modifier !=3D fourcc =3D linear modifier, size, numbe=
r
> of planes, alignment constraints and everything else can be changed by
> a modifier (and there's examples for all of these, maybe not yet in
> all cases for NV12, but I think NV12 + AFBC modifiers gives some
> pretty interesting results). In generally you need to think of the
> (drm fourcc, modifier) as the pair identified the pixel format, each
> part individually is fairly meanigless. We have lots of modifiers
> where the exact tiling mode/layout changes depending upon the fourcc
> code.

I only meant that the NV12 + mod have the same number of planes, and
should be large enough to store a linear NV12 equivalent. Not that it
would render correctly (even though I found it useful to be able to
render them when I needed to reverse it).

>=20
> The only exception is legacy interfaces, i.e. when you create a
> framebuffer with only the drm fourcc and not a modifier. In that case
> you get driver specific behaviour, but modifier aware drivers tend to
> change that into a specific (fourcc, modifier) pair again (at least
> i915.ko, and it's what I recommend).
>=20
> Oh and we have some legacy modifiers that depend upon the target hw,
> but it's very much not recommended (we did it in i915 to make things
> easier on really old platforms, on some of them we don't even know the
> exact tiling mode since it's not documented nor correctly
> reverse-engineered).
>=20
> Another fun case are some of the recent non-byte-aligned formats, for
> which you need to have a modifier to be able to use them with anything
> - there's not really a real linear layout for them, they just serve as
> an index/parameter into the modifier space.
>=20
> > I think DRM + mod reduce the amount of dedicated formats that needs to
> > be added, and simplify the documentation of each formats. I was looking
> > at the Amlogic Axi configurations on Amlogic S905x recently, and for
> > each well known format, there is a bitmask that let you do arbitrary
> > swapping of bits, so effectively if we start exposing all these with
> > V4L2 style, the list would become very long and hard to maintained.
>=20
> See above, modifiers aren't really simple ...
> -Daniel
>=20
> > > Cheers,
> > >=20
> > > Paul
> > >=20
> > > > -Daniel
> > > >=20
> > > > > > I think Boris (CCed) is working to change that by allowing to
> > > > > > pass a DRM modifier through V4L2. With that, we'd be in a situa=
tion
> > > > > > where some formats are described by the v4l2 pixfmt alone and s=
ome
> > > > > > formats are also described a modifier (but I looked at it from =
a
> > > > > > distance so might have misunderstod). That feels better since i=
t avoids
> > > > > > the combinatory explosion from describing each format + modifie=
r
> > > > > > individually.
> > > > > >=20
> > > > > > What do you think?
> > > > > >=20
> > > > > > > > v4l tends to conflate pixel format with stuff that we tend =
to encode
> > > > > > > > in modifiers a lot more.
> > > > > > >=20
> > > > > > > Boris is working on adding the modifiers concept to v4l2, so =
we're
> > > > > > > converging here, and we can totally have a layer in v4l2 to c=
onvert
> > > > > > > between old v4l2 "format+modifiers" formats, and DRM style fo=
rmats.
> > > > > > >=20
> > > > > > > > There's a bunch of reasons we can't just use v4l, and they'=
re as
> > > > > > > > valid as ever:
> > > > > > > >=20
> > > > > > > > - We overlap badly in some areas, so even if fourcc codes m=
atch, we
> > > > > > > >   can't use them and need a duplicated DRM_FOURCC code.
> > > > > > >=20
> > > > > > > Do yo have an example of one of those areas?
> > > > > > >=20
> > > > > > > > - v4l encodes some metadata into the fourcc that we encode =
elsewhere,
> > > > > > > >   e.g. offset for planar yuv formats, or tiling mode
> > > > > > >=20
> > > > > > > As I was saying, this changes on the v4l2 side, and convergin=
g to
> > > > > > > what DRM is doing.
> > > > > > >=20
> > > > > > > > - drm fourcc code doesn't actually define the drm_format_in=
fo
> > > > > > > >   uniquely, drivers can override that (that's an explicit d=
esign
> > > > > > > >   intent of modifiers, to allow drivers to add another plan=
e for
> > > > > > > >   e.g. compression information). You'd need to pull that dr=
iver
> > > > > > > >   knowledge into your format library.
> > > > > > >=20
> > > > > > > I'm not sure how my patches are changing anything here. This =
is
> > > > > > > litterally the same code, with the functions renamed.
> > > > > > >=20
> > > > > > > If drivers want to override that, then yeah, fine, we can let=
 them do
> > > > > > > that. Just like any helper this just provides a default that =
covers
> > > > > > > most of the cases.
> > > > > > >=20
> > > > > > > > Iow there's no way we can easily adopt v4l fourcc, except i=
f we do
> > > > > > > > something like a new addfb flag.
> > > > > > >=20
> > > > > > > For the formats that would be described as a modifier, sure. =
For all
> > > > > > > the others (that are not yet supported by DRM), then I don't =
really
> > > > > > > see why not.
> > > > > > >=20
> > > > > > > > > And given how the current state is a mess in this regard,=
 I'm not too
> > > > > > > > > optimistic about keeping the formats in their relevant fr=
ameworks.
> > > > > > > > >=20
> > > > > > > > > Having a shared library, governed by both, will make this=
 far easier,
> > > > > > > > > since it will be easy to discover the formats that are al=
ready
> > > > > > > > > supported by the other subsystem.
> > > > > > > >=20
> > > > > > > > I think a compat library that (tries to, best effort) conve=
rt between
> > > > > > > > v4l and drm fourcc would make sense. Somewhere in drivers/v=
ideo, next
> > > > > > > > to the conversion functions for videomode <-> drm_display_m=
ode
> > > > > > > > perhaps. That should be useful for drivers.
> > > > > > >=20
> > > > > > > That's not really what this series is about though. That seri=
es is
> > > > > > > about sharing the (image|pixels) formats database across ever=
yone so
> > > > > > > that everyone can benefit from it.
> > > > > > >=20
> > > > > > > > Unifying the formats themselves, and all the associated met=
adata is
> > > > > > > > imo a no-go, and was a pretty conscious decision when we im=
plemented
> > > > > > > > drm_fourcc a few years back.
> > > > > > > >=20
> > > > > > > > > If we want to keep the current library in DRM, we have tw=
o options
> > > > > > > > > then:
> > > > > > > > >=20
> > > > > > > > >   - Support all the v4l2 formats in the DRM library, whic=
h is
> > > > > > > > >     essentially what I'm doing in the last patches. Howev=
er, that
> > > > > > > > >     would require to have the v4l2 developpers also revie=
wing stuff
> > > > > > > > >     there. And given how busy they are, I cannot really s=
ee how that
> > > > > > > > >     would work.
> > > > > > > >=20
> > > > > > > > Well, if we end up with a common library then yes we need c=
ross
> > > > > > > > review. There's no way around that. Doesn't matter where ex=
actly that
> > > > > > > > library is in the filesystem tree, and adding a special MAI=
NTAINERS
> > > > > > > > entry for anything related to fourcc (both drm and v4l) to =
make sure
> > > > > > > > they get cross-posted is easy. No file renaming needed.
> > > > > > >=20
> > > > > > > That would create some governing issues as well. For example,=
 if you
> > > > > > > ever have a patch from one fourcc addition (that might or mig=
ht not be
> > > > > > > covered by v4l2), will you wait for any v4l2 developper to re=
view it?
> > > > > > >=20
> > > > > > > If it's shared code, then it should be shared, and every clie=
nt
> > > > > > > framework put on an equal footing.
> > > > > > >=20
> > > > > > > > >   - Develop the same library from within v4l2. That is re=
ally a poor
> > > > > > > > >     solution, since the information would be greatly dupl=
icated
> > > > > > > > >     between the two, and in terms of maintainance, code, =
and binary
> > > > > > > > >     size that would be duplicated too.
> > > > > > > >=20
> > > > > > > > It's essentially what we decided to do for drm years back.
> > > > > > >=20
> > > > > > > And it was probably the right solution back then, but I'm rea=
lly not
> > > > > > > convinced it's still the right thing to do today.
> > > > > > >=20
> > > > > > > > > Having it shared allows to easily share, and discover for=
mats from the
> > > > > > > > > other subsystem, and to have a single, unique place where=
 this is
> > > > > > > > > centralized.
> > > > > > > >=20
> > > > > > > > What I think could work as middle ground:
> > > > > > > > - Put drm_format stuff into a separate .ko
> > > > > > > > - Add a MAINTAINERS entry to make sure all things fourcc ar=
e cross
> > > > > > > > posted to both drm and v4l lists. Easy on the drm side, sin=
ce it's all
> > > > > > > > separate files. Not sure it's so convenient for v4l uapi.
> > > > > > > > - Add a conversion library that tries to best-effort map be=
tween drm
> > > > > > > > and v4l formats. On the drm side that most likely means you=
 need
> > > > > > > > offsets for planes, and modifiers too (since those are impl=
ied in some
> > > > > > > > v4l fourcc). Emphasis on "best effort" i.e. only support as=
 much as
> > > > > > > > the drivers that use this library need.
> > > > > > > > - Add drm_fourcc as-needed by these drivers that want to us=
e a unified
> > > > > > > > format space.
> > > > > > > >=20
> > > > > > > > Forcing this unification on everyone otoh is imo way too mu=
ch.
> > > > > > >=20
> > > > > > > v4l2 is starting to converge with DRM, and we're using the DR=
M API
> > > > > > > pretty much untouched for that library, so I'm not really sur=
e how
> > > > > > > anyone is hurt by that unification.
> > > > >=20
> > > > > --
> > > > > Regards,
> > > > >=20
> > > > > Laurent Pinchart
>=20
>=20

--=-SXe6P+m1+ReTTnHtr2bw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXL9IiQAKCRBxUwItrAao
HDu/AJwNcZNIJwMu9jrFzNOlrzgoSjuRcgCfafnLdn0Muu3S4QafE6H1ciwKpoE=
=ib71
-----END PGP SIGNATURE-----

--=-SXe6P+m1+ReTTnHtr2bw--

