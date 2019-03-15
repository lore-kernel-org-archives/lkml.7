Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF96C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFF5218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfCOKZZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:25:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfCOKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:25:24 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B99BB27E7AF;
        Fri, 15 Mar 2019 10:25:22 +0000 (GMT)
Date:   Fri, 15 Mar 2019 11:25:19 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>
Cc:     Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        kernel@collabora.com, nicholas.kazlauskas@amd.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] drm/rockchip: fix fb references in async update
Message-ID: <20190315112519.0af4fdc0@collabora.com>
In-Reply-To: <61b8420e-9b63-b67f-e9a8-fb8a0cb7d219@daenzer.net>
References: <20190312022204.2775-1-helen.koike@collabora.com>
        <20190312022204.2775-2-helen.koike@collabora.com>
        <20190312073438.05ad8173@collabora.com>
        <f888a2d0-c6b1-8995-7254-ba2923dd22f9@collabora.com>
        <20190312165243.5b771e4a@collabora.com>
        <CAAFQd5CCEDaxLbw0E9NJJ-tEcHd8-Lidvcvt8qfPAnKu7uuj8w@mail.gmail.com>
        <05750143-708b-b84e-af67-82ec6815bd89@daenzer.net>
        <ed44e1f4-07da-b1cb-b5cb-d34d29758502@collabora.com>
        <d91d5582-3ccf-2249-21ee-9ccf115096b2@daenzer.net>
        <dd7de9ff-0ac8-80fd-b88b-250bdf988921@collabora.com>
        <61b8420e-9b63-b67f-e9a8-fb8a0cb7d219@daenzer.net>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 11:11:36 +0100
Michel Dänzer <michel@daenzer.net> wrote:

