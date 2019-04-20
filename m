Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5DC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D422186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 22:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="guu2cSnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfDTW7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 18:59:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57380 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDTW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 18:59:17 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 684CB5F;
        Sun, 21 Apr 2019 00:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555801153;
        bh=w2pL8ZP2Zhgt2aL0B0gmYOBk0RROsYuBshyB1Tp6kHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guu2cSnLVi0zd846snvFP12rC+GsIGh82ymqEVEp31KKA0uazTFUdAZ8kAMzNgBA7
         WbPWlhMdbag+z8KJGfV3Ykd8PmY87HHD8O8sWwRPzDhgI7IzPNlA99Ofn/Ex4UcFD+
         NIK2ra4p6juGODfhxC6JyGxmtiFKGhewJobkdi3k=
Date:   Sun, 21 Apr 2019 01:59:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
Message-ID: <20190420225904.GZ4964@pendragon.ideasonboard.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
 <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea>
 <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Apr 18, 2019 at 12:07:44PM +0200, Daniel Vetter wrote:
> On Thu, Apr 18, 2019 at 11:02 AM Maxime Ripard wrote:
> > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > On Thu, Apr 18, 2019 at 8:22 AM Maxime Ripard wrote:
> > > > On Wed, Apr 17, 2019 at 05:41:21PM +0200, Daniel Vetter wrote:
> > > > > On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
> > > > > > Hi,
> > > > > >
> > > > > > DRM comes with an extensive format support to retrieve the various
> > > > > > parameters associated with a given format (such as the subsampling, or the
> > > > > > bits per pixel), as well as some helpers and utilities to ease the driver
> > > > > > development.
> > > > > >
> > > > > > v4l2, on the other side, doesn't provide such facilities, leaving each
> > > > > > driver reimplement a subset of the formats parameters for the one supported
> > > > > > by that particular driver. This leads to a lot of duplication and
> > > > > > boilerplate code in the v4l2 drivers.
> > > > > >
> > > > > > This series tries to address this by moving the DRM format API into lib and
> > > > > > turning it into a more generic API. In order to do this, we've needed to do
> > > > > > some preliminary changes on the DRM drivers, then moved the API and finally
> > > > > > converted a v4l2 driver to give an example of how such library could be
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
> > > > > >   - Fixed the compilation breakages, and did a run of allmodconfig for arm,
> > > > > >     arm64 and x86_64
> > > > > >   - Fixed out of array bounds warnings in the image_format_info_block_*
> > > > > >     functions
> > > > > >   - Added License and copyright headers on missing files
> > > > > >
> > > > > > Maxime Ripard (20):
> > > > > >   drm: Remove users of drm_format_num_planes
> > > > > >   drm: Remove users of drm_format_(horz|vert)_chroma_subsampling
> > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_cpp
> > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plane_width/height
> > > > > >   drm: Replace instances of drm_format_info by drm_get_format_info
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
> > > > > In the interest of making myself unpopular: Why move this out of drm?
> > > > >
> > > > > We do have a bunch of other such shared helpers already (mostly in
> > > > > drivers/video) for dt videomode and hdmi infoframes, and I'm not super
> > > > > sure that's going better than keeping it maintained in drm.

That's a bit of a different situation as both DRM and FBDEV address the
same features (display output), and FBDEV is deprecared and replaced by
DRM.

I'm not against maintaining a 4CC library in DRM (adding a third-party
maintainer would likely create more problems than it would solve), but
that doesn't mean the library has to live in drivers/gpu/, nor that it
needs to have the drm_ prefix. I would actually advocate to make it live
in a neutral directory, with a neutral prefix (kudos to anyone who can
propose a nice naming convention that would establish a new shared
ground for image/video-related Linux APIs), and maintained through the
DRM tree (possibly with extra entries in MAINTAINERS to ensure it
reaches all the related folks).

> > > > > Plus the uapi is already that you include drm_fourcc.h to get at these,
> > > > > dropping the drm prefix isn't going to help I think.
> > > > >
> > > > > Of course we'd need to make it a separate drm_formats.ko (so that v4l can
> > > > > use it without dragging in all of drm), and we need to add some fields for
> > > > > converting to v4l fourcc codes (which are different). But that should be
> > > > > all possible. And I don't think the drm_ prefix in v4l code is a problem,
> > > > > it's actually a feature: It makes it really clear that these are the drm
> > > > > fourcc codes, as allocated in drm_fourcc.h, plus their modifiers, and all
> > > > > that. That allocation authority is also already baked into various khr/ext
> > > > > standards, too.

There's one thing that V4L2 has and DRM hasn't for 4CCs: good
documentation. Look at
https://linuxtv.org/downloads/v4l-dvb-apis-new/uapi/v4l/pixfmt-packed-rgb.html
or
https://linuxtv.org/downloads/v4l-dvb-apis-new/uapi/v4l/yuv-formats.html
for instance. It's painful to write, painful to read, but defines the
4CCs very clearly without ambiguity. I wouldn't be surprised if
different drivers used the same DRM 4CC for different formats due to the
lack of detailed documentation. Moving to a shared library for 4CCs
should also address the documentation side, and any new format added to
the kernel, whether from the V4L2 side or the DRM side, would be
required to provide detailed documentation. That would be a great
improvement for DRM 4CC handling.

