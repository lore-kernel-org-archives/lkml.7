Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2488C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D77520882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfICGYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:24:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfICGYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:24:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E19D2C058CB8;
        Tue,  3 Sep 2019 06:24:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8068060A9F;
        Tue,  3 Sep 2019 06:24:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7926748E5; Tue,  3 Sep 2019 08:24:17 +0200 (CEST)
Date:   Tue, 3 Sep 2019 08:24:17 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 4/5] drm/qxl: use drm_gem_object_funcs callbacks
Message-ID: <20190903062417.a4gpgaollk5jruas@sirius.home.kraxel.org>
References: <20190902124126.7700-1-kraxel@redhat.com>
 <20190902124126.7700-5-kraxel@redhat.com>
 <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a9d97c7-26a4-bee6-e9a2-120abbd5277c@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 06:24:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 04:34:49PM +0200, Thomas Zimmermann wrote:
> This patch seems unrelated.

Well, patch 5/5 depends on it because it hooks the
drm_gem_ttm_print_info helper into the new
qxl_object_funcs added by this patch.

> Am 02.09.19 um 14:41 schrieb Gerd Hoffmann:
> > Switch qxl to use drm_gem_object_funcs callbacks
> > instead of drm_driver callbacks.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
> >  drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 2b726a51a302..996d428fa7e6 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -258,16 +258,8 @@ static struct drm_driver qxl_driver = {
> >  #endif
> >  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> >  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> > -	.gem_prime_pin = qxl_gem_prime_pin,
> > -	.gem_prime_unpin = qxl_gem_prime_unpin,
> > -	.gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> >  	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> > -	.gem_prime_vmap = qxl_gem_prime_vmap,
> > -	.gem_prime_vunmap = qxl_gem_prime_vunmap,
> >  	.gem_prime_mmap = qxl_gem_prime_mmap,
> > -	.gem_free_object_unlocked = qxl_gem_object_free,
> > -	.gem_open_object = qxl_gem_object_open,
> > -	.gem_close_object = qxl_gem_object_close,
> >  	.fops = &qxl_fops,
> >  	.ioctls = qxl_ioctls,
> >  	.irq_handler = qxl_irq_handler,
> > diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> > index 548dfe6f3b26..29aab7b14513 100644
> > --- a/drivers/gpu/drm/qxl/qxl_object.c
> > +++ b/drivers/gpu/drm/qxl/qxl_object.c
> > @@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
> >  	}
> >  }
> >  
> > +static const struct drm_gem_object_funcs qxl_object_funcs = {
> > +	.free = qxl_gem_object_free,
> > +	.open = qxl_gem_object_open,
> > +	.close = qxl_gem_object_close,
> > +	.pin = qxl_gem_prime_pin,
> > +	.unpin = qxl_gem_prime_unpin,
> > +	.get_sg_table = qxl_gem_prime_get_sg_table,
> > +	.vmap = qxl_gem_prime_vmap,
> > +	.vunmap = qxl_gem_prime_vunmap,
> > +};
> > +
> >  int qxl_bo_create(struct qxl_device *qdev,
> >  		  unsigned long size, bool kernel, bool pinned, u32 domain,
> >  		  struct qxl_surface *surf,
> > @@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
> >  		kfree(bo);
> >  		return r;
> >  	}
> > +	bo->tbo.base.funcs = &qxl_object_funcs;
> >  	bo->type = domain;
> >  	bo->pin_count = pinned ? 1 : 0;
> >  	bo->surface_id = 0;
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
> 



