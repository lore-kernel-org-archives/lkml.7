Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECC120684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfDXMTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:19:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58581 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDXMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:19:17 -0400
X-Originating-IP: 90.88.147.33
Received: from aptenodytes (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B826B1C0004;
        Wed, 24 Apr 2019 12:19:12 +0000 (UTC)
Message-ID: <cfb80745a780083034aae661f5b84cf6114bc186.camel@bootlin.com>
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
Date:   Wed, 24 Apr 2019 14:19:11 +0200
In-Reply-To: <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
         <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
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

On Wed, 2019-04-24 at 10:31 +0200, Michel Dänzer wrote:
> On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> > On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> > > Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > > > > It would be cool if both could be used concurrently and not just return
> > > > > -EBUSY when the device is used with the other subsystem.
> > > > 
> > > > We live in this world already :-) I think there's even patches (or merged
> > > > already) to add fences to v4l, for Android.
> > > 
> > > This work is currently suspended. It will require some feature on DRM
> > > display to really make this useful, but there is also a lot of
> > > challanges in V4L2. In GFX space, most of the use case are about
> > > rendering as soon as possible. Though, in multimedia we have two
> > > problems, we need to synchronize the frame rendering with the audio,
> > > and output buffers may comes out of order due to how video CODECs are
> > > made.
> > 
> > Definitely, it feels like the DRM display side is currently a good fit
> > for render use cases, but not so much for precise display cases where
> > we want to try and display a buffer at a given vblank target instead of
> > "as soon as possible".
> > 
> > I have a userspace project where I've implemented a page flip queue,
> > which only schedules the next flip when relevant and keeps ready
> > buffers in the queue until then. This requires explicit vblank
> > syncronisation (which DRM offsers, but pretty much all other display
> > APIs, that are higher-level don't, so I'm just using a refresh-rate
> > timer for them) and flip done notification.
> > 
> > I haven't looked too much at how to flip with a target vblank with DRM
> > directly but maybe the atomic API already has the bits in for that (but
> > I haven't heard of such a thing as a buffer queue, so that makes me
> > doubt it).
> 
> Not directly. What's available is that if userspace waits for vblank n
> and then submits a flip, the flip will complete in vblank n+1 (or a
> later vblank, depending on when the flip is submitted and when the
> fences the flip depends on signal).
> 
> There is reluctance allowing more than one flip to be queued in the
> kernel, as it would considerably increase complexity in the kernel. It
> would probably only be considered if there was a compelling use-case
> which was outright impossible otherwise.

Well, I think it's just less boilerplace for userspace. This is indeed
quite complex, and I prefer to see that complexity done once and well
in Linux rather than duplicated in userspace with more or less reliable
implementations.

> > Well, I need to handle stuff like SDL in my userspace project, so I have
> > to have all that queuing stuff in software anyway, but it would be good
> > if each project didn't have to implement that. Worst case, it could be
> > in libdrm too.
> 
> Usually, this kind of queuing will be handled in a display server such
> as Xorg or a Wayland compositor, not by the application such as a video
> player itself, or any library in the latter's address space. I'm not
> sure there's much potential for sharing code between display servers for
> this.

This assumes that you are using a display server, which is definitely
not always the case (there is e.g. Kodi GBM). Well, I'm not saying it
is essential to have it in the kernel, but it would avoid code
duplication and lower the complexity in userspace.

> > > In the first, we'd need a mechanism where we can schedule a render at a
> > > specific time or vblank. We can of course already implement this in
> > > software, but with fences, the scheduling would need to be done in the
> > > driver. Then if the fence is signalled earlier, the driver should hold
> > > on until the delay is met. If the fence got signalled late, we also
> > > need to think of a workflow. As we can't schedule more then one render
> > > in DRM at one time, I don't really see yet how to make that work.
> > 
> > Indeed, that's also one of the main issues I've spotted. Before using
> > an implicit fence, we basically have to make sure the frame is due for
> > display at the next vblank. Otherwise, we need to refrain from using
> > the fence and schedule the flip later, which is kind of counter-
> > productive.
> 
> Fences are about signalling that the contents of a frame are "done" and
> ready to be presented. They're not about specifying which frame is to be
> presented when.

Yes, that's precisely the issue I see with them. Once you have
scheduled the flip with a buffer, it is too late to schedule a more
recent buffer for flip if a more recent buffer is available sooner (see
the issue that Nicolas is describing). If you attach a vblank target to
the flip, the flip can be skipped when the fence is signaled if a more
recent buffer was signaled first.

> > I feel like specifying a target vblank would be a good unit for that,
> 
> The mechanism described above works for that.

I still don't see any fence-based mechanism that can work to achieve
that, but maybe I'm missing your point.

> > since it's our native granularity after all (while a timestamp is not).
> 
> Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
> changes things in this regard. It makes the vblank length variable, and
> if you wait for multiple vblanks between flips, you get the maximum
> vblank length corresponding to the minimum refresh rate / timing
> granularity. Thus, it would be useful to allow userspace to specify a
> timestamp corresponding to the earliest time when the flip is to
> complete. The kernel could then try to hit that as closely as possible.

I'm not very familiar with how this works, but I don't really see what
it changes. Does it mean we can flip multiple times per vblank?
If so, how can userspace be aware of that and deal with it properly?
Unless I'm missing something, I think flip scheduling should still work
on vblank granularity in that case.

And I really like a vblank count over a timestamp, as one is the native
unit at hand and the other one only correleates to it.

Cheers,

Paul
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

