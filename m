Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E05C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7BE2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfDRJC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:02:27 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48489 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfDRJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:02:26 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2FE5A4002A;
        Thu, 18 Apr 2019 09:02:22 +0000 (UTC)
Date:   Thu, 18 Apr 2019 11:02:21 +0200
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
Message-ID: <20190418090221.e57dogn4yx5nwdni@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
 <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ku5lnx6rytxcw6t4"
Content-Disposition: inline
In-Reply-To: <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ku5lnx6rytxcw6t4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> On Thu, Apr 18, 2019 at 8:22 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Wed, Apr 17, 2019 at 05:41:21PM +0200, Daniel Vetter wrote:
> > > On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >
> > > > DRM comes with an extensive format support to retrieve the various
> > > > parameters associated with a given format (such as the subsampling, or the
> > > > bits per pixel), as well as some helpers and utilities to ease the driver
> > > > development.
> > > >
> > > > v4l2, on the other side, doesn't provide such facilities, leaving each
> > > > driver reimplement a subset of the formats parameters for the one supported
> > > > by that particular driver. This leads to a lot of duplication and
> > > > boilerplate code in the v4l2 drivers.
> > > >
> > > > This series tries to address this by moving the DRM format API into lib and
> > > > turning it into a more generic API. In order to do this, we've needed to do
> > > > some preliminary changes on the DRM drivers, then moved the API and finally
> > > > converted a v4l2 driver to give an example of how such library could be
> > > > used.
> > > >
> > > > Let me know what you think,
> > > > Maxime
> > > >
> > > > Changes from RFC:
> > > >   - Rebased on next
> > > >   - Fixed the various formats mapping
> > > >   - Added tags
> > > >   - Did most of the formats functions as inline functions
> > > >   - Used a consistent prefix for all the utilities functions
> > > >   - Fixed the compilation breakages, and did a run of allmodconfig for arm,
> > > >     arm64 and x86_64
> > > >   - Fixed out of array bounds warnings in the image_format_info_block_*
> > > >     functions
> > > >   - Added License and copyright headers on missing files
> > > >
> > > > Maxime Ripard (20):
> > > >   drm: Remove users of drm_format_num_planes
> > > >   drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
> > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
> > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
> > > >   drm: Replace instances of drm_format_info by drm_get_format_info
> > > >   lib: Add video format information library
> > > >   drm/fb: Move from drm_format_info to image_format_info
> > > >   drm/malidp: Convert to generic image format library
> > > >   drm/client: Convert to generic image format library
> > > >   drm/exynos: Convert to generic image format library
> > > >   drm/i915: Convert to generic image format library
> > > >   drm/ipuv3: Convert to generic image format library
> > > >   drm/msm: Convert to generic image format library
> > > >   drm/omap: Convert to generic image format library
> > > >   drm/rockchip: Convert to generic image format library
> > > >   drm/tegra: Convert to generic image format library
> > > >   drm/fourcc: Remove old DRM format API
> > > >   lib: image-formats: Add v4l2 formats support
> > > >   lib: image-formats: Add more functions
> > > >   media: sun6i: Convert to the image format API
> > >
> > > In the interest of making myself unpopular: Why move this out of drm?
> > >
> > > We do have a bunch of other such shared helpers already (mostly in
> > > drivers/video) for dt videomode and hdmi infoframes, and I'm not super
> > > sure that's going better than keeping it maintained in drm.
> > >
> > > Plus the uapi is already that you include drm_fourcc.h to get at these,
> > > dropping the drm prefix isn't going to help I think.
> > >
> > > Of course we'd need to make it a separate drm_formats.ko (so that v4l can
> > > use it without dragging in all of drm), and we need to add some fields for
> > > converting to v4l fourcc codes (which are different). But that should be
> > > all possible. And I don't think the drm_ prefix in v4l code is a problem,
> > > it's actually a feature: It makes it really clear that these are the drm
> > > fourcc codes, as allocated in drm_fourcc.h, plus their modifiers, and all
> > > that. That allocation authority is also already baked into various khr/ext
> > > standards, too.
> >
> > The way I see it, there's a fundamental difference between the UAPI
> > and the kernel. I don't suggest we change anything about the UAPI: the
> > drm formats should keep their prefix, drm_fourcc.h can remain that
> > authority, it's all fine.
> >
> > Internally however, the long term goal is to share the fourcc's
> > between DRM and V4L2 for the same formats. It basically means that of
> > course v4l2 should be using the DRM fourcc when a format exists in DRM
> > and not v4l2, but also that DRM should use v4l2 fourcc when the format
> > exists in v4l2 but not DRM, and that is far more likely, given the
> > already extensive v4l2 formats support.
>
> Uh no. We did look at v4l fourcc extensively when deciding upon a drm
> format identifier space.

No to what exactly?

> And a lot of people pushed for the "fourcc is a standard", when
> really it's totally not.

Even if it's not a standard, having consistency would be a good thing.

