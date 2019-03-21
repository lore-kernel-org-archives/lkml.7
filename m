Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54021874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfCUP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:58:40 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51585 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:58:40 -0400
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2973D20000F;
        Thu, 21 Mar 2019 15:58:35 +0000 (UTC)
Message-ID: <a027f99e59c90b2b3a87c4b18a263cfee4cc5795.camel@bootlin.com>
Subject: Re: [PATCH v2 2/2] drm/vc4: Allocated/liberate the binner BO at
 firstopen/lastclose
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 21 Mar 2019 16:58:35 +0100
In-Reply-To: <87wokth498.fsf@anholt.net>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com>
         <20190320154809.14823-3-paul.kocialkowski@bootlin.com>
         <87wokth498.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 20 mars 2019 à 09:58 -0700, Eric Anholt a écrit :
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner BO is a pre-requisite to GPU operations, so we must ensure
> > that it is always allocated when the GPU is in use. Currently, we are
> > allocating it at probe time and liberating/allocating it during runtime
> > pm cycles.
> > 
> > First, since the binner buffer is only required for GPU rendering, it's
> > a waste to allocate it when the driver probes since internal users of
> > the driver (such as fbcon) won't try to use the GPU.
> > 
> > Move the allocation/liberation to the firstopen/lastclose instead to
> > only allocate it when userspace has opened the device and adapt the IRQ
> > handler to return early when no binner BO was allocated yet.
> > 
> > Second, because the buffer is allocated from the same pool as other GPU
> > buffers, we might run into a situation where we are out of memory at
> > runtime resume. This causes the binner BO allocation to fail and results
> > in all subsequent operations to fail, resulting in a major hang in
> > userspace.
> > 
> > As a result, keep the buffer alive during runtime pm.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> > index 4cd2ccfe15f4..efaba2b02f6c 100644
> > --- a/drivers/gpu/drm/vc4/vc4_irq.c
> > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> > @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
> >  	struct vc4_exec_info *exec;
> >  	unsigned long irqflags;
> >  
> > +	if (!bo)
> > +		return;
> > +
> >  	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
> >  	if (bin_bo_slot < 0) {
> >  		DRM_ERROR("Couldn't allocate binner overflow mem\n");
> 
> Hmm.  We take the OOM IRQ on poweron, have no bin BO since nobody's
> opened yet, and leave it.  Do we ever get the OOM IRQ again after that?
> Seems like vc4_allocate_bin_bo() might need to kick something so that we
> can fill an OOM request.

I just had a look and it seems that we do get the OOM interrupt again
after the bin BO is allocated. Actually, I can see it kicking from time
to time when using X with glamor.

From what I understood, this looks fairly legitimate. Should we be
worried about this?

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

