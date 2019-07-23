Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E6C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CAD218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3e4xd/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbfGWHoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:44:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36531 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfGWHoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:44:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so42086800wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0TLIYkO8uumi3GBhJE5lfTt9elr+issvmsKItiIQNs=;
        b=h3e4xd/3csB+FEz9ZFAL3Knn0E+wmwKhHl+FpqObJOWcpo+A4RKKGE48OXvgz5dnj5
         uEgl7ryLdc6BwaEu13KYLpCJkvwn9WQUx7j+ropAIEbU0m17pBXGIrt13avhd0dJ+XNB
         Mc9vr6g3zSem9Pw40/dbHbR/f4T1aUscpfKqLmt4rX09OW0UMShV5asiVkwX7cOwPAlb
         RWMhHx0nzY4OkmFENkkY4+dGWKYqwZHKGngWob628IvH7VM3eUVL6rkB8LB3B/zRBp8c
         xbhdu65++VvqR1YUI/261IpyYg/VorMW+eb7EadLHNT9BYTFHd5gozJwT95xoqL5g0SE
         XUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0TLIYkO8uumi3GBhJE5lfTt9elr+issvmsKItiIQNs=;
        b=WTdZQYMe4S1SC/6/3okpRvM9U+a1h2j4+vHK+NXFOdx5hsb3d/0BeMY7n4EsQVPqLv
         PPS8UcxfEgpGeVZR8EL5e5p9or0VWiUvPpVLgbMrLhqIrSN3MIVrHKerv+gdX4ZRQl1i
         qaKlFP2SFibqCMireRBMMxQuO2vqcw8aE8MaPxHnYS02+FFfkpXCxtXCVAZoCggZ9y7K
         QCp9xX8rmYbTM/U3lr11m4Shl9KNu5poQxzjUnXPwEEhRwqYP0SWjl3kekS21vdO2Ps4
         1vgYSnj6Ai/M2q4FRDJHiTfP9cW+gwKu/f4sy54ijj2TEfR20tx091j3viXQOjIWZbPI
         aSfg==
X-Gm-Message-State: APjAAAVG2Oqm54HfoNgxw500QURLDR/WElN1sAFqd8rJEMC3by5UaA9I
        aN4tlpLBYRICUYR7eiByrkTa1oPgPwO3Bt+0vjU=
X-Google-Smtp-Source: APXvYqyw1OuXBt3NTkk2OHYVFEhCrIaNB7tPzd27J71ZmyBFih4o1v/+pNe9nv+wfLPlxzuSkU8cpTrdoNCWvXUd8fs=
X-Received: by 2002:adf:f450:: with SMTP id f16mr48066341wrp.335.1563867860853;
 Tue, 23 Jul 2019 00:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190718081943.10272-1-daniel.baluta@nxp.com>
In-Reply-To: <20190718081943.10272-1-daniel.baluta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 23 Jul 2019 10:44:09 +0300
Message-ID: <CAEnQRZDwBBR5qQT9NQX7c6kyrjp2Mw_so=QgkARw-gUgj3VeEA@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx: Add DSP IPC protocol interface
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just realized that for this patch I forgot to add [PATCH v3]. Shawn,
should I resend?

Oleksij, care to have a look at this v3. It has a minor modification
but basically
all your review in v1 is still addressed.



