Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DFC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFE52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfEOUug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:50:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46335 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:50:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id z19so1314649qtz.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 13:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoiUAmeKPw/pdD40GLo8HG1mUfQRJDhIA9wodB2uBqc=;
        b=XDKmng0nisemBZJP4hJWv9+86G/C2bkI2Svz0jg0k1P9EAU+iPG6RoHkFXrekuhr/B
         7vYwdDN9rmKAvICMmkqpHy6LnwuslrbjZPIDOR77n9PLbMWKxIGauHXPoJqNP0nTbAri
         nZ4EqGfwX4XjeGK3N7LKZmamQBb3PF8eWXbA43++aEk/4Rezq+ypPaNITVXllDyD34n7
         OJjZXmAKRtBrk0YlQIeFhpDWn1dtbcnL/hJlOY8x23hf1ngSJ/bazVQOZWgEdsfMRkDg
         FDlSqUiinZS6My+9q6WF3g+qgE+PE3PqZz63iqGwPpBipeyLyG8if9XZqYtF+EUR6Jw9
         c3jA==
X-Gm-Message-State: APjAAAU+kBJZOOBfLOXEZwo8Kelgfkj+S3wCGkjtNkDP0H8EHzaxnZ6K
        ywT5c24cu3pNUzyVpxVYBOfrisQ/dFMl32ade2sFAU0u64zQZg==
X-Google-Smtp-Source: APXvYqynPLvdllc3+4rsPV6FfaJGtw4zvsaFmKz0WuH0vIyP7RzXIFVXsn22W7leanGKtMd7HDesnJDdcojcXnCzJtw=
X-Received: by 2002:a0c:f40a:: with SMTP id h10mr10605409qvl.180.1557953434378;
 Wed, 15 May 2019 13:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-10-elder@linaro.org>
 <CAK8P3a0eYWN6mMwft5OSu8wQQo=kWh5safGFFNkDCELZJyiMmQ@mail.gmail.com> <58b03138-d99f-b22f-5f8a-969612163135@linaro.org>
In-Reply-To: <58b03138-d99f-b22f-5f8a-969612163135@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 22:50:17 +0200
Message-ID: <CAK8P3a1CD2CjLzvWAeZcpEo5U2-fX1wgjKQ2-1oyigwE_KwBqg@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: qcom: ipa: GSI transactions
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

On Wed, May 15, 2019 at 2:26 PM Alex Elder <elder@linaro.org> wrote:
> On 5/15/19 2:34 AM, Arnd Bergmann wrote:
> >> +/* Cancel a channel's pending transactions */
> >> +void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
> >> +{
> >> +       struct gsi_trans_info *trans_info = &channel->trans_info;
> >> +       u32 evt_ring_id = channel->evt_ring_id;
> >> +       struct gsi *gsi = channel->gsi;
> >> +       struct gsi_evt_ring *evt_ring;
> >> +       struct gsi_trans *trans;
> >> +       unsigned long flags;
> >> +
> >> +       evt_ring = &gsi->evt_ring[evt_ring_id];
> >> +
> >> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> >> +
> >> +       list_for_each_entry(trans, &trans_info->pending, links)
> >> +               trans->result = -ECANCELED;
> >> +
> >> +       list_splice_tail_init(&trans_info->pending, &trans_info->complete);
> >> +
> >> +       spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
> >> +
> >> +       spin_lock_irqsave(&gsi->spinlock, flags);
> >> +
> >> +       if (gsi->event_enable_bitmap & BIT(evt_ring_id))
> >> +               gsi_event_handle(gsi, evt_ring_id);
> >> +
> >> +       spin_unlock_irqrestore(&gsi->spinlock, flags);
> >> +}
> >
> > That is a lot of irqsave()/irqrestore() operations. Do you actually call
> > all of these functions from hardirq context?
>
> The transaction list is definitely updated in IRQ context,
> but I think it is no longer updated in hardirq context (the
> softirq was a recent change).  This particular function is
> definitely not called in a hardirq context, so I can remove
> the irqsave/irqrestore.

If you want to protect against concurrent softirqs, you still
need spin_lock_bh(), which is cheaper than spin_lock_irqsave()
but still requires writing to the shared cache line for the
atomic update of the lock.

> I'll survey my spinlock use throughout the driver and will
> remove any irqsave/irqrestore used in non-hardirq contexts.

Ok. I actually hope that most of the spinlocks can be
removed from the data path entirely. I just replied on the
ring.spinlock, which I think can go away and be replaced
either with two atomic_t values (rp_local and wp_local
only; 'wp' appears to be unused), or even just an smp_rmb()/
smp_wmb() pair for each access. The gsi register spinlock
can probably be avoided as well if we stop disabling and
renabling the interrupts as I suggested.

gsi_trans_info->spinlock is harder to get rid of unfortunately,
as that would require changing the way you do the doubly linked
lists.

     Arnd
