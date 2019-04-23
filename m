Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF714C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BBC21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfDWOzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:55:31 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35323 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfDWOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:55:30 -0400
X-Originating-IP: 90.88.147.33
Received: from aptenodytes (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7805F1BF214;
        Tue, 23 Apr 2019 14:55:25 +0000 (UTC)
Message-ID: <96cf0927fa74eb91a6f110f43a21ddd3d8a7333a.camel@bootlin.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
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
Date:   Tue, 23 Apr 2019 16:55:24 +0200
In-Reply-To: <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
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
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2019-04-23 at 10:28 -0400, Nicolas Dufresne wrote:
> Le mardi 23 avril 2019 à 14:33 +0200, Paul Kocialkowski a écrit :
> > Hi,
> > 
> > On Tue, 2019-04-23 at 09:30 +0200, Daniel Vetter wrote:
> > > On Sun, Apr 21, 2019 at 01:40:45AM +0300, Laurent Pinchart wrote:
> > > > Hi Paul,
> > > > 
> > > > On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wrote:
> > > > > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > > > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > > > > > And a lot of people pushed for the "fourcc is a standard", when
> > > > > > > really it's totally not.
> > > > > > 
> > > > > > Even if it's not a standard, having consistency would be a good thing.
> > > > > > 
> > > > > > And you said yourself that DRM fourcc is now pretty much an authority
> > > > > > for the fourcc, so it definitely looks like a standard to me.
> > > > > 
> > > > > I think trying to make the V4L2 and DRM fourccs converge is a lost
> > > > > cause, as it has already significantly diverged. Even if we coordinate
> > > > > an effort to introduce new formats with the same fourcc on both sides,
> > > > > I don't see what good that would be since the formats we have now are
> > > > > still plagued by the inconsistency.
> > > > > 
> > > > > I think we always need an explicit translation step from either v4l2 or
> > > > > drm to the internal representation and back, without ever assuming that
> > > > > formats might be compatible because they share the same fourcc.
> > > > 
> > > > I don't agree. APIs evolve, and while we can't switch from one set of
> > > > 4CCs to another in existing APIs, we could in new APIs. Boris is working
> > > > on new ioctls to handle formats in V4L2, and while 4CC unification could
> > > > be impopular from a userspace developers point of view there, I don't
> > > > think we have ruled it out completely. The move to the request API is
> > > > also an area where a common set of 4CCs could be used, as it will depart
> > > > from the existing V4L2 ioctls. To summarize my opinion, we're not there
> > > > yet, but I wouldn't rule it out completely for the future.
> > > > 
> > > > > It looks like so far, V4L2 pixel formats describe a DRM pixel format +
> > > > > modifier.
> > > > 
> > > > DRM modifiers are mostly about tiling and compression, and we hardly
> > > > support these in V4L2. What are the modifiers you think are hardcoded in
> > > > 4CCs in V4L2 ?
> > > 
> > > Hm maybe it was a drm one that didn't come from v4l or anywhere else
> > > really, but the NV12MT one is nv12 + some tiling. I think we managed to
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
> 
> So all this to say that V4L2 equally needs supports for these.

Yes, I definitely agree with that.

> What I understood through DRM API is that a buffer allocated for let's say
> NV12 + mod, is compatible with linear NV12. That could be used to
> simplify some code, but at the same time, a common API that deals with
> the padding and alignment of each format + mod independently would do
> that same as long as this is not variable depending on which target HW
> uses that same format.
> 
> I think DRM + mod reduce the amount of dedicated formats that needs to
> be added, and simplify the documentation of each formats. I was looking
> at the Amlogic Axi configurations on Amlogic S905x recently, and for
> each well known format, there is a bitmask that let you do arbitrary
> swapping of bits, so effectively if we start exposing all these with
> V4L2 style, the list would become very long and hard to maintained.

The number of possible combinations is indeed much too high to have
them exposed as single V4L2 formats. Not to mention the VC4 tiling
modifiers where the column height is passed as an argument to the
modifier (so there is a modifier base and a variable part to it).

So I definitely agree that having a way to represent modifiers in V4L2
would be quite relevant and useful.

Cheers,

Paul

> > > -Daniel
> > > 
> > > > > I think Boris (CCed) is working to change that by allowing to
> > > > > pass a DRM modifier through V4L2. With that, we'd be in a situation
> > > > > where some formats are described by the v4l2 pixfmt alone and some
> > > > > formats are also described a modifier (but I looked at it from a
> > > > > distance so might have misunderstod). That feels better since it avoids
> > > > > the combinatory explosion from describing each format + modifier
> > > > > individually.
> > > > > 
> > > > > What do you think?
> > > > > 
> > > > > > > v4l tends to conflate pixel format with stuff that we tend to encode
> > > > > > > in modifiers a lot more.
> > > > > > 
> > > > > > Boris is working on adding the modifiers concept to v4l2, so we're
> > > > > > converging here, and we can totally have a layer in v4l2 to convert
> > > > > > between old v4l2 "format+modifiers" formats, and DRM style formats.
> > > > > > 
> > > > > > > There's a bunch of reasons we can't just use v4l, and they're as
> > > > > > > valid as ever:
> > > > > > > 
> > > > > > > - We overlap badly in some areas, so even if fourcc codes match, we
> > > > > > >   can't use them and need a duplicated DRM_FOURCC code.
> > > > > > 
> > > > > > Do yo have an example of one of those areas?
> > > > > > 
> > > > > > > - v4l encodes some metadata into the fourcc that we encode elsewhere,
> > > > > > >   e.g. offset for planar yuv formats, or tiling mode
> > > > > > 
> > > > > > As I was saying, this changes on the v4l2 side, and converging to
> > > > > > what DRM is doing.
> > > > > > 
> > > > > > > - drm fourcc code doesn't actually define the drm_format_info
> > > > > > >   uniquely, drivers can override that (that's an explicit design
> > > > > > >   intent of modifiers, to allow drivers to add another plane for
> > > > > > >   e.g. compression information). You'd need to pull that driver
> > > > > > >   knowledge into your format library.
> > > > > > 
> > > > > > I'm not sure how my patches are changing anything here. This is
> > > > > > litterally the same code, with the functions renamed.
> > > > > > 
> > > > > > If drivers want to override that, then yeah, fine, we can let them do
> > > > > > that. Just like any helper this just provides a default that covers
> > > > > > most of the cases.
> > > > > > 
> > > > > > > Iow there's no way we can easily adopt v4l fourcc, except if we do
> > > > > > > something like a new addfb flag.
> > > > > > 
> > > > > > For the formats that would be described as a modifier, sure. For all
> > > > > > the others (that are not yet supported by DRM), then I don't really
> > > > > > see why not.
> > > > > > 
> > > > > > > > And given how the current state is a mess in this regard, I'm not too
> > > > > > > > optimistic about keeping the formats in their relevant frameworks.
> > > > > > > > 
> > > > > > > > Having a shared library, governed by both, will make this far easier,
> > > > > > > > since it will be easy to discover the formats that are already
> > > > > > > > supported by the other subsystem.
> > > > > > > 
> > > > > > > I think a compat library that (tries to, best effort) convert between
> > > > > > > v4l and drm fourcc would make sense. Somewhere in drivers/video, next
> > > > > > > to the conversion functions for videomode <-> drm_display_mode
> > > > > > > perhaps. That should be useful for drivers.
> > > > > > 
> > > > > > That's not really what this series is about though. That series is
> > > > > > about sharing the (image|pixels) formats database across everyone so
> > > > > > that everyone can benefit from it.
> > > > > > 
> > > > > > > Unifying the formats themselves, and all the associated metadata is
> > > > > > > imo a no-go, and was a pretty conscious decision when we implemented
> > > > > > > drm_fourcc a few years back.
> > > > > > > 
> > > > > > > > If we want to keep the current library in DRM, we have two options
> > > > > > > > then:
> > > > > > > > 
> > > > > > > >   - Support all the v4l2 formats in the DRM library, which is
> > > > > > > >     essentially what I'm doing in the last patches. However, that
> > > > > > > >     would require to have the v4l2 developpers also reviewing stuff
> > > > > > > >     there. And given how busy they are, I cannot really see how that
> > > > > > > >     would work.
> > > > > > > 
> > > > > > > Well, if we end up with a common library then yes we need cross
> > > > > > > review. There's no way around that. Doesn't matter where exactly that
> > > > > > > library is in the filesystem tree, and adding a special MAINTAINERS
> > > > > > > entry for anything related to fourcc (both drm and v4l) to make sure
> > > > > > > they get cross-posted is easy. No file renaming needed.
> > > > > > 
> > > > > > That would create some governing issues as well. For example, if you
> > > > > > ever have a patch from one fourcc addition (that might or might not be
> > > > > > covered by v4l2), will you wait for any v4l2 developper to review it?
> > > > > > 
> > > > > > If it's shared code, then it should be shared, and every client
> > > > > > framework put on an equal footing.
> > > > > > 
> > > > > > > >   - Develop the same library from within v4l2. That is really a poor
> > > > > > > >     solution, since the information would be greatly duplicated
> > > > > > > >     between the two, and in terms of maintainance, code, and binary
> > > > > > > >     size that would be duplicated too.
> > > > > > > 
> > > > > > > It's essentially what we decided to do for drm years back.
> > > > > > 
> > > > > > And it was probably the right solution back then, but I'm really not
> > > > > > convinced it's still the right thing to do today.
> > > > > > 
> > > > > > > > Having it shared allows to easily share, and discover formats from the
> > > > > > > > other subsystem, and to have a single, unique place where this is
> > > > > > > > centralized.
> > > > > > > 
> > > > > > > What I think could work as middle ground:
> > > > > > > - Put drm_format stuff into a separate .ko
> > > > > > > - Add a MAINTAINERS entry to make sure all things fourcc are cross
> > > > > > > posted to both drm and v4l lists. Easy on the drm side, since it's all
> > > > > > > separate files. Not sure it's so convenient for v4l uapi.
> > > > > > > - Add a conversion library that tries to best-effort map between drm
> > > > > > > and v4l formats. On the drm side that most likely means you need
> > > > > > > offsets for planes, and modifiers too (since those are implied in some
> > > > > > > v4l fourcc). Emphasis on "best effort" i.e. only support as much as
> > > > > > > the drivers that use this library need.
> > > > > > > - Add drm_fourcc as-needed by these drivers that want to use a unified
> > > > > > > format space.
> > > > > > > 
> > > > > > > Forcing this unification on everyone otoh is imo way too much.
> > > > > > 
> > > > > > v4l2 is starting to converge with DRM, and we're using the DRM API
> > > > > > pretty much untouched for that library, so I'm not really sure how
> > > > > > anyone is hurt by that unification.
> > > > 
> > > > -- 
> > > > Regards,
> > > > 
> > > > Laurent Pinchart
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

