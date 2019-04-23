Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CDC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09FC217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="ygi9OuDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfDWO2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:28:35 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfDWO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:28:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id f125so3851819qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=kg8h0oxkbuYeyiU8lm843tXNxAiLD0i6ZCwHcRcITqw=;
        b=ygi9OuDjJkh5HdkwmA7cVBigg4+EZRu0vDBJRl4Eb/LR5Jo4e4iLJH8dHB09Y5D/is
         OSdHo80uu9S1PpToU9GLaH/idJ2V/nRPV6kYKzfDmA9ikKO6EyN+pPoUVLTVqR6phoTR
         k3We+QuFll4EDl5wHzwWM5o/MM370q8ubjRrVZNNRkpY48I+kAHP34a6T7Tpn5W2GzNh
         k41OlFe+imJOcHANcGvMEekJZE211hjOHn0+Haq2vVGHK9mbJIB6/HiGMJMK6OVsykZQ
         Zofr0VJwRe+fDnyi0CBFv+1wR/E1Yu3NuH8IJC5/n1ya03Bs2fG+/aXwn1rkxfwbkNii
         o68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=kg8h0oxkbuYeyiU8lm843tXNxAiLD0i6ZCwHcRcITqw=;
        b=Kvqh4EIRcGi7U2zwqCG8WLi5FyzL/4Rzv26yeL9h003F08gIc7/yhHijWUVXxcqiSe
         OSQvgPlJCiTHREDZbhcjuMoxMtlUzejYvjjlhjyxVf1CChsVHurVfSa4SrDMox2ocNkQ
         YA6lM8elio/UaCBBIJJVcVwzmuD/gPl3DjbYDkumEv0vh9/yWWYZsKjHXi28LmXlJrVK
         Ws3Ut9YI35SmarKsikR8KnE53klvm8eDS3ILhAlZX700QDfkoeMVjrqKkXtkAtGkAbOO
         uVn8fiZ2/boh0QY3q2cc7E7t6j/a0CBv/jXPfDWcv7knkm/EnccHJ2Y4Ur7u5/wxHrta
         A+EQ==
X-Gm-Message-State: APjAAAUL2iZGYBKUZCD76w8ko3dVeo/htb/Ua8hqfLykyLm4xAzSxd1c
        jRvRnerp6JXcKMp4jR3AIRkYAA==
X-Google-Smtp-Source: APXvYqyrIkmw9+qVvg7vQzi6msMq98/vf8Y7jGas6NDXmRnfySspiwyK4o6WAnBwMoUyGD6mAksVMg==
X-Received: by 2002:ae9:ec07:: with SMTP id h7mr4975574qkg.7.1556029714112;
        Tue, 23 Apr 2019 07:28:34 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id x24sm9791557qtm.65.2019.04.23.07.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 07:28:32 -0700 (PDT)
Message-ID: <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Date:   Tue, 23 Apr 2019 10:28:30 -0400
In-Reply-To: <f288e1d29277fcd79b251d99f84fb9b165364fac.camel@bootlin.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <20190417154121.GJ13337@phenom.ffwll.local>
         <20190418062229.eyog4i62eg4pr6uf@flea>
         <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
         <20190418090221.e57dogn4yx5nwdni@flea>
         <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
         <20190420224045.GY4964@pendragon.ideasonboard.com>
         <20190423073026.GX13337@phenom.ffwll.local>
         <f288e1d29277fcd79b251d99f84fb9b165364fac.camel@bootlin.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-Zh7rxIBSoDrjPaJGfnkv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Zh7rxIBSoDrjPaJGfnkv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 23 avril 2019 =C3=A0 14:33 +0200, Paul Kocialkowski a =C3=A9crit :
> Hi,
>=20
> On Tue, 2019-04-23 at 09:30 +0200, Daniel Vetter wrote:
> > On Sun, Apr 21, 2019 at 01:40:45AM +0300, Laurent Pinchart wrote:
> > > Hi Paul,
> > >=20
> > > On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wrote:
> > > > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > > > > And a lot of people pushed for the "fourcc is a standard", when
> > > > > > really it's totally not.
> > > > >=20
> > > > > Even if it's not a standard, having consistency would be a good t=
hing.
> > > > >=20
> > > > > And you said yourself that DRM fourcc is now pretty much an autho=
rity
> > > > > for the fourcc, so it definitely looks like a standard to me.
> > > >=20
> > > > I think trying to make the V4L2 and DRM fourccs converge is a lost
> > > > cause, as it has already significantly diverged. Even if we coordin=
ate
> > > > an effort to introduce new formats with the same fourcc on both sid=
es,
> > > > I don't see what good that would be since the formats we have now a=
re
> > > > still plagued by the inconsistency.
> > > >=20
> > > > I think we always need an explicit translation step from either v4l=
2 or
> > > > drm to the internal representation and back, without ever assuming =
that
> > > > formats might be compatible because they share the same fourcc.
> > >=20
> > > I don't agree. APIs evolve, and while we can't switch from one set of
> > > 4CCs to another in existing APIs, we could in new APIs. Boris is work=
ing
> > > on new ioctls to handle formats in V4L2, and while 4CC unification co=
uld
> > > be impopular from a userspace developers point of view there, I don't
> > > think we have ruled it out completely. The move to the request API is
> > > also an area where a common set of 4CCs could be used, as it will dep=
art
> > > from the existing V4L2 ioctls. To summarize my opinion, we're not the=
re
> > > yet, but I wouldn't rule it out completely for the future.
> > >=20
> > > > It looks like so far, V4L2 pixel formats describe a DRM pixel forma=
t +
> > > > modifier.
> > >=20
> > > DRM modifiers are mostly about tiling and compression, and we hardly
> > > support these in V4L2. What are the modifiers you think are hardcoded=
 in
