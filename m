Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5659C2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfDRIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:55:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37563 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfDRIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:55:00 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1BC5240007;
        Thu, 18 Apr 2019 08:54:54 +0000 (UTC)
Message-ID: <522d6a7734a29df47fe11f5f6311b49e14dabae0.camel@bootlin.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Thu, 18 Apr 2019 10:54:54 +0200
In-Reply-To: <20190418081816.GO13337@phenom.ffwll.local>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 2019-04-18 at 10:18 +0200, Daniel Vetter wrote:
> On Wed, Apr 17, 2019 at 08:10:15PM +0200, Paul Kocialkowski wrote:
> > Hi Nicolas,
> > 
> > I'm detaching this thread from our V4L2 stateless decoding spec since
> > it has drifted off and would certainly be interesting to DRM folks as
> > well!
> > 
> > For context: I was initially talking about writing up support for the
> > Allwinner 2D engine as a DRM render driver, where I'd like to be able
> > to batch jobs that affect the same destination buffer to only signal
> > the out fence once when the batch is done. We have a similar issue in
> > v4l2 where we'd like the destination buffer for a set of requests (each
> > covering one H264 slice) to be marked as done once the set was decoded.
> > 
> > Le mercredi 17 avril 2019 à 12:22 -0400, Nicolas Dufresne a écrit :
> > > > > > Interestingly, I'm experiencing the exact same problem dealing with a
> > > > > > 2D graphics blitter that has limited ouput scaling abilities which
> > > > > > imply handlnig a large scaling operation as multiple clipped smaller
> > > > > > scaling operations. The issue is basically that multiple jobs have to
> > > > > > be submitted to complete a single frame and relying on an indication
> > > > > > from the destination buffer (such as a fence) doesn't work to indicate
> > > > > > that all the operations were completed, since we get the indication at
> > > > > > each step instead of at the end of the batch.
> > > > > 
> > > > > That looks similar to the IMX.6 IPU m2m driver. It splits the image in
> > > > > tiles of 1024x1024 and process each tile separately. This driver has
> > > > > been around for a long time, so I guess they have a solution to that.
> > > > > They don't need requests, because there is nothing to be bundled with
> > > > > the input image. I know that Renesas folks have started working on a
> > > > > de-interlacer. Again, this kind of driver may process and reuse input
> > > > > buffers for motion compensation, but I don't think they need special
> > > > > userspace API for that.
> > > > 
> > > > Thanks for the reference! I hope it's not a blitter that was
> > > > contributed as a V4L2 driver instead of DRM, as it probably would be
> > > > more useful in DRM (but that's way beside the point).
> > > 
> > > DRM does not offer a generic and discoverable interface for these
> > > accelerators. Note that these drivers have most of the time started as
> > > DRM driver and their DRM side where dropped. That was the case for
> > > Exynos drivers at least.
> > 
> > Heh, sadly I'm aware of how things turn out most of the time. The thing
> > is that DRM expects drivers to implement their own interface. That's
> > fine for passing BOs with GPU bitstream and textures, but not so much
> > for dealing with framebuffer-based operations where the streaming and
> > buffer interface that v4l2 has is a good fit.
> > 
> > There's also the fact that the 2D pipeline is fixed-function and highly
> > hardware-specific, so we need driver-specific job descriptions to
> > really make the most of it. That's where v4l2 is not much of a good fit
> > for complex 2D pipelines either. Most 2D engines can take multiple
> > inputs and blit them together in various ways, which is too far from
> > what v4l2 deals with. So we can have fixed single-buffer pipelines with
> > at best CSC and scaling, but not much more with v4l2 really.
> > 
> > I don't think it would be too much work to bring an interface to DRM in
> > order to describe render framebuffers (we only have display
> > framebuffers so far), with a simple queuing interface for scheduling
> > driver-specific jobs, which could be grouped together to only signal
> > the out fences when every buffer of the batch was done being rendered.
> > This last point would allow handling cases where userapce need to
> > perform multiple operations to carry out the single operation that it
> > needs to do. In the case of my 2D blitter, that would be scaling above
> > a 1024x1024 destination, which could be required to scaling a video
> > buffer up to a 1920x1080 display. With that, we can e.g. page flip the
> > 2D engine destination buffer and be certain that scaling will be fully
> > done when the fence is signaled.
> > 
> > There's also the userspace problem: DRM render has mesa to back it in
> > userspace and provide a generic API for other programes. For 2D
> > engines, we don't have much to hold on to. Cairo has a DRM render
> > interface that supports a few DRM render drivers where there is either
> > a 2D pipeline or where pre-built shaders are used to implement a 2D
> > pipeline, and that's about it as far as I know.
> > 
> > There's also the possibility of writing up a drm-render DDX to handle
> > these 2D blitters that can make things a lot faster when running a
> > desktop environment. As for wayland, well, I don't really know what to
> > think. I was under the impression that it relies on GL for 2D
> > operations, but am really not sure how true that actually is.
> 
> Just fyi in case you folks aren't aware, I typed up a blog a while ago
> about why drm doesn't have a 2d submit api:
> 
> https://blog.ffwll.ch/2018/08/no-2d-in-drm.html

I definitely share the observation that each 2D engine has its own kind
of pipeline, which is close to impossible to describe in a generic way
while exposing all the possible features of the pipeline.

I thought about this some more yesterday and I see a few areas that
could however be made generic:
* GEM allocation for framebuffers (with a unified ioctl);
* framebuffer management, (that's only in KMS for now and we need
pretty much the same thing here);
* some queuing mechanism, either for standalone submissions or groups
of them.

So I started thinking about writing up a "DRM GFX" API which would
provide this, instead of implementing it in my 2D blitter driver.
There's a chance I'll submit a proposal of that along with my driver.

I am convinced the job submit ioctl needs to remain driver-specific to
properly describe the pipeline though.

> > > The thing is that DRM is great if you do immediate display stuff, while
> > > V4L2 is nice if you do streaming, where you expect filling queued, and
> > > popping buffers from queues.
> > > 
> > > In the end, this is just an interface, nothing prevents you from making
> > > an internal driver (like the Meson Canvas) and simply letting multiple
> > > sub-system expose it. Specially that some of these IP will often
> > > support both signal and memory processing, so they equally fit into a
> > > media controller ISP, a v4l2 m2m or a DRM driver.
> > 
> > Having base drivers that can hook to both v4l2 m2m and DRM would
> > definitely be awesome. Maybe we could have some common internal
> > synchronization logic to make writing these drivers easier.
> 
> We have, it's called dma_fence. Ties into dma_bufs using
> reservation_objecsts.

That's not what I meant: I'm talking about exposing the 2D engine
capabilities through both DRM and V4L2 M2M, where the V4L2 M2M driver
would be an internal client to DRM. So it's about using the same
hardware with both APIs concurrently.

And while at it, we could allow detaching display pipeline elements
that have intermediary writeback and exposing them as 2D engines
through the same API (which would return busy when the block is used
for the video pipeline).

> > It would be cool if both could be used concurrently and not just return
> > -EBUSY when the device is used with the other subsystem.
> 
> We live in this world already :-) I think there's even patches (or merged
> already) to add fences to v4l, for Android.
> 
> > Anyway, that's my 2 cents about the situation and what we can do to
> > improve it. I'm definitely interested in tackling these items, but it
> > may take some time before we get there. Not to mention we need to
> > rework media/v4l2 for per-slice decoding support ;)
> > 
> > > Another driver you might want to look is Rockchip RGA driver (which is
> > > a multi function IP, including blitting).
> > 
> > Yep, I've aware of it as well. There's also vivante which exposes 2D
> > cores but I'm really not sure whether any function is actually
> > implemented. 
> > 
> > OMAP4 and OMAP5 have a 2D engine that seems to be vivante as well from
> > what I could find out, but it seems to only have blobs for bltsville
> > and no significant docs.
> 
> Yeah that's the usual approach for drm 2d drivers: You have a bespoke
> driver in userspace. Usually that means an X driver, but there's been talk
> to pimp the hwc interface to make that _the_ 2d accel interface. There's
> also fbdev ... *shudder*.
> 
> All of these options are geared towards ultimately displaying stuff on
> screens, not pure m2m 2d accel.

I think it would be good to have a specific library to translate
between "standard" 2d ops (porter-duff blending and such) to driver-
specific setup submit ioctls. Could be called "libdrm-gfx" and used by
an associated DDX (as well as any other program that needs 2D ops
acceleration).

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

