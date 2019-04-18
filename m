Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429CC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC31C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h+2loIfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbfDRISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:18:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37679 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388341AbfDRISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:18:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so1071789ede.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M3sejZMVhFeID8zPTGkXxP8kTwM980vNh9pTofxi32Y=;
        b=h+2loIfcWivaOrahN6jPBGhdzuUS3OFS5ILiy1vVuF29+HLuchI+uPXL/zbsz18YV8
         FE/LlGq6s2H17drGsuDBgDvxWkvgsDLrI7UgYImP45PpVlZoGPe3aNjKPYXqkWRDKz/9
         n7qRRXINg8eibxPkWSXf/vfcK4nPRIvwNOJZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M3sejZMVhFeID8zPTGkXxP8kTwM980vNh9pTofxi32Y=;
        b=MatKEph5p5EWtrdWbcsQmXe3lvUwr3UkIAk5jEns1cjHqlbkmiz9fA45iQDBBZQsTc
         mCKzG1RL7+/P7xigNYn45ahPS7ejxV0WCV6CTs+vCrWssf50pgud9Q0RLR2cv3LJhZ/W
         qNo5ZLtCFuKRHy/YeCCNyiQMFAW8SG+HlY8dYO7iyRZ4E//pwJqmFKnoAgixiH/CEQOn
         l/h9w7aNcfdtrFXApJ56Hcc3Uim/nLt/8bwjyU9sn1BDLcsttVgkDAGwrvVM0aKZzuz0
         JF5WDR1LQzFoIIrRKJApECUPTy0CUSLFO49yMeiifqJTcHT+JjNbh1HEzs8CQMz/TIqr
         MvdQ==
X-Gm-Message-State: APjAAAXlRtIIW8h04ydDexyXr65aocmFs9uWWPLkwXyzg+TN/WSG/8cb
        Ssc85tO0N8Qc7+33av08l7E7UyY9VDk=
