Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42601206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfC2PC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:02:29 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33729 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2PC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:02:29 -0400
X-Originating-IP: 90.88.32.136
Received: from aptenodytes (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F17CD240017;
        Fri, 29 Mar 2019 15:02:23 +0000 (UTC)
Message-ID: <5ed7c5f361bca47d3f9771f9ed27e28e2fccb179.camel@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Daniel Stone <daniel@fooishbar.org>, Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Fri, 29 Mar 2019 16:02:23 +0100
In-Reply-To: <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
         <20190320154809.14823-2-paul.kocialkowski@bootlin.com>
         <87zhpph4c2.fsf@anholt.net>
         <82618ee8c2a2380a62b1fb894e5c35c602e20f3d.camel@bootlin.com>
         <20190328185307.GZ2665@phenom.ffwll.local>
         <CAPj87rMmW_7Kiy==ZxvvmHXhQLWC+F=uxed442HpMMZr=MwjRA@mail.gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-03-29 at 09:09 +0000, Daniel Stone wrote:
> Hi,
> 
> On Thu, 28 Mar 2019 at 18:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Mar 21, 2019 at 04:27:06PM +0100, Paul Kocialkowski wrote:
> > > I don't see other options either, and using firstclose/lastopen feels
> > > overall more readable in the driver code.
> > > 
> > > I'm not sure there is such a big overhead associated with allocating
> > > the binner BO (it seems that the current implementation tries to alloc
> > > until the specific memory constraints for the buffer are met, so
> > > perhaps that can take time). But if there is, I suppose it's best to
> > > have that when starting up rather than delaying the first render
> > > operation.
> > 
> > I'm not entirely buying the "we don't need this for fbcon only" argument -
> > there's plenty of dumb kms clients too (boot splash and whatever else
> > there might be). If you don't want to keep this around I think allocating
> > on first non-dumb bo allocation and dropping it when the last such fd
> > closes sounds like a much better idea. Needs a bit more state, you need to
> > track per drm_file whether you've already allocated a non-dumb bo, and a
> > drm_device refcount, but that's not much. Firstopen feels like the wrong
> > thing.
> > 
> > Another option would be first_renderopen or something like that, except
> > you can also render on the legacy node and I'm not sure how much there's a
> > demand for this in other drivers. In the end you have open/close
> > callbacks, you can do all the driver specific things you want to do in
> > there.
> 
> I'd like to avoid doing it in open where possible, since that hurts
> device enumeration from userspace.

I've noticed the same issue with firstopen, where our buffer is
allocated/liberated a couple of times during enumeration, before the
final open that stays alive during use.

I'm not sure what is preferable between that and allocating when the
GPU is first used. Slowing down the first GPU operation with the
allocation does not sound too great either and it feels like the buffer
should have been allocated earlier.

To me, it feels I think it's better to have delays due to allocation at
enumeration / startup rather than later on, but I might be missing some
elements to have a clear idea.

What do you think?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

