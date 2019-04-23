Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E49C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfDWIaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:30:16 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38751 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDWIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:30:16 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6AF6760013;
        Tue, 23 Apr 2019 08:30:09 +0000 (UTC)
Message-ID: <d9ccaaf4db46abf0098fbeb178a42c71a7860b9d.camel@bootlin.com>
Subject: Re: [PATCH v5 3/4] drm/vc4: Check for the binner bo before handling
 OOM interrupt
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>
Date:   Tue, 23 Apr 2019 10:30:09 +0200
In-Reply-To: <87v9zf806m.fsf@anholt.net>
References: <20190415123908.28986-1-paul.kocialkowski@bootlin.com>
         <20190415123908.28986-4-paul.kocialkowski@bootlin.com>
         <87v9zf806m.fsf@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2019-04-15 at 13:48 -0700, Eric Anholt wrote:
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > Since the OOM interrupt directly deals with the binner bo, it doesn't
> > make sense to try and handle it without a binner buffer registered.
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
> >  
> > +	if (!bo)
> > +		return;
> > +
> >  	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
> >  	if (bin_bo_slot < 0) {
> >  		DRM_ERROR("Couldn't allocate binner overflow mem\n");
> > -- 
> > 2.21.0
> 
> I don't think this is going to be race-free.  You're checking outside of
> a lock, then proceeding to use it even if (in patch 4) the bin BO was in
> the process of being freed during the file close path.  Can we put all
> of the overflow process here under the same lock as freeing?

Definitely, sorry I missed that.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

