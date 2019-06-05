Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F03C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB242070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9vN1qtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFECkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:40:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41393 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFECkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:40:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so4250755qkk.8;
        Tue, 04 Jun 2019 19:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th/In1EH7UcyHmxW7K3uDsljxw8v1wY5CcUNV8kWPWQ=;
        b=m9vN1qtdZleGVMto+cOZMhkx6Kgbuj8mmg75Oa/DJfeJwL76Pu8EIp5ncAXiQLbrO4
         gSmiscK+BwWKCgiPw3WU0wxzk1GzUyZMhaLvDHgItcJcoq/JOVcsMRQbSsCxtkNKDEKP
         biJq570+7Dz8WU+BPr6BfGzHu6sjkm84/4rWr4Igeg3HoM6+0oR5XEBK5Z7qc8dMw/I+
         xmZG/1Z9LK4h5eNfOOWkFPHFZ6cXE+bGMGPcIJujPW9RpqH2AoFRKm+Xkf7ZJ3JmdcX5
         Le7HJaaJ2nmcd2x5kspmk+p5oRYXSO+zWpcstrFDOO9FzuEz1sFL7qxLdW8r6XNecwBI
         0mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th/In1EH7UcyHmxW7K3uDsljxw8v1wY5CcUNV8kWPWQ=;
        b=Dj74pbV49Uy1ba9hMIvST6DEtlfbFzMPAfEsTUZHc34GyJlNuo5sR4qYV0DlC2DilW
         SADLpsOiS1ithocb3ZkmU9iyxCKGLdYTR+c4LQMcrzPRefCUGw09+YrpY7IzXtc8xi2b
         J9Q+zmq7iz95LiDXEfIZ64bzhmCf9v+wZTubRWy8WmDRUtg4fMR635jk2o7I1iyUtUBe
         zN/hLFyKuJBy1EmX5pXPDAJX3aSVRzGhTNL8xucjXPovlh0lOqlVD7vy50c6m3i2sQB6
         0peDDHX3cOuag8AaOILAuMOedjQ5Njxfcl39cSeLHnXmjmp8Jhu43oKPDfodozS3e3X+
         PaFQ==
X-Gm-Message-State: APjAAAU+M/hDLrrlM8hBQJLGIWxITzgwhargzfSSRMbmjxsAXT8b5uwL
        go0XAbPuBdGgfedOr5vWoLPRMnQMdUIrwfGSEsv7ONpDvis=
X-Google-Smtp-Source: APXvYqxv1dF8beeJXku4qb8frV4bNnruTr+jGJVLRqeH2fjyubuCrCC+cZnP9DnapXg44nKFmy/GTRl6sDbGcfun7gY=
X-Received: by 2002:ae9:ed48:: with SMTP id c69mr29692139qkg.114.1559702431012;
 Tue, 04 Jun 2019 19:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-4-git-send-email-xiaoxiang@xiaomi.com> <bc0e287e-cadd-c61c-c6c4-28cad642b9eb@st.com>
 <CAH2Cfb_kCvyYpRS8BVgkmA0W7ZHjjCXcC7nhaXji2oMOuqm76w@mail.gmail.com> <eb650649-e8cc-dd7a-c579-7ffb580273b9@st.com>
In-Reply-To: <eb650649-e8cc-dd7a-c579-7ffb580273b9@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 5 Jun 2019 10:40:17 +0800
Message-ID: <CAH2Cfb8QOjDPRa9p--9qcnbJ7mbosDKXg59OQeVxB44GGY3_3w@mail.gmail.com>
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

