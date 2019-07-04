Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68AAC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E674216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKiKA2Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGDTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 15:08:26 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35451 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGDTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:08:26 -0400
Received: by mail-io1-f50.google.com with SMTP id m24so5116779ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9btak+fKeivJpFWumZoTjMC0trVA+9MBYmqaPWrOHn0=;
        b=kKiKA2Bj2KAI7YLiGcXr0lnUd35Z3UyghngWdqXiuA02WwEsXazhsQZ2v/rgyYCWIH
         QIHGE6M8JPkfdOpDTW3UzfojE/jdlxwLksTRbmJMTtStjpQz8CGWJu/qF7ygua0YZEgx
         MZAT43VECo5VkmOouhrKOC82DAu+xzsJ9+fYC364Z+Ux3E64M4LkH+0oB4H2QVUGDLuc
         RT5MGIzK7yMVUmB8K99/ot6LYVjDmM2Mz+qfqYj+PU7GDG5x0Y3gx9YQJiemTx42YtI4
         MZpCNrpKfIjAWtnU5SUwmQ7+d79p6bmIychFN/kp1I0+ymcIhPYGJS4UOPL1qIcZDu6a
         K6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9btak+fKeivJpFWumZoTjMC0trVA+9MBYmqaPWrOHn0=;
        b=CtcZ01lnq0iyoWsmudRhymyLH5NSLD9F617fnOsbG7z72Gc7PK3FDxGxXKIT6MzvyK
         mVgJNrjgOnjUt/lPMeZx30WyrYatM3+0yfDBN5V+NBzG9ve47kZvX2XFr53OYnbSUG+8
         F2wiWeMJVJet8GYGLHhfoHTtfrsyFGo6iulXvGxx8Jn+IAtQnut9tCsWoW2HyObw9v2I
         6Q2nwSXMANoDGLVrgbNqkgigvu5frfMLcthFJmkAMlrS7P9bHHYbPyxJ1d+mJuA+6KfM
         mpA65SVZnUtagscEMozdWieL1Bp70HuKxu+n0su6vmiw9xuVp8iwWuJ7A5V24P6MGO0R
         jgIg==
X-Gm-Message-State: APjAAAXbVxbrOjiWIR4ED+Hg9A0AMV1cuIIz+noqlsjmeOMwiCbsyoJu
        Lle+XAuLIt3IxtgAQhruQnz44EgfMNM0rFC3CVM=
X-Google-Smtp-Source: APXvYqwVyWfwlxBxJohecI/H5oxgmdJ1n8iHxHi16NUSGnX6AI3z95oR6ILRv45iTfcdHoNfZuLXFs+sMg1SjT1yH1E=
X-Received: by 2002:a6b:6012:: with SMTP id r18mr5922135iog.241.1562267305070;
 Thu, 04 Jul 2019 12:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-16-kraxel@redhat.com>
 <CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com> <20190704115138.ou77sb3rlrex67tj@sirius.home.kraxel.org>
In-Reply-To: <20190704115138.ou77sb3rlrex67tj@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 4 Jul 2019 12:08:14 -0700
Message-ID: <CAPaKu7SDwR1TgFQK2XGEbRqSkCO0XZYxGhcjzsAwOH42aOHEEw@mail.gmail.com>
Subject: Re: [PATCH v6 15/18] drm/virtio: rework virtio_gpu_transfer_to_host_ioctl
 fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 4:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > >         convert_to_hw_box(&box, &args->box);
> > >         if (!vgdev->has_virgl_3d) {
> > >                 virtio_gpu_cmd_transfer_to_host_2d
> > > -                       (vgdev, qobj, offset,
> > > +                       (vgdev, gem_to_virtio_gpu_obj(objs->objs[0]), offset,
> > >                          box.w, box.h, box.x, box.y, NULL);
> > > +               virtio_gpu_array_put_free(objs);
> > Don't we need this in non-3D case as well?
>
> No, ...
>
> > >                 virtio_gpu_cmd_transfer_to_host_3d
> > > -                       (vgdev, qobj,
> > > +                       (vgdev,
> > >                          vfpriv ? vfpriv->ctx_id : 0, offset,
> > > -                        args->level, &box, fence);
> > > -               reservation_object_add_excl_fence(qobj->base.base.resv,
> > > -                                                 &fence->f);
> > > +                        args->level, &box, objs, fence);
>
> ... 3d case passes the objs list to virtio_gpu_cmd_transfer_to_host_3d,
> so it gets added to the vbuf and released when the command is finished.
Why doesn't this apply to virtio_gpu_cmd_transfer_to_host_2d?

When object array was introduced, it was said that the object array
was to keep the objects alive until the vbuf using the objects is
retired..  That sounded applicable to any vbuf that uses objects.


>
> cheers,
>   Gerd
>
