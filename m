Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCD1C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5035020673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH//MheY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfF3SsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 14:48:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45777 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:48:05 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so23615053ioc.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3e5wbnegHeRX/hJTHNWrhDPE+mePTed2TBFVD0zzdU=;
        b=tH//MheYyEsn2cxzZcYSNMd+x21QhqkEDOTdsUgDTmN3b9XSew6Pn+SqEv9spR2WhZ
         oaaQdZOwvfuYIbxcPsJYN6PUQ5YtwmgqAweWZGr2Ox7OjAbjQv3Wo55QQP3UgID2jXbk
         dwwWHTEHh988J92DKnx0jDLBSrHt1xGdV9D+7X8wox+1mQoSkxs03p/mzf4SAL2qJMuh
         DMzwRPnR4b/toWdtVkwZWjmc8PdtL75iXOVVT+cGk+FnWAW9BP0oNiHa5SGhpnVHA7jO
         w2IpzFALFSSoV7m7r2nXqYZ+yJBmLMEB/uN0tes/tmRr8ZcRUgaJdLpqoxmZJMhHIDAF
         K0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3e5wbnegHeRX/hJTHNWrhDPE+mePTed2TBFVD0zzdU=;
        b=Mo9xV9O/BEfyrrMPOTgWhcE6iCFsNkBbqzl1g50g7+CT5RtrQnB3GmjECp8zyMYgDu
         V5f096B30ZkpKBDoq9FEYBwbmdUglLag32ZAF/ryFRUuF1IbCFOfbm2sgsnXU3pxxLO4
         vMDtfoOm5ZzTDUoV+N0Vbs49NwmaZukB7t7Sn+v94S6HKbW5n2oFt8vf3yLtPIQEpVh0
         7jiOD41g0ipoPWY3lsTlQRJLl7ih0jHUTCiLGzWhsfhMwW/T9YH6PZtJRxCM3m8pqVRj
         j2sy275g5yquzMqObnNnovJ2sDAYJEkNpoHOFxXVSShHIyYycg+33BEFTwEOnfS+pmvr
         1EOg==
X-Gm-Message-State: APjAAAUPD6EHYKmarZ7Q65FcVFx2urLwvOTAwr4C+6c+wvcef/h5P78y
        C2WnWubtr8LTvrbP3jf5mOsriOSr26WPs90VHss=
X-Google-Smtp-Source: APXvYqxNLFDvF0Jc8OwVu9LJ+6zdM0k+fYaovAM8wP7F1mMOdc1R0K9E7gAjVdtCsigB5xj68Ba+RU7xru8auhzN0q4=
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr14718033iot.200.1561920484443;
 Sun, 30 Jun 2019 11:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-9-kraxel@redhat.com>
 <CAPaKu7QjuKMJfhTVOzBsUb8cT9cGgesG_-skQeBO8hL8UqcAzw@mail.gmail.com> <20190628103412.f2n7ybp3qtxbhdk4@sirius.home.kraxel.org>
In-Reply-To: <20190628103412.f2n7ybp3qtxbhdk4@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 30 Jun 2019 11:47:53 -0700
Message-ID: <CAPaKu7Qvxp1poDoKz5Rft1uG0-7ijtTJQ-sLibvtewdZyVjXug@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:34 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > @@ -120,9 +120,9 @@ struct virtio_gpu_vbuffer {
> > >
> > >         char *resp_buf;
> > >         int resp_size;
> > > -
> > >         virtio_gpu_resp_cb resp_cb;
> > >
> > > +       struct virtio_gpu_object_array *objs;
> > This can use a comment (e.g., objects referenced by the vbuffer)
>
> IMHO this is obvious ...
>
> > >  void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
> > >                            void *data, uint32_t data_size,
> > > -                          uint32_t ctx_id, struct virtio_gpu_fence *fence);
> > > +                          uint32_t ctx_id, struct virtio_gpu_fence *fence,
> > > +                          struct virtio_gpu_object_array *objs);
> > Can we keep fence, which is updated, as the last parameter?
>
> Fixed.
>
> > > +       if (buflist) {
> > > +               for (i = 0; i < exbuf->num_bo_handles; i++)
> > > +                       reservation_object_add_excl_fence(buflist->objs[i]->resv,
> > > +                                                         &out_fence->f);
> > > +               drm_gem_unlock_reservations(buflist->objs, buflist->nents,
> > > +                                           &ticket);
> > > +       }
> > We used to unlock after virtio_gpu_cmd_submit.
> >
> > I guess, the fence is considered signaled (because its seqno is still
> > 0) until after virtio_gpu_cmd_submit.  We probably don't want other
> > processes to see the semi-initialized fence.
>
> Good point.  Fixed.
>
> > >  out_memdup:
> > >         kfree(buf);
> > >  out_unresv:
> > > -       ttm_eu_backoff_reservation(&ticket, &validate_list);
> > > -out_free:
> > > -       virtio_gpu_unref_list(&validate_list);
> > Keeping out_free to free buflist seems just fine.
>
> We don't need the separate label though ...
>
> > > +       drm_gem_unlock_reservations(buflist->objs, buflist->nents, &ticket);
> > >  out_unused_fd:
> > >         kvfree(bo_handles);
> > > -       kvfree(buflist);
> > > +       if (buflist)
> > > +               virtio_gpu_array_put_free(buflist);
>
> ... and the buflist is released here if needed.
>
> But we need if (buflist) for drm_gem_unlock_reservations too.  Fixed.
>
> > > -
> > > -               list_del(&entry->list);
> > > -               free_vbuf(vgdev, entry);
> > >         }
> > >         wake_up(&vgdev->ctrlq.ack_queue);
> > >
> > >         if (fence_id)
> > >                 virtio_gpu_fence_event_process(vgdev, fence_id);
> > > +
> > > +       list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
> > > +               if (entry->objs)
> > > +                       virtio_gpu_array_put_free(entry->objs);
> > > +               list_del(&entry->list);
> > We are clearing the list.  I guess list_del is not needed.
> > > +               free_vbuf(vgdev, entry);
>
> This just shuffles around the code.  Dropping list_del() is unrelated
> and should be a separate patch.
Fair point.  We now loop the list twice and I was just looking for
chances for micro-optimizations.
>
> Beside that I'm not sure it actually can be dropped.  free_vbuf() will
> not kfree() the vbuf but keep it cached in a freelist instead.
vbuf is created with kmem_cache_zalloc which always zeros the struct.

>
> cheers,
>   Gerd
>
