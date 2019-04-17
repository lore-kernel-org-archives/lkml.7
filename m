Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491A9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CB820663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfDQSKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:10:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:52337 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQSKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:10:20 -0400
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D874220000C;
        Wed, 17 Apr 2019 18:10:15 +0000 (UTC)
Message-ID: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
Subject: Support for 2D engines/blitters in V4L2 and DRM
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Wed, 17 Apr 2019 20:10:15 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

I'm detaching this thread from our V4L2 stateless decoding spec since
it has drifted off and would certainly be interesting to DRM folks as
well!

For context: I was initially talking about writing up support for the
Allwinner 2D engine as a DRM render driver, where I'd like to be able
to batch jobs that affect the same destination buffer to only signal
the out fence once when the batch is done. We have a similar issue in
v4l2 where we'd like the destination buffer for a set of requests (each
covering one H264 slice) to be marked as done once the set was decoded.

Le mercredi 17 avril 2019 à 12:22 -0400, Nicolas Dufresne a écrit :
> > > > Interestingly, I'm experiencing the exact same problem dealing with a
> > > > 2D graphics blitter that has limited ouput scaling abilities which
> > > > imply handlnig a large scaling operation as multiple clipped smaller
> > > > scaling operations. The issue is basically that multiple jobs have to
> > > > be submitted to complete a single frame and relying on an indication
> > > > from the destination buffer (such as a fence) doesn't work to indicate
> > > > that all the operations were completed, since we get the indication at
> > > > each step instead of at the end of the batch.
> > > 
> > > That looks similar to the IMX.6 IPU m2m driver. It splits the image in
> > > tiles of 1024x1024 and process each tile separately. This driver has
> > > been around for a long time, so I guess they have a solution to that.
> > > They don't need requests, because there is nothing to be bundled with
> > > the input image. I know that Renesas folks have started working on a
> > > de-interlacer. Again, this kind of driver may process and reuse input
> > > buffers for motion compensation, but I don't think they need special
> > > userspace API for that.
> > 
> > Thanks for the reference! I hope it's not a blitter that was
> > contributed as a V4L2 driver instead of DRM, as it probably would be
> > more useful in DRM (but that's way beside the point).
> 
> DRM does not offer a generic and discoverable interface for these
> accelerators. Note that these drivers have most of the time started as
> DRM driver and their DRM side where dropped. That was the case for
> Exynos drivers at least.

Heh, sadly I'm aware of how things turn out most of the time. The thing
is that DRM expects drivers to implement their own interface. That's
fine for passing BOs with GPU bitstream and textures, but not so much
for dealing with framebuffer-based operations where the streaming and
buffer interface that v4l2 has is a good fit.

There's also the fact that the 2D pipeline is fixed-function and highly
hardware-specific, so we need driver-specific job descriptions to
really make the most of it. That's where v4l2 is not much of a good fit
for complex 2D pipelines either. Most 2D engines can take multiple
inputs and blit them together in various ways, which is too far from
what v4l2 deals with. So we can have fixed single-buffer pipelines with
at best CSC and scaling, but not much more with v4l2 really.

I don't think it would be too much work to bring an interface to DRM in
order to describe render framebuffers (we only have display
framebuffers so far), with a simple queuing interface for scheduling
driver-specific jobs, which could be grouped together to only signal
the out fences when every buffer of the batch was done being rendered.
This last point would allow handling cases where userapce need to
perform multiple operations to carry out the single operation that it
needs to do. In the case of my 2D blitter, that would be scaling above
a 1024x1024 destination, which could be required to scaling a video
buffer up to a 1920x1080 display. With that, we can e.g. page flip the
2D engine destination buffer and be certain that scaling will be fully
done when the fence is signaled.

There's also the userspace problem: DRM render has mesa to back it in
userspace and provide a generic API for other programes. For 2D
engines, we don't have much to hold on to. Cairo has a DRM render
interface that supports a few DRM render drivers where there is either
a 2D pipeline or where pre-built shaders are used to implement a 2D
pipeline, and that's about it as far as I know.

There's also the possibility of writing up a drm-render DDX to handle
these 2D blitters that can make things a lot faster when running a
desktop environment. As for wayland, well, I don't really know what to
think. I was under the impression that it relies on GL for 2D
operations, but am really not sure how true that actually is.

> The thing is that DRM is great if you do immediate display stuff, while
> V4L2 is nice if you do streaming, where you expect filling queued, and
> popping buffers from queues.
> 
> In the end, this is just an interface, nothing prevents you from making
> an internal driver (like the Meson Canvas) and simply letting multiple
> sub-system expose it. Specially that some of these IP will often
> support both signal and memory processing, so they equally fit into a
> media controller ISP, a v4l2 m2m or a DRM driver.

Having base drivers that can hook to both v4l2 m2m and DRM would
definitely be awesome. Maybe we could have some common internal
synchronization logic to make writing these drivers easier.

It would be cool if both could be used concurrently and not just return
-EBUSY when the device is used with the other subsystem.

Anyway, that's my 2 cents about the situation and what we can do to
improve it. I'm definitely interested in tackling these items, but it
may take some time before we get there. Not to mention we need to
rework media/v4l2 for per-slice decoding support ;)

> Another driver you might want to look is Rockchip RGA driver (which is
> a multi function IP, including blitting).

Yep, I've aware of it as well. There's also vivante which exposes 2D
cores but I'm really not sure whether any function is actually
implemented. 

OMAP4 and OMAP5 have a 2D engine that seems to be vivante as well from
what I could find out, but it seems to only have blobs for bltsville
and no significant docs.

Cheers,

Paul

