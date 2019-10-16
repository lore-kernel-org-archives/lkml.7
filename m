Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2491FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9AB20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mraH2iYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404636AbfJPKcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:32:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38680 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfJPKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:32:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so20910387edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwWeyz+aV65ylJM3Yds80Rd3NxT0cm8T84WXMLoHLPI=;
        b=mraH2iYXobhNOmURbFc7O/mUStcb4Ebna5NPbZzma6Hk2deMI6atn3eCu9BgRxGbSt
         SfqPC3S0bVEia/cWI8USOxbP0k4Li+B9yLKwE7CYqK0+Mj7nMGsVhWfxR+47Su+OHUel
         00cJl0qz2GJ4mS7pHBS0qZ2ovXYlE0pK9nf0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwWeyz+aV65ylJM3Yds80Rd3NxT0cm8T84WXMLoHLPI=;
        b=qZC9ARlvaoOZ4DlP14fyuf8VqDiVg32ET5i/7/6ZD/ftgi4DH94nV+g+tdzXIlRbOB
         Q/cols828lfJofjRyliAhkHIYRxZcct+IEHhO5uSw12UbApzVn66qGTfXnFEQskhO852
         C1lKRyCT3ZApysbiRbnf4WbYWmUfmsO2YsRU6T+3WTVdE/YU6YSUEfx8A/LlZFR4u3A2
         N3RAQVZlBHdKzZVo7cOwq956RT7OoBPuu6RaL2SJUOpENKSFtZUQEc1DyLFkssDVzugp
         LTxUWk3NnU05Y0wXtSp1Qn9gHhfA/U6ID+KwJCjtjdD1VJU7+gKQ0uFGh060icnw0VQf
         ejkA==
X-Gm-Message-State: APjAAAXJx7VdWxYQ1wppZxf0xxZYxq5Lw543VBuuHk1y9HgVu/L0V4C6
        2IRMTJxsv5enH08EIIcuU4kwkISySh2+MQ==
X-Google-Smtp-Source: APXvYqwjsIcJouGibXlwpD4NMBs+LSjfNKFFFQOMl6GvcrB/eoyhh6SCwKfcTPbq6gw8aNS8rDrDuA==
X-Received: by 2002:a17:906:1e07:: with SMTP id g7mr39926562ejj.256.1571221929875;
        Wed, 16 Oct 2019 03:32:09 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id f4sm4067327edf.47.2019.10.16.03.32.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 03:32:09 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id a6so2300710wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:32:08 -0700 (PDT)
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr2986693wmu.64.1571221927560;
 Wed, 16 Oct 2019 03:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190917132305.GV3958@phenom.ffwll.local>
 <CAAFQd5ADmObo1yVnFGaWDU=DHF+tex3tWJxTZLkxv=EdGNNM7A@mail.gmail.com>
 <20191008100328.GN16989@phenom.ffwll.local> <CAAFQd5CR2YhyNoSv7=nUhPQ7Nap6n36DrtsCfqS+-iWydAqbNA@mail.gmail.com>
 <20191008150435.GO16989@phenom.ffwll.local> <CAAFQd5DhKn_2uSA=1JDSj0H98aT8X9UjxWaTBwZCDfOC7YR5Sg@mail.gmail.com>
 <20191016091822.GR11828@phenom.ffwll.local>
