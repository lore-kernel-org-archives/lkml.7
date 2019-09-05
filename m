Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1878BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA676206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfIEFXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28749 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfIEFXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 343963090FD1;
        Thu,  5 Sep 2019 05:23:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE9AF60606;
        Thu,  5 Sep 2019 05:23:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 84C01784F; Thu,  5 Sep 2019 07:23:40 +0200 (CEST)
Date:   Thu, 5 Sep 2019 07:23:40 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix command submission with objects but
 without fence.
Message-ID: <20190905052340.gfwmzkqwcpxtvzvu@sirius.home.kraxel.org>
References: <20190904074828.32502-1-kraxel@redhat.com>
 <CAPaKu7RWiEr5n_DWcg0H2PPnRs9CUn-ZgQV3NYe8VrdZgEAhTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7RWiEr5n_DWcg0H2PPnRs9CUn-ZgQV3NYe8VrdZgEAhTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 05:23:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 04:10:30PM -0700, Chia-I Wu wrote:
> On Wed, Sep 4, 2019 at 12:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Only call virtio_gpu_array_add_fence if we actually have a fence.
> >
> > Fixes: da758d51968a ("drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing")
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > index 595fa6ec2d58..7fd2851f7b97 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > @@ -339,11 +339,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> >                 goto again;
> >         }
> >
> > -       if (fence)
> > +       if (fence) {
> >                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> > -       if (vbuf->objs) {
> > -               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > -               virtio_gpu_array_unlock_resv(vbuf->objs);
> > +               if (vbuf->objs) {
> > +                       virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > +                       virtio_gpu_array_unlock_resv(vbuf->objs);
> > +               }
> This leaks when fence == NULL and vbuf->objs != NULL (which can really
> happen IIRC... not at my desk to check).

Yes, it can happen, for example when flushing dumb buffers.

But I don't think we leak in this case.  The code paths which don't need
a fence also do not call virtio_gpu_array_lock_resv(), so things are
balanced.  The actual release of the objs happens in
virtio_gpu_dequeue_ctrl_func() via virtio_gpu_array_put_free_delayed().

cheers,
  Gerd

