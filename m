Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFBCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B22184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naVn6t4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfDEPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:44:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38556 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:44:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id g37so3227568plb.5;
        Fri, 05 Apr 2019 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Za4Rlp/fjsf7EBbuyq7zSpb5sgWMWXT/s5M8omPN1Q8=;
        b=naVn6t4Fe1AgqW+3CwYW+SucFdSe0ZpKdXUxC2ZulDSpySFifeFoZx84yBE4eKdSSN
         d85GzC1UX+lSebKIE13cx6yrd6clgjTjCRd1k5vixe8z/9l/gL+C3+T8ClpmXUGSbxr6
         BiNZHwwcllE0gL8dVhWCjmB33tc5LOPMlCL3cPW0y4AjJO1hKUARkwiKp9DELsP9xVIy
         /tj7ddauUmoWkG/A8XLM7SJQwC4WdBfHtH+NEAsC4pGwrHOx3tJ90sQ0mvFRe9OBWzPR
         VxIeQIBCQXxLO/63drMzBJxIOXkLaJ/I8myVY023umuPlxi8otHTtveHhdLsnudn1Kox
         Ky9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Za4Rlp/fjsf7EBbuyq7zSpb5sgWMWXT/s5M8omPN1Q8=;
        b=Nu9SvilqTvF0s2tIYRum8v7C9A6fssG7X1mU24yp2Zjeo74rxtpt4kRbKLLrXqtbnG
         YbRyfkcPgzW0T67rDmb9xRn73ltlqsa752VV+EiThjY44JdpgLcVuqQiptHXuHbph/zc
         kCvVspnRspeSD0u3EvDAHy/ppwjSPhdLO+UuClKnH/gBzQc5D1sbOPqJv0hhGisLCGSc
         hLR/cTeM3M6IlAr5KpuuccjphP6E8xmZBBt4surueeRz7ZL0uTHzw9m4NmYfHntTGZVT
         B4Nqq+NE23PJH2AGoGvSSxi4K7c9ly969z0Bh2iJR2TnAv5AxH8dFRquGiMz6kOOHTPT
         9GvQ==
X-Gm-Message-State: APjAAAVP11lMFeh3gkF+4v1zbtY8VcUFmzohxU1m8ImILto8OP6JIKmY
        9lAEtRXQWmdAN5oEj5K6LnxyMhS/1CrqLB5f1IU=
X-Google-Smtp-Source: APXvYqx7nuPQsNTaR4CneoahxBWTlaJRSOf0H8ybCS4XwWIJEAVOce9NZk7SdndvgtsYNNDcjcRkIy2eSZlFzLosgCQ=
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr13201423plb.281.1554479066492;
 Fri, 05 Apr 2019 08:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1554406595-3128-1-git-send-email-lsun@mellanox.com>
In-Reply-To: <1554406595-3128-1-git-send-email-lsun@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 18:44:14 +0300
Message-ID: <CAHp75VdUwn1NEpSc0_Oc4wEh0TRzCwcE0_tajg3ak8BjfZ_-Mw@mail.gmail.com>
Subject: Re: [PATCH v13] platform/mellanox: Add TmFifo driver for Mellanox
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

On Thu, Apr 4, 2019 at 10:36 PM Liming Sun <lsun@mellanox.com> wrote:
> This commit adds the TmFifo platform driver for Mellanox BlueField
> Soc. TmFifo is a shared FIFO which enables external host machine
> to exchange data with the SoC via USB or PCIe. The driver is based
> on virtio framework and has console and network access enabled.

Thanks for an update. Almost good.
My comments below.

Meanwhile I pushed this to my review and testing queue, thanks!

> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/circ_buf.h>
> +#include <linux/efi.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>

Perhaps blank line here. Would be more clear that this is utilizing
virtio framework.

> +#include <linux/virtio_config.h>
> +#include <linux/virtio_console.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ring.h>

> +/**
> + * mlxbf_tmfifo_msg_hdr - Structure of the TmFifo message header
> + * @type: message type
> + * @len: payload length
> + * @u: 64-bit union data
> + */
> +union mlxbf_tmfifo_msg_hdr {
> +       struct {
> +               u8 type;
> +               __be16 len;
> +               u8 unused[5];
> +       } __packed;
> +       u64 data;

I'm not sure I understand how you can distinguish which field of union to use?
Isn't here some type missed?

> +};

> +static u8 mlxbf_tmfifo_net_default_mac[ETH_ALEN] = {

> +       0x00, 0x1A, 0xCA, 0xFF, 0xFF, 0x01};

This should be two lines.

> +/* Supported virtio-net features. */
> +#define MLXBF_TMFIFO_NET_FEATURES      (BIT_ULL(VIRTIO_NET_F_MTU) | \
> +                                        BIT_ULL(VIRTIO_NET_F_STATUS) | \
> +                                        BIT_ULL(VIRTIO_NET_F_MAC))

Better to write as

#define FOO \
(BIT(x) | BIT(y) ...)

I think I told this earlier?

> +/* Allocate vrings for the fifo. */

fifo -> FIFO (and check all occurrences)

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

I don't see how this will free the allocated entries.
I think I told about this either.

> +                       return -ENOMEM;
> +               }
> +
> +               vring->va = va;
> +               vring->dma = dma;
> +       }
> +
> +       return 0;
> +}

> +/* House-keeping timer. */
> +static void mlxbf_tmfifo_timer(struct timer_list *arg)
> +{

> +       struct mlxbf_tmfifo *fifo = container_of(arg, struct mlxbf_tmfifo,
> +                                                timer);

One line would be still good enough.

> +       int more;
> +
> +       more = !test_and_set_bit(MLXBF_TM_RX_HWM_IRQ, &fifo->pend_events) ||
> +                   !test_and_set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
> +
> +       if (more)
> +               schedule_work(&fifo->work);
> +
> +       mod_timer(&fifo->timer, jiffies + MLXBF_TMFIFO_TIMER_INTERVAL);
> +}

> +       status = efi.get_variable(mlxbf_tmfifo_efi_name, &guid, NULL, &size,
> +                                 buf);
> +       if (status == EFI_SUCCESS && size == ETH_ALEN)
> +               ether_addr_copy(mac, buf);
> +       else

> +               memcpy(mac, mlxbf_tmfifo_net_default_mac, ETH_ALEN);

ether_addr_copy() as well.

> +}

> +       fifo->pdev = pdev;

Do you really need to keep pdev there? Isn't struct device pointer enough?


> +       /* Create the console vdev. */
> +       ret = mlxbf_tmfifo_create_vdev(&pdev->dev, fifo, VIRTIO_ID_CONSOLE, 0,
> +                                      NULL, 0);

If you define temporary variable
  struct device *dev = &pdev->dev;
these lines can be merged into one.

> +       if (ret)
> +               goto fail;

-- 
With Best Regards,
Andy Shevchenko
