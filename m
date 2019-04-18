Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D97C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF621850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbfDRMBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:01:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39783 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbfDRMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:01:49 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id BA7B0200006;
        Thu, 18 Apr 2019 12:01:43 +0000 (UTC)
Date:   Thu, 18 Apr 2019 14:01:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
Message-ID: <20190418120143.4x7bvhgkh23mgsup@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
 <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea>
 <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbg2pzqpc3mg5r64"
Content-Disposition: inline
In-Reply-To: <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vbg2pzqpc3mg5r64
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 12:07:44PM +0200, Daniel Vetter wrote:
> On Thu, Apr 18, 2019 at 11:02 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > On Thu, Apr 18, 2019 at 8:22 AM Maxime Ripard <maxime.ripard@bootlin.=
com> wrote:
> > > > On Wed, Apr 17, 2019 at 05:41:21PM +0200, Daniel Vetter wrote:
> > > > > On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
> > > > > > Hi,
> > > > > >
> > > > > > DRM comes with an extensive format support to retrieve the vari=
ous
> > > > > > parameters associated with a given format (such as the subsampl=
ing, or the
> > > > > > bits per pixel), as well as some helpers and utilities to ease =
the driver
> > > > > > development.
> > > > > >
> > > > > > v4l2, on the other side, doesn't provide such facilities, leavi=
ng each
> > > > > > driver reimplement a subset of the formats parameters for the o=
ne supported
> > > > > > by that particular driver. This leads to a lot of duplication a=
nd
> > > > > > boilerplate code in the v4l2 drivers.
> > > > > >
> > > > > > This series tries to address this by moving the DRM format API =
into lib and
> > > > > > turning it into a more generic API. In order to do this, we've =
needed to do
> > > > > > some preliminary changes on the DRM drivers, then moved the API=
 and finally
> > > > > > converted a v4l2 driver to give an example of how such library =
could be
> > > > > > used.
> > > > > >
> > > > > > Let me know what you think,
> > > > > > Maxime
> > > > > >
> > > > > > Changes from RFC:
> > > > > >   - Rebased on next
> > > > > >   - Fixed the various formats mapping
> > > > > >   - Added tags
> > > > > >   - Did most of the formats functions as inline functions
> > > > > >   - Used a consistent prefix for all the utilities functions
> > > > > >   - Fixed the compilation breakages, and did a run of allmodcon=
fig for arm,
> > > > > >     arm64 and x86_64
> > > > > >   - Fixed out of array bounds warnings in the image_format_info=
_block_*
> > > > > >     functions
> > > > > >   - Added License and copyright headers on missing files
> > > > > >
> > > > > > Maxime Ripard (20):
> > > > > >   drm: Remove users of drm_format_num_planes
> > > > > >   drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
> > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_=
cpp
> > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_=
width/height
> > > > > >   drm: Replace instances of drm_format_info by drm_get_format_i=
nfo
> > > > > >   lib: Add video format information library
> > > > > >   drm/fb: Move from drm_format_info to image_format_info
> > > > > >   drm/malidp: Convert to generic image format library
> > > > > >   drm/client: Convert to generic image format library
> > > > > >   drm/exynos: Convert to generic image format library
> > > > > >   drm/i915: Convert to generic image format library
> > > > > >   drm/ipuv3: Convert to generic image format library
> > > > > >   drm/msm: Convert to generic image format library
> > > > > >   drm/omap: Convert to generic image format library
> > > > > >   drm/rockchip: Convert to generic image format library
> > > > > >   drm/tegra: Convert to generic image format library
> > > > > >   drm/fourcc: Remove old DRM format API
> > > > > >   lib: image-formats: Add v4l2 formats support
> > > > > >   lib: image-formats: Add more functions
> > > > > >   media: sun6i: Convert to the image format API
> > > > >
> > > > > In the interest of making myself unpopular: Why move this out of =
drm?
> > > > >
> > > > > We do have a bunch of other such shared helpers already (mostly in
> > > > > drivers/video) for dt videomode and hdmi infoframes, and I'm not =
super
> > > > > sure that's going better than keeping it maintained in drm.
> > > > >
> > > > > Plus the uapi is already that you include drm_fourcc.h to get at =
these,
> > > > > dropping the drm prefix isn't going to help I think.
> > > > >
> > > > > Of course we'd need to make it a separate drm_formats.ko (so that=
 v4l can
> > > > > use it without dragging in all of drm), and we need to add some f=
ields for
> > > > > converting to v4l fourcc codes (which are different). But that sh=
ould be
> > > > > all possible. And I don't think the drm_ prefix in v4l code is a =
problem,
> > > > > it's actually a feature: It makes it really clear that these are =
the drm
> > > > > fourcc codes, as allocated in drm_fourcc.h, plus their modifiers,=
 and all
