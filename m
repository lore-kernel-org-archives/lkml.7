Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C22C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA47220645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfDWQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:38:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58409 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfDWQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:38:51 -0400
X-Originating-IP: 93.29.109.196
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AEFF9C0007;
        Tue, 23 Apr 2019 16:38:46 +0000 (UTC)
Message-ID: <c08bf38bc50f0ee537e225a4d02223b31dd3598f.camel@bootlin.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Stone <daniel@fooishbar.org>,
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
        <linux-media@vger.kernel.org>
Date:   Tue, 23 Apr 2019 18:38:46 +0200
In-Reply-To: <CAPj87rOyX_6X-UbgPVrU-uGeeyqgTnp57UYD3QUJeiCWDfk9Kg@mail.gmail.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <20190417154121.GJ13337@phenom.ffwll.local>
         <20190418062229.eyog4i62eg4pr6uf@flea>
         <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
         <20190418090221.e57dogn4yx5nwdni@flea>
         <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
         <20190420225904.GZ4964@pendragon.ideasonboard.com>
         <20190423072554.GW13337@phenom.ffwll.local>
         <CAPj87rMWdjEvTJWRvdMLTZyw7pZpo5PpPr0FWcALNRe_D8cYqw@mail.gmail.com>
         <20190423155416.GI16111@pendragon.ideasonboard.com>
         <CAPj87rOyX_6X-UbgPVrU-uGeeyqgTnp57UYD3QUJeiCWDfk9Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 23 avril 2019 à 17:02 +0100, Daniel Stone a écrit :
> Hi Laurent,
> 
> On Tue, 23 Apr 2019 at 16:54, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Tue, Apr 23, 2019 at 09:59:37AM +0100, Daniel Stone wrote:
> > > On Tue, 23 Apr 2019 at 08:26, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > Totally. Let's take DRM_FORMAT_XRGB8888 + I915_FORMAT_MOD_Y_TILED as
> > > an example. [... details ...]
> > 
> > Looks like we have different kinds of metadata to consider. On the V4L2
> > side metadata usually refers to the context in which a frame was
> > captured, it doesn't tell how to interpret the contents of the pixels.
> > In the case you just described, the metadata is part of the frame
> > contents. I agree that this is a proper use case for storing such
> > metadata in a plane. What I wouldn't like to see being stored in a plane
> > is for instance gamma tables or similar data that configures the
> > processing pipeline in the display engine (I know we have an API for
> > gamma tables, this is just an example).
> > 
> > > It would be good to understand what you had in mind when you said that
> > > using multiple planes created a mess. I haven't touched media
> > > encode/decode units at a low level for quite a while (hooray for
> > > gst-v4l2!), but I remember that they often used padding areas around
> > > the buffer for scratch space - maybe motion vectors or similar? That
> > > case is quite different to something like CCS, since the data is only
> > > meaningful to the media engine and must be ignored (but preserved) by
> > > everyone else. Using multiple planes in that case isn't appropriate,
> > > since it's very specific to how that hardware unit deals with that
> > > buffer, instead of something that every consumer needs to understand
> > > in order to use it.
> > 
> > With metadata unrelated to the pixel content, using a separate plane in
> > the same buffer resulted in an explosion of the number of combinations
> > that we would need to support, and ultimately led to a very ill-defined
> > API. We decided to convey metadata related to the frame capture context
> > (e.g. what exposure time was used for the frame) and processing pipeline
> > configuration data in different buffers than the frame itself.
> 
> Yeah, that makes sense. It's not really that different from what
> happens with GPUs either: the final colour buffer the display
> controller gets from a game is the product of a _lot_ of other work
> which is invisible to the display controller, including things like
> depth and stencil buffers, command buffers, etc etc. Those are closely
> related to the frame production, but totally irrelevant for exchanging
> the colour buffer with other subsystems.
> 
> I think we should look at the metadata buffers you're describing in
> the same way. Perhaps each V4L2 buffer could have driver-private
> auxiliary buffer storage, or perhaps it's something you need to
> separately expose to userspace as auxiliary data which must be
> preserved but ignored. But modifiers are really only about what you
> need when exchanging image colour buffers between subsystems, not
> anything else.
> 
> You're pretty close with gamma tables as well; for HDR and other kinds
> of complex colour management, we need to carry a fair bit of auxiliary
> information in order to display the image correctly. These have quite
> different uses though: normally the colour buffer is produced by the
> hardware and the primaries/whitepoints/etc are produced by software,
> with the colour-management details remaining static across the life of
> a swapchain even as you flip between multiple buffers. Given that, it
> doesn't really make sense to try to stuff them into the same storage.

I agree that we need to keep things minimal and clearly distinguish
between what constitutes the description of the pixel buffer in terms
of how it's laid out in memory and information about how the data
should be interpreted.

And there's indeed a fair share of things to consider there. Adding to
the list above, I'm also thinking of the YUV colorspace information
which must be passed along when displaying a buffer.

But that's essentially not required to have a common description of
buffers unified accross subsystems. Thinking about that, it would be
interesting to have a common base structure for buffers used in v4l2
and drm. Ideally, that could be shared when doing dma-buf to avoid
having userspace describe buffers and memory each time a buffer is
imported into another subsystem. This could also help us solve the
ambiguity related to the YUV M-suffixed formats. Another idea could be
having common ioctls to get a unified buffer description from userspace
and e.g. mmap on a per-plane basis (with virtual mappings like DRM
does).

What do you think?

Cheers,

Paul