X-Google-Smtp-Source: APXvYqykW9taDI97gC/Ks2cImjrS2og1u4qHwH/26iG0SYwuzadMcseeNNHkhV+l/dpVR0iC9y+1rg==
X-Received: by 2002:a50:be42:: with SMTP id b2mr4188121edi.192.1555575500088;
        Thu, 18 Apr 2019 01:18:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x55sm335963edx.66.2019.04.18.01.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:18:19 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:18:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
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
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
Message-ID: <20190418081816.GO13337@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:10:15PM +0200, Paul Kocialkowski wrote:
> Hi Nicolas,
> 
> I'm detaching this thread from our V4L2 stateless decoding spec since
> it has drifted off and would certainly be interesting to DRM folks as
> well!
> 
> For context: I was initially talking about writing up support for the
> Allwinner 2D engine as a DRM render driver, where I'd like to be able
> to batch jobs that affect the same destination buffer to only signal
> the out fence once when the batch is done. We have a similar issue in
> v4l2 where we'd like the destination buffer for a set of requests (each
> covering one H264 slice) to be marked as done once the set was decoded.
> 
> Le mercredi 17 avril 2019 à 12:22 -0400, Nicolas Dufresne a écrit :
> > > > > Interestingly, I'm experiencing the exact same problem dealing with a
> > > > > 2D graphics blitter that has limited ouput scaling abilities which
> > > > > imply handlnig a large scaling operation as multiple clipped smaller
> > > > > scaling operations. The issue is basically that multiple jobs have to
> > > > > be submitted to complete a single frame and relying on an indication
> > > > > from the destination buffer (such as a fence) doesn't work to indicate
> > > > > that all the operations were completed, since we get the indication at
> > > > > each step instead of at the end of the batch.
> > > > 
> > > > That looks similar to the IMX.6 IPU m2m driver. It splits the image in
> > > > tiles of 1024x1024 and process each tile separately. This driver has
> > > > been around for a long time, so I guess they have a solution to that.
> > > > They don't need requests, because there is nothing to be bundled with
> > > > the input image. I know that Renesas folks have started working on a
> > > > de-interlacer. Again, this kind of driver may process and reuse input
> > > > buffers for motion compensation, but I don't think they need special
> > > > userspace API for that.
> > > 
> > > Thanks for the reference! I hope it's not a blitter that was
> > > contributed as a V4L2 driver instead of DRM, as it probably would be
> > > more useful in DRM (but that's way beside the point).
> > 
> > DRM does not offer a generic and discoverable interface for these
> > accelerators. Note that these drivers have most of the time started as
> > DRM driver and their DRM side where dropped. That was the case for
> > Exynos drivers at least.
> 
> Heh, sadly I'm aware of how things turn out most of the time. The thing
> is that DRM expects drivers to implement their own interface. That's
> fine for passing BOs with GPU bitstream and textures, but not so much
> for dealing with framebuffer-based operations where the streaming and
> buffer interface that v4l2 has is a good fit.
> 
> There's also the fact that the 2D pipeline is fixed-function and highly
> hardware-specific, so we need driver-specific job descriptions to
> really make the most of it. That's where v4l2 is not much of a good fit
> for complex 2D pipelines either. Most 2D engines can take multiple
> inputs and blit them together in various ways, which is too far from
> what v4l2 deals with. So we can have fixed single-buffer pipelines with
> at best CSC and scaling, but not much more with v4l2 really.
> 
> I don't think it would be too much work to bring an interface to DRM in
> order to describe render framebuffers (we only have display
> framebuffers so far), with a simple queuing interface for scheduling
> driver-specific jobs, which could be grouped together to only signal
> the out fences when every buffer of the batch was done being rendered.
> This last point would allow handling cases where userapce need to
> perform multiple operations to carry out the single operation that it
> needs to do. In the case of my 2D blitter, that would be scaling above
> a 1024x1024 destination, which could be required to scaling a video
> buffer up to a 1920x1080 display. With that, we can e.g. page flip the
> 2D engine destination buffer and be certain that scaling will be fully
> done when the fence is signaled.
> 
> There's also the userspace problem: DRM render has mesa to back it in
> userspace and provide a generic API for other programes. For 2D
> engines, we don't have much to hold on to. Cairo has a DRM render
> interface that supports a few DRM render drivers where there is either
> a 2D pipeline or where pre-built shaders are used to implement a 2D
> pipeline, and that's about it as far as I know.
> 
> There's also the possibility of writing up a drm-render DDX to handle
> these 2D blitters that can make things a lot faster when running a
> desktop environment. As for wayland, well, I don't really know what to
> think. I was under the impression that it relies on GL for 2D
> operations, but am really not sure how true that actually is.

Just fyi in case you folks aren't aware, I typed up a blog a while ago
about why drm doesn't have a 2d submit api:

https://blog.ffwll.ch/2018/08/no-2d-in-drm.html

> > The thing is that DRM is great if you do immediate display stuff, while
> > V4L2 is nice if you do streaming, where you expect filling queued, and
> > popping buffers from queues.
> > 
> > In the end, this is just an interface, nothing prevents you from making
> > an internal driver (like the Meson Canvas) and simply letting multiple
> > sub-system expose it. Specially that some of these IP will often
> > support both signal and memory processing, so they equally fit into a
> > media controller ISP, a v4l2 m2m or a DRM driver.
> 
> Having base drivers that can hook to both v4l2 m2m and DRM would
> definitely be awesome. Maybe we could have some common internal
> synchronization logic to make writing these drivers easier.

We have, it's called dma_fence. Ties into dma_bufs using
reservation_objecsts.

> It would be cool if both could be used concurrently and not just return
> -EBUSY when the device is used with the other subsystem.

We live in this world already :-) I think there's even patches (or merged
already) to add fences to v4l, for Android.

> Anyway, that's my 2 cents about the situation and what we can do to
> improve it. I'm definitely interested in tackling these items, but it
> may take some time before we get there. Not to mention we need to
> rework media/v4l2 for per-slice decoding support ;)
> 
> > Another driver you might want to look is Rockchip RGA driver (which is
> > a multi function IP, including blitting).
> 
> Yep, I've aware of it as well. There's also vivante which exposes 2D
> cores but I'm really not sure whether any function is actually
> implemented. 
> 
> OMAP4 and OMAP5 have a 2D engine that seems to be vivante as well from
> what I could find out, but it seems to only have blobs for bltsville
> and no significant docs.

Yeah that's the usual approach for drm 2d drivers: You have a bespoke
driver in userspace. Usually that means an X driver, but there's been talk
to pimp the hwc interface to make that _the_ 2d accel interface. There's
also fbdev ... *shudder*.

All of these options are geared towards ultimately displaying stuff on
screens, not pure m2m 2d accel.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
