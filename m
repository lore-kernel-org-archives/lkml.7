Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6BC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C84321850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGDMAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfGDMAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:00:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BF9A3082200;
        Thu,  4 Jul 2019 12:00:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-222.ams2.redhat.com [10.36.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AAEB8E65E;
        Thu,  4 Jul 2019 12:00:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 32AD311AB5; Thu,  4 Jul 2019 14:00:31 +0200 (CEST)
Date:   Thu, 4 Jul 2019 14:00:31 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 16/18] drm/virtio: rework
 virtio_gpu_cmd_context_{attach,detach}_resource
Message-ID: <20190704120031.mbgkwcrmxvmtp2ll@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-17-kraxel@redhat.com>
 <CAAfnVBmKotCfkrM4hph4++FDrVUYR8WKpomP7Y0-aergqHTSyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVBmKotCfkrM4hph4++FDrVUYR8WKpomP7Y0-aergqHTSyA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 04 Jul 2019 12:00:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:08:46PM -0700, Gurchetan Singh wrote:
> On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > Switch to the virtio_gpu_array_* helper workflow.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_drv.h |  4 ++--
> >  drivers/gpu/drm/virtio/virtgpu_gem.c | 24 +++++++++++-------------
> >  drivers/gpu/drm/virtio/virtgpu_vq.c  | 10 ++++++----
> >  3 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > index b1f63a21abb6..d99c54abd090 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -292,10 +292,10 @@ void virtio_gpu_cmd_context_destroy(struct
> > virtio_gpu_device *vgdev,
> >                                     uint32_t id);
> >  void virtio_gpu_cmd_context_attach_resource(struct virtio_gpu_device
> > *vgdev,
> >                                             uint32_t ctx_id,
> > -                                           uint32_t resource_id);
> > +                                           struct virtio_gpu_object_array
> > *objs);
> >  void virtio_gpu_cmd_context_detach_resource(struct virtio_gpu_device
> > *vgdev,
> >                                             uint32_t ctx_id,
> > -                                           uint32_t resource_id);
> > +                                           struct virtio_gpu_object_array
> > *objs);
> >  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
> >                            void *data, uint32_t data_size,
> >                            uint32_t ctx_id,
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > index 6baf64141645..e75819dbba80 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > @@ -111,19 +111,18 @@ int virtio_gpu_gem_object_open(struct drm_gem_object
> > *obj,
> >  {
> >         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> >         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> > -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> > -       int r;
> > +       struct virtio_gpu_object_array *objs;
> >
> >         if (!vgdev->has_virgl_3d)
> >                 return 0;
> >
> > -       r = virtio_gpu_object_reserve(qobj);
> > -       if (r)
> > -               return r;
> > +       objs = virtio_gpu_array_alloc(1);
> > +       if (!objs)
> > +               return -ENOMEM;
> > +       virtio_gpu_array_add_obj(objs, obj);
> >
> >         virtio_gpu_cmd_context_attach_resource(vgdev, vfpriv->ctx_id,
> > -                                              qobj->hw_res_handle);
> > -       virtio_gpu_object_unreserve(qobj);
> > +                                              objs);
> >         return 0;
> >  }
> >
> > @@ -132,19 +131,18 @@ void virtio_gpu_gem_object_close(struct
> > drm_gem_object *obj,
> >  {
> >         struct virtio_gpu_device *vgdev = obj->dev->dev_private;
> >         struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
> > -       struct virtio_gpu_object *qobj = gem_to_virtio_gpu_obj(obj);
> > -       int r;
> > +       struct virtio_gpu_object_array *objs;
> >
> >         if (!vgdev->has_virgl_3d)
> >                 return;
> >
> > -       r = virtio_gpu_object_reserve(qobj);
> > -       if (r)
> > +       objs = virtio_gpu_array_alloc(1);
> > +       if (!objs)
> >                 return;
> > +       virtio_gpu_array_add_obj(objs, obj);
> >
> 
> This seems to call drm_gem_object_get.  Without adding the objects to the
> vbuf, aren't we missing the corresponding drm_gem_object_put_unlocked?

Yes.  Fixed.

> Some miscellaneous comments:
> 1) Maybe virtio_gpu_array can have it's own header and file?  virtgpu_drv.h
> is getting rather big..

Longer-term it might move out anyway due to becoming a generic drm helper.

> 2) What data are you trying to protect with the additional references?  Is
> it host side resources (i.e, the host GL texture or buffer object) or is it
> guest side resources (fences)?

Protect the (guest) gem object, specifically make sure the
bo->hw_res_handle stays valid.

cheers,
  Gerd

