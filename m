Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D9821734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDDOd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:33:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:51919 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:33:27 -0400
X-Originating-IP: 90.88.30.125
Received: from aptenodytes (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C38E8240033;
        Thu,  4 Apr 2019 14:33:23 +0000 (UTC)
Message-ID: <041896dd4a8fb7e234356ee6d37a8a04909dd8b2.camel@bootlin.com>
Subject: Re: [PATCH v4 3/4] drm/vc4: Check for the binner bo before handling
 OOM interrupt
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 04 Apr 2019 16:33:23 +0200
In-Reply-To: <87ef6ior0m.fsf@anholt.net>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com>
         <20190403154856.9470-4-paul.kocialkowski@bootlin.com>
         <87ef6ior0m.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Le mercredi 03 avril 2019 à 11:58 -0700, Eric Anholt a écrit :
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > Since the OOM interrupt directly deals with the binner bo, it doesn't
> > make sense to try and handle it without a binner buffer registered.
> > The interrupt will kick again in due time, so we can safely ignore it
> > without a binner bo allocated.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_irq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> > index ffd0a4388752..723dc86b4511 100644
> > --- a/drivers/gpu/drm/vc4/vc4_irq.c
> > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> > @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
> >  	struct vc4_exec_info *exec;
> >  	unsigned long irqflags;
> 
> Since OOM handling is tricky, could we add a comment to help the next
> person try to understand it:
> 
> /* The OOM IRQ is level-triggered, so we'll see one at power-on before
>  * any jobs are submitted.  The OOM IRQ is masked when this work is
>  * scheduled, so we can safely return if there's no binner memory
>  * (because no client is currently using 3D).  When a bin job is
>  * later submitted, its tile memory allocation will end up bringing us
>  * back to a non-OOM state so the OOM can be triggered again.
>  */
> 
> But, actually, I don't see how the OOM IRQ will ever get re-enabled.

Okay so I investigated that to try and understand what's going on.
We are definitely writing the OUTOMEM bit to V3D_INTDIS just before
scheduling the workqueue, and never re-enable the IRQ when leaving
early in the workqueue because !vc4->bin_bo.

It turns out that what saves us here is vc4_irq_postinstall being
called from runtime resume at "the right time". Obviously this is more
than fragile, so we should really be re-enabling the IRQ as soon as we
have the binner bo allocated.

Since we're now allocating at the first non-dumb bo alloc, I think we
need to make sure that we did in fact get the irq and registered the
allocated BO with the workqueue before submitting the rcl. Or does the
hardware provide any mechanism to take that off our hands somehow?

What do you think?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

