Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB11C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79A320661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lign940r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfCEPea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:34:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfCEPe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:34:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so5877785pgd.1;
        Tue, 05 Mar 2019 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5O+drpyp5+lMQr5Ffk5yg8aP6GmcXzUUGc4hU3ITDeg=;
        b=Lign940rn/bvGghOz7pCNKdnWfh1mTFLJVAojPtgt8uu1sTyS4sQHq0jU4e482JoZf
         QayTY6jXu5ixAPCmBk5AJSgfRfmVoLF09kljeLGFCFw/2n3ysGdjEsaHbY86Dg7u5XkV
         P5gkV6mfxa3fFl7St5Ks7Wp6YljdJB97V2h3dMoR3/PUiKHpVI5n+831JbnDPF/B95EW
         vga5/C1iRC6Ip5U0pkqzuz2rQmTkD1Qr+FXwSVEQRJbcTMTUWIia5fsKvnPRJJDr/fXZ
         B77EQeVN6f8cRHr0E81+Lh3q/j3eWSxQWtVd7iPLsXXwRORUWglQm9OXZ9BYffU3ht0s
         rlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5O+drpyp5+lMQr5Ffk5yg8aP6GmcXzUUGc4hU3ITDeg=;
        b=F0F5VuSbJerJS96h9m6tjKR7beSMMmeHKc0Xg+83EcbeXtmti/t97cXu/EMC2Suc0A
         5zhBVq4tPw0EVLtmKu0bmEvUM9di5vabPVrEmEPyG7o+dfnLiGM8hIkMUmyeBIOZjeuy
         xusWwbLDUo/dkdApPf8WNh0c01W5puPTgWveqjew6OKKFG8sYG5rDFhcWCrz7Ls4iZQp
         oxTyczpjB8su+5OA50Nizs+IIT71zYOfkNAwJkXEHHzBOHwmiDYXJSSj9O2sGVTG5/MA
         7ddrVuL1AEgw0AVPXPgn5lK/m3RxbEJNOaDjrcazGaP+r9ofF7RiOgQBbifkvKpzTHr8
         B8cw==
X-Gm-Message-State: APjAAAWqTdRyhP4x5P3pmILnv8EdSH1ZZrDm8MZgbxJC5EiKk7V45lEE
        htwtc/oXdV7ApjbmIgGpW78RE4sKeJSTZhbDwlk=
X-Google-Smtp-Source: APXvYqyE7mPmUoYIht7Wv1nMuSOoHWyy4RfgNBD45sjIX8FrmEzNce5ROUlhckN2Lm2wWLhtXk3Qj5v46ZBkUlcUgxU=
X-Received: by 2002:a63:d442:: with SMTP id i2mr1874455pgj.246.1551800068009;
 Tue, 05 Mar 2019 07:34:28 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1551369083-31122-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1551369083-31122-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Mar 2019 17:34:16 +0200
Message-ID: <CAHp75VdnAaL0ygbW=8omO4HT2-diV7Dp4twsPsc8GzxtSktpgA@mail.gmail.com>
Subject: Re: [PATCH v10] platform/mellanox: Add TmFifo driver for Mellanox
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

On Thu, Feb 28, 2019 at 5:51 PM Liming Sun <lsun@mellanox.com> wrote:
>
> This commit adds the TmFifo platform driver for Mellanox BlueField
> Soc. TmFifo is a shared FIFO which enables external host machine
> to exchange data with the SoC via USB or PCIe. The driver is based
> on virtio framework and has console and network access enabled.

Thank you for an update.

Unfortunately more work is needed. My comments below.

> +#define MLXBF_TMFIFO_TX_STS__COUNT_RMASK               GENMASK(8, 0)
> +#define MLXBF_TMFIFO_TX_STS__COUNT_MASK                        GENMASK(8, 0)

> +#define MLXBF_TMFIFO_TX_CTL__LWM_RMASK                 GENMASK(7, 0)
> +#define MLXBF_TMFIFO_TX_CTL__LWM_MASK                  GENMASK(7, 0)

> +#define MLXBF_TMFIFO_TX_CTL__HWM_RMASK                 GENMASK(7, 0)
> +#define MLXBF_TMFIFO_TX_CTL__HWM_MASK                  GENMASK(15, 8)

> +#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_RMASK         GENMASK(8, 0)
> +#define MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK          GENMASK_ULL(40, 32)

> +#define MLXBF_TMFIFO_RX_STS__COUNT_RMASK               GENMASK(8, 0)
> +#define MLXBF_TMFIFO_RX_STS__COUNT_MASK                        GENMASK(8, 0)

> +#define MLXBF_TMFIFO_RX_CTL__LWM_RMASK                 GENMASK(7, 0)
> +#define MLXBF_TMFIFO_RX_CTL__LWM_MASK                  GENMASK(7, 0)

> +#define MLXBF_TMFIFO_RX_CTL__HWM_RMASK                 GENMASK(7, 0)
> +#define MLXBF_TMFIFO_RX_CTL__HWM_MASK                  GENMASK(15, 8)

> +#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK         GENMASK(8, 0)
> +#define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK          GENMASK_ULL(40, 32)

Since two of them have _ULL suffix I'm wondering if you have checked
for side effects on the rest, i.e. if you operate with 64-bit variable
and use something like ~MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK, it may
give you interesting results.

> +#define MLXBF_TMFIFO_TIMER_INTERVAL            (HZ / 10)

