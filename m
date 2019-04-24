Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4905218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfDXOmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:42:00 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47393 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731289AbfDXOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:41:57 -0400
X-Originating-IP: 90.88.147.33
Received: from aptenodytes (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 05D1A20020;
        Wed, 24 Apr 2019 14:41:52 +0000 (UTC)
Message-ID: <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date:   Wed, 24 Apr 2019 16:41:52 +0200
In-Reply-To: <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
         <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
         <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
         <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
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

On Wed, 2019-04-24 at 16:39 +0200, Michel Dänzer wrote:
> On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
> > Le mercredi 24 avril 2019 à 10:31 +0200, Michel Dänzer a écrit :
> > > On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> > > > On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> > > > > Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > > > > In the first, we'd need a mechanism where we can schedule a render at a
> > > > > specific time or vblank. We can of course already implement this in
> > > > > software, but with fences, the scheduling would need to be done in the
> > > > > driver. Then if the fence is signalled earlier, the driver should hold
> > > > > on until the delay is met. If the fence got signalled late, we also
> > > > > need to think of a workflow. As we can't schedule more then one render
> > > > > in DRM at one time, I don't really see yet how to make that work.
> > > > 
> > > > Indeed, that's also one of the main issues I've spotted. Before using
> > > > an implicit fence, we basically have to make sure the frame is due for
> > > > display at the next vblank. Otherwise, we need to refrain from using
> > > > the fence and schedule the flip later, which is kind of counter-
> > > > productive.
> > > 
> > > Fences are about signalling that the contents of a frame are "done" and
> > > ready to be presented. They're not about specifying which frame is to be
> > > presented when.
> > > 
> > > 
> > > > I feel like specifying a target vblank would be a good unit for that,
> > > 
> > > The mechanism described above works for that.
> > > 
> > > > since it's our native granularity after all (while a timestamp is not).
> > > 
> > > Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
> > > changes things in this regard. It makes the vblank length variable, and
> > > if you wait for multiple vblanks between flips, you get the maximum
> > > vblank length corresponding to the minimum refresh rate / timing
> > > granularity. Thus, it would be useful to allow userspace to specify a
> > > timestamp corresponding to the earliest time when the flip is to
> > > complete. The kernel could then try to hit that as closely as possible.
> > 
> > Rendering a video stream is more complex then what you describe here.
> > Whenever there is a unexpected delay (late delivery of a frame as an
> > example) you may endup in situation where one frame is ready after the
> > targeted vblank. If there is another frame that targets the following
> > vblank that gets ready on-time, the previous frame should be replaced
> > by the most recent one.
> > 
> > With fences, what happens is that even if you received the next frame
> > on time, naively replacing it is not possible, because we don't know
> > when the fence for the next frame will be signalled. If you simply
> > always replace the current frame, you may endup skipping a lot more
> > vblank then what you expect, and that results in jumpy playback.
> 
> So you want to be able to replace a queued flip with another one then.
> That doesn't necessarily require allowing more than one flip to be
> queued ahead of time.

There might be other ways to do it, but this one has plenty of
advantages.

> Note that this can also be done in userspace with explicit fencing (by
> only selecting a frame and submitting it to the kernel after all
> corresponding fences have signalled), at least to some degree, but the
> kernel should be able to do it up to a later point in time and more
> reliably, with less risk of missing a flip for a frame which becomes
> ready just in time.

Indeed, but it would be great if we could do that with implicit fencing
as well.

> > Render queues with timestamp are used to smooth rendering and handle
> > rendering collision so that the latency is kept low (like when you have
> > a 100fps video over a 60Hz display). This is normally done in
> > userspace, but with fences, you ask the kernel to render something in
> > an unpredictable future, so we loose the ability to make the final
> > decision.
> 
> That's just not what fences are intended to be used for with the current
> KMS UAPI.

Yes, and I think we're discussing towards changing that in the future.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

