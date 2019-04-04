Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417EDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140822075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfDDMin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:38:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:36411 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:38:43 -0400
Received: from aptenodytes (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id AF92110004D;
        Thu,  4 Apr 2019 12:38:38 +0000 (UTC)
Message-ID: <23336c399cd31738750fa060854f5a076b722300.camel@bootlin.com>
Subject: Re: [PATCH v4 4/4] drm/vc4: Allocate binner bo when starting to use
 the V3D
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 04 Apr 2019 14:38:38 +0200
In-Reply-To: <87ftqyor88.fsf@anholt.net>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com>
         <20190403154856.9470-5-paul.kocialkowski@bootlin.com>
         <87ftqyor88.fsf@anholt.net>
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

Le mercredi 03 avril 2019 à 11:53 -0700, Eric Anholt a écrit :
> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > The binner bo is not required until the V3D is in use, so avoid
> > allocating it at probe and do it on the first non-dumb BO allocation.
> > Keep track of which clients are using the V3D and liberate the buffer
> > when there is none left.
> > 
> > We also want to keep it alive during runtime suspend/resume to avoid
> > failing to allocate it at resume. This happens when the CMA pool is
> > full at that point and results in a hard crash.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_bo.c  | 32 ++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/vc4/vc4_drv.c |  9 +++++++++
> >  drivers/gpu/drm/vc4/vc4_drv.h |  4 ++++
> >  drivers/gpu/drm/vc4/vc4_v3d.c | 13 -------------
> >  4 files changed, 45 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> > index 88ebd681d7eb..b941f09b9378 100644
> > --- a/drivers/gpu/drm/vc4/vc4_bo.c
> > +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> > @@ -799,6 +799,30 @@ vc4_prime_import_sg_table(struct drm_device *dev,
> >  	return obj;
> >  }
> >  
> > +static int vc4_prepare_bin_bo(struct drm_device *dev,
> > +			      struct drm_file *file_priv)
> > +{
> > +	struct vc4_file *vc4file = file_priv->driver_priv;
> > +	struct vc4_dev *vc4 = to_vc4_dev(dev);
> > +	int ret;
> > +
> > +	if (!vc4->v3d)
> > +		return -ENODEV;
> > +
> > +	if (!vc4file->needs_bin_bo) {
> > +		atomic_inc(&vc4->bin_bo_usecnt);
> > +		vc4file->needs_bin_bo = true;
> > +	}
> > +
> > +	if (!vc4->bin_bo) {
> > +		ret = vc4_v3d_allocate_bin_bo(vc4);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> 
> This atomic usage looks really racy.  For example, multiple clients
> could call allocate at the same time and leak one.  Or this timeline:
> 
> us           them
>              dec count to 0
> inc count
> check bin_bo
>              free bin_bo

Oh, you're definitely right. Sorry I missed that.

> vc4_v3d_allocate_bin_bo should probably be a vc4_v3d_bin_bo_get()
> returning a kref on the BO, called under a lock protecting both one
> file_priv being dereferenced by multiple threads in the kernel at the
> same time (so file_priv doesn't try to double-get its ref) and multiple
> file_privs trying to get the bin_bo at once.

Sounds good, I'll look into it and spin up a new revision soon.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