> On 2019-03-14 6:51 p.m., Helen Koike wrote:
> > On 3/14/19 6:15 AM, Michel Dänzer wrote:  
> >> On 2019-03-13 7:08 p.m., Helen Koike wrote:  
> >>> On 3/13/19 6:58 AM, Michel Dänzer wrote:  
> >>>> On 2019-03-13 4:42 a.m., Tomasz Figa wrote:  
> >>>>> On Wed, Mar 13, 2019 at 12:52 AM Boris Brezillon
> >>>>> <boris.brezillon@collabora.com> wrote:  
> >>>>>> On Tue, 12 Mar 2019 12:34:45 -0300
> >>>>>> Helen Koike <helen.koike@collabora.com> wrote:  
> >>>>>>> On 3/12/19 3:34 AM, Boris Brezillon wrote:  
> >>>>>>>> On Mon, 11 Mar 2019 23:21:59 -0300
> >>>>>>>> Helen Koike <helen.koike@collabora.com> wrote:
> >>>>>>>>  
> >>>>>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> >>>>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> >>>>>>>>> @@ -912,30 +912,31 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
> >>>>>>>>>                                      struct drm_plane_state *new_state)
> >>>>>>>>>  {
> >>>>>>>>>    struct vop *vop = to_vop(plane->state->crtc);
> >>>>>>>>> -  struct drm_plane_state *plane_state;
> >>>>>>>>> +  struct drm_framebuffer *old_fb = plane->state->fb;
> >>>>>>>>>
> >>>>>>>>> -  plane_state = plane->funcs->atomic_duplicate_state(plane);
> >>>>>>>>> -  plane_state->crtc_x = new_state->crtc_x;
> >>>>>>>>> -  plane_state->crtc_y = new_state->crtc_y;
> >>>>>>>>> -  plane_state->crtc_h = new_state->crtc_h;
> >>>>>>>>> -  plane_state->crtc_w = new_state->crtc_w;
> >>>>>>>>> -  plane_state->src_x = new_state->src_x;
> >>>>>>>>> -  plane_state->src_y = new_state->src_y;
> >>>>>>>>> -  plane_state->src_h = new_state->src_h;
> >>>>>>>>> -  plane_state->src_w = new_state->src_w;
> >>>>>>>>> -
> >>>>>>>>> -  if (plane_state->fb != new_state->fb)
> >>>>>>>>> -          drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
> >>>>>>>>> -
> >>>>>>>>> -  swap(plane_state, plane->state);
> >>>>>>>>> -
> >>>>>>>>> -  if (plane->state->fb && plane->state->fb != new_state->fb) {
> >>>>>>>>> +  /*
> >>>>>>>>> +   * A scanout can still be occurring, so we can't drop the reference to
> >>>>>>>>> +   * the old framebuffer. To solve this we get a reference to old_fb and
> >>>>>>>>> +   * set a worker to release it later.  
> >>>>>>>>
> >>>>>>>> Hm, doesn't look like an async update to me if we have to wait for the
> >>>>>>>> next VBLANK to happen to get the new content on the screen. Maybe we
> >>>>>>>> should reject async updates when old_fb != new_fb in the rk  
> >>>>>>>> ->async_check() hook.  
> >>>>>>>
> >>>>>>> Unless I am misunderstanding this, we don't wait here, we just grab a
> >>>>>>> reference to the fb in case it is being still used by the hw, so it
> >>>>>>> doesn't get released prematurely.  
> >>>>>>
> >>>>>> I was just reacting to the comment that says the new FB should stay
> >>>>>> around until the next VBLANK event happens. If the FB must stay around
> >>>>>> that probably means the HW is still using, which made me wonder if this
> >>>>>> HW actually supports async update (where async means "update now and
> >>>>>> don't care about about tearing"). Or maybe it takes some time to switch
> >>>>>> to the new FB and waiting for the next VBLANK to release the old FB was
> >>>>>> an easy solution to not wait for the flip to actually happen in  
> >>>>>> ->async_update() (which is kind of a combination of async+non-blocking).  
> >>>>>
> >>>>> The hardware switches framebuffers on vblank, so whatever framebuffer
> >>>>> is currently being scanned out from needs to stay there until the
> >>>>> hardware switches to the new one in shadow registers. If that doesn't
> >>>>> happen, you get IOMMU faults and the display controller stops working
> >>>>> since we don't have any fault handling currently, just printing a
> >>>>> message.  
> >>>>
> >>>> Sounds like your hardware doesn't actually support async flips. It's
> >>>> probably better for the driver not to pretend otherwise.  
> >>>
> >>> I think wee need to clarify the meaning of the async_update callback
> >>> (and we should clarify it in the docs).
> >>>
> >>> The way I understand what the async_update callback should do is: don't
> >>> block (i.e. don't wait for the next vblank),  
> >>
> >> Note that those are two separate things. "Async flips" are about "don't
> >> wait for vblank", not about "don't block".
> >>
> >>  
> >>> and update the hw state at some point with the latest state from the
> >>> last call to async_update.
> >>>
> >>> Which means that: any driver can implement the async_update callback,
> >>> independently if it supports changing its state right away or not.
> >>> If hw supports, async_update can change the hw state right away, if not,
> >>> then changes will be applied in the next vblank (it can even amend the
> >>> pending commit if there is one).
> >>> With this, we can remove all the legacy cursor code to use the
> >>> async_update callback, since async_update can be called 100 times before
> >>> the next vblank, and the latest state will be set to the hw without
> >>> waiting 100 vblanks.
> >>>
> >>> Please, let me know if this is your understanding as well. If not, then
> >>> we need to remodel things.  
> >>
> >> While this may make sense for cursor updates, I don't think it does for
> >> async flips. If the flip only actually takes effect during the next
> >> vblank, it doesn't really fit the definition and userspace expectation
> >> of an async flip. It's better to clearly communicate to userspace that
> >> the hardware cannot do async flips, than to pretend it can and fake
> >> them. Userspace has to deal with this anyway, since async flips weren't
> >> always supported in general.  
> > 
> > What do you think if we separate two concepts here:
> > 
> > - amend mode: works like cursor updates, i.e, update the hw state at
> > some point with the latest state from the last call to async_update. No
> > special hardware support is required.
> > 
> > - async update: update hw state immediately. This depends if the hw
> > supports it or not.
> > 
> > Every async update is an amend, but the opposite is not necessarily true.
> > 
> > What do you think if we rename the current async_update to amend_update,
> > and we add a parameter "force_async" to it? (or maybe
> > force_immediate_update?)
> > Then amend_check with force_async=1 would fail if the hardware doesn't
> > support it (we could also add flags in the capabilities to inform
> > userspace the expected behaviour of things and if the hw supports
> > force_sync).
> > 
> > Like this, we can implement the cursors using the amend_update (which is
> > now called async_update), and async_flips with amend_update with
> > force_async=1.  
> 
> Might force_async make sense for cursor updates as well? I thought some
> hardware supported HW cursor updates outside of vblank, but I'm not sure.
> 
> Without force_async, are cursor updates always applied to the hardware
> on the next vblank, even if the pending commit is delayed further (e.g.
> because a fence it depends on doesn't signal before vblank)? If cursor
> updates can be delayed beyond the next vblank, that can result in bad
> user experience.

You mean you have

1. sync/regular update pending (waiting on a fence)
2. async update on top of #1

?

In that case I'd expect async_update to either fail with -EBUSY or
fallback to a sync update, but #2 should never go before #1 because the
plane state in #2 has been constructed from the expected state after #1
has been applied.

Note that right now this situation cannot happen because we fallback to
a sync update when ->hw_done of the previous commit is not signaled.
