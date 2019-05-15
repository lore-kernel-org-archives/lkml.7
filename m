Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4547C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8512084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEOMke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:40:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38985 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfEOMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:40:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so3027567qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwxYLcAXWfjkqmWMw2YaydohNEg09KMHkCzxeJMo9TA=;
        b=Q0Uvb9WHl1+eJhLtRVxjEYlFHLRVyViZPSqzqSByA+diAqrTncVPoo2ANJ4Jq8Pa+9
         4u0Q1KmmNSadWmYWQyXcCdkaNlA9EogMjOl7h15+h1yjwWwFyKh7nZgSQQxToXa/1ApQ
         f/gTdhv8/WfygIDG/IXPsTlG3NdrKfnUBElKnaoOj9lfvPxqlsz0nb1ZdKf2RTUZl3XW
         OpzCZqfpP/dFxmCOe4FJ6ESxkvT0RL5AQnrznRluhwuOtm8K/f7K0XmcSA6FXhO8QKOT
         uAa4z/JeMUULJ+okKAibaBFs8ybNYHhWVgjltARbfU2qcU6+8xq4E2GB0JLsIBrBeqel
         wzag==
X-Gm-Message-State: APjAAAU/NU5U8b9NDpgifZaeMWfD4gYLJ/iHGa5MHmVK2SoQS3E044/N
        gNHZBmfBpqxlJ2ETUMMeBbLdy/nnfAKnWe5qwH8=
X-Google-Smtp-Source: APXvYqy6+ImJxnSBa9VYXjyyEIfv40fT7yAp26ih7RvEJzRLwPLstx/aRCvtRbCr0f/ELALWipPwXP0km+QhQTgSQqc=
X-Received: by 2002:ac8:2d21:: with SMTP id n30mr33991548qta.96.1557924032651;
 Wed, 15 May 2019 05:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-9-elder@linaro.org>
 <CAK8P3a1gi2pbjh8+Ev1=hMXrnUeQuHxdFubcC50PVVXVpjhSmQ@mail.gmail.com> <72869c32-c2c5-54f9-10d9-8c0ed9f6300d@linaro.org>
In-Reply-To: <72869c32-c2c5-54f9-10d9-8c0ed9f6300d@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 14:40:16 +0200
Message-ID: <CAK8P3a3RCHF0UyKunaoCNvEd0X9EiD62PPfnfGxKG1L95Jz7dA@mail.gmail.com>
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

On Wed, May 15, 2019 at 2:13 PM Alex Elder <elder@linaro.org> wrote:
> On 5/15/19 2:21 AM, Arnd Bergmann wrote:


> >> +/* Wait for all transaction activity on a channel to complete */
> >> +void gsi_channel_trans_quiesce(struct gsi *gsi, u32 channel_id)
> >> +{
> >> +       struct gsi_channel *channel = &gsi->channel[channel_id];
> >> +       struct gsi_trans_info *trans_info;
> >> +       struct gsi_trans *trans = NULL;
> >> +       struct gsi_evt_ring *evt_ring;
> >> +       struct list_head *list;
> >> +       unsigned long flags;
> >> +
> >> +       trans_info = &channel->trans_info;
> >> +       evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
> >> +
> >> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> >> +
> >> +       /* Find the last list to which a transaction was added */
> >> +       if (!list_empty(&trans_info->alloc))
> >> +               list = &trans_info->alloc;
> >> +       else if (!list_empty(&trans_info->pending))
> >> +               list = &trans_info->pending;
> >> +       else if (!list_empty(&trans_info->complete))
> >> +               list = &trans_info->complete;
> >> +       else if (!list_empty(&trans_info->polled))
> >> +               list = &trans_info->polled;
> >> +       else
> >> +               list = NULL;
> >> +
> >> +       if (list) {
> >> +               struct gsi_trans *trans;
> >> +
> >> +               /* The last entry on this list is the last one allocated.
> >> +                * Grab a reference so we can wait for it.
> >> +                */
> >> +               trans = list_last_entry(list, struct gsi_trans, links);
> >> +               refcount_inc(&trans->refcount);
> >> +       }
> >> +
> >> +       spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
> >> +
> >> +       /* If there is one, wait for it to complete */
> >> +       if (trans) {
> >> +               wait_for_completion(&trans->completion);
> >
> > Since you are waiting here, you clearly can't be called
> > from interrupt context, or with interrupts disabled, so it's
> > clearer to use spin_lock_irq() instead of spin_lock_irqsave().
> >
> > I generally try to avoid the _irqsave versions altogether, unless
> > it is really needed for a function that is called both from
> > irq-disabled and irq-enabled context.
>
> OK.  And I appreciate what your saying here because I do prefer
> code that communicates more about the context in ways like
> you describe.

Right, also reading the status of the irq-enable flag can be
expensive on some CPUs, so spin_lock_irqsave() ends up
much more slower than spin_lock() or spin_lock_irq(). Not sure
if it makes a huge difference on this particular platform, but
it's better not to have to worry about it.

     Arnd
