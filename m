Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DB8C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ECD217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF1KeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfF1KeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:34:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CFBD3082E55;
        Fri, 28 Jun 2019 10:34:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D77B05C70C;
        Fri, 28 Jun 2019 10:34:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D90AF16E05; Fri, 28 Jun 2019 12:34:12 +0200 (CEST)
Date:   Fri, 28 Jun 2019 12:34:12 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
 fencing
Message-ID: <20190628103412.f2n7ybp3qtxbhdk4@sirius.home.kraxel.org>
References: <20190620060726.926-1-kraxel@redhat.com>
 <20190620060726.926-9-kraxel@redhat.com>
 <CAPaKu7QjuKMJfhTVOzBsUb8cT9cGgesG_-skQeBO8hL8UqcAzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7QjuKMJfhTVOzBsUb8cT9cGgesG_-skQeBO8hL8UqcAzw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 28 Jun 2019 10:34:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > @@ -120,9 +120,9 @@ struct virtio_gpu_vbuffer {
> >
> >         char *resp_buf;
> >         int resp_size;
> > -
> >         virtio_gpu_resp_cb resp_cb;
> >
> > +       struct virtio_gpu_object_array *objs;
> This can use a comment (e.g., objects referenced by the vbuffer)

IMHO this is obvious ...

> >  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
> >                            void *data, uint32_t data_size,
> > -                          uint32_t ctx_id, struct virtio_gpu_fence *fence);
> > +                          uint32_t ctx_id, struct virtio_gpu_fence *fence,
> > +                          struct virtio_gpu_object_array *objs);
> Can we keep fence, which is updated, as the last parameter?

Fixed.

> > +       if (buflist) {
> > +               for (i = 0; i < exbuf->num_bo_handles; i++)
> > +                       reservation_object_add_excl_fence(buflist->objs[i]->resv,
> > +                                                         &out_fence->f);
> > +               drm_gem_unlock_reservations(buflist->objs, buflist->nents,
> > +                                           &ticket);
> > +       }
> We used to unlock after virtio_gpu_cmd_submit.
> 
> I guess, the fence is considered signaled (because its seqno is still
> 0) until after virtio_gpu_cmd_submit.  We probably don't want other
> processes to see the semi-initialized fence.

Good point.  Fixed.

> >  out_memdup:
> >         kfree(buf);
> >  out_unresv:
> > -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> > -out_free:
> > -       virtio_gpu_unref_list(&validate_list);
> Keeping out_free to free buflist seems just fine.

We don't need the separate label though ...

> > +       drm_gem_unlock_reservations(buflist->objs, buflist->nents, &ticket);
> >  out_unused_fd:
> >         kvfree(bo_handles);
> > -       kvfree(buflist);
> > +       if (buflist)
> > +               virtio_gpu_array_put_free(buflist);

... and the buflist is released here if needed.

But we need if (buflist) for drm_gem_unlock_reservations too.  Fixed.

> > -
> > -               list_del(&entry->list);
> > -               free_vbuf(vgdev, entry);
> >         }
> >         wake_up(&vgdev->ctrlq.ack_queue);
> >
> >         if (fence_id)
> >                 virtio_gpu_fence_event_process(vgdev, fence_id);
> > +
> > +       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> > +               if (entry->objs)
> > +                       virtio_gpu_array_put_free(entry->objs);
> > +               list_del(&entry->list);
> We are clearing the list.  I guess list_del is not needed.
> > +               free_vbuf(vgdev, entry);

This just shuffles around the code.  Dropping list_del() is unrelated
and should be a separate patch.

Beside that I'm not sure it actually can be dropped.  free_vbuf() will
not kfree() the vbuf but keep it cached in a freelist instead.

cheers,
  Gerd

