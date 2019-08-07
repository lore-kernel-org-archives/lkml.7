Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A36C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B0321E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfHGH04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:26:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfHGH04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F07F230B1B7E;
        Wed,  7 Aug 2019 07:26:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8722826164;
        Wed,  7 Aug 2019 07:26:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8E28811AB8; Wed,  7 Aug 2019 09:26:54 +0200 (CEST)
Date:   Wed, 7 Aug 2019 09:26:54 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm: add gem ttm helpers
Message-ID: <20190807072654.arqvx37p4yxhegcu@sirius.home.kraxel.org>
References: <20190806133454.8254-1-kraxel@redhat.com>
 <20190806133454.8254-2-kraxel@redhat.com>
 <20190806135426.GA7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806135426.GA7444@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 07 Aug 2019 07:26:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +/**
> > + * drm_gem_ttm_mmap_offset() - Returns a GEM ttm object's mmap offset
> > + * @gbo:	the GEM ttm object
> > + *
> > + * See drm_vma_node_offset_addr() for more information.
> > + *
> > + * Returns:
> > + * The buffer object's offset for userspace mappings on success, or
> > + * 0 if no offset is allocated.
> > + */
> > +u64 drm_gem_ttm_mmap_offset(struct ttm_buffer_object *bo)
> > +{
> > +	return drm_vma_node_offset_addr(&bo->base.vma_node);
> 
> Why do we need a new one here, can't we use the existing gem
> implementation for this (there really should only be one I hope, but I
> didn't check).

Havn't found one.

But maybe we don't need this as separate function and can simply move
the drm_vma_node_offset_addr() call into
drm_gem_ttm_driver_dumb_mmap_offset().

> > +int drm_gem_ttm_driver_dumb_mmap_offset(struct drm_file *file,
> > +					 struct drm_device *dev,
> > +					 uint32_t handle, uint64_t *offset)
> > +{
> > +	struct drm_gem_object *gem;
> > +	struct ttm_buffer_object *bo;
> > +
> > +	gem = drm_gem_object_lookup(file, handle);
> > +	if (!gem)
> > +		return -ENOENT;
> > +
> > +	bo = drm_gem_ttm_of_gem(gem);
> > +	*offset = drm_gem_ttm_mmap_offset(bo);
> > +
> > +	drm_gem_object_put_unlocked(gem);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_gem_ttm_driver_dumb_mmap_offset);
> 
> Same for this, you're just upcasting to ttm_bo and then downcasting to
> gem_bo again ... I think just a series to roll out the existing gem
> helpers everywhere should work?

I don't think so.  drm_gem_dumb_map_offset() calls
drm_gem_create_mmap_offset(), which I think is not correct for ttm
objects because ttm_bo_init() handles vma_node initialization.

cheers,
  Gerd

