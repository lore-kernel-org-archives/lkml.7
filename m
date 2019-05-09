Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673D7C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579820989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 13:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD8lE6ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEINAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 09:00:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36859 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfEINAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:00:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so1077441qth.3;
        Thu, 09 May 2019 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFf5YJI+u+GR5yZiIxTRCn38IQWix2LIwu6HPgqqURU=;
        b=QD8lE6ld6rdy4QFqLGk9mbXYDZneaTGvZ+hF+RE4vU7+9154wQc7Z1c/fXfYd9bh2G
         RzCahup8OiTP7V8rBzqgjaIdMjI91peAVFKqr7+gTcuMeyAIj43UdIHshARCdfrOxrpo
         KlwLsCmazdxHF4peTlewZOrUipTTzpGyAPa9IAxGIjJYJdDzYv+/k5MPmgVSOVl3DI0G
         s5tS5UN09uGKba6OmLOa8DMYkBb4hxwjUosfdx/5zYhDk/Lfvpn4rdXU/QS8rmpY2BpS
         v6BWxNqjH2HhArgMYo3Xd7cZDTVugiq1AAyi7VcFamVEV+mnzeGkWQbtY07Sgy2seCpU
         rAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFf5YJI+u+GR5yZiIxTRCn38IQWix2LIwu6HPgqqURU=;
        b=IZ/u2uEexbCwv0noEWDUO7F33TAjCommAIUpPurWZPsN6B5kpJt/T3gV4ox3n+gtu6
         3mgf4aKHk5ny/Q/Xm0Ef7pZFOxMNqAw6FzAli48eIza+cEEMoqBXIenhrCBfcp+0awo3
         HgOB/3I/+Vb3kL+X8oETznj0/KHHaa7GjDAzrx040cdBvqdU/pJDyVkCwimx6iD97yjy
         FhxPhg0Km0fbz18CIPMqKcBDjJ9Dyh6MQhXTEvPWjNQYxa+DstcPb2AaHVQs/MJxNPAC
         Gxwk9/WHiZR6cF9kV4V4k6Igp9EjZDFKkvZIKUxBk+bPyACtcm1ggzx0IjPGAdhLxSIA
         +heA==
X-Gm-Message-State: APjAAAX1MAnYyAfxWsdB61GSW93NKTBbvAxi3jpO6T1j3pMdykwISjUD
        3KjY7Olmvdq8STeP8xhCWDyGbLo1oASO573wy90=
X-Google-Smtp-Source: APXvYqzAagP/WoP7Sg52D+mHpEV8Oq5swHUFKZADFawvZsZ+xXB6WH3QOJG2kgbSIHGFbqP8Kk6u0hgXiS9MZQSWcgU=
X-Received: by 2002:ac8:2291:: with SMTP id f17mr3529626qta.330.1557406820839;
 Thu, 09 May 2019 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-4-git-send-email-xiaoxiang@xiaomi.com> <bc0e287e-cadd-c61c-c6c4-28cad642b9eb@st.com>
In-Reply-To: <bc0e287e-cadd-c61c-c6c4-28cad642b9eb@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Thu, 9 May 2019 21:00:08 +0800
Message-ID: <CAH2Cfb_kCvyYpRS8BVgkmA0W7ZHjjCXcC7nhaXji2oMOuqm76w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rpmsg: virtio_rpmsg_bus: get buffer size from config space
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 8:36 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>
> Hello Xiang,
>
> Similar mechanism has been proposed by Loic 2 years ago (link to the
> series here https://lkml.org/lkml/2017/3/28/349).
>
> Did you see them? Regarding history, patches seem just on hold...
>

Just saw this patchset, so it's common problem hit by many vendor,
rpmsg framework need to address it.:)

> Main differences (except interesting RX/TX size split) seems that you
> - don't use the virtio_config_ops->get

virtio_cread call virtio_config_ops->get internally, the ideal is same
for both patch, just the implementation detail is different.

> - define a new feature VIRTIO_RPMSG_F_NS.

I add this flag to keep the compatibility with old remote peer, and
also follow the common virito driver practice.

