Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85872C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0520675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfF1YcFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfEOMNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:13:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43526 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfEOMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:13:12 -0400
Received: by mail-io1-f65.google.com with SMTP id v7so1992330iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6hbYqFXCquO8pKo9SaRS6B2RwA4rXp5nw/wOQi/O4vc=;
        b=yfF1YcFFcyTNTFKANXNWI1Rmi2aOH69ME7nnJc/B2DBUebVxqC8al4Fo34htgvE3Hz
         hMJ+GRdOnRobHuOGGDdx2sJ+1S0/VCPo0REEJwsInW1LZjoz/ALnCI6+tf3Ht97Ec2mv
         y5NloT7ztLaBFPyWyGlZw4JiQv40AvzBefpz0vODLENmkC2ePLWWbkgEESIGmPVPgFz6
         Md4Ch1PrbXoxaY7t2e8JoaemquRpDG2b+v56TVpo+GgZ0eV1gdrXmVi7hObCBn8ihEyn
         ByX5U4Luv/Fjev6f2E/Fdk7+Gye/qZ7DC4UqWGI0Z54TSfbPACIbumwny/3MuKYRPxTk
         chfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hbYqFXCquO8pKo9SaRS6B2RwA4rXp5nw/wOQi/O4vc=;
        b=G6QN0C5V6MvmN6ftOEWiR0KCVQuJDUDRyQDawQHSJRmfSAiPKCK5psrj0MOwNusOab
         PrBA529080XnbJCzNwnLQtIsWkjSAd0gBOYFo3hTasW6D5rFhIaFO2AVtgImVnVHepJk
         SnC0hOe0Gsn7Y37FmLpbsq0eiGN08foknN4sa0oVJwhW2+TZp6uHFnXxXtW+0UWzZlrj
         Lotj2AUnWdopl9fQIT9vrWWUES4QFB3BfZzn0vYSHTlXSzoJKRkypgWE0HPPXJDPrWlz
         w6YLO9cQMKpntrZI26wqAUem0edWkfLzSA2tqcOowTRa+mnX7HwUmUWXcDGdornNvrGX
         LPwg==
X-Gm-Message-State: APjAAAWXerLaNLJttCOWlIQKtbAJObbXcQ5qYjsW8qlOXXKTzrGbC4My
        jIrxo4j/2RQMcdCw+Nj5Rl11cDhYpbM=
X-Google-Smtp-Source: APXvYqypUuHacRqSyBRfff6IK2aHOgF2tkOwI+bnNRkDFjcdmGVmI2sAzfAZvQgl6/9fYiv/YrBy/A==
X-Received: by 2002:a6b:18a:: with SMTP id 132mr22387689iob.225.1557922391292;
        Wed, 15 May 2019 05:13:11 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id x74sm27961itb.33.2019.05.15.05.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 05:13:10 -0700 (PDT)
Subject: Re: [PATCH 08/18] soc: qcom: ipa: the generic software interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-9-elder@linaro.org>
 <CAK8P3a1gi2pbjh8+Ev1=hMXrnUeQuHxdFubcC50PVVXVpjhSmQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <72869c32-c2c5-54f9-10d9-8c0ed9f6300d@linaro.org>
Date:   Wed, 15 May 2019 07:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1gi2pbjh8+Ev1=hMXrnUeQuHxdFubcC50PVVXVpjhSmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 2:21 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> 
>> +/** gsi_gpi_channel_scratch - GPI protocol scratch register
>> + *
>> + * @max_outstanding_tre:
>> + *     Defines the maximum number of TREs allowed in a single transaction
>> + *     on a channel (in Bytes).  This determines the amount of prefetch
>> + *     performed by the hardware.  We configure this to equal the size of
>> + *     the TLV FIFO for the channel.
>> + * @outstanding_threshold:
>> + *     Defines the threshold (in Bytes) determining when the sequencer
>> + *     should update the channel doorbell.  We configure this to equal
>> + *     the size of two TREs.
>> + */
>> +struct gsi_gpi_channel_scratch {
>> +       u64 rsvd1;
>> +       u16 rsvd2;
>> +       u16 max_outstanding_tre;
>> +       u16 rsvd3;
>> +       u16 outstanding_threshold;
>> +} __packed;
>> +
>> +/** gsi_channel_scratch - channel scratch configuration area
>> + *
>> + * The exact interpretation of this register is protocol-specific.
>> + * We only use GPI channels; see struct gsi_gpi_channel_scratch, above.
>> + */
>> +union gsi_channel_scratch {
>> +       struct gsi_gpi_channel_scratch gpi;
>> +       struct {
>> +               u32 word1;
>> +               u32 word2;
>> +               u32 word3;
>> +               u32 word4;
>> +       } data;
>> +} __packed;
> 
> What are the exact alignment requirements on these structures,
> do you ever need to have them on odd addresses? If not, please
> remove the __packed, or add __aligned() with the actual alignment,
> e.g. __aligned(4), to let the compiler create better code and
> avoid bytewise accesses.

