Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D602084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r257t7nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDKJBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:01:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33633 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDKJBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:01:33 -0400
Received: by mail-vs1-f68.google.com with SMTP id a190so3059835vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnatT+jdtQF0JEB7Nk+rRsGXNIW2kJHlGBbezXEtsEA=;
        b=r257t7nJSEYG00c7JQwV7VQyIw1FZGynR2MOLhNuH/WY4PiuTQUVQkfPYFW1C7+scf
         0O/IY/861L6ydpdi0TEQJiJ1PjIudUbGY2rV4pYw8bmm6EbWYhUgg46GbBNasCMkO9uV
         s18KjfS5+l+gfUpRu++r1rByJbLgp2iXi1eoWxifCgroV1A3Mk9kY583ETL20WnOxgI4
         AS7D/cBatvjctVBm4nxRyqbFL70XToCY7rO70y2mkNC6yYFI4gVOhJNAC90mTIFe2g1k
         sWvHli5XY2xadk8UyM7D8BbSVGN8u/OSIprB9dzjL03U7SblELbxJGlc3Lsfh/Vu7k8N
         +21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnatT+jdtQF0JEB7Nk+rRsGXNIW2kJHlGBbezXEtsEA=;
        b=ImBD2c5q7vPG3Znnqz831u7q9QO1EG5ej/u5m0DvMeBcepyHGhy0eedodgMPnZ/Fo2
         KtxP0L1ZgLu1m6uGOIUUonRiMcuj74dNh1mqPKBBKHTRIubdZGkRfsR/2yK3XdHwSbhy
         dxcN83l5WV5CBGgTN74EQ4YfbZCGRCJnsC7BoFHYPk9RNdKxm3xKg0ESUX635oS/0fKX
         u05Z5n6BmYQwHgh3zdgjZKW3H6MTOOoiC5vlo5PWhiGcAI+I8IDhYnYECuUgnw3nsx0B
         /ENO2uJaaX/A1vshwP7gWjzXWMRxIG3WCBNAXEg+iyF/jwKEkzKDX2iRF2vab60KtKfc
         ixYg==
X-Gm-Message-State: APjAAAXOd2h/c6RO6QDjpRga3peMUUHI9ecS6NDyr61qTRY0wJ32IW+1
        D0HlxAeQ+HCxKlA1iIxUOSIllFGvWbAJ/qEutoXtDw==
X-Google-Smtp-Source: APXvYqwDdqE/o2RrwREk77vUS27uHxKVdSVOxqXYu38QwsgxM0TJnvklLlUyfzHFzBWAhKjrwy0ny1645mJWeUzw0/I=
X-Received: by 2002:a67:fa04:: with SMTP id i4mr27302504vsq.18.1554973292450;
 Thu, 11 Apr 2019 02:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411070948.29564-1-hch@lst.de> <20190411070948.29564-2-hch@lst.de>
In-Reply-To: <20190411070948.29564-2-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 11:00:56 +0200
Message-ID: <CAPDyKFqHrvz_5taNTx7k6Skx=Ox+9XgQHHz0LZyr4QNV9orvRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: let the dma map ops handle bouncing
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, 11 Apr 2019 at 09:10, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.

I would appreciate some information in the changelog, as it's quite
unclear of what this change really means.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..eb9c0692062c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -354,18 +354,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
>  static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       u64 limit = BLK_BOUNCE_HIGH;
>         unsigned block_size = 512;
>
> -       if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
> -               limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
> -
>         blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
>         blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
>         if (mmc_can_erase(card))
>                 mmc_queue_setup_discard(mq->queue, card);
>
> -       blk_queue_bounce_limit(mq->queue, limit);
> +       if (!mmc_dev(host)->dma_mask || !*mmc_dev(host)->dma_mask)
> +               blk_queue_bounce_limit(mq->queue, BLK_BOUNCE_HIGH);

So this means we are not going to set a bounce limit for the queue, in
case we have a dma mask.

Why isn't that needed no more? Whats has changed?

>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>

Kind regards
Uffe
