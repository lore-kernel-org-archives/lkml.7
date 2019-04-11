Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EB7C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0B2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0b9VJRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDKOJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:09:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39027 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:09:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id a96so3476608pla.6;
        Thu, 11 Apr 2019 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PPjleAfV7xHDBq3M8dTEGwescQ1aUf43BZfhxZhFtY=;
        b=U0b9VJRAgbnEySeWezMMKCR9n0G7KzFPBVsoijp+ZJ1ZSGtZ7anFCc8jN9PkgQLSl5
         P8CIzyGijQ70UmOmHnMa4yX1OrXT6E2j12n/JJzuc2p/tv/cvR548kMddzqCyQn4WBHQ
         lLO+ZL/r5X0GMjgZdAx4WkgSAxsvBxW3j8xcVgBeRVY95Pk3IhkA6ITo8bLnZKeE7QWZ
         Xn+eFAS0l4wwx4PBKoAYkr2hkvxOKtL3ehZalq9E0aGR9+F9RyLncYNOLVlhifNkUkqR
         c700b2dhAOWHvgk4lUK850a/uirxKfanzTADSBpgH9dgFPl/eXMp0MnDXweOtJxF5/yo
         wNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PPjleAfV7xHDBq3M8dTEGwescQ1aUf43BZfhxZhFtY=;
        b=MkoR7K7gpGzudLrkD6MCVhYgsfZwIt5UizR0qWNb2SPKEuboyh4yKs8oSGKv6IlUhg
         573R7ANfwhvmMm7Kq7ddrNGGvV4q7TXtc7qxV8qujRIDNOm22ipLCNX2vyATs65v/PVj
         thrtCVnkx3UqlBo36RTQXXCwhphB1hIRPBrC+NHMsoHrRUyd14LjIoH8j6VLVU8PFfcA
         BVS4w1AGZV3akPVwRfbBX8t64F/M71225/JlKvmBGA3RSr4qAO/sHohLL3XDuv55lkGX
         c1rjeAJu2wegqYeyfIpNFIBP03e0YRGo848gFOHIq1JPAfr4jsz81W5RIJJX4kEzQBaY
         EGiw==
X-Gm-Message-State: APjAAAX92RiDFCuOIk++ocoPuXamYUiJPucLCo3gpIDMGcOjvq2THYWK
        bm7Z0gBADdRy4i2hjK3XMiTl8FwBFcBw5Zr8wbk=
X-Google-Smtp-Source: APXvYqylppYs8AvY5pR2BZLfrJ3gk1eJUG6q+Vg6x+Ffy3+FY/vIAUPKqcTJvLp6jf1MqZRl6hPdMTLJ/e9hInpMfG8=
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr51505715plb.222.1554991795139;
 Thu, 11 Apr 2019 07:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1554602585-6853-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1554602585-6853-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Apr 2019 17:09:43 +0300
Message-ID: <CAHp75Vdo2oJ8umHh4J_9a3cFQHO3Nk3ss+HAJpaXUT=kHZhCng@mail.gmail.com>
Subject: Re: [PATCH v14] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
To:     Liming Sun <lsun@mellanox.com>
Cc:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 7, 2019 at 5:03 AM Liming Sun <lsun@mellanox.com> wrote:
>
> This commit adds the TmFifo platform driver for Mellanox BlueField
> Soc. TmFifo is a shared FIFO which enables external host machine
> to exchange data with the SoC via USB or PCIe. The driver is based
> on virtio framework and has console and network access enabled.

Thanks for an update, my comments below.

> +/**
> + * mlxbf_tmfifo_vdev - Structure of the TmFifo virtual device
> + * @vdev: virtio device, in which the vdev.id.device field has the
> + *        VIRTIO_ID_xxx id to distinguish the virtual device.
> + * @status: status of the device
> + * @features: supported features of the device
> + * @vrings: array of tmfifo vrings of this device
> + * @config.cons: virtual console config -
> + *               select if vdev.id.device is VIRTIO_ID_CONSOLE
> + * @config.net: virtual network config -
> + *              select if vdev.id.device is VIRTIO_ID_NET
> + * @tx_buf: tx buffer used to buffer data before writing into the FIFO
> + */
> +struct mlxbf_tmfifo_vdev {
> +       struct virtio_device vdev;
> +       u8 status;
> +       u64 features;
> +       struct mlxbf_tmfifo_vring vrings[MLXBF_TMFIFO_VRING_MAX];
> +       union {
> +               struct virtio_console_config cons;
> +               struct virtio_net_config net;
> +       } config;
> +       struct circ_buf tx_buf;
> +};

(1)

> +/**
> + * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
> + * @type: message type
> + * @len: payload length
> + * @data: 64-bit data used to write the message header into the TmFifo register.
> + *
> + * This message header is a union of struct and u64 data. The 'struct' has
> + * type and length field which are used to encode & decode the message. The
> + * 'data' field is used to read/write the message header from/to the FIFO.
> + */
> +union mlxbf_tmfifo_msg_hdr {
> +       struct {
> +               u8 type;
> +               __be16 len;
> +               u8 unused[5];
> +       } __packed;
> +       u64 data;
> +};

This union misses a type. See, for example, above structure (1) where
union is used correctly.