Honestly I don't know but I would guess they've actually
got alignment requirements consistent with C standard...
Many, many structures had the __packed attribute attached
in the original code.  I removed most but apparently not
all.  I will remove the __packed here, and will scan through
the rest of the code for other similar instances and will
remove those if appropriate as well.

>> +/* Init function for GSI.  GSI hardware does not need to be "ready" */
>> +int gsi_init(struct gsi *gsi, struct platform_device *pdev, u32 data_count,
>> +            const struct gsi_ipa_endpoint_data *data)
>> +{
>> +       struct resource *res;
>> +       resource_size_t size;
>> +       unsigned int irq;
>> +       int ret;
>> +
>> +       gsi->dev = &pdev->dev;
>> +       init_dummy_netdev(&gsi->dummy_dev);
> 
> Can you add a comment here to explain what the 'dummy' device is
> needed for?

Yes, good idea.

FYI it's needed because the GSI code is not a "real"
network device (that, where needed, is implemented in
"ipa_netdev.c", two logical layers up), but in order
to use NAPI there needs to be one.


>> +       /* Get GSI memory range and map it */
>> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsi");
>> +       if (!res)
>> +               return -ENXIO;
>> +
>> +       size = resource_size(res);
>> +       if (res->start > U32_MAX || size > U32_MAX - res->start)
>> +               return -EINVAL;
>> +
>> +       gsi->virt = ioremap_nocache(res->start, size);
>> +       if (!gsi->virt)
>> +               return -ENOMEM;
> 
> The _nocache() postfix is not needed here, and I find it a bit
> confusing, just use plain ioremap, or maybe even
> devm_platform_ioremap_resource() to save the
> platform_get_resource_byname().

OK good idea.  This was in the original code and I neglected
to chase this down.  Thank you for catching it.

>> +       ret = request_irq(irq, gsi_isr, 0, "gsi", gsi);
>> +       if (ret)
>> +               goto err_unmap_virt;
>> +       gsi->irq = irq;
>> +
>> +       ret = enable_irq_wake(gsi->irq);
>> +       if (ret)
>> +               dev_err(gsi->dev, "error %d enabling gsi wake irq\n", ret);
>> +       gsi->irq_wake_enabled = ret ? 0 : 1;
>> +
>> +       spin_lock_init(&gsi->spinlock);
>> +       mutex_init(&gsi->mutex);
> 
> This looks a bit dangerous if you can ever get to the point of
> having a pending interrupt. before the structure is fully initialized.
> This can probably not happen in practice, but it's better to request
> the interrupts last to be on the safe side.

Understood.  I'll fix that.

>> +/* Wait for all transaction activity on a channel to complete */
>> +void gsi_channel_trans_quiesce(struct gsi *gsi, u32 channel_id)
>> +{
>> +       struct gsi_channel *channel = &gsi->channel[channel_id];
>> +       struct gsi_trans_info *trans_info;
>> +       struct gsi_trans *trans = NULL;
>> +       struct gsi_evt_ring *evt_ring;
>> +       struct list_head *list;
>> +       unsigned long flags;
>> +
>> +       trans_info = &channel->trans_info;
>> +       evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
>> +
>> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
>> +
>> +       /* Find the last list to which a transaction was added */
>> +       if (!list_empty(&trans_info->alloc))
>> +               list = &trans_info->alloc;
>> +       else if (!list_empty(&trans_info->pending))
>> +               list = &trans_info->pending;
>> +       else if (!list_empty(&trans_info->complete))
>> +               list = &trans_info->complete;
>> +       else if (!list_empty(&trans_info->polled))
>> +               list = &trans_info->polled;
>> +       else
>> +               list = NULL;
>> +
>> +       if (list) {
>> +               struct gsi_trans *trans;
>> +
>> +               /* The last entry on this list is the last one allocated.
>> +                * Grab a reference so we can wait for it.
>> +                */
>> +               trans = list_last_entry(list, struct gsi_trans, links);
>> +               refcount_inc(&trans->refcount);
>> +       }
>> +
>> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
>> +
>> +       /* If there is one, wait for it to complete */
>> +       if (trans) {
>> +               wait_for_completion(&trans->completion);
> 
> Since you are waiting here, you clearly can't be called
> from interrupt context, or with interrupts disabled, so it's
> clearer to use spin_lock_irq() instead of spin_lock_irqsave().
> 
> I generally try to avoid the _irqsave versions altogether, unless
> it is really needed for a function that is called both from
> irq-disabled and irq-enabled context.

OK.  And I appreciate what your saying here because I do prefer
code that communicates more about the context in ways like
you describe.

Thanks you.

					-Alex

> 
>      Arnd
> 