On Tue, Jun 4, 2019 at 10:25 PM Arnaud Pouliquen
<arnaud.pouliquen@st.com> wrote:
>
> Hello Xiang,
>
> On 5/9/19 3:00 PM, xiang xiao wrote:
> > On Thu, May 9, 2019 at 8:36 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
> >>
> >> Hello Xiang,
> >>
> >> Similar mechanism has been proposed by Loic 2 years ago (link to the
> >> series here https://lkml.org/lkml/2017/3/28/349).
> >>
> >> Did you see them? Regarding history, patches seem just on hold...
> >>
> >
> > Just saw this patchset, so it's common problem hit by many vendor,
> > rpmsg framework need to address it.:)
> >
> >> Main differences (except interesting RX/TX size split) seems that you
> >> - don't use the virtio_config_ops->get
> >
> > virtio_cread call virtio_config_ops->get internally, the ideal is same
> > for both patch, just the implementation detail is different.
> >
> >> - define a new feature VIRTIO_RPMSG_F_NS.
> >
> > I add this flag to keep the compatibility with old remote peer, and
> > also follow the common virito driver practice.
> I discussed with Loic, he is ok to go further with your patch and
> abandon his one. Please find some remarks below in-line
> >
> >>
> >> Regards
> >> Arnaud
> >>
> >>
> >> On 1/31/19 4:41 PM, Xiang Xiao wrote:
> >>> 512 bytes isn't always suitable for all case, let firmware
> >>> maker decide the best value from resource table.
> >>> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
> >>>
> >>> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> >>> ---
> >>>  drivers/rpmsg/virtio_rpmsg_bus.c  | 50 +++++++++++++++++++++++++--------------
> >>>  include/uapi/linux/virtio_rpmsg.h | 24 +++++++++++++++++++
> >>>  2 files changed, 56 insertions(+), 18 deletions(-)
> >>>  create mode 100644 include/uapi/linux/virtio_rpmsg.h
> >>>
> >>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>> index 59c4554..049dd97 100644
> >>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> >>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> >>> @@ -16,6 +16,7 @@
> >>>  #include <linux/virtio.h>
> >>>  #include <linux/virtio_ids.h>
> >>>  #include <linux/virtio_config.h>
> >>> +#include <linux/virtio_rpmsg.h>
> >>>  #include <linux/scatterlist.h>
> >>>  #include <linux/dma-mapping.h>
> >>>  #include <linux/slab.h>
> >>> @@ -38,7 +39,8 @@
> >>>   * @sbufs:   kernel address of tx buffers
> >>>   * @num_rbufs:       total number of buffers for rx
> >>>   * @num_sbufs:       total number of buffers for tx
> >>> - * @buf_size:        size of one rx or tx buffer
> >>> + * @rbuf_size:       size of one rx buffer
> >>> + * @sbuf_size:       size of one tx buffer
> >>>   * @last_sbuf:       index of last tx buffer used
> >>>   * @rbufs_dma:       dma base addr of rx buffers
> >>>   * @sbufs_dma:       dma base addr of tx buffers
> >>> @@ -61,7 +63,8 @@ struct virtproc_info {
> >>>       void *rbufs, *sbufs;
> >>>       unsigned int num_rbufs;
> >>>       unsigned int num_sbufs;
> >>> -     unsigned int buf_size;
> >>> +     unsigned int rbuf_size;
> >>> +     unsigned int sbuf_size;
> >>>       int last_sbuf;
> >>>       dma_addr_t rbufs_dma;
> >>>       dma_addr_t sbufs_dma;
> >>> @@ -73,9 +76,6 @@ struct virtproc_info {
> >>>       struct rpmsg_endpoint *ns_ept;
> >>>  };
> >>>
> >>> -/* The feature bitmap for virtio rpmsg */
> >>> -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service notifications */
> >>> -
> >>>  /**
> >>>   * struct rpmsg_hdr - common header for all rpmsg messages
> >>>   * @src: source address
> >>> @@ -452,7 +452,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
> >>>
> >>>       /* either pick the next unused tx buffer */
> >>>       if (vrp->last_sbuf < vrp->num_sbufs)
> >>> -             ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
> >>> +             ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
> >>>       /* or recycle a used one */
> >>>       else
> >>>               ret = virtqueue_get_buf(vrp->svq, &len);
> >>> @@ -578,7 +578,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
> >>>        * messaging), or to improve the buffer allocator, to support
> >>>        * variable-length buffer sizes.
> >>>        */
> >>> -     if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
> >>> +     if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
> >>>               dev_err(dev, "message is too big (%d)\n", len);
> >>>               return -EMSGSIZE;
> >>>       }
> >>> @@ -718,7 +718,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >>>        * We currently use fixed-sized buffers, so trivially sanitize
> >>>        * the reported payload length.
> >>>        */
> >>> -     if (len > vrp->buf_size ||
> >>> +     if (len > vrp->rbuf_size ||
> >>>           msg->len > (len - sizeof(struct rpmsg_hdr))) {
> >>>               dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg->len);
> >>>               return -EINVAL;
> >>> @@ -751,7 +751,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
> >>>               dev_warn(dev, "msg received with no recipient\n");
> >>>
> >>>       /* publish the real size of the buffer */
> >>> -     rpmsg_sg_init(&sg, msg, vrp->buf_size);
> >>> +     rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
> >>>
> >>>       /* add the buffer back to the remote processor's virtqueue */
> >>>       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
> >>> @@ -907,11 +907,24 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>       else
> >>>               vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
> >>>
> >>> -     vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> >>> +     /* try to get buffer size from config space */
> >>> +     if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
> >>> +             /* note: virtio_rpmsg_config is defined from remote view */
> >>> +             virtio_cread(vdev, struct virtio_rpmsg_config,
> >>> +                          txbuf_size, &vrp->rbuf_size);
> >>> +             virtio_cread(vdev, struct virtio_rpmsg_config,
> >>> +                          rxbuf_size, &vrp->sbuf_size);
> >>> +     }
> >>> +
> >>> +     /* use the default if resource table doesn't provide one */
> >>> +     if (!vrp->rbuf_size)
> >>> +             vrp->rbuf_size = MAX_RPMSG_BUF_SIZE;
> In this case constant should be renamed DEFAULT_RPMSG_BUF_SIZE as it is
> no more a max value