> > > > The way I see it, there's a fundamental difference between the UAPI
> > > > and the kernel. I don't suggest we change anything about the UAPI: the
> > > > drm formats should keep their prefix, drm_fourcc.h can remain that
> > > > authority, it's all fine.
> > > >
> > > > Internally however, the long term goal is to share the fourcc's
> > > > between DRM and V4L2 for the same formats. It basically means that of
> > > > course v4l2 should be using the DRM fourcc when a format exists in DRM
> > > > and not v4l2, but also that DRM should use v4l2 fourcc when the format
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
> 
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

Could you give one or a couple of examples of V4L2 4CCs that are not
OCD-compatible ? :-)

> > > - v4l encodes some metadata into the fourcc that we encode elsewhere,
> > >   e.g. offset for planar yuv formats, or tiling mode
> >
> > As I was saying, this changes on the v4l2 side, and converging to
> > what DRM is doing.
> >
> > > - drm fourcc code doesn't actually define the drm_format_info
> > >   uniquely, drivers can override that (that's an explicit design
> > >   intent of modifiers, to allow drivers to add another plane for
> > >   e.g. compression information). You'd need to pull that driver
> > >   knowledge into your format library.

That's a mistake in my opinion. We tried that in V4L2 to store metadata
in a separate plane, and had to go another route eventually as it
created a very bad mess.

There's a tendency in both subsystems to look at the other as a bit of a
retarded relative, and that's a shame, we have lots to learn from each
other's mistakes. That wouldn't be too difficult if people started
talking to each other.

A semi-related comment: DRM also carries other mistakes of its own, I'm
thinking about DRM_FORMAT_BIG_ENDIAN in particular

> > I'm not sure how my patches are changing anything here. This is
> > litterally the same code, with the functions renamed.
> >
> > If drivers want to override that, then yeah, fine, we can let them do
> > that. Just like any helper this just provides a default that covers
> > most of the cases.
> >
> > > Iow there's no way we can easily adopt v4l fourcc, except if we do
> > > something like a new addfb flag.
> >
> > For the formats that would be described as a modifier, sure. For all
> > the others (that are not yet supported by DRM), then I don't really
> > see why not.
> 
> See above, we tried that initially, didn't pass the ocd tests when
> reviewing. Maybe the situation is better outside of rbgx/a formats,
> and I think we do at least try to use the same fourcc codes there when
> there already is one. But then the details occasionally look
> different.
> 
> > > > And given how the current state is a mess in this regard, I'm not too
> > > > optimistic about keeping the formats in their relevant frameworks.
> > > >
> > > > Having a shared library, governed by both, will make this far easier,
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

That should be solved by the proposal above, maintaining the shared
library in the DRM tree. We would need to be careful there, and ideally
maintain that in a separate branch that could be merged in both DRM and
V4L2 without having to merge most of the other subsystem's pending
changes at the same time, but I think it's doable without any big issue.

> > If it's shared code, then it should be shared, and every client
> > framework put on an equal footing.
> >
> > > >   - Develop the same library from within v4l2. That is really a poor
> > > >     solution, since the information would be greatly duplicated
> > > >     between the two, and in terms of maintainance, code, and binary
> > > >     size that would be duplicated too.
> > >
> > > It's essentially what we decided to do for drm years back.
> >
> > And it was probably the right solution back then, but I'm really not
> > convinced it's still the right thing to do today.
> >
> > > > Having it shared allows to easily share, and discover formats from the
> > > > other subsystem, and to have a single, unique place where this is
> > > > centralized.
> > >
> > > What I think could work as middle ground:
> > > - Put drm_format stuff into a separate .ko
> > > - Add a MAINTAINERS entry to make sure all things fourcc are cross
> > > posted to both drm and v4l lists. Easy on the drm side, since it's all
> > > separate files. Not sure it's so convenient for v4l uapi.
> > > - Add a conversion library that tries to best-effort map between drm
> > > and v4l formats. On the drm side that most likely means you need
> > > offsets for planes, and modifiers too (since those are implied in some
> > > v4l fourcc). Emphasis on "best effort" i.e. only support as much as
> > > the drivers that use this library need.
> > > - Add drm_fourcc as-needed by these drivers that want to use a unified
> > > format space.
> > >
> > > Forcing this unification on everyone otoh is imo way too much.
> >
> > v4l2 is starting to converge with DRM, and we're using the DRM API
> > pretty much untouched for that library, so I'm not really sure how
> > anyone is hurt by that unification.
> 
> It might make sense to regularly pull v4l updates into drm-next then
> anyway. That would also remove the need to have the format library
> somewhere else.

Are you saying it should the live in V4L2 ? ;-)

-- 
Regards,

Laurent Pinchart
