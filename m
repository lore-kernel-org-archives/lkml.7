Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84857C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1762166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfEOTiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:38:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44736 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfEOTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:38:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so1063615qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyWzyI2UXZXBor7mB3ol4MqEYJD1vGyEwW2168pojnA=;
        b=tHzNRfOBQ54qbbT/dL+JbqVJtaqmHgbBjn3uGwAYvsGvtdQfwos4Q+oD4RMf5U/wLQ
         f8DTl5BXDXi+h3b8/Hyv9qqiZPqtIRO61WCfSOy9hBfd8Bs89QmrZ2n0eDliZekHQDi3
         8yP39XNuRo3wEyP/yHL31s3jSuMrODQun22aE9sPKluc8M4N3VeHhrnsQcTYbzy0LXTz
         oLSkL1lpSbahfO7I/5MyqUXwbxYKhK8Eq3shwgGtCsCnfOAeWzUuKAj/oethb+xu0a7B
         RNatvmordXvtGpZNzE3ttplrLn2L7gKRqxq7YHVzWxdhbzzFzwZCfEqyzM8v5TlPpo/q
         ez9Q==
X-Gm-Message-State: APjAAAXF04Ur8p9hzbMalI7f2GXVXzPeOMbi/ed66i7tBmVJ5hc21QcP
        4wSh56KsUJ7PDgmzQSePoK7dvFiJV7OZj+JARP4=
X-Google-Smtp-Source: APXvYqyXfEWrkoVlkor6gduR93XqdVIZZomQkQEF8yId7Hd2cBQHS2Q/QxxMEAgT5gNl9idHYeSfw2ZA7A9JEVXuXhU=
X-Received: by 2002:ac8:2924:: with SMTP id y33mr37005088qty.212.1557949096837;
 Wed, 15 May 2019 12:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190512012508.10608-1-elder@linaro.org> <20190512012508.10608-9-elder@linaro.org>
In-Reply-To: <20190512012508.10608-9-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 21:37:59 +0200
Message-ID: <CAK8P3a2QZ3-VEQ21AHGAz4JPEDSKAUZtqtVarQ9Uk7Bg32PpNQ@mail.gmail.com>
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

> +static int gsi_ring_alloc(struct gsi *gsi, struct gsi_ring *ring, u32 count)
> +{
> +       size_t size = roundup_pow_of_two(count * sizeof(struct gsi_tre));
> +       dma_addr_t addr;
> +
> +       /* Hardware requires a power-of-2 ring size (and alignment) */
> +       ring->virt = dma_alloc_coherent(gsi->dev, size, &addr, GFP_KERNEL);
> +       if (!ring->virt)
> +               return -ENOMEM;
> +       ring->addr = addr;
> +       ring->base = addr & GENMASK(31, 0);
> +       ring->size = size;
> +       ring->end = ring->base + size;
> +       spin_lock_init(&ring->spinlock);
> +
> +       return 0;
> +}

Another comment for this patch: dma_alloc_coherent() does not guarantee
alignment of the requested buffer as implied by the comment. In many
configurations, it /is/ naturally aligned because the buffer comes from
alloc_pages(), but you can't really be sure.

I suspect it's actually only broken when the buffer spans a 4GB boundary
(and updating the lower 32 bit in the register gives a wrong pointer), which
is unlikely but will happen at some point according to Murphy's law.
If you just need the dma_addr_t to not cross a 4GB boundary, the
easiest solution would be to use GFP_DMA32, which gives you a
buffer that is mapped to the first 4GB bus address space (not necessarily
the first 4GB of RAM if you have an iommu).

If you manually align the ring buffer, it should be fine too, though I have
to say that the way the driver does pointer arithmetic on 32-bit integers
seems rather fragile as well.

A nicer way to deal with ring buffers in general is to only ever use a
32-bit index number stored in an atomic_t, use atomic_inc_return()
to advance the index and then mask the number when turning it into
an index. With that, you should also be able to avoid the shared
spinlock. Moving the rp and wp into separate cache lines further
reduces the coherency traffic by avoiding concurrent writes on the
same line.

      Arnd
