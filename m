Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7552183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfDRLuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:50:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55035 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:49:59 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9D056E0006;
        Thu, 18 Apr 2019 11:49:54 +0000 (UTC)
Message-ID: <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Date:   Thu, 18 Apr 2019 13:49:54 +0200
In-Reply-To: <20190418090221.e57dogn4yx5nwdni@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <20190417154121.GJ13337@phenom.ffwll.local>
         <20190418062229.eyog4i62eg4pr6uf@flea>
         <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
         <20190418090221.e57dogn4yx5nwdni@flea>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > And a lot of people pushed for the "fourcc is a standard", when
> > really it's totally not.
> 
> Even if it's not a standard, having consistency would be a good thing.
> 
> And you said yourself that DRM fourcc is now pretty much an authority
> for the fourcc, so it definitely looks like a standard to me.

I think trying to make the V4L2 and DRM fourccs converge is a lost
cause, as it has already significantly diverged. Even if we coordinate
an effort to introduce new formats with the same fourcc on both sides,
I don't see what good that would be since the formats we have now are
still plagued by the inconsistency.

I think we always need an explicit translation step from either v4l2 or
drm to the internal representation and back, without ever assuming that
formats might be compatible because they share the same fourcc.

It looks like so far, V4L2 pixel formats describe a DRM pixel format +
modifier. I think Boris (CCed) is working to change that by allowing to
pass a DRM modifier through V4L2. With that, we'd be in a situation
where some formats are described by the v4l2 pixfmt alone and some
formats are also described a modifier (but I looked at it from a
distance so might have misunderstod). That feels better since it avoids
the combinatory explosion from describing each format + modifier
individually.

What do you think?

Cheers,

Paul

> > v4l tends to conflate pixel format with stuff that we tend to encode
> > in modifiers a lot more.
> 
> Boris is working on adding the modifiers concept to v4l2, so we're
> converging here, and we can totally have a layer in v4l2 to convert
> between old v4l2 "format+modifiers" formats, and DRM style formats.
> 
> > There's a bunch of reasons we can't just use v4l, and they're as
> > valid as ever:
> > 
> > - We overlap badly in some areas, so even if fourcc codes match, we
> >   can't use them and need a duplicated DRM_FOURCC code.
> 
> Do yo have an example of one of those areas?
> 
> > - v4l encodes some metadata into the fourcc that we encode elsewhere,
> >   e.g. offset for planar yuv formats, or tiling mode
> 
> As I was saying, this changes on the v4l2 side, and converging to
> what DRM is doing.
> 
> > - drm fourcc code doesn't actually define the drm_format_info
> >   uniquely, drivers can override that (that's an explicit design
> >   intent of modifiers, to allow drivers to add another plane for
> >   e.g. compression information). You'd need to pull that driver
> >   knowledge into your format library.
> 
> I'm not sure how my patches are changing anything here. This is
> litterally the same code, with the functions renamed.
> 
> If drivers want to override that, then yeah, fine, we can let them do
> that. Just like any helper this just provides a default that covers
> most of the cases.
> 
> > Iow there's no way we can easily adopt v4l fourcc, except if we do
> > something like a new addfb flag.
> 
> For the formats that would be described as a modifier, sure. For all
> the others (that are not yet supported by DRM), then I don't really
> see why not.
> 
> > > And given how the current state is a mess in this regard, I'm not too
> > > optimistic about keeping the formats in their relevant frameworks.
> > > 
> > > Having a shared library, governed by both, will make this far easier,
> > > since it will be easy to discover the formats that are already
> > > supported by the other subsystem.
> > 
> > I think a compat library that (tries to, best effort) convert between
> > v4l and drm fourcc would make sense. Somewhere in drivers/video, next
> > to the conversion functions for videomode <-> drm_display_mode
> > perhaps. That should be useful for drivers.
> 
> That's not really what this series is about though. That series is
> about sharing the (image|pixels) formats database across everyone so
> that everyone can benefit from it.
> 
> > Unifying the formats themselves, and all the associated metadata is
> > imo a no-go, and was a pretty conscious decision when we implemented
> > drm_fourcc a few years back.
> > 
> > > If we want to keep the current library in DRM, we have two options
> > > then:
> > > 
> > >   - Support all the v4l2 formats in the DRM library, which is
> > >     essentially what I'm doing in the last patches. However, that
> > >     would require to have the v4l2 developpers also reviewing stuff
> > >     there. And given how busy they are, I cannot really see how that
> > >     would work.
> > 
> > Well, if we end up with a common library then yes we need cross
> > review. There's no way around that. Doesn't matter where exactly that
> > library is in the filesystem tree, and adding a special MAINTAINERS
> > entry for anything related to fourcc (both drm and v4l) to make sure
> > they get cross-posted is easy. No file renaming needed.
> 
> That would create some governing issues as well. For example, if you
> ever have a patch from one fourcc addition (that might or might not be
> covered by v4l2), will you wait for any v4l2 developper to review it?
> 
> If it's shared code, then it should be shared, and every client
> framework put on an equal footing.
> 
> > >   - Develop the same library from within v4l2. That is really a poor
> > >     solution, since the information would be greatly duplicated
> > >     between the two, and in terms of maintainance, code, and binary
> > >     size that would be duplicated too.
> > 
> > It's essentially what we decided to do for drm years back.
> 
> And it was probably the right solution back then, but I'm really not
> convinced it's still the right thing to do today.
> 
> > > Having it shared allows to easily share, and discover formats from the
> > > other subsystem, and to have a single, unique place where this is
> > > centralized.
> > 
> > What I think could work as middle ground:
> > - Put drm_format stuff into a separate .ko
> > - Add a MAINTAINERS entry to make sure all things fourcc are cross
> > posted to both drm and v4l lists. Easy on the drm side, since it's all
> > separate files. Not sure it's so convenient for v4l uapi.
> > - Add a conversion library that tries to best-effort map between drm
> > and v4l formats. On the drm side that most likely means you need
> > offsets for planes, and modifiers too (since those are implied in some
> > v4l fourcc). Emphasis on "best effort" i.e. only support as much as
> > the drivers that use this library need.
> > - Add drm_fourcc as-needed by these drivers that want to use a unified
> > format space.
> > 
> > Forcing this unification on everyone otoh is imo way too much.
> 
> v4l2 is starting to converge with DRM, and we're using the DRM API
> pretty much untouched for that library, so I'm not really sure how
> anyone is hurt by that unification.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

