Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9EC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F78B20665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQ7/2/6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFNKJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:09:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36272 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFNKJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:09:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so1719834wmm.1;
        Fri, 14 Jun 2019 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tttA6QP3drU9UFZ8meFU4pNEjel88MoFarHf7RqWNG0=;
        b=uQ7/2/6HS8ExTK9uAfP12Bhl15IO8YnSUKnz1+VYd466/iP9Gwaj/PYu4aOp1E4hFA
         x08aopG/vj6EPwPEnhf7QkoHKZlWBLwxaoXbmyt5TU3/yCaSkNWJidCEQgABquokD9lT
         iMxnP5FH3nPxAiJ1ANZxhIBWNCS8iKtA2sUvITBOkJ4xOGyy42VfAcEFHVFHdN7AauCD
         bNzybTbBn2C2RWSo64WdtXCSAf4CzJZa+BDbNBr0cLHMA+B9Vd5Vm9XEzrTWGgnFpfQe
         QVOAcB2sLlpkTiQxw5JOTc7XyDg9on6Fq02UL5mZF4fpul40nR/JFSdkG5WdhRyMKS5A
         deQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tttA6QP3drU9UFZ8meFU4pNEjel88MoFarHf7RqWNG0=;
        b=NJS1ypVTO5lf6gjKjjr+yiEQRLtqDI/UZXw+z7AIm5r+BHjfVlZK/XIEONNcoEQuG4
         Sx6IesUgEg0lzXYiYvlEFOcHbk3MVQJQTtzmxP8lTNFotjO8m1PNZap5rihOZ8b10z4c
         78yaF/7rQ6KopMH9S97r9+k74q+fObj327/4lPGT2QvFbTJjISIweN8GeM3QH6m04EFh
         edft+n3OeliaFY6PAAniPxSdvSHDkwJsTvi14B9+BPVjTveO2B6lR0uHVQDJf9MUN9cM
         XU1cUxleV0nhbjv843FNI5bBJc9xLeorTVieW4dLAUOA7BIn2gQ/Y8NInVJ55Iwzv5lE
         IHHA==
X-Gm-Message-State: APjAAAXcIp3G6LEMMBLyW2U2aY3dhGh1BpwS6rNFTIAbS4Q9ejg8lcqj
        0xDMXKMEduV893vLRTi5XMxfNUb2mK8zoMq1w9A=
X-Google-Smtp-Source: APXvYqxNBpcJGXy5iu+MavJyA3/r4Y+qJh1Zy6rneXKcvJxT0Utb863yXxgiGtEt/vxmK5hyu36bARLqoFmqv6oQY3I=
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr6900329wmi.73.1560506967636;
 Fri, 14 Jun 2019 03:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-2-daniel.baluta@nxp.com>
 <20190614090815.lb2vnncqnom3fgu2@pengutronix.de>
In-Reply-To: <20190614090815.lb2vnncqnom3fgu2@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 14 Jun 2019 13:09:16 +0300
Message-ID: <CAEnQRZCCsWZUyeoaRns6HjjyG-u0Nrac9g9Ga5E2UiF=CJLqEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] firmware: imx: Add DSP IPC protocol driver
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:08 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi Daniel,
>
> please, see my review inline.

Thanks Oleksij for review. See my answers inline.

