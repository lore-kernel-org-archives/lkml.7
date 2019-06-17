Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ABC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE1C206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E1lV/u7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFQOLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:11:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43459 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:11:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so16324386edr.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlCo9TC98c5FZkjUzIf1KLkN5UgmU6J99oGWDzFXHpI=;
        b=E1lV/u7o1nMu/5qcTlwV2LMql4XhweKWVE452oSFGI9R9SjCnpHHJnbxQXIKoXvsmz
         MjEC7OHqO9/kJOeec+mu0Z8koL5fprasZn58JKAQBBN+0wxWXoJYVbr7u+ap7ulflBy9
         qPQrTUudwz+GPCINTlkK6HQ+6xSffoDX3Zgzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zlCo9TC98c5FZkjUzIf1KLkN5UgmU6J99oGWDzFXHpI=;
        b=mhINOp05CvZDU/21Y/hezB9OpBPNDLI++QFOuYYNgMjzmaeiA9h+SHmEmYKS20DvP3
         JuB+tMKXlE3weHVw7PI/ydFvYovDWiHOijK5O0hWgqNHZinZwIIaT4+q0pUXGlE/iLNP
         lu8psUcRagox6VO+mWi5VjTguVqA0c3B7Lme7JIRWFtqKhPvFyL6BBbsy+Y60NqdTLpq
         RoQ/27eKHX2cVM9kevRbQ1vkgxC/QDglK1C+COXsrMgXeUVhmNsCYYsBzHpP2/BR9Eu8
         pt+m5bMl2Odc7YIfq74EAloF3eVnnWK2oVjXeGiTJNFc49+uFL2xzx/Tnmz4eVqDvCZq
         H46Q==
X-Gm-Message-State: APjAAAVURUAyIZx1LRgBPsRIMpJZ7+4S73gCM6b40x4mWeu/A5JBd/iP
        Y9FNzCRDIKYPrcmaDR80jNwqYw==
X-Google-Smtp-Source: APXvYqyFOj7EMYy9qivyoZv6/j9iQIWwU8H2myH8qg8E6iBR3g1ZdPTuAJd2zbKKIw0TxP9ixHftTQ==
X-Received: by 2002:aa7:c486:: with SMTP id m6mr54266304edq.298.1560780712473;
        Mon, 17 Jun 2019 07:11:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m19sm2186424eje.30.2019.06.17.07.11.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 07:11:50 -0700 (PDT)
Date:   Mon, 17 Jun 2019 16:11:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] drm/virtio: pass gem reservation object to ttm init
Message-ID: <20190617141148.GE12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-2-kraxel@redhat.com>
 <20190617140825.GD12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617140825.GD12905@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 04:08:25PM +0200, Daniel Vetter wrote:
> On Mon, Jun 17, 2019 at 01:14:03PM +0200, Gerd Hoffmann wrote:
> > With this gem and ttm will use the same reservation object,
> > so mixing and matching ttm / gem reservation helpers should
> > work fine.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> While doing my prime doc+cleanup series I wondered whether we should do
> this for everyone, and perhaps even remove ttm_bo.ttm_resv. Only driver
> which doesn't yet have a gem_bo embedded in the same allocation is vmwgfx,
> and that would be easy to fix by adding a vmwgfx_resv somehwere.
> 
> Anyway, looks like a solid start into the convergence story.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Aside: if virtio ever allows dma-buf sharing with something else (or
multiple virtio-gpu instances), then together with my patch series this
will fix dma-buf import. Atm virtio ignores the reservation object of the
imported dma-buf, which for foreing objects really isn't correct.
-Daniel

> 
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_object.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> > index b2da31310d24..242766d644a7 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> > @@ -132,7 +132,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> >  	virtio_gpu_init_ttm_placement(bo);
> >  	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
> >  			  ttm_bo_type_device, &bo->placement, 0,
> > -			  true, acc_size, NULL, NULL,
> > +			  true, acc_size, NULL,
> > +			  bo->gem_base.resv,
> >  			  &virtio_gpu_ttm_bo_destroy);
> >  	/* ttm_bo_init failure will call the destroy */
> >  	if (ret != 0)
> > -- 
> > 2.18.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