Yes, DEFAULT_RPMSG_BUF_SIZE is more reasonable now.

> >>> +     if (!vrp->sbuf_size)
> >>> +             vrp->sbuf_size = MAX_RPMSG_BUF_SIZE;
> Here, if the config space exists you need to update it in consequence to
> ensure coherency with the remote processor config.

The update is already done in if (virtio_has_feature(vdev,
VIRTIO_RPMSG_F_BUFSZ)), here just handle the zero value in config
space which mean the remote side want to use the default value even
VIRTIO_RPMSG_F_BUFSZ set.
For example:
1.remote side want to change one direction buffer size, but keep
another direction as default
2.or remote side want to change other config options(define in the
furture) not the buffer size

>
> >>>
> >>>       /* allocate coherent memory for the buffers */
> >>>       vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> >>> -                                     vrp->num_rbufs * vrp->buf_size,
> >>> +                                     vrp->num_rbufs * vrp->rbuf_size,
> >>>                                       &vrp->rbufs_dma, GFP_KERNEL);
> >>>       if (!vrp->rbufs) {
> >>>               err = -ENOMEM;
> >>> @@ -922,7 +935,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>               vrp->rbufs, &vrp->rbufs_dma);
> >>>
> >>>       vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> >>> -                                     vrp->num_sbufs * vrp->buf_size,
> >>> +                                     vrp->num_sbufs * vrp->sbuf_size,
> >>>                                       &vrp->sbufs_dma, GFP_KERNEL);
> >>>       if (!vrp->sbufs) {
> >>>               err = -ENOMEM;
> >>> @@ -935,9 +948,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>       /* set up the receive buffers */
> >>>       for (i = 0; i < vrp->num_rbufs; i++) {
> >>>               struct scatterlist sg;
> >>> -             void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> >>> +             void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
> >>>
> >>> -             rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
> >>> +             rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
> >>>
> >>>               err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
> >>>                                         GFP_KERNEL);
> >>> @@ -984,11 +997,11 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >>>
> >>>  free_sbufs:
> >>>       dma_free_coherent(vdev->dev.parent->parent,
> >>> -                       vrp->num_sbufs * vrp->buf_size,
> >>> +                       vrp->num_sbufs * vrp->sbuf_size,
> >>>                         vrp->sbufs, vrp->sbufs_dma);
> >>>  free_rbufs:
> >>>       dma_free_coherent(vdev->dev.parent->parent,
> >>> -                       vrp->num_rbufs * vrp->buf_size,
> >>> +                       vrp->num_rbufs * vrp->rbuf_size,
> >>>                         vrp->rbufs, vrp->rbufs_dma);
> >>>  vqs_del:
> >>>       vdev->config->del_vqs(vrp->vdev);
> >>> @@ -1023,10 +1036,10 @@ static void rpmsg_remove(struct virtio_device *vdev)
> >>>       vdev->config->del_vqs(vrp->vdev);
> >>>
> >>>       dma_free_coherent(vdev->dev.parent->parent,
> >>> -                       vrp->num_sbufs * vrp->buf_size,
> >>> +                       vrp->num_sbufs * vrp->sbuf_size,
> >>>                         vrp->sbufs, vrp->sbufs_dma);
> >>>       dma_free_coherent(vdev->dev.parent->parent,
> >>> -                       vrp->num_rbufs * vrp->buf_size,
> >>> +                       vrp->num_rbufs * vrp->rbuf_size,
> >>>                         vrp->rbufs, vrp->rbufs_dma);
> >>>
> >>>       kfree(vrp);
> >>> @@ -1039,6 +1052,7 @@ static struct virtio_device_id id_table[] = {
> >>>
> >>>  static unsigned int features[] = {
> >>>       VIRTIO_RPMSG_F_NS,
> >>> +     VIRTIO_RPMSG_F_BUFSZ,
> >>>  };
> >>>
> >>>  static struct virtio_driver virtio_ipc_driver = {
> >>> diff --git a/include/uapi/linux/virtio_rpmsg.h b/include/uapi/linux/virtio_rpmsg.h
> >>> new file mode 100644
> >>> index 0000000..24fa0dd
> >>> --- /dev/null
> >>> +++ b/include/uapi/linux/virtio_rpmsg.h
> Strange to define a user space API for kernel usage need. Could you
> elaborate?

I just follow the practice other virtio drivers(e.g.
include/uapi/virtio_net.h) applied, but rpmsg driver don't need to
talk with the host VM software like other virtio driver, yes this
header file isn't really needed.

> >>> @@ -0,0 +1,24 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >>> +/*
> >>> + * Copyright (C) Pinecone Inc. 2019
> >>> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
> >>> + */
> >>> +
> >>> +#ifndef _UAPI_LINUX_VIRTIO_RPMSG_H
> >>> +#define _UAPI_LINUX_VIRTIO_RPMSG_H
> >>> +
> >>> +#include <linux/types.h>
> >>> +
> >>> +/* The feature bitmap for virtio rpmsg */
> >>> +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service notifications */
> >>> +#define VIRTIO_RPMSG_F_BUFSZ 2 /* RP get buffer size from config space */
> Would be useful to document it in rpmsg.txt

Good point, but it is better to put them into this document:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
like other vritio driver spec.

> >>> +
> >>> +struct virtio_rpmsg_config {
> >>> +     /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
> >>> +     __u32 txbuf_size;
> >>> +     __u32 rxbuf_size;
> >>> +     __u32 reserved[14]; /* Reserve for the future use */
> >>> +     /* Put the customize config here */
> >>> +} __attribute__((packed));
> >>> +
> Wouldn't it be better to add an identifier and a version fields at the
> beginning of the structure? Idea would be to simplify a future extension
> In this case is VIRTIO_RPMSG_F_BUFSZ still useful?
>

Yes, I consider this option before, but after review all
include/uapi/virtio_*.h, I found that virito driver prefer feature
bits than version number to handle the compability issue.
For example, if we need introduce more options in the furture, we need:
1.Add new feature bit to notice the option exist
2.Allocate the field from reserved space

> >>> +#endif /* _UAPI_LINUX_VIRTIO_RPMSG_H */
> >>>
> --
> Thanks
> Arnaud