>
> On Fri, Jun 14, 2019 at 04:16:49PM +0800, daniel.baluta@nxp.com wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Some of i.MX8 processors (e.g i.MX8QM, i.MX8QXP) contain
> > the Tensilica HiFi4 DSP for advanced pre- and post-audio
> > processing.
> >
> > The communication between Host CPU and DSP firmware is
> > taking place using a shared memory area for message passing
> > and a dedicated Messaging Unit for notifications.
> >
> > DSP IPC protocol driver offers a doorbell interface using
> > imx-mailbox API.
> >
> > We use 4 MU channels (2 x TXDB, 2 x RXDB) to implement a
> > request-reply protocol.
> >
> > Connection 0 (txdb0, rxdb0):
> >         - Host writes messasge to shared memory [SHMEM]
> >       - Host sends a request [MU]
> >       - DSP handles request [SHMEM]
> >       - DSP sends reply [MU]
> >
> > Connection 1 (txdb1, rxdb1):
> >       - DSP writes a message to shared memory [SHMEM]
> >       - DSP sends a request [MU]
> >       - Host handles request [SHMEM]
> >       - Host sends reply [MU]
> >
> > The protocol driver will be used by a Host client to
> > communicate with the DSP. First client will be the i.MX8
> > part from Sound Open Firmware infrastructure.
> >
> > The protocol drivers offers the following interface:
> >
> > On Tx:
> >    - imx_dsp_ring_doorbell, will be called to notify the DSP
> >    that it needs to handle a request.
> >
> > On Rx:
> >    - clients need to provide two callbacks:
> >       .handle_reply
> >       .handle_request
> >   - the callbacks will be used by the protocol driver on
> >     notification arrival from DSP.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  drivers/firmware/imx/Kconfig     |  11 ++
> >  drivers/firmware/imx/Makefile    |   1 +
> >  drivers/firmware/imx/imx-dsp.c   | 167 +++++++++++++++++++++++++++++++
> >  include/linux/firmware/imx/dsp.h |  61 +++++++++++
> >  4 files changed, 240 insertions(+)
> >  create mode 100644 drivers/firmware/imx/imx-dsp.c
> >  create mode 100644 include/linux/firmware/imx/dsp.h
> >
> > diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> > index 42b566f8903f..383996b679a8 100644
> > --- a/drivers/firmware/imx/Kconfig
> > +++ b/drivers/firmware/imx/Kconfig
> > @@ -1,4 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +config IMX_DSP
> > +     bool "IMX DSP Protocol driver"
> > +     depends on IMX_MBOX
> > +     help
> > +       This enables DSP IPC protocol between host CPU (Linux)
> > +       and the firmware running on DSP.
> > +       DSP exists on some i.MX8 processors (e.g i.MX8QM, i.MX8QXP).
> > +
> > +          It acts like a doorbell. Client might use shared memory to
> > +       exchange information with DSP side.
> > +
> >  config IMX_SCU
> >       bool "IMX SCU Protocol driver"
> >       depends on IMX_MBOX
> > diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> > index 802c4ad8e8f9..08bc9ddfbdfb 100644
> > --- a/drivers/firmware/imx/Makefile
> > +++ b/drivers/firmware/imx/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_IMX_DSP)                += imx-dsp.o
> >  obj-$(CONFIG_IMX_SCU)                += imx-scu.o misc.o imx-scu-irq.o
> >  obj-$(CONFIG_IMX_SCU_PD)     += scu-pd.o
> > diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
> > new file mode 100644
> > index 000000000000..953fd364ad76
> > --- /dev/null
> > +++ b/drivers/firmware/imx/imx-dsp.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 NXP
> > + *  Author: Daniel Baluta <daniel.baluta@nxp.com>
> > + *
> > + * Implementation of the DSP IPC interface (host side)
> > + */
> > +
> > +#include <linux/firmware/imx/dsp.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mailbox_client.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +static struct imx_dsp_ipc *imx_dsp_handle;
> > +
> > +/*
> > + * Get the default handle used by DSP
> > + */
> > +int imx_dsp_get_handle(struct imx_dsp_ipc **ipc)
> > +{
> > +     if (!imx_dsp_handle)
> > +             return -EPROBE_DEFER;
> > +
> > +     *ipc = imx_dsp_handle;
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(imx_dsp_get_handle);
>
> Please, extract needed device or handle form device tree. The consumer
> should pars own device tree node and get the phandle to the dsp node.

I understand the idea, but I'm not sure how this can be done.

imx_dsp_handle is just a pointer to the memory allocated in imx_dsp_probe.

I assume that consumer might have access to this driver's
platform_device dev and
we can hive the imx_dsp_ipc handle inside some sort of private date. I will
investigate this. So far I have followed the approach taken in
drivers/firmware/imx/imx-scu.c

>
> > +void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data)
> > +{
> > +     if (!ipc)
> > +             return;
> > +
> > +     ipc->private_data = data;
> > +}
> > +EXPORT_SYMBOL(imx_dsp_set_data);
> > +
> > +void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
> > +{
> > +     if (!ipc)
> > +             return NULL;
> > +
> > +     return ipc->private_data;
> > +}
> > +EXPORT_SYMBOL(imx_dsp_get_data);
> > +
> > +/*
> > + * imx_dsp_ring_doorbell - triggers an interrupt on the other side (DSP)
> > + *
> > + * @dsp: DSP IPC handle
> > + * @chan_idx: index of the channel where to trigger the interrupt
> > + *
> > + * Returns non-negative value for success, negative value for error
> > + */
> > +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc, unsigned int idx)
> > +{
> > +     int ret;
> > +     struct imx_dsp_chan *dsp_chan;
> > +
> > +     if (idx > DSP_MU_CHAN_NUM)
> > +             return -EINVAL;
>
> On this test idx may overflow. DSP_MU_CHAN_NUM is 4, means idx can be:
> 0, 1, 2, 3. In you case idx == 4 is allowed, so the caller will be able
> to corrupt the rest of imx_dsp_ipc struct.

Indeed, you are right! Will fix in v2.

>
> > +     dsp_chan = &ipc->chans[idx];
> > +     ret = mbox_send_message(dsp_chan->ch, NULL);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(imx_dsp_ring_doorbell);
> > +
> > +/*
> > + * imx_dsp_handle_rx - rx callback used by imx mailbox
> > + *
> > + * @c: mbox client
> > + * @msg: message received
> > + *
> > + * Users of DSP IPC will need to privde handle_reply and handle_request
> > + * callbacks.
> > + */
> > +static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
> > +{
> > +     struct imx_dsp_chan *chan = container_of(c, struct imx_dsp_chan, cl);
> > +
> > +     if (chan->idx == 0) {
> > +             chan->ipc->ops->handle_reply(chan->ipc);
> > +     } else {
> > +             chan->ipc->ops->handle_request(chan->ipc);
> > +             imx_dsp_ring_doorbell(chan->ipc, 1);
> > +     }
> > +}
> > +
> > +static int imx_dsp_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct imx_dsp_ipc *dsp_ipc;
> > +     struct imx_dsp_chan *dsp_chan;
> > +     struct mbox_client *cl;
> > +     char *chan_name;
> > +     int ret;
> > +     int i;
> > +
> > +     dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
> > +     if (!dsp_ipc)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
> > +             if (i < 2)
> > +                     chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
> > +             else
> > +                     chan_name = kasprintf(GFP_KERNEL, "rxdb%d", i - 2);
> > +
> > +             if (!chan_name)
> > +                     return -ENOMEM;
> > +
> > +             dsp_chan = &dsp_ipc->chans[i];
> > +             cl = &dsp_chan->cl;
> > +             cl->dev = dev;
> > +             cl->tx_block = false;
> > +             cl->knows_txdone = true;
> > +             cl->rx_callback = imx_dsp_handle_rx;
> > +
> > +             dsp_chan->ipc = dsp_ipc;
> > +             dsp_chan->idx = i % 2;
> > +             dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> > +             if (IS_ERR(dsp_chan->ch)) {
> > +                     ret = PTR_ERR(dsp_chan->ch);
> > +                     if (ret != -EPROBE_DEFER)
> > +                             dev_err(dev, "Failed to request mbox chan %s ret %d\n",
> > +                                     chan_name, ret);
> > +                     return ret;
>
> On the error you will leak the memory previously allocated chan_name.
> And you should call mbox_free_channel() for each previously registered
> channel in this loop.

Will fix in v2.

>
> > +             }
> > +
> > +             dev_dbg(dev, "request mbox chan %s\n", chan_name);
> > +             /* chan_name is not used anymore by framework */
> > +             kfree(chan_name);
> > +     }
> > +
> > +     dsp_ipc->dev = dev;
> > +
> > +     imx_dsp_handle = dsp_ipc;
>
> bad idea. What happens if multiple dsp nodes are registered in the
> device tree?