> > > > > that. That allocation authority is also already baked into variou=
s khr/ext
> > > > > standards, too.
> > > >
> > > > The way I see it, there's a fundamental difference between the UAPI
> > > > and the kernel. I don't suggest we change anything about the UAPI: =
the
> > > > drm formats should keep their prefix, drm_fourcc.h can remain that
> > > > authority, it's all fine.
> > > >
> > > > Internally however, the long term goal is to share the fourcc's
> > > > between DRM and V4L2 for the same formats. It basically means that =
of
> > > > course v4l2 should be using the DRM fourcc when a format exists in =
DRM
> > > > and not v4l2, but also that DRM should use v4l2 fourcc when the for=
mat
> > > > exists in v4l2 but not DRM, and that is far more likely, given the
> > > > already extensive v4l2 formats support.
> > >
> > > Uh no. We did look at v4l fourcc extensively when deciding upon a drm
> > > format identifier space.
> >
> > No to what exactly?
> >
> > > And a lot of people pushed for the "fourcc is a standard", when
> > > really it's totally not.
> >
> > Even if it's not a standard, having consistency would be a good thing.
> >
> > And you said yourself that DRM fourcc is now pretty much an authority
> > for the fourcc, so it definitely looks like a standard to me.
>
> drm fourcc is the authority for drm fourcc codes. Not for any of the
> others (and there's lots of them). Now it's used in a bunch of other
> places (khr standards, dri protocols in wayland/X11), but they're
> still only drm fourcc. There is no overall fourcc standard.

Sounds like a de-facto standard to me =C2=AF\_(=E3=83=84)_/=C2=AF

But even then, whether we decide to converge the fourcc or not, that's
still the long term goal. Short term, that series doesn't do any of
it, it just makes it easier if we ever want to go down that road.

> > > v4l tends to conflate pixel format with stuff that we tend to encode
> > > in modifiers a lot more.
> >
> > Boris is working on adding the modifiers concept to v4l2, so we're
> > converging here, and we can totally have a layer in v4l2 to convert
> > between old v4l2 "format+modifiers" formats, and DRM style formats.
> >
> > > There's a bunch of reasons we can't just use v4l, and they're as
> > > valid as ever:
> > >
> > > - We overlap badly in some areas, so even if fourcc codes match, we
> > >   can't use them and need a duplicated DRM_FOURCC code.
> >
> > Do yo have an example of one of those areas?
>
> I think the rgb stuff was one of the big reasons to not reuse any
> existing fourcc standard (whether v4l, or another one from e.g. video
> container formats). We had initial patches to reuse the fourcc that
> existed, but the end result was really inconsistent, so we ditch that
> and rolled out a new set of entirely drm specific fourcc codes for
> rgba.

Ok, so let's ditch that plan and focus on the rest

> > > > And given how the current state is a mess in this regard, I'm not t=
oo
> > > > optimistic about keeping the formats in their relevant frameworks.
> > > >
> > > > Having a shared library, governed by both, will make this far easie=
r,
> > > > since it will be easy to discover the formats that are already
> > > > supported by the other subsystem.
> > >
> > > I think a compat library that (tries to, best effort) convert between
> > > v4l and drm fourcc would make sense. Somewhere in drivers/video, next
> > > to the conversion functions for videomode <-> drm_display_mode
> > > perhaps. That should be useful for drivers.
> >
> > That's not really what this series is about though. That series is
> > about sharing the (image|pixels) formats database across everyone so
> > that everyone can benefit from it.
>
> Yeah I know. I still think leaving the drm fourcc with the drm prefix
> would be good, since there's really no standard here.
>
> > > Unifying the formats themselves, and all the associated metadata is
> > > imo a no-go, and was a pretty conscious decision when we implemented
> > > drm_fourcc a few years back.
> > >
> > > > If we want to keep the current library in DRM, we have two options
> > > > then:
> > > >
> > > >   - Support all the v4l2 formats in the DRM library, which is
> > > >     essentially what I'm doing in the last patches. However, that
> > > >     would require to have the v4l2 developpers also reviewing stuff
> > > >     there. And given how busy they are, I cannot really see how that
> > > >     would work.
> > >
> > > Well, if we end up with a common library then yes we need cross
> > > review. There's no way around that. Doesn't matter where exactly that
> > > library is in the filesystem tree, and adding a special MAINTAINERS
> > > entry for anything related to fourcc (both drm and v4l) to make sure
> > > they get cross-posted is easy. No file renaming needed.
> >
> > That would create some governing issues as well. For example, if you
> > ever have a patch from one fourcc addition (that might or might not be
> > covered by v4l2), will you wait for any v4l2 developper to review it?
>
> None of this is fixed by code renaming or locations. Either way we
> need to figure that out.
>
> And yes part of the reasons for not moving this out of drm is that I'm
> not a fan of boutique trees for small stuff. If sharing means we need
> to split the drm_fourcc code and library out of drm trees, I'm not
> sure that's a good idea. We're already super liberal with merging
> anything through driver trees with acks, and integrating them quickly
> into drm-next. This would still be workable if v4l sends regular pull
> requests to drm-next (every 1-2 weeks, like the other big gpu trees
> do). If we can only sync up once per merge window with a shared
> boutique tree for formats only, life is going to be painful.

I don't get why we want to turn DRM into some kind of a black hole
that would pull everything. We don't have to, really. And at the same
time it carries the message that v4l2 is less important than DRM for
some reason, which I'm really not comfortable with.

And I don't really get why you're against this in the first
place. When you have some code in a single driver that would benefit
more driver, you create a helper and move it into the core.

In this case, we have some code used by a framework that more
framework could use, and we move it to a core-er place. How is that
different?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vbg2pzqpc3mg5r64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLhnJwAKCRDj7w1vZxhR
xfxkAQCcxN5lYYPsLywQ49OMZ9Mgp4m8SpBkmbDp7jP/5ggJQAD+LuNKoEcNWsk8
siunD1smnPOZ9u/jlSQ0FKb02pE0PQs=
=KBrr
-----END PGP SIGNATURE-----

--vbg2pzqpc3mg5r64--
