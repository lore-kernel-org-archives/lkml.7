Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EFAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC902084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMxfbIWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfEONcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:32:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40111 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfEONce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:32:34 -0400
Received: by mail-it1-f193.google.com with SMTP id g71so72480ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ge6EYu+idJkuiSql+JEbZghal5x65pcJTMYe5g45ui0=;
        b=FMxfbIWYpWTwgI22BmGs8Yiq8MAHLoEtv+5G7MRX86Ka/JQf4g7OTdAnYP1PGFAqyQ
         uNK6W4sefjl9Rv/K95nmfN4QKCxF23slGuZUJRaxzJbpJYODaz9A4hCji7Ff6KkWOo2A
         BB968g3ehKaYUYb3P5gxwlnmXavUJ0cnpCqxvxL6CHjg5fXWvhoIR3rwvMFTR8z4uiDD
         2UwSK4XmSUx5QixaB3aNBAoOJ2oGDD85odPqgIxBH+BItzlmNUrpGUiy8Tc12RyTALGT
         MHuRwgbbSntAbv/gazcAlTrFfgi7L2/bxoKfkixAJdTRzKIBO8bLKBHsrBNTAvBAR8BE
         847Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ge6EYu+idJkuiSql+JEbZghal5x65pcJTMYe5g45ui0=;
        b=mIZVagUdmvT9HcAZB6orMMHF+yDuMWIhw/Hez0EkuJMfyc/yLAEh9tebtaEdRWVwXo
         PLFfupNEtG8xH0X/EftDfNsJ+SN9382V7pkRGzrFGXltyUfxp55cRjXd9OXT9aICdGr7
         Pci3aouV1pb+iR5RNpGGWWYzhNZCXX7GXxtQEAlGHslH9L6Pss1l0sIChjS17qCUk7IU
         Mmo8mICG1nArIpy187uO+cYXrt8qGigECZ8aTmfKNMBHmdKyrzO8fyL0fLIf09cR0ZMr
         PW5+54SO6URPa0ajVrp7jTIJLCbsp3NOKiXz/8Wc1S8kCgGsOWlnV5eptnkjCzHBER3q
         m7fg==
X-Gm-Message-State: APjAAAVuWwJfqXIojyEwlCn+0P9aPRM9W4I6jt266OUOimcUYpAJsxOe
        5Ly9aK3wjkLvyRaegi/fLuuPKGgVkCM=
X-Google-Smtp-Source: APXvYqwIvHM6F1lUXVh8Y9vJVNajF38jzsuciqQS1yZ15j0SXKUvMHuSSNK59P486JV3CvYkAsnbrA==
X-Received: by 2002:a05:660c:12ce:: with SMTP id k14mr7812071itd.149.1557927152234;
        Wed, 15 May 2019 06:32:32 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id z19sm676468iol.24.2019.05.15.06.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 06:32:31 -0700 (PDT)
Subject: Re: [PATCH 08/18] soc: qcom: ipa: the generic software interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-9-elder@linaro.org>
 <CAK8P3a0r5rg-_Vet+aUUzq3S9g=TJHPz9-0yQ0sY21NGd+4J0w@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <fc8ad575-9ad6-27ab-3255-ef0f41f5b1c5@linaro.org>
Date:   Wed, 15 May 2019 08:32:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0r5rg-_Vet+aUUzq3S9g=TJHPz9-0yQ0sY21NGd+4J0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 5:47 AM, Arnd Bergmann wrote:
> On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:
> 
> The per-event interrupt handling seems to be more complex than
> necessary:

I just noticed this message.  I'll take another look at this
whole interrupt control mechanism and will try to streamline
it along the lines of what you describe.

Thanks.

					-Alex

> 
>> +/* Enable or disable an event interrupt */
>> +static void
>> +_gsi_irq_control_event(struct gsi *gsi, u32 evt_ring_id, bool enable)
>> +{
>> +       u32 mask = BIT(evt_ring_id);
>> +       u32 val;
>> +
>> +       if (enable)
>> +               gsi->event_enable_bitmap |= mask;
>> +       else
>> +               gsi->event_enable_bitmap &= ~mask;
>> +
>> +       val = gsi->event_enable_bitmap;
>> +       iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
>> +}
>> +
>> +static void gsi_irq_enable_event(struct gsi *gsi, u32 evt_ring_id)
>> +{
>> +       _gsi_irq_control_event(gsi, evt_ring_id, true);
> 
> You maintain a bitmap here of the enabled-state, and have
> to use a spinlock to ensure that the two are in sync.
> 
>> +/* Returns true if the interrupt state (enabled or not) changed */
>> +static bool gsi_channel_intr(struct gsi_channel *channel, bool enable)
>> +{
>> +       u32 evt_ring_id = channel->evt_ring_id;
>> +       struct gsi *gsi = channel->gsi;
>> +       u32 mask = BIT(evt_ring_id);
>> +       unsigned long flags;
>> +       bool different;
>> +       u32 enabled;
>> +
>> +       spin_lock_irqsave(&gsi->spinlock, flags);
>> +
>> +       enabled = gsi->event_enable_bitmap & mask;
>> +       different = enable == !enabled;
>> +
>> +       if (different) {
>> +               if (enabled)
>> +                       gsi_irq_disable_event(channel->gsi, evt_ring_id);
>> +               else
>> +                       gsi_irq_enable_event(channel->gsi, evt_ring_id);
>> +       }
>> +
>> +       spin_unlock_irqrestore(&gsi->spinlock, flags);
>> +
>> +       return different;
>> +}
> 
> This gets called for each active channel, so you repeatedly
> have to get the spinlock and read the irq-enabled state for it.
> 
>> +static void gsi_isr_ieob(struct gsi *gsi)
>> +{
>> +       u32 evt_mask;
>> +
>> +       evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
>> +       evt_mask &= ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
>> +       iowrite32(evt_mask, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
>> +
>> +       while (evt_mask) {
>> +               u32 evt_ring_id = __ffs(evt_mask);
>> +
>> +               evt_mask ^= BIT(evt_ring_id);
>> +
>> +               gsi_event_handle(gsi, evt_ring_id);
>> +       }
>> +}
> 
> However, you start out by clearing all bits here.
> 
> Why not skip the clearing and and leave the interrupts enabled,
> while moving the GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET
> write (for a single channel that was completed) to the end of
> gsi_channel_poll()?
> 
> Something like
> 
> static void gsi_isr_ieob(struct gsi *gsi)
> {
>       u32 evt_mask;
> 
>       evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
>       while (evt_mask) {
>                u32 evt_ring_id = __ffs(evt_mask);
>                evt_mask ^= BIT(evt_ring_id);
> 
>                napi_schedule(gsi->evt_ring[evt_ring_id].channel.napi);
>       }
> }
> 
> I also removed the GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET
> read here, as that is probably more expensive than calling napi_schedule()
> for a channel that is already scheduled. Most of the time, I'd expect the
> interrupt to only signal a single channel anyway.
> 
>         Arnd
> 