> > > 4CCs in V4L2 ?
> >=20
> > Hm maybe it was a drm one that didn't come from v4l or anywhere else
> > really, but the NV12MT one is nv12 + some tiling. I think we managed to
> > uapi-bend that one into shape in at least drm.
>=20
> The one I had in mind is V4L2_PIX_FMT_SUNXI_TILED_NV12 which translates
> to DRM_FORMAT_NV12 + DRM_FORMAT_MOD_ALLWINNER_TILED. Seems to be a
> pretty similar case to the Mediatek one indeed.
>=20
> In our cause, that's because the video decoding engine produces its
> destination buffers in a specific tiled format, that the display engine
> can take in directly.

We also have the Samsung tiling (Z pattern) as mentioned here, but also
linear 16x16 tile placement (also from Samsung ?) and I believe Amlogic
CODEC patches is bringing another tiling (unavoidable on older Meson8,
with 64bytes swaps). All these should be expressed as NV12 + mod in DRM
space.

What is very often not enabled, but affect the performance on mainline
media drivers is the ARM frame buffer compression. I know that RK chips
have support for this, and that you can't achieve the maximum
throughput without that. This one is not documented anywhere, but I
understand that there is multiple variants that HW vendor licence.
Though, in general, each SoC are likely running a single variant, so a
single mod would make sense.

So all this to say that V4L2 equally needs supports for these. What I
understood through DRM API is that a buffer allocated for let's say
NV12 + mod, is compatible with linear NV12. That could be used to
simplify some code, but at the same time, a common API that deals with
the padding and alignment of each format + mod independently would do
that same as long as this is not variable depending on which target HW
uses that same format.

I think DRM + mod reduce the amount of dedicated formats that needs to
be added, and simplify the documentation of each formats. I was looking
at the Amlogic Axi configurations on Amlogic S905x recently, and for
each well known format, there is a bitmask that let you do arbitrary
swapping of bits, so effectively if we start exposing all these with
V4L2 style, the list would become very long and hard to maintained.

>=20
> Cheers,
>=20
> Paul
>=20
> > -Daniel
> >=20
> > > > I think Boris (CCed) is working to change that by allowing to
> > > > pass a DRM modifier through V4L2. With that, we'd be in a situation
> > > > where some formats are described by the v4l2 pixfmt alone and some
> > > > formats are also described a modifier (but I looked at it from a
> > > > distance so might have misunderstod). That feels better since it av=
oids
> > > > the combinatory explosion from describing each format + modifier
> > > > individually.
> > > >=20
> > > > What do you think?
> > > >=20
> > > > > > v4l tends to conflate pixel format with stuff that we tend to e=
ncode
> > > > > > in modifiers a lot more.
> > > > >=20
> > > > > Boris is working on adding the modifiers concept to v4l2, so we'r=
e
> > > > > converging here, and we can totally have a layer in v4l2 to conve=
rt
> > > > > between old v4l2 "format+modifiers" formats, and DRM style format=
s.
> > > > >=20
> > > > > > There's a bunch of reasons we can't just use v4l, and they're a=
s
> > > > > > valid as ever:
> > > > > >=20
> > > > > > - We overlap badly in some areas, so even if fourcc codes match=
, we
> > > > > >   can't use them and need a duplicated DRM_FOURCC code.
> > > > >=20
> > > > > Do yo have an example of one of those areas?
> > > > >=20
> > > > > > - v4l encodes some metadata into the fourcc that we encode else=
where,
> > > > > >   e.g. offset for planar yuv formats, or tiling mode
> > > > >=20
> > > > > As I was saying, this changes on the v4l2 side, and converging to
> > > > > what DRM is doing.
> > > > >=20
> > > > > > - drm fourcc code doesn't actually define the drm_format_info
> > > > > >   uniquely, drivers can override that (that's an explicit desig=
n
> > > > > >   intent of modifiers, to allow drivers to add another plane fo=
r
> > > > > >   e.g. compression information). You'd need to pull that driver
> > > > > >   knowledge into your format library.
> > > > >=20
> > > > > I'm not sure how my patches are changing anything here. This is
> > > > > litterally the same code, with the functions renamed.
> > > > >=20
> > > > > If drivers want to override that, then yeah, fine, we can let the=
m do
> > > > > that. Just like any helper this just provides a default that cove=
rs
> > > > > most of the cases.
> > > > >=20
> > > > > > Iow there's no way we can easily adopt v4l fourcc, except if we=
 do
