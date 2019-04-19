Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E1FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5389120643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDSTBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:01:18 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38388 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfDSTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:01:16 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 627D03AA160;
        Fri, 19 Apr 2019 08:38:26 +0000 (UTC)
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A7ED1240013;
        Fri, 19 Apr 2019 08:38:20 +0000 (UTC)
Message-ID: <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel@ffwll.ch>
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date:   Fri, 19 Apr 2019 10:38:20 +0200
In-Reply-To: <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
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

On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > > It would be cool if both could be used concurrently and not just return
> > > -EBUSY when the device is used with the other subsystem.
> > 
> > We live in this world already :-) I think there's even patches (or merged
> > already) to add fences to v4l, for Android.
> 
> This work is currently suspended. It will require some feature on DRM
> display to really make this useful, but there is also a lot of
> challanges in V4L2. In GFX space, most of the use case are about
> rendering as soon as possible. Though, in multimedia we have two
> problems, we need to synchronize the frame rendering with the audio,
> and output buffers may comes out of order due to how video CODECs are
> made.

Definitely, it feels like the DRM display side is currently a good fit
for render use cases, but not so much for precise display cases where
we want to try and display a buffer at a given vblank target instead of
"as soon as possible".

I have a userspace project where I've implemented a page flip queue,
which only schedules the next flip when relevant and keeps ready
buffers in the queue until then. This requires explicit vblank
syncronisation (which DRM offsers, but pretty much all other display
APIs, that are higher-level don't, so I'm just using a refresh-rate
timer for them) and flip done notification.

I haven't looked too much at how to flip with a target vblank with DRM
directly but maybe the atomic API already has the bits in for that (but
I haven't heard of such a thing as a buffer queue, so that makes me
doubt it). Well, I need to handle stuff like SDL in my userspace
project, so I have to have all that queuing stuff in software anyway,
but it would be good if each project didn't have to implement that.
Worst case, it could be in libdrm too.

> In the first, we'd need a mechanism where we can schedule a render at a
> specific time or vblank. We can of course already implement this in
> software, but with fences, the scheduling would need to be done in the
> driver. Then if the fence is signalled earlier, the driver should hold
> on until the delay is met. If the fence got signalled late, we also
> need to think of a workflow. As we can't schedule more then one render
> in DRM at one time, I don't really see yet how to make that work.

Indeed, that's also one of the main issues I've spotted. Before using
an implicit fence, we basically have to make sure the frame is due for
display at the next vblank. Otherwise, we need to refrain from using
the fence and schedule the flip later, which is kind of counter-
productive.

So maybe adding this queue in DRM directly would make everyone's life
much easier for non-render applications.

I feel like specifying a target vblank would be a good unit for that,
since it's our native granularity after all (while a timestamp is not).

> For the second, it's complicated on V4L2 side. Currently we signal
> buffers when they are ready in the display order. With fences, we
> receive early pairs buffer and fence (in decoding order). There exist
> cases where reordering is done by the driver (stateful CODEC). We
> cannot schedule these immediately we would need a new mechanism to know
> which one come next. If we just reuse current mechnism, it would void
> the fence usage since the fence will always be signalled by the time it
> reaches DRM or other v4l2 component.

Well, our v4l2 buffers do have a timestamp and fences expose it too, so
we'd need DRM to convert that to a target vblank and add it to the
internal queue mentioned above. That seems doable.

I think we only gave a vague meaning to the v4l2 timestamp for the
decoding case and it could be any number, the timestamp when submitting
decoding or the target timestamp for the frame. I think we should aim
for the latter, but not sure it's always doable to know beforehand.
Perhaps you have a clear idea of this?

> There also other issues, for video capture pipeline, if you are not
> rendering ASAP, you need the HW timestamp in order to schedule. Again,
> we'd get the fence early, but the actual timestamp will be signalled at
> the very last minutes, so we also risk of turning the fence into pure
> overhead. Note that as we speak, I have colleagues who are
> experimenting with frame timestamp prediction that slaves to the
> effective timestamp (catching up over time). But we still have issues
> when the capture driver skipped a frame (missed a capture window).
> 
> I hope this is useful reflection data,

It is definitely very useful and there seems to be a few things that
could be improved already without too much effort.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