>
> Regards
> Arnaud
>
>
> On 1/31/19 4:41 PM, Xiang Xiao wrote:
> > 512 bytes isn't always suitable for all case, let firmware
> > maker decide the best value from resource table.
> > enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> >
> > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c  | 50 +++++++++++++++++++++++++--------------
> >  include/uapi/linux/virtio_rpmsg.h | 24 +++++++++++++++++++
> >  2 files changed, 56 insertions(+), 18 deletions(-)
> >  create mode 100644 include/uapi/linux/virtio_rpmsg.h
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 59c4554..049dd97 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_ids.h>
> >  #include <linux/virtio_config.h>
> > +#include <linux/virtio_rpmsg.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/slab.h>
> > @@ -38,7 +39,8 @@
> >   * @sbufs:   kernel address of tx buffers
> >   * @num_rbufs:       total number of buffers for rx
> >   * @num_sbufs:       total number of buffers for tx
> > - * @buf_size:        size of one rx or tx buffer
> > + * @rbuf_size:       size of one rx buffer
> > + * @sbuf_size:       size of one tx buffer
> >   * @last_sbuf:       index of last tx buffer used
> >   * @rbufs_dma:       dma base addr of rx buffers
> >   * @sbufs_dma:       dma base addr of tx buffers
> > @@ -61,7 +63,8 @@ struct virtproc_info {
> >       void *rbufs, *sbufs;
> >       unsigned int num_rbufs;
> >       unsigned int num_sbufs;
> > -     unsigned int buf_size;
> > +     unsigned int rbuf_size;
> > +     unsigned int sbuf_size;
> >       int last_sbuf;
> >       dma_addr_t rbufs_dma;
> >       dma_addr_t sbufs_dma;
> > @@ -73,9 +76,6 @@ struct virtproc_info {
> >       struct rpmsg_endpoint *ns_ept;
> >  };
> >
> > -/* The feature bitmap for virtio rpmsg */
> > -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service notifications */
> > -
> >  /**
> >   * struct rpmsg_hdr - common header for all rpmsg messages
> >   * @src: source address
> > @@ -452,7 +452,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
> >
> >       /* either pick the next unused tx buffer */
> >       if (vrp->last_sbuf < vrp->num_sbufs)
> > -             ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> > +             ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
> >       /* or recycle a used one */
> >       else
> >               ret = virtqueue_get_buf(vrp->svq, &len);
> > @@ -578,7 +578,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
> >        * messaging), or to improve the buffer allocator, to support
> >        * variable-length buffer sizes.
> >        */
> > -     if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> > +     if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
> >               dev_err(dev, "message is too big (%d)\n", len);
> >               return -EMSGSIZE;
> >       }
> > @@ -718,7 +718,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >        * We currently use fixed-sized buffers, so trivially sanitize
> >        * the reported payload length.
> >        */
> > -     if (len > vrp->buf_size ||
> > +     if (len > vrp->rbuf_size ||
> >           msg->len > (len - sizeof(struct rpmsg_hdr))) {
> >               dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg->len);
> >               return -EINVAL;
> > @@ -751,7 +751,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >               dev_warn(dev, "msg received with no recipient\n");
> >
> >       /* publish the real size of the buffer */
> > -     rpmsg_sg_init(&sg, msg, vrp->buf_size);
> > +     rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
> >
> >       /* add the buffer back to the remote processor's virtqueue */
> >       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> > @@ -907,11 +907,24 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >       else
> >               vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
> >
> > -     vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> > +     /* try to get buffer size from config space */
> > +     if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> > +             /* note: virtio_rpmsg_config is defined from remote view */
> > +             virtio_cread(vdev, struct virtio_rpmsg_config,
> > +                          txbuf_size, &vrp->rbuf_size);
> > +             virtio_cread(vdev, struct virtio_rpmsg_config,
> > +                          rxbuf_size, &vrp->sbuf_size);
> > +     }
> > +
> > +     /* use the default if resource table doesn't provide one */
> > +     if (!vrp->rbuf_size)
> > +             vrp->rbuf_size = MAX_RPMSG_BUF_SIZE;
> > +     if (!vrp->sbuf_size)
> > +             vrp->sbuf_size = MAX_RPMSG_BUF_SIZE;
> >
> >       /* allocate coherent memory for the buffers */
> >       vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> > -                                     vrp->num_rbufs * vrp->buf_size,
> > +                                     vrp->num_rbufs * vrp->rbuf_size,
> >                                       &vrp->rbufs_dma, GFP_KERNEL);
> >       if (!vrp->rbufs) {
> >               err = -ENOMEM;
> > @@ -922,7 +935,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >               vrp->rbufs, &vrp->rbufs_dma);
> >
> >       vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> > -                                     vrp->num_sbufs * vrp->buf_size,
> > +                                     vrp->num_sbufs * vrp->sbuf_size,
> >                                       &vrp->sbufs_dma, GFP_KERNEL);
> >       if (!vrp->sbufs) {
> >               err = -ENOMEM;
> > @@ -935,9 +948,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >       /* set up the receive buffers */
> >       for (i = 0; i < vrp->num_rbufs; i++) {
> >               struct scatterlist sg;
> > -             void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > +             void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
> >
> > -             rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> > +             rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
> >
> >               err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> >                                         GFP_KERNEL);
> > @@ -984,11 +997,11 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >
> >  free_sbufs:
> >       dma_free_coherent(vdev->dev.parent->parent,
> > -                       vrp->num_sbufs * vrp->buf_size,
> > +                       vrp->num_sbufs * vrp->sbuf_size,
> >                         vrp->sbufs, vrp->sbufs_dma);
> >  free_rbufs:
> >       dma_free_coherent(vdev->dev.parent->parent,
> > -                       vrp->num_rbufs * vrp->buf_size,
> > +                       vrp->num_rbufs * vrp->rbuf_size,
> >                         vrp->rbufs, vrp->rbufs_dma);
> >  vqs_del:
> >       vdev->config->del_vqs(vrp->vdev);
> > @@ -1023,10 +1036,10 @@ static void rpmsg_remove(struct virtio_device *vdev)
> >       vdev->config->del_vqs(vrp->vdev);
> >
> >       dma_free_coherent(vdev->dev.parent->parent,
> > -                       vrp->num_sbufs * vrp->buf_size,
> > +                       vrp->num_sbufs * vrp->sbuf_size,
> >                         vrp->sbufs, vrp->sbufs_dma);
> >       dma_free_coherent(vdev->dev.parent->parent,
> > -                       vrp->num_rbufs * vrp->buf_size,
> > +                       vrp->num_rbufs * vrp->rbuf_size,
> >                         vrp->rbufs, vrp->rbufs_dma);
> >
> >       kfree(vrp);
> > @@ -1039,6 +1052,7 @@ static struct virtio_device_id id_table[] = {
> >
> >  static unsigned int features[] = {
> >       VIRTIO_RPMSG_F_NS,
> > +     VIRTIO_RPMSG_F_BUFSZ,
> >  };
> >
> >  static struct virtio_driver virtio_ipc_driver = {
> > diff --git a/include/uapi/linux/virtio_rpmsg.h b/include/uapi/linux/virtio_rpmsg.h
> > new file mode 100644
> > index 0000000..24fa0dd
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_rpmsg.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) Pinecone Inc. 2019
> > + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> > + */
> > +
> > +#ifndef _UAPI_LINUX_VIRTIO_RPMSG_H
> > +#define _UAPI_LINUX_VIRTIO_RPMSG_H
> > +
> > +#include <linux/types.h>
> > +
> > +/* The feature bitmap for virtio rpmsg */
> > +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service notifications */
> > +#define VIRTIO_RPMSG_F_BUFSZ 2 /* RP get buffer size from config space */
> > +
> > +struct virtio_rpmsg_config {
> > +     /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> > +     __u32 txbuf_size;
> > +     __u32 rxbuf_size;
> > +     __u32 reserved[14]; /* Reserve for the future use */
> > +     /* Put the customize config here */
> > +} __attribute__((packed));
> > +
> > +#endif /* _UAPI_LINUX_VIRTIO_RPMSG_H */
> >