In-Reply-To: <20191016091822.GR11828@phenom.ffwll.local>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 16 Oct 2019 19:31:55 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CuhqgrMrTCgOdsdUU_Qh5bhRT5f1A94xiQR5WkzSMTOA@mail.gmail.com>
Message-ID: <CAAFQd5CuhqgrMrTCgOdsdUU_Qh5bhRT5f1A94xiQR5WkzSMTOA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 6:18 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Oct 16, 2019 at 12:19:02PM +0900, Tomasz Figa wrote:
> > On Wed, Oct 9, 2019 at 12:04 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Tue, Oct 08, 2019 at 07:49:39PM +0900, Tomasz Figa wrote:
> > > > On Tue, Oct 8, 2019 at 7:03 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > >
> > > > > On Sat, Oct 05, 2019 at 02:41:54PM +0900, Tomasz Figa wrote:
> > > > > > Hi Daniel, Gerd,
> > > > > >
> > > > > > On Tue, Sep 17, 2019 at 10:23 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 12, 2019 at 06:41:21PM +0900, Tomasz Figa wrote:
> > > > > > > > This patch is an early RFC to judge the direction we are following in
> > > > > > > > our virtualization efforts in Chrome OS. The purpose is to start a
> > > > > > > > discussion on how to handle buffer sharing between multiple virtio
> > > > > > > > devices.
> > > > > > > >
> > > > > > > > On a side note, we are also working on a virtio video decoder interface
> > > > > > > > and implementation, with a V4L2 driver for Linux. Those will be posted
> > > > > > > > for review in the near future as well.
> > > > > > > >
> > > > > > > > Any feedback will be appreciated! Thanks in advance.
> > > > > > > >
> > > > > > > > ===
> > > > > > > >
> > > > > > > > With the range of use cases for virtualization expanding, there is going
> > > > > > > > to be more virtio devices added to the ecosystem. Devices such as video
> > > > > > > > decoders, encoders, cameras, etc. typically work together with the
> > > > > > > > display and GPU in a pipeline manner, which can only be implemented
> > > > > > > > efficiently by sharing the buffers between producers and consumers.
> > > > > > > >
> > > > > > > > Existing buffer management framework in Linux, such as the videobuf2
> > > > > > > > framework in V4L2, implements all the DMA-buf handling inside generic
> > > > > > > > code and do not expose any low level information about the buffers to
> > > > > > > > the drivers.
> > > > > > > >
> > > > > > > > To seamlessly enable buffer sharing with drivers using such frameworks,
> > > > > > > > make the virtio-gpu driver expose the resource handle as the DMA address
> > > > > > > > of the buffer returned from the DMA-buf mapping operation. Arguably, the
> > > > > > > > resource handle is a kind of DMA address already, as it is the buffer
> > > > > > > > identifier that the device needs to access the backing memory, which is
> > > > > > > > exactly the same role a DMA address provides for native devices.
> > > > > > > >
> > > > > > > > A virtio driver that does memory management fully on its own would have
> > > > > > > > code similar to following. The code is identical to what a regular
> > > > > > > > driver for real hardware would do to import a DMA-buf.
> > > > > > > >
> > > > > > > > static int virtio_foo_get_resource_handle(struct virtio_foo *foo,
> > > > > > > >                                         struct dma_buf *dma_buf, u32 *id)
> > > > > > > > {
> > > > > > > >       struct dma_buf_attachment *attach;
> > > > > > > >       struct sg_table *sgt;
> > > > > > > >       int ret = 0;
> > > > > > > >
> > > > > > > >       attach = dma_buf_attach(dma_buf, foo->dev);
> > > > > > > >       if (IS_ERR(attach))
> > > > > > > >               return PTR_ERR(attach);
> > > > > > > >
> > > > > > > >       sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> > > > > > > >       if (IS_ERR(sgt)) {
> > > > > > > >               ret = PTR_ERR(sgt);
> > > > > > > >               goto err_detach;
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       if (sgt->nents != 1) {
> > > > > > > >               ret = -EINVAL;
> > > > > > > >               goto err_unmap;
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       *id = sg_dma_address(sgt->sgl);
> > > > > > >
> > > > > > > I agree with Gerd, this looks pretty horrible to me.
> > > > > > >
> > > > > > > The usual way we've done these kind of special dma-bufs is:
> > > > > > >
> > > > > > > - They all get allocated at the same place, through some library or
> > > > > > >   whatever.
> > > > > > >
> > > > > > > - You add a dma_buf_is_virtio(dma_buf) function, or maybe something that
> > > > > > >   also upcasts or returns NULL, which checks for dma_buf->ops.
> > > > > > >
> > > > > >
> > > > > > Thanks for a lot of valuable feedback and sorry for the late reply.
> > > > > >
> > > > > > While I agree that stuffing the resource ID in sg_dma_address() is
> > > > > > quite ugly (for example, the regular address arithmetic doesn't work),
> > > > > > I still believe we need to convey information about these buffers
> > > > > > using regular kernel interfaces.
> > > > > >
> > > > > > Drivers in some subsystems like DRM tend to open code any buffer
> > > > > > management and then it wouldn't be any problem to do what you
> > > > > > suggested. However, other subsystems have generic frameworks for
> > > > > > buffer management, like videobuf2 for V4L2. Those assume regular
> > > > > > DMA-bufs that can be handled with regular dma_buf_() API and described
> > > > > > using sgtables and/or pfn vectors and/or DMA addresses.
> > > > >
> > > > > "other subsystem sucks" doesn't sound like a good design paradigm to me.
> > > > > Forced midlayers are a bad design decision isn't really new at all ...
> > > > >
> > > >
> > > > Sorry, I don't think that's an argument. There are various design
> > > > aspects and for the scenarios for which V4L2 was designed, the other
> > > > subsystems may actually "suck". Let's not derail the discussion into
> > > > judging which subsystems are better or worse.
> > > >
> > > > Those mid layers are not forced, you don't have to use videobuf2, but
> > > > it saves you a lot of open coding, potential security issues and so
> > > > on.
> > >
> > > Oh, it sounded like they're forced. If they're not then we should still be
> > > able to do whatever special handling we want/need to do.
> >
> > They aren't forced, but if one doesn't use them, they need to
> > reimplement the buffer queues in the driver. That's quite a big
> > effort, especially given the subtleties of stateful (i.e. fully
> > hardware-based) video decoding, such as frame buffer reordering,
> > dynamic resolution changes and so on.
> >
> > That said, we could still grab the DMA-buf FD directly in the V4L2
> > QBUF callback of the driver and save it in some map, so we can look it
> > up later when given a buffer index. But we would still need to make
> > the DMA-buf itself importable. For virtio-gpu I guess that would mean
> > returning an sg_table backed by the shadow buffer pages.
> >
> > By the way, have you received the emails from the other thread?
> > ([PATCH] [RFC] vdec: Add virtio video decode device specification)
>
> Yeah I've seen something fly by. Didn't look like I could contribute
> anything useful there.

Okay, thanks. Just wanted to make sure that there wasn't any issue
with my mailer.

Best regards,
Tomasz

> -Daniel
>
> >
> > Best regards,
> > Tomasz
> >
> >
> > > -Daniel
> > >
> > > >
> > > > > > > - Once you've upcasted at runtime by checking for ->ops, you can add
> > > > > > >   whatever fancy interfaces you want. Including a real&proper interface to
> > > > > > >   get at whatever underlying id you need to for real buffer sharing
> > > > > > >   between virtio devices.
> > > > > > >
> > > > > > > In a way virtio buffer/memory ids are a kind of private bus, entirely
> > > > > > > distinct from the dma_addr_t bus. So can't really stuff them under this
> > > > > > > same thing like we e.g. do with pci peer2peer.
> > > > > >
> > > > > > As I mentioned earlier, there is no single "dma_addr_t bus". Each
> > > > > > device (as in struct device) can be on its own different DMA bus, with
> > > > > > a different DMA address space. There is not even a guarantee that a
> > > > > > DMA address obtained for one PCI device will be valid for another if
> > > > > > they are on different buses, which could have different address
> > > > > > mappings.
> > > > > >
> > > > > > Putting that aside, we're thinking about a different approach, as Gerd
> > > > > > suggested in another thread, the one about the Virtio Video Decoder
> > > > > > protocol. I'm going to reply there, making sure to CC everyone
> > > > > > involved here.
> > > > >
> > > > > ok.
> > > > > -Daniel
> > > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Tomasz
> > > > > >
> > > > > > > -Daniel
> > > > > > >
> > > > > > > >
> > > > > > > > err_unmap:
> > > > > > > >       dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> > > > > > > > err_detach:
> > > > > > > >       dma_buf_detach(dma_buf, attach);
> > > > > > > >
> > > > > > > >       return ret;
> > > > > > > > }
> > > > > > > >
> > > > > > > > On the other hand, a virtio driver that uses an existing kernel
> > > > > > > > framework to manage buffers would not need to explicitly handle anything
> > > > > > > > at all, as the framework part responsible for importing DMA-bufs would
> > > > > > > > already do the work. For example, a V4L2 driver using the videobuf2
> > > > > > > > framework would just call thee vb2_dma_contig_plane_dma_addr() function
> > > > > > > > to get what the above open-coded function would return.
> > > > > > > >
> > > > > > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 +
> > > > > > > >  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++
> > > > > > > >  drivers/gpu/drm/virtio/virtgpu_prime.c | 81 ++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 87 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > > > > > index 0fc32fa0b3c0..ac095f813134 100644
> > > > > > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > > > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> > > > > > > > @@ -210,6 +210,8 @@ static struct drm_driver driver = {
> > > > > > > >  #endif
> > > > > > > >       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > > > > > > >       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> > > > > > > > +     .gem_prime_export = virtgpu_gem_prime_export,
> > > > > > > > +     .gem_prime_import = virtgpu_gem_prime_import,
> > > > > > > >       .gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
> > > > > > > >       .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
> > > > > > > >       .gem_prime_vmap = virtgpu_gem_prime_vmap,
> > > > > > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > > > > > index e28829661724..687cfce91885 100644
> > > > > > > > --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > > > > > +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> > > > > > > > @@ -367,6 +367,10 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
> > > > > > > >  int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
> > > > > > > >
> > > > > > > >  /* virtgpu_prime.c */
> > > > > > > > +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> > > > > > > > +                                      int flags);
> > > > > > > > +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> > > > > > > > +                                             struct dma_buf *buf);
> > > > > > > >  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> > > > > > > >  struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> > > > > > > >       struct drm_device *dev, struct dma_buf_attachment *attach,
> > > > > > > > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > > > > > index dc642a884b88..562eb1a2ed5b 100644
> > > > > > > > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > > > > > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > > > > > > > @@ -22,6 +22,9 @@
> > > > > > > >   * Authors: Andreas Pokorny
> > > > > > > >   */
> > > > > > > >
> > > > > > > > +#include <linux/dma-buf.h>
> > > > > > > > +#include <linux/dma-direction.h>
> > > > > > > > +
> > > > > > > >  #include <drm/drm_prime.h>
> > > > > > > >
> > > > > > > >  #include "virtgpu_drv.h"
> > > > > > > > @@ -30,6 +33,84 @@
> > > > > > > >   * device that might share buffers with virtgpu
> > > > > > > >   */
> > > > > > > >
> > > > > > > > +static struct sg_table *
> > > > > > > > +virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
> > > > > > > > +                     enum dma_data_direction dir)
> > > > > > > > +{
> > > > > > > > +     struct drm_gem_object *obj = attach->dmabuf->priv;
> > > > > > > > +     struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > > > > > > > +     struct sg_table *sgt;
> > > > > > > > +     int ret;
> > > > > > > > +
> > > > > > > > +     sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> > > > > > > > +     if (!sgt)
> > > > > > > > +             return ERR_PTR(-ENOMEM);
> > > > > > > > +
> > > > > > > > +     ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> > > > > > > > +     if (ret) {
> > > > > > > > +             kfree(sgt);
> > > > > > > > +             return ERR_PTR(-ENOMEM);
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     sg_dma_address(sgt->sgl) = bo->hw_res_handle;
> > > > > > > > +     sg_dma_len(sgt->sgl) = obj->size;
> > > > > > > > +     sgt->nents = 1;
> > > > > > > > +
> > > > > > > > +     return sgt;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > > > > > > > +                                   struct sg_table *sgt,
> > > > > > > > +                                   enum dma_data_direction dir)
> > > > > > > > +{
> > > > > > > > +     sg_free_table(sgt);
> > > > > > > > +     kfree(sgt);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static const struct dma_buf_ops virtgpu_dmabuf_ops =  {
> > > > > > > > +     .cache_sgt_mapping = true,
> > > > > > > > +     .attach = drm_gem_map_attach,
> > > > > > > > +     .detach = drm_gem_map_detach,
> > > > > > > > +     .map_dma_buf = virtgpu_gem_map_dma_buf,
> > > > > > > > +     .unmap_dma_buf = virtgpu_gem_unmap_dma_buf,
> > > > > > > > +     .release = drm_gem_dmabuf_release,
> > > > > > > > +     .mmap = drm_gem_dmabuf_mmap,
> > > > > > > > +     .vmap = drm_gem_dmabuf_vmap,
> > > > > > > > +     .vunmap = drm_gem_dmabuf_vunmap,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
> > > > > > > > +                                      int flags)
> > > > > > > > +{
> > > > > > > > +     struct dma_buf *buf;
> > > > > > > > +
> > > > > > > > +     buf = drm_gem_prime_export(obj, flags);
> > > > > > > > +     if (!IS_ERR(buf))
> > > > > > > > +             buf->ops = &virtgpu_dmabuf_ops;
> > > > > > > > +
> > > > > > > > +     return buf;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
> > > > > > > > +                                             struct dma_buf *buf)
> > > > > > > > +{
> > > > > > > > +     struct drm_gem_object *obj;
> > > > > > > > +
> > > > > > > > +     if (buf->ops == &virtgpu_dmabuf_ops) {
> > > > > > > > +             obj = buf->priv;
> > > > > > > > +             if (obj->dev == dev) {
> > > > > > > > +                     /*
> > > > > > > > +                      * Importing dmabuf exported from our own gem increases
> > > > > > > > +                      * refcount on gem itself instead of f_count of dmabuf.
> > > > > > > > +                      */
> > > > > > > > +                     drm_gem_object_get(obj);
> > > > > > > > +                     return obj;
> > > > > > > > +             }
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return drm_gem_prime_import(dev, buf);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > > > > > > >  {
> > > > > > > >       struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > > > > > > > --
> > > > > > > > 2.23.0.237.gc6a4ce50a0-goog
> > > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Daniel Vetter
> > > > > > > Software Engineer, Intel Corporation
> > > > > > > http://blog.ffwll.ch
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
