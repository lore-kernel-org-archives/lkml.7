Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A971C606B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2aOuh4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfGHL43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36744 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbfGHL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id y16so4355395vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
        b=n2aOuh4+2HfLrrQ/AerkGk8nPcV0a9lHD1biMG5L8xAvYkxmgeLA8NS7F25S5q3m4/
         PCxVdgp2Jf8w+c1ts10xe7qmXFh+7oane/qyxsSzTyhYVjYlUWbx7mj0ICC6+bojcHJI
         0SINwngWRJuBqkIGoFi8LSLM9AAf4cWCut+tz8LeJrgv1RvYMMYGzCJDEIEEotA8Lx4T
         ExMvH2gvUGRMH8HhXJ4gQBnh9YRG72rx3rbZCAk4XKuIF2dvHFVtWbEZbGdLt8u1/62E
         wvQoT932jJjfBcNytTV6L5O68aaoqrXemfhwy6DrUlk5jFD5bypBb8QcMyuWa0IaOma9
         Ed1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INqtaKqgJbsCXfOBlyhjMGZiHQUnucRAJNFBEd5g9d0=;
        b=SVum7hL5jm76uyaGIhv99Z/MhpOTodkHm3sgg/Po3MayUp6+2Iqsnq2GJebTUDO0YT
         4HbM5v5IjACsaSk19AgW05uSogtVHBF+8Lg+cl9pGxqG/fhdMaZSl0EmYNrorhv6RdcW
         Kn/XAsBIzgJsC7XV9oUe6J66TNa4sVIWWXeLGL/O7RC7N/17EX0yT8Bcmdz3ySvANGPY
         n05O5bkasW4Wb0ci+0UnTHJmaZXwzMgQHl00SotdHv7RKdILyO/stnluV3c+Ipql/Gd+
         x6ESbo3zb/C2HESijors0b1FUmokS4IDIYuEHYAPQ3OpF5dXo4rlqpuDllfVZtprINtI
         MxkA==
X-Gm-Message-State: APjAAAVLGpcU6/X2HfaZImK7U0doknICYwA6I3hSBctNfOhrOFWsEJPH
        sfIMvjeENGJOsB32zJD5Bb2mg/V68TlGmQvgbuEf9Q==
X-Google-Smtp-Source: APXvYqzuMQxu5Q5w1+tmz7XnrX4NkraXYwW+cB7xG+jvVxMPoX8GHek6Jxl9SAJweTu5ja02CrA++IPVX9ipqF+7hMA=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr9881440vsp.165.1562586984367;
 Mon, 08 Jul 2019 04:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-2-hch@lst.de>
In-Reply-To: <20190625092042.19320-2-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:48 +0200
Message-ID: <CAPDyKFotnDCpt9k-r3D2uYRAzpFVA3woRQENLcNcDY0q8+8SVg@mail.gmail.com>
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

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> Just like we do for all other block drivers.  Especially as the limit
> imposed at the moment might be way to pessimistic for iommus.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

From your earlier reply, I decided to fold in the following
information to the changelog, as to clarify things a bit:

"This also means we are not going to set a bounce limit for the queue, in
case we have a dma mask. On most architectures it was never needed, the
major hold out was x86-32 with PAE, but that has been fixed by now."

Please tell, if you want me to change something.

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 3557d5c51141..e327f80ebe70 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -350,18 +350,15 @@ static const struct blk_mq_ops mmc_mq_ops = {
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
>         blk_queue_max_hw_sectors(mq->queue,
>                 min(host->max_blk_count, host->max_req_size / 512));
>         blk_queue_max_segments(mq->queue, host->max_segs);
> --
> 2.20.1
>