True. Altough we have only one DSP. Having that global variable seemed
a very idea from the start. Will need to fix that also in imx-scu.c

>
> > +     dev_info(dev, "NXP i.MX DSP IPC initialized\n");
> > +
> > +     return devm_of_platform_populate(dev);
> > +}
> > +
> > +static const struct of_device_id imx_dsp_match[] = {
> > +     { .compatible = "fsl,imx-dsp", },
>
> i would prefer to have chip name in the compatible. For example
> fsl,imx8qm-dsp. Soon or later we will need to define some quirks
> for on or another chip.

I see. Will fix in v2.

>
> > +     { /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver imx_dsp_driver = {
> > +     .driver = {
> > +             .name = "imx-dsp",
> > +             .of_match_table = imx_dsp_match,
> > +     },
> > +     .probe = imx_dsp_probe,
> > +};
> > +builtin_platform_driver(imx_dsp_driver);
> > +
> > +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> > +MODULE_DESCRIPTION("IMX DSP IPC protocol driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
> > new file mode 100644
> > index 000000000000..75637d8fab34
> > --- /dev/null
> > +++ b/include/linux/firmware/imx/dsp.h
> > @@ -0,0 +1,61 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Copyright 2018 NXP
> > + *
> > + * Header file for the DSP IPC implementation
> > + */
> > +
> > +#ifndef _IMX_DSP_IPC_H
> > +#define _IMX_DSP_IPC_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/types.h>
> > +#include <linux/mailbox_client.h>
> > +
> > +#define DSP_MU_CHAN_NUM              4
> > +
> > +struct imx_dsp_chan {
> > +     struct imx_dsp_ipc *ipc;
> > +     struct mbox_client cl;
> > +     struct mbox_chan *ch;
> > +     int idx;
> > +};
> > +
> > +struct imx_dsp_ops {
> > +     void (*handle_reply)(struct imx_dsp_ipc *ipc);
> > +     void (*handle_request)(struct imx_dsp_ipc *ipc);
> > +};
> > +
> > +struct imx_dsp_ipc {
> > +     /* Host <-> DSP communication uses 2 txdb and 2 rxdb channels */
> > +     struct imx_dsp_chan chans[DSP_MU_CHAN_NUM];
> > +     struct device *dev;
> > +     struct imx_dsp_ops *ops;
> > +     void *private_data;
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_IMX_DSP)
> > +
> > +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
> > +int imx_dsp_get_handle(struct imx_dsp_ipc **ipc);
> > +void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data);
> > +void *imx_dsp_get_data(struct imx_dsp_ipc *ipc);
> > +
> > +#else
> > +
> > +static inline int imx_dsp_get_handle(struct imx_dsp_ipc **ipc)
> > +{
> > +     return -EIO;
>
> please, use -ENOTSUPP instead.

Makes sense. Will fix in v2.

thanks,
Daniel.