On Thu, Jul 18, 2019 at 11:21 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> Some of i.MX8 processors (e.g i.MX8QM, i.MX8QXP) contain
> the Tensilica HiFi4 DSP for advanced pre- and post-audio
> processing.
>
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing
> and a dedicated Messaging Unit for notifications.
>
> DSP IPC protocol offers a doorbell interface using
> imx-mailbox API.
>
> We use 4 MU channels (2 x TXDB, 2 x RXDB) to implement a
> request-reply protocol.
>
> Connection 0 (txdb0, rxdb0):
>         - Host writes messasge to shared memory [SHMEM]
>         - Host sends a request [MU]
>         - DSP handles request [SHMEM]
>         - DSP sends reply [MU]
>
> Connection 1 (txdb1, rxdb1):
>         - DSP writes a message to shared memory [SHMEM]
>         - DSP sends a request [MU]
>         - Host handles request [SHMEM]
>         - Host sends reply [MU]
>
> The protocol interface will be used by a Host client to
> communicate with the DSP. First client will be the i.MX8
> part from Sound Open Firmware infrastructure.
>
> The protocol offers the following interface:
>
> On Tx:
>    - imx_dsp_ring_doorbell, will be called to notify the DSP
>    that it needs to handle a request.
>
> On Rx:
>    - clients need to provide two callbacks:
>         .handle_reply
>         .handle_request
>   - the callbacks will be used by the protocol on
>     notification arrival from DSP.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> Changes since v2:
>         - remove DSP IPC own DT node as per Rob comments
>         - make dsp responsability to add MU nodes
>         - already got a Reviewed-by from Oleksij but won't add it
>         here since he might have some comments about new changes.
>         - drop dt-bindings patch since the DSP IPC no longer have
>         an associated DT node
>
>  drivers/firmware/imx/Kconfig     |  11 +++
>  drivers/firmware/imx/Makefile    |   1 +
>  drivers/firmware/imx/imx-dsp.c   | 138 +++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/dsp.h |  67 +++++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 drivers/firmware/imx/imx-dsp.c
>  create mode 100644 include/linux/firmware/imx/dsp.h
>
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 42b566f8903f..0dbee32da4c6 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -1,4 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config IMX_DSP
> +       bool "IMX DSP Protocol driver"
> +       depends on IMX_MBOX
> +       help
> +         This enables DSP IPC protocol between host AP (Linux)
> +         and the firmware running on DSP.
> +         DSP exists on some i.MX8 processors (e.g i.MX8QM, i.MX8QXP).
> +
> +         It acts like a doorbell. Client might use shared memory to
> +         exchange information with DSP side.
> +
>  config IMX_SCU
>         bool "IMX SCU Protocol driver"
>         depends on IMX_MBOX
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 802c4ad8e8f9..08bc9ddfbdfb 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_IMX_DSP)          += imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)          += imx-scu.o misc.o imx-scu-irq.o
>  obj-$(CONFIG_IMX_SCU_PD)       += scu-pd.o
> diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
> new file mode 100644
> index 000000000000..b05bdb06662e
> --- /dev/null
> +++ b/drivers/firmware/imx/imx-dsp.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + *  Author: Daniel Baluta <daniel.baluta@nxp.com>
> + *
> + * Implementation of the DSP IPC interface (host side)
> + */
> +
> +#include <linux/firmware/imx/dsp.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/*
> + * imx_dsp_ring_doorbell - triggers an interrupt on the other side (DSP)
> + *
> + * @dsp: DSP IPC handle
> + * @chan_idx: index of the channel where to trigger the interrupt
> + *
> + * Returns non-negative value for success, negative value for error
> + */
> +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc, unsigned int idx)
> +{
> +       int ret;
> +       struct imx_dsp_chan *dsp_chan;
> +
> +       if (idx >= DSP_MU_CHAN_NUM)
> +               return -EINVAL;
> +
> +       dsp_chan = &ipc->chans[idx];
> +       ret = mbox_send_message(dsp_chan->ch, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(imx_dsp_ring_doorbell);
> +
> +/*
> + * imx_dsp_handle_rx - rx callback used by imx mailbox
> + *
> + * @c: mbox client
> + * @msg: message received
> + *
> + * Users of DSP IPC will need to privde handle_reply and handle_request
> + * callbacks.
> + */
> +static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
> +{
> +       struct imx_dsp_chan *chan = container_of(c, struct imx_dsp_chan, cl);
> +
> +       if (chan->idx == 0) {
> +               chan->ipc->ops->handle_reply(chan->ipc);
> +       } else {
> +               chan->ipc->ops->handle_request(chan->ipc);
> +               imx_dsp_ring_doorbell(chan->ipc, 1);
> +       }
> +}
> +
> +static int imx_dsp_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct imx_dsp_ipc *dsp_ipc;
> +       struct imx_dsp_chan *dsp_chan;
> +       struct mbox_client *cl;
> +       char *chan_name;
> +       int ret;
> +       int i, j;
> +
> +       device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> +
> +       dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
> +       if (!dsp_ipc)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
> +               if (i < 2)
> +                       chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
> +               else
> +                       chan_name = kasprintf(GFP_KERNEL, "rxdb%d", i - 2);
> +
> +               if (!chan_name)
> +                       return -ENOMEM;
> +
> +               dsp_chan = &dsp_ipc->chans[i];
> +               cl = &dsp_chan->cl;
> +               cl->dev = dev;
> +               cl->tx_block = false;
> +               cl->knows_txdone = true;
> +               cl->rx_callback = imx_dsp_handle_rx;
> +
> +               dsp_chan->ipc = dsp_ipc;
> +               dsp_chan->idx = i % 2;
> +               dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> +               if (IS_ERR(dsp_chan->ch)) {
> +                       ret = PTR_ERR(dsp_chan->ch);
> +                       if (ret != -EPROBE_DEFER)
> +                               dev_err(dev, "Failed to request mbox chan %s ret %d\n",
> +                                       chan_name, ret);
> +                       goto out;
> +               }
> +
> +               dev_dbg(dev, "request mbox chan %s\n", chan_name);
> +               /* chan_name is not used anymore by framework */
> +               kfree(chan_name);
> +       }
> +
> +       dsp_ipc->dev = dev;
> +
> +       dev_set_drvdata(dev, dsp_ipc);
> +
> +       dev_info(dev, "NXP i.MX DSP IPC initialized\n");
> +
> +       return devm_of_platform_populate(dev);
> +out:
> +       kfree(chan_name);
> +       for (j = 0; j < i; j++) {
> +               dsp_chan = &dsp_ipc->chans[j];
> +               mbox_free_channel(dsp_chan->ch);
> +       }
> +
> +       return ret;
> +}
> +
> +static struct platform_driver imx_dsp_driver = {
> +       .driver = {
> +               .name = "imx-dsp",
> +       },
> +       .probe = imx_dsp_probe,
> +};
> +builtin_platform_driver(imx_dsp_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
> +MODULE_DESCRIPTION("IMX DSP IPC protocol driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/firmware/imx/dsp.h b/include/linux/firmware/imx/dsp.h
> new file mode 100644
> index 000000000000..7562099c9e46
> --- /dev/null
> +++ b/include/linux/firmware/imx/dsp.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019 NXP
> + *
> + * Header file for the DSP IPC implementation
> + */
> +
> +#ifndef _IMX_DSP_IPC_H
> +#define _IMX_DSP_IPC_H
> +
> +#include <linux/device.h>
> +#include <linux/types.h>
> +#include <linux/mailbox_client.h>
> +
> +#define DSP_MU_CHAN_NUM                4
> +
> +struct imx_dsp_chan {
> +       struct imx_dsp_ipc *ipc;
> +       struct mbox_client cl;
> +       struct mbox_chan *ch;
> +       char *name;
> +       int idx;
> +};
> +
> +struct imx_dsp_ops {
> +       void (*handle_reply)(struct imx_dsp_ipc *ipc);
> +       void (*handle_request)(struct imx_dsp_ipc *ipc);
> +};
> +
> +struct imx_dsp_ipc {
> +       /* Host <-> DSP communication uses 2 txdb and 2 rxdb channels */
> +       struct imx_dsp_chan chans[DSP_MU_CHAN_NUM];
> +       struct device *dev;
> +       struct imx_dsp_ops *ops;
> +       void *private_data;
> +};
> +
> +static inline void imx_dsp_set_data(struct imx_dsp_ipc *ipc, void *data)
> +{
> +       if (!ipc)
> +               return;
> +
> +       ipc->private_data = data;
> +}
> +
> +static inline void *imx_dsp_get_data(struct imx_dsp_ipc *ipc)
> +{
> +       if (!ipc)
> +               return NULL;
> +
> +       return ipc->private_data;
> +}
> +
> +#if IS_ENABLED(CONFIG_IMX_DSP)
> +
> +int imx_dsp_ring_doorbell(struct imx_dsp_ipc *dsp, unsigned int chan_idx);
> +
> +#else
> +
> +static inline int imx_dsp_ring_doorbell(struct imx_dsp_ipc *ipc,
> +                                       unsigned int chan_idx)
> +{
> +       return -ENOTSUPP;
> +}
> +
> +#endif
> +#endif /* _IMX_DSP_IPC_H */
> --
> 2.17.1
>