> +/* Allocate vrings for the FIFO. */
> +static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
> +                                    struct mlxbf_tmfifo_vdev *tm_vdev)
> +{
> +       struct mlxbf_tmfifo_vring *vring;
> +       struct device *dev;
> +       dma_addr_t dma;
> +       int i, size;
> +       void *va;
> +
> +       for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
> +               vring = &tm_vdev->vrings[i];
> +               vring->fifo = fifo;
> +               vring->num = MLXBF_TMFIFO_VRING_SIZE;
> +               vring->align = SMP_CACHE_BYTES;
> +               vring->index = i;
> +               vring->vdev_id = tm_vdev->vdev.id.device;
> +               dev = &tm_vdev->vdev.dev;
> +
> +               size = vring_size(vring->num, vring->align);
> +               va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
> +               if (!va) {

> +                       dev_err(dev->parent, "dma_alloc_coherent failed\n");
> +                       mlxbf_tmfifo_free_vrings(fifo, tm_vdev);

First do things, then report about what has been done.

> +                       return -ENOMEM;
> +               }
> +
> +               vring->va = va;
> +               vring->dma = dma;
> +       }
> +
> +       return 0;
> +}

> +/* Interrupt handler. */
> +static irqreturn_t mlxbf_tmfifo_irq_handler(int irq, void *arg)
> +{
> +       struct mlxbf_tmfifo_irq_info *irq_info = arg;
> +

> +       if (irq_info->index < MLXBF_TM_MAX_IRQ &&

On which circumstances this is possible?

> +           !test_and_set_bit(irq_info->index, &irq_info->fifo->pend_events))
> +               schedule_work(&irq_info->fifo->work);
> +
> +       return IRQ_HANDLED;
> +}

> +static void mlxbf_tmfifo_release_pending_pkt(struct mlxbf_tmfifo_vring *vring)
> +{
> +       struct vring_desc *desc_head;
> +       u32 len = 0;
> +
> +       if (vring->desc_head) {
> +               desc_head = vring->desc_head;
> +               len = vring->pkt_len;
> +       } else {
> +               desc_head = mlxbf_tmfifo_get_next_desc(vring);

> +               if (desc_head)

Redundant...

> +                       len = mlxbf_tmfifo_get_pkt_len(vring, desc_head);

...this is NULL-aware AFAICS.

> +       }
> +
> +       if (desc_head)
> +               mlxbf_tmfifo_release_desc(vring, desc_head, len);
> +
> +       vring->pkt_len = 0;
> +       vring->desc = NULL;
> +       vring->desc_head = NULL;
> +}

> +/* The notify function is called when new buffers are posted. */
> +static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
> +{
> +       struct mlxbf_tmfifo_vring *vring = vq->priv;
> +       struct mlxbf_tmfifo_vdev *tm_vdev;
> +       struct mlxbf_tmfifo *fifo;
> +       unsigned long flags;
> +
> +       fifo = vring->fifo;
> +
> +       /*
> +        * Virtio maintains vrings in pairs, even number ring for Rx
> +        * and odd number ring for Tx.
> +        */

> +       if (!(vring->index & BIT(0))) {

Perhaps positive conditional is better.

> +               if (test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events))
> +                       return true;
> +       } else {
> +               /*
> +                * Console could make blocking call with interrupts disabled.
> +                * In such case, the vring needs to be served right away. For
> +                * other cases, just set the TX LWM bit to start Tx in the
> +                * worker handler.
> +                */
> +               if (vring->vdev_id == VIRTIO_ID_CONSOLE) {
> +                       spin_lock_irqsave(&fifo->spin_lock, flags);
> +                       tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
> +                       mlxbf_tmfifo_console_output(tm_vdev, vring);
> +                       spin_unlock_irqrestore(&fifo->spin_lock, flags);
> +               } else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
> +                                           &fifo->pend_events)) {
> +                       return true;
> +               }
> +       }
> +
> +       schedule_work(&fifo->work);
> +
> +       return true;
> +}

> +/* Read the value of a configuration field. */
> +static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
> +                                   unsigned int offset,
> +                                   void *buf,
> +                                   unsigned int len)
> +{
> +       struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
> +

> +       if (offset + len > sizeof(tm_vdev->config))
> +               return;

This doesn't protect against too big len and offset.
Same for other similar checks.

> +
> +       memcpy(buf, (u8 *)&tm_vdev->config + offset, len);
> +}

> +/* Read the configured network MAC address from efi variable. */
> +static void mlxbf_tmfifo_get_cfg_mac(u8 *mac)
> +{
> +       efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
> +       unsigned long size = ETH_ALEN;
> +       efi_status_t status;
> +       u8 buf[ETH_ALEN];
> +

> +       status = efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL, &size,
> +                                 buf);

Use one line.

> +       if (status == EFI_SUCCESS && size == ETH_ALEN)
> +               ether_addr_copy(mac, buf);
> +       else
> +               ether_addr_copy(mac, mlxbf_tmfifo_net_default_mac);
> +}

> +/* Probe the TMFIFO. */
> +static int mlxbf_tmfifo_probe(struct platform_device *pdev)
> +{

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       fifo->rx_base = devm_ioremap_resource(dev, res);

There is new helper devm_platform_ioremap_resource().
Please, use it instead.

> +       if (IS_ERR(fifo->rx_base))
> +               return PTR_ERR(fifo->rx_base);

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       fifo->tx_base = devm_ioremap_resource(dev, res);

Ditto.

> +       if (IS_ERR(fifo->tx_base))
> +               return PTR_ERR(fifo->tx_base);

> +}

-- 
With Best Regards,
Andy Shevchenko