And you said yourself that DRM fourcc is now pretty much an authority
for the fourcc, so it definitely looks like a standard to me.

> v4l tends to conflate pixel format with stuff that we tend to encode
> in modifiers a lot more.

Boris is working on adding the modifiers concept to v4l2, so we're
converging here, and we can totally have a layer in v4l2 to convert
between old v4l2 "format+modifiers" formats, and DRM style formats.

> There's a bunch of reasons we can't just use v4l, and they're as
> valid as ever:
>
> - We overlap badly in some areas, so even if fourcc codes match, we
>   can't use them and need a duplicated DRM_FOURCC code.

Do yo have an example of one of those areas?

> - v4l encodes some metadata into the fourcc that we encode elsewhere,
>   e.g. offset for planar yuv formats, or tiling mode

As I was saying, this changes on the v4l2 side, and converging to
what DRM is doing.

> - drm fourcc code doesn't actually define the drm_format_info
>   uniquely, drivers can override that (that's an explicit design
>   intent of modifiers, to allow drivers to add another plane for
>   e.g. compression information). You'd need to pull that driver
>   knowledge into your format library.

I'm not sure how my patches are changing anything here. This is
litterally the same code, with the functions renamed.

If drivers want to override that, then yeah, fine, we can let them do
that. Just like any helper this just provides a default that covers
most of the cases.

> Iow there's no way we can easily adopt v4l fourcc, except if we do
> something like a new addfb flag.

For the formats that would be described as a modifier, sure. For all
the others (that are not yet supported by DRM), then I don't really
see why not.

> > And given how the current state is a mess in this regard, I'm not too
> > optimistic about keeping the formats in their relevant frameworks.
> >
> > Having a shared library, governed by both, will make this far easier,
> > since it will be easy to discover the formats that are already
> > supported by the other subsystem.
>
> I think a compat library that (tries to, best effort) convert between
> v4l and drm fourcc would make sense. Somewhere in drivers/video, next
> to the conversion functions for videomode <-> drm_display_mode
> perhaps. That should be useful for drivers.

That's not really what this series is about though. That series is
about sharing the (image|pixels) formats database across everyone so
that everyone can benefit from it.

> Unifying the formats themselves, and all the associated metadata is
> imo a no-go, and was a pretty conscious decision when we implemented
> drm_fourcc a few years back.
>
> > If we want to keep the current library in DRM, we have two options
> > then:
> >
> >   - Support all the v4l2 formats in the DRM library, which is
> >     essentially what I'm doing in the last patches. However, that
> >     would require to have the v4l2 developpers also reviewing stuff
> >     there. And given how busy they are, I cannot really see how that
> >     would work.
>
> Well, if we end up with a common library then yes we need cross
> review. There's no way around that. Doesn't matter where exactly that
> library is in the filesystem tree, and adding a special MAINTAINERS
> entry for anything related to fourcc (both drm and v4l) to make sure
> they get cross-posted is easy. No file renaming needed.

That would create some governing issues as well. For example, if you
ever have a patch from one fourcc addition (that might or might not be
covered by v4l2), will you wait for any v4l2 developper to review it?

If it's shared code, then it should be shared, and every client
framework put on an equal footing.

> >   - Develop the same library from within v4l2. That is really a poor
> >     solution, since the information would be greatly duplicated
> >     between the two, and in terms of maintainance, code, and binary
> >     size that would be duplicated too.
>
> It's essentially what we decided to do for drm years back.

And it was probably the right solution back then, but I'm really not
convinced it's still the right thing to do today.

> > Having it shared allows to easily share, and discover formats from the
> > other subsystem, and to have a single, unique place where this is
> > centralized.
>
> What I think could work as middle ground:
> - Put drm_format stuff into a separate .ko
> - Add a MAINTAINERS entry to make sure all things fourcc are cross
> posted to both drm and v4l lists. Easy on the drm side, since it's all
> separate files. Not sure it's so convenient for v4l uapi.
> - Add a conversion library that tries to best-effort map between drm
> and v4l formats. On the drm side that most likely means you need
> offsets for planes, and modifiers too (since those are implied in some
> v4l fourcc). Emphasis on "best effort" i.e. only support as much as
> the drivers that use this library need.
> - Add drm_fourcc as-needed by these drivers that want to use a unified
> format space.
>
> Forcing this unification on everyone otoh is imo way too much.

v4l2 is starting to converge with DRM, and we're using the DRM API
pretty much untouched for that library, so I'm not really sure how
anyone is hurt by that unification.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ku5lnx6rytxcw6t4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLg9HQAKCRDj7w1vZxhR
xXrZAQCjuV6O3ycJjy50aJ8yIJ4Cwi43TE8JopBxsc3crmtshwEAmBT1lc+Cr1z0
6qm5zgN8iKw0cXvRWAQP8LqZU91gkwA=
=00aT
-----END PGP SIGNATURE-----

--ku5lnx6rytxcw6t4--
