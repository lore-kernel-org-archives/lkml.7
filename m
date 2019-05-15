Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D282084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfEOHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:21:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38434 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:21:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id a64so877543qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 00:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9h0PtC8BJg+KYyXGN5vaaGhzmeYsFVJY3Snc/1xB430=;
        b=ui5EC6wCc7zIzzmIWcEEvSBd7PzP+6YxrtNNeC8Z4WGudNaryd2IVriV85zmewnEkA
         tr2ejnGj0quzyFg8p+moELhXR/1rroJsd0DFI+1DglcxZaaCevugSqcGVWxei388Gy39
         LS1iCbsk5C4+TY4HhHAZCqWIOkfIcbUY6D+f9gnC58el9bQsMYwbVimGv8xcVXLeNktx
         fSEwcAjHRrM5OAOA72F8sEwSqrGtVTTdtkEhQEWwiftb8oH1FaXOzju6xnLWQGygye+u
         wNqfWg8h+c74x69bunB/V6V8v43ZhDKJcZ7XKrqTDb6bEzMt8jQl7kdc1X5bEoeVMD26
         8l6w==
X-Gm-Message-State: APjAAAVQ/pkvKsIQTcnZIzyLvw36ZCfg48u6YW7WW3m4zvkH429qXpqA
        Gzh9Vr1b7KNgHnICT8+VqmlQWs4JjmTG5YWqvTc=
X-Google-Smtp-Source: APXvYqyKzQyA5PcXyJzWxhUCN33Q8F8XlJY1ipnoZ63QWNlyNAHTiEVMq3PuAhInu8EIb3l828kVvt9e+SRVNKFTC/s=
X-Received: by 2002:a05:620a:1368:: with SMTP id d8mr9744289qkl.107.1557904901038;
 Wed, 15 May 2019 00:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-9-elder@linaro.org>
In-Reply-To: <20190512012508.10608-9-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 09:21:24 +0200
Message-ID: <CAK8P3a1gi2pbjh8+Ev1=hMXrnUeQuHxdFubcC50PVVXVpjhSmQ@mail.gmail.com>
Subject: Re: [PATCH 08/18] soc: qcom: ipa: the generic software interface
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:

> +/** gsi_gpi_channel_scratch - GPI protocol scratch register
> + *
> + * @max_outstanding_tre:
> + *     Defines the maximum number of TREs allowed in a single transaction
> + *     on a channel (in Bytes).  This determines the amount of prefetch
> + *     performed by the hardware.  We configure this to equal the size of
> + *     the TLV FIFO for the channel.
> + * @outstanding_threshold:
> + *     Defines the threshold (in Bytes) determining when the sequencer
> + *     should update the channel doorbell.  We configure this to equal
> + *     the size of two TREs.
> + */
> +struct gsi_gpi_channel_scratch {
> +       u64 rsvd1;
> +       u16 rsvd2;
> +       u16 max_outstanding_tre;
> +       u16 rsvd3;
> +       u16 outstanding_threshold;
> +} __packed;
> +
> +/** gsi_channel_scratch - channel scratch configuration area
> + *
> + * The exact interpretation of this register is protocol-specific.
> + * We only use GPI channels; see struct gsi_gpi_channel_scratch, above.
> + */
> +union gsi_channel_scratch {
> +       struct gsi_gpi_channel_scratch gpi;
> +       struct {
> +               u32 word1;
> +               u32 word2;
> +               u32 word3;
> +               u32 word4;
> +       } data;
> +} __packed;

What are the exact alignment requirements on these structures,
do you ever need to have them on odd addresses? If not, please
remove the __packed, or add __aligned() with the actual alignment,
e.g. __aligned(4), to let the compiler create better code and
avoid bytewise accesses.

> +/* Init function for GSI.  GSI hardware does not need to be "ready" */
> +int gsi_init(struct gsi *gsi, struct platform_device *pdev, u32 data_count,
> +            const struct gsi_ipa_endpoint_data *data)
> +{
> +       struct resource *res;
> +       resource_size_t size;
> +       unsigned int irq;
> +       int ret;
> +
> +       gsi->dev = &pdev->dev;
> +       init_dummy_netdev(&gsi->dummy_dev);

Can you add a comment here to explain what the 'dummy' device is
needed for?

> +       /* Get GSI memory range and map it */
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsi");
> +       if (!res)
> +               return -ENXIO;
> +
> +       size = resource_size(res);
> +       if (res->start > U32_MAX || size > U32_MAX - res->start)
> +               return -EINVAL;
> +
> +       gsi->virt = ioremap_nocache(res->start, size);
> +       if (!gsi->virt)
> +               return -ENOMEM;

The _nocache() postfix is not needed here, and I find it a bit
confusing, just use plain ioremap, or maybe even
devm_platform_ioremap_resource() to save the
platform_get_resource_byname().

> +       ret = request_irq(irq, gsi_isr, 0, "gsi", gsi);
> +       if (ret)
> +               goto err_unmap_virt;
> +       gsi->irq = irq;
> +
> +       ret = enable_irq_wake(gsi->irq);
> +       if (ret)
> +               dev_err(gsi->dev, "error %d enabling gsi wake irq\n", ret);
> +       gsi->irq_wake_enabled = ret ? 0 : 1;
> +
> +       spin_lock_init(&gsi->spinlock);
> +       mutex_init(&gsi->mutex);

This looks a bit dangerous if you can ever get to the point of
having a pending interrupt. before the structure is fully initialized.
This can probably not happen in practice, but it's better to request
the interrupts last to be on the safe side.

> +/* Wait for all transaction activity on a channel to complete */
> +void gsi_channel_trans_quiesce(struct gsi *gsi, u32 channel_id)
> +{
> +       struct gsi_channel *channel = &gsi->channel[channel_id];
> +       struct gsi_trans_info *trans_info;
> +       struct gsi_trans *trans = NULL;
> +       struct gsi_evt_ring *evt_ring;
> +       struct list_head *list;
> +       unsigned long flags;
> +
> +       trans_info = &channel->trans_info;
> +       evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
> +
> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> +
> +       /* Find the last list to which a transaction was added */
> +       if (!list_empty(&trans_info->alloc))
> +               list = &trans_info->alloc;
> +       else if (!list_empty(&trans_info->pending))
> +               list = &trans_info->pending;
> +       else if (!list_empty(&trans_info->complete))
> +               list = &trans_info->complete;
> +       else if (!list_empty(&trans_info->polled))
> +               list = &trans_info->polled;
> +       else
> +               list = NULL;
> +
> +       if (list) {
> +               struct gsi_trans *trans;
> +
> +               /* The last entry on this list is the last one allocated.
> +                * Grab a reference so we can wait for it.
> +                */
> +               trans = list_last_entry(list, struct gsi_trans, links);
> +               refcount_inc(&trans->refcount);
> +       }
> +
> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> +
> +       /* If there is one, wait for it to complete */
> +       if (trans) {
> +               wait_for_completion(&trans->completion);

Since you are waiting here, you clearly can't be called
from interrupt context, or with interrupts disabled, so it's
clearer to use spin_lock_irq() instead of spin_lock_irqsave().

I generally try to avoid the _irqsave versions altogether, unless
it is really needed for a function that is called both from
irq-disabled and irq-enabled context.

     Arnd
