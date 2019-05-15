Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FCA2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEOKsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:48:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46510 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:48:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so2595102qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gZYwYdV7q8QDeTTZWUnY8ifdtmwlYBuJRTK/kQFSoo=;
        b=TvItq2gK2vyiCLAgUBTWYrLoVuli/b8UXSjFemSOSO2OfWBChgfHL1K1mpbEcYNrXO
         0bVdIIlTgkK3/5NmtaxBf4lJXKL1gRsv6cvVhYNnqQ3kEmZBfjZ1tgP2qC+x1YnUs7ze
         87lvyXAzD1VzHADPySADdJMIer3d8mHzQVXwkNShiKbIriP3i7RMsvLZ78J7Jnrx1kaQ
         xgp07xbTpYxv3NmfcaJni+CGk3GbhroyNDglHVVdgZUhAqinr4aGZK5nIWDqmjmGQJeY
         eEef4cr4nZWdsmBg+W0bw9sr0BBu8w4IJFBuF634J7ANMz8oH0hbqWWMK7LEeNDW5aqE
         u+tA==
X-Gm-Message-State: APjAAAVU3YNMAfDq2GmWvx2qnzcJwYpJJBbSH0bxnD8fhqVXtSUxmpds
        xzCWl0x1UphqTlOJVN0hq79j4mXCSKqji1nkvJM=
X-Google-Smtp-Source: APXvYqxRoI0q2OGN6GbVhrk5jmHWu7TGkiTHYPmPP1u5t5qX2nKN5Fu+XpYP2rpSa1K+4pKahIf3rh57LHMarN1Y+ps=
X-Received: by 2002:ac8:2924:: with SMTP id y33mr34295279qty.212.1557917294353;
 Wed, 15 May 2019 03:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-9-elder@linaro.org>
In-Reply-To: <20190512012508.10608-9-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 12:47:58 +0200
Message-ID: <CAK8P3a0r5rg-_Vet+aUUzq3S9g=TJHPz9-0yQ0sY21NGd+4J0w@mail.gmail.com>
Subject: Re: [PATCH 08/18] soc: qcom: ipa: the generic software interface
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, Ben Chan <benchan@google.com>,
        Eric Caruso <ejcaruso@google.com>, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 3:25 AM Alex Elder <elder@linaro.org> wrote:

The per-event interrupt handling seems to be more complex than
necessary:

> +/* Enable or disable an event interrupt */
> +static void
> +_gsi_irq_control_event(struct gsi *gsi, u32 evt_ring_id, bool enable)
> +{
> +       u32 mask = BIT(evt_ring_id);
> +       u32 val;
> +
> +       if (enable)
> +               gsi->event_enable_bitmap |= mask;
> +       else
> +               gsi->event_enable_bitmap &= ~mask;
> +
> +       val = gsi->event_enable_bitmap;
> +       iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
> +}
> +
> +static void gsi_irq_enable_event(struct gsi *gsi, u32 evt_ring_id)
> +{
> +       _gsi_irq_control_event(gsi, evt_ring_id, true);

You maintain a bitmap here of the enabled-state, and have
to use a spinlock to ensure that the two are in sync.

> +/* Returns true if the interrupt state (enabled or not) changed */
> +static bool gsi_channel_intr(struct gsi_channel *channel, bool enable)
> +{
> +       u32 evt_ring_id = channel->evt_ring_id;
> +       struct gsi *gsi = channel->gsi;
> +       u32 mask = BIT(evt_ring_id);
> +       unsigned long flags;
> +       bool different;
> +       u32 enabled;
> +
> +       spin_lock_irqsave(&gsi->spinlock, flags);
> +
> +       enabled = gsi->event_enable_bitmap & mask;
> +       different = enable == !enabled;
> +
> +       if (different) {
> +               if (enabled)
> +                       gsi_irq_disable_event(channel->gsi, evt_ring_id);
> +               else
> +                       gsi_irq_enable_event(channel->gsi, evt_ring_id);
> +       }
> +
> +       spin_unlock_irqrestore(&gsi->spinlock, flags);
> +
> +       return different;
> +}

This gets called for each active channel, so you repeatedly
have to get the spinlock and read the irq-enabled state for it.

> +static void gsi_isr_ieob(struct gsi *gsi)
> +{
> +       u32 evt_mask;
> +
> +       evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
> +       evt_mask &= ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
> +       iowrite32(evt_mask, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
> +
> +       while (evt_mask) {
> +               u32 evt_ring_id = __ffs(evt_mask);
> +
> +               evt_mask ^= BIT(evt_ring_id);
> +
> +               gsi_event_handle(gsi, evt_ring_id);
> +       }
> +}

However, you start out by clearing all bits here.

Why not skip the clearing and and leave the interrupts enabled,
while moving the GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET
write (for a single channel that was completed) to the end of
gsi_channel_poll()?

Something like

static void gsi_isr_ieob(struct gsi *gsi)
{
      u32 evt_mask;

      evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
      while (evt_mask) {
               u32 evt_ring_id = __ffs(evt_mask);
               evt_mask ^= BIT(evt_ring_id);

               napi_schedule(gsi->evt_ring[evt_ring_id].channel.napi);
      }
}

I also removed the GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET
read here, as that is probably more expensive than calling napi_schedule()
for a channel that is already scheduled. Most of the time, I'd expect the
interrupt to only signal a single channel anyway.

        Arnd