> > > > > > something like a new addfb flag.
> > > > >=20
> > > > > For the formats that would be described as a modifier, sure. For =
all
> > > > > the others (that are not yet supported by DRM), then I don't real=
ly
> > > > > see why not.
> > > > >=20
> > > > > > > And given how the current state is a mess in this regard, I'm=
 not too
> > > > > > > optimistic about keeping the formats in their relevant framew=
orks.
> > > > > > >=20
> > > > > > > Having a shared library, governed by both, will make this far=
 easier,
> > > > > > > since it will be easy to discover the formats that are alread=
y
> > > > > > > supported by the other subsystem.
> > > > > >=20
> > > > > > I think a compat library that (tries to, best effort) convert b=
etween
> > > > > > v4l and drm fourcc would make sense. Somewhere in drivers/video=
, next
> > > > > > to the conversion functions for videomode <-> drm_display_mode
> > > > > > perhaps. That should be useful for drivers.
> > > > >=20
> > > > > That's not really what this series is about though. That series i=
s
> > > > > about sharing the (image|pixels) formats database across everyone=
 so
> > > > > that everyone can benefit from it.
> > > > >=20
> > > > > > Unifying the formats themselves, and all the associated metadat=
a is
> > > > > > imo a no-go, and was a pretty conscious decision when we implem=
ented
> > > > > > drm_fourcc a few years back.
> > > > > >=20
> > > > > > > If we want to keep the current library in DRM, we have two op=
tions
> > > > > > > then:
> > > > > > >=20
> > > > > > >   - Support all the v4l2 formats in the DRM library, which is
> > > > > > >     essentially what I'm doing in the last patches. However, =
that
> > > > > > >     would require to have the v4l2 developpers also reviewing=
 stuff
> > > > > > >     there. And given how busy they are, I cannot really see h=
ow that
> > > > > > >     would work.
> > > > > >=20
> > > > > > Well, if we end up with a common library then yes we need cross
> > > > > > review. There's no way around that. Doesn't matter where exactl=
y that
> > > > > > library is in the filesystem tree, and adding a special MAINTAI=
NERS
> > > > > > entry for anything related to fourcc (both drm and v4l) to make=
 sure
> > > > > > they get cross-posted is easy. No file renaming needed.
> > > > >=20
> > > > > That would create some governing issues as well. For example, if =
you
> > > > > ever have a patch from one fourcc addition (that might or might n=
ot be
> > > > > covered by v4l2), will you wait for any v4l2 developper to review=
 it?
> > > > >=20
> > > > > If it's shared code, then it should be shared, and every client
> > > > > framework put on an equal footing.
> > > > >=20
> > > > > > >   - Develop the same library from within v4l2. That is really=
 a poor
> > > > > > >     solution, since the information would be greatly duplicat=
ed
> > > > > > >     between the two, and in terms of maintainance, code, and =
binary
> > > > > > >     size that would be duplicated too.
> > > > > >=20
> > > > > > It's essentially what we decided to do for drm years back.
> > > > >=20
> > > > > And it was probably the right solution back then, but I'm really =
not
> > > > > convinced it's still the right thing to do today.
> > > > >=20
> > > > > > > Having it shared allows to easily share, and discover formats=
 from the
> > > > > > > other subsystem, and to have a single, unique place where thi=
s is
> > > > > > > centralized.
> > > > > >=20
> > > > > > What I think could work as middle ground:
> > > > > > - Put drm_format stuff into a separate .ko
> > > > > > - Add a MAINTAINERS entry to make sure all things fourcc are cr=
oss
> > > > > > posted to both drm and v4l lists. Easy on the drm side, since i=
t's all
> > > > > > separate files. Not sure it's so convenient for v4l uapi.
> > > > > > - Add a conversion library that tries to best-effort map betwee=
n drm
> > > > > > and v4l formats. On the drm side that most likely means you nee=
d
> > > > > > offsets for planes, and modifiers too (since those are implied =
in some
> > > > > > v4l fourcc). Emphasis on "best effort" i.e. only support as muc=
h as
> > > > > > the drivers that use this library need.
> > > > > > - Add drm_fourcc as-needed by these drivers that want to use a =
unified
> > > > > > format space.
> > > > > >=20
> > > > > > Forcing this unification on everyone otoh is imo way too much.
> > > > >=20
> > > > > v4l2 is starting to converge with DRM, and we're using the DRM AP=
I
> > > > > pretty much untouched for that library, so I'm not really sure ho=
w
> > > > > anyone is hurt by that unification.
> > >=20
> > > --=20
> > > Regards,
> > >=20
> > > Laurent Pinchart

--=-Zh7rxIBSoDrjPaJGfnkv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXL8hDgAKCRBxUwItrAao
HH1WAKCYq4AV39+mMbk/uAJVx5oqTcZulACfc1HmiSCS/5VX587mgIWFv57vmn0=
=uoRg
-----END PGP SIGNATURE-----

--=-Zh7rxIBSoDrjPaJGfnkv--