> +/**
> + * mlxbf_tmfifo_u64 - Union of 64-bit data
> + * @data - 64-bit data in host byte order
> + * @data_le - 64-bit data in little-endian byte order
> + *
> + * It's expected to send 64-bit little-endian value (__le64) into the TmFifo.
> + * readq() and writeq() expect u64 instead. A union structure is used here
> + * to workaround the explicit casting usage like writeq(*(u64 *)&data_le).
> + */

How do you know what readq()/writeq() does with the data? Is it on all
architectures?
How the endianess conversion affects the actual data?

> +union mlxbf_tmfifo_u64 {
> +       u64 data;
> +       __le64 data_le;
> +};

> +/*
> + * Default MAC.
> + * This MAC address will be read from EFI persistent variable if configured.
> + * It can also be reconfigured with standard Linux tools.
> + */
> +static u8 mlxbf_tmfifo_net_default_mac[6] = {
> +       0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};

> +#define mlxbf_vdev_to_tmfifo(dev)      \
> +       container_of(dev, struct mlxbf_tmfifo_vdev, vdev)

One line?

> +/* Return the consumed Tx buffer space. */
> +static int mlxbf_tmfifo_vdev_tx_buf_len(struct mlxbf_tmfifo_vdev *tm_vdev)
> +{
> +       int len;
> +
> +       if (tm_vdev->tx_tail >= tm_vdev->tx_head)
> +               len = tm_vdev->tx_tail - tm_vdev->tx_head;
> +       else
> +               len = MLXBF_TMFIFO_CONS_TX_BUF_SIZE - tm_vdev->tx_head +
> +                       tm_vdev->tx_tail;
> +       return len;
> +}

Is this custom implementation of some kind of circ_buf?

> +/* Allocate vrings for the fifo. */
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

And how do you clean previously allocated items?

> +                       return -ENOMEM;
> +               }
> +
> +               vring->va = va;
> +               vring->dma = dma;
> +       }
> +
> +       return 0;
> +}

> +/* Disable interrupts of the fifo device. */
> +static void mlxbf_tmfifo_disable_irqs(struct mlxbf_tmfifo *fifo)
> +{
> +       int i, irq;
> +
> +       for (i = 0; i < MLXBF_TM_MAX_IRQ; i++) {
> +               irq = fifo->irq_info[i].irq;

> +               if (irq) {

I don't think this check is needed if you can guarantee that it has no
staled records.

> +                       fifo->irq_info[i].irq = 0;
> +                       disable_irq(irq);
> +               }
> +       }
> +}

> +/* Get the number of available words in the TmFifo for sending. */
> +static int mlxbf_tmfifo_get_tx_avail(struct mlxbf_tmfifo *fifo, int vdev_id)
> +{
> +       int tx_reserve;
> +       u64 sts;
> +
> +       /* Reserve some room in FIFO for console messages. */
> +       if (vdev_id == VIRTIO_ID_NET)
> +               tx_reserve = fifo->tx_fifo_size / MLXBF_TMFIFO_RESERVE_RATIO;
> +       else
> +               tx_reserve = 1;
> +
> +       sts = readq(fifo->tx_base + MLXBF_TMFIFO_TX_STS);

> +       return (fifo->tx_fifo_size - tx_reserve -
> +               FIELD_GET(MLXBF_TMFIFO_TX_STS__COUNT_MASK, sts));

Redundant parens.
Moreover, consider

u32 count; // or whatever suits for FIELD_GET().
...

sts = readq(...);
count = FIELD_GET(...);
return ...;

> +}

> +       while (size > 0) {
> +               addr = cons->tx_buf + cons->tx_head;
> +
> +               if (cons->tx_head + sizeof(u64) <=
> +                   MLXBF_TMFIFO_CONS_TX_BUF_SIZE) {
> +                       memcpy(&data, addr, sizeof(u64));
> +               } else {
> +                       partial = MLXBF_TMFIFO_CONS_TX_BUF_SIZE - cons->tx_head;
> +                       memcpy(&data, addr, partial);

> +                       memcpy((u8 *)&data + partial, cons->tx_buf,
> +                              sizeof(u64) - partial);

Unaligned access?!

> +               }

> +               buf.data = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
> +               buf.data = le64_to_cpu(buf.data_le);

Are you sure this is correct?
How did you test this on BE architectures?

> +       tm_vdev = devm_kzalloc(dev, sizeof(*tm_vdev), GFP_KERNEL);

Is it appropriate use of devm_* ?

> +       if (!tm_vdev) {
> +               ret = -ENOMEM;
> +               goto fail;
> +       }

> +/* Read the configured network MAC address from efi variable. */
> +static void mlxbf_tmfifo_get_cfg_mac(u8 *mac)
> +{
> +       efi_guid_t guid = EFI_GLOBAL_VARIABLE_GUID;
> +       efi_status_t status;
> +       unsigned long size;

> +       u8 buf[6];

ETH_ALEN ?

> +
> +       size = sizeof(buf);

Ditto.

> +       status = efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL, &size,
> +                                 buf);

> +       if (status == EFI_SUCCESS && size == sizeof(buf))

Ditto.

> +               memcpy(mac, buf, sizeof(buf));

ether_addr_copy().

> +}

> +       memcpy(net_config.mac, mlxbf_tmfifo_net_default_mac, 6);

ether_addr_copy()...

> +       mlxbf_tmfifo_get_cfg_mac(net_config.mac);

... but actually above should be part of this function.

-- 
With Best Regards,
Andy Shevchenko
