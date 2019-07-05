Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1611C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB2F20843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGEJGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:06:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50654 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfGEJGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:06:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE86F30860A0;
        Fri,  5 Jul 2019 09:05:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B3281BC67;
        Fri,  5 Jul 2019 09:05:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4FE3116E32; Fri,  5 Jul 2019 11:05:53 +0200 (CEST)
Date:   Fri, 5 Jul 2019 11:05:53 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 15/18] drm/virtio: rework
 virtio_gpu_transfer_to_host_ioctl fencing
Message-ID: <20190705090553.jx5zcdoxeimojq2i@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-16-kraxel@redhat.com>
 <CAPaKu7S0n=E7g0o2e6fEk1YjP+u=tsoV8upw7J=noSx88PgP+A@mail.gmail.com>
 <20190704115138.ou77sb3rlrex67tj@sirius.home.kraxel.org>
 <CAPaKu7SDwR1TgFQK2XGEbRqSkCO0XZYxGhcjzsAwOH42aOHEEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7SDwR1TgFQK2XGEbRqSkCO0XZYxGhcjzsAwOH42aOHEEw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 05 Jul 2019 09:06:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:08:14PM -0700, Chia-I Wu wrote:
> On Thu, Jul 4, 2019 at 4:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > >         convert_to_hw_box(&box, &args->box);
> > > >         if (!vgdev->has_virgl_3d) {
> > > >                 virtio_gpu_cmd_transfer_to_host_2d
> > > > -                       (vgdev, qobj, offset,
> > > > +                       (vgdev, gem_to_virtio_gpu_obj(objs->objs[0]), offset,
> > > >                          box.w, box.h, box.x, box.y, NULL);
> > > > +               virtio_gpu_array_put_free(objs);
> > > Don't we need this in non-3D case as well?
> >
> > No, ...
> >
> > > >                 virtio_gpu_cmd_transfer_to_host_3d
> > > > -                       (vgdev, qobj,
> > > > +                       (vgdev,
> > > >                          vfpriv ? vfpriv->ctx_id : 0, offset,
> > > > -                        args->level, &box, fence);
> > > > -               reservation_object_add_excl_fence(qobj->base.base.resv,
> > > > -                                                 &fence->f);
> > > > +                        args->level, &box, objs, fence);
> >
> > ... 3d case passes the objs list to virtio_gpu_cmd_transfer_to_host_3d,
> > so it gets added to the vbuf and released when the command is finished.
> Why doesn't this apply to virtio_gpu_cmd_transfer_to_host_2d?

Hmm, yes, makes sense to handle both the same way.

With virgl=off qemu processes the commands from the guest
synchronously, so it'll work fine as-is.  So you can't hit
the theoretical race window in practice.  But depending
on that host-side implementation detail isn't a good idea
indeed.

cheers,
  Gerd

