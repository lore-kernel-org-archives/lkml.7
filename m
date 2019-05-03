Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C33C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18282081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 10:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUVVEC+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfECKHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 06:07:09 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41987 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfECKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 06:07:09 -0400
Received: by mail-ua1-f68.google.com with SMTP id h4so1807888uaj.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMsfO5bwv4fct0CXFpp+M6L+nA/SFqgtUnj/08mh3/M=;
        b=HUVVEC+mmY62Aby7AgNB3ndZ3gtUn897nDSRdcWPjGm37j62VZ06IlJ3sJp75XjKn4
         vwsOUyvL4yd05V3PV92pWSwTB495C+E5MQwNz7WTtAHcE9nF/oWHgZBFxiExFNm8oGGs
         8huLs+XM5ko0jgg62YHFpqZ9RplzgJEQpRsxZUrEGIxVVffb6vrlUMXqpD5M5nvPiPFc
         QpfSXjGfxrPIeICt/FVSCbokO8ACtxL9BHc7sUMrDRgfxhRixIuSof11KFh23tIaCV/o
         hcRMaESYVO0rZIVl1fXT0uVMxA038Tnnmun+ONcVZsXQDk41NjK+Q6kvygPxxWrsYcKl
         InUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMsfO5bwv4fct0CXFpp+M6L+nA/SFqgtUnj/08mh3/M=;
        b=lOqOMBG4hOA6Q+IxlXOiR1Vq+9v27eA2NQWkczJ2xXr6gT4BfIo9nF49VEdyylprqw
         vfqlLDiuTGIgC1BrxWueTVLRutsWyPaCYg1T+SDNZ+BEPrZbGYfju9Q37qvgeGJRYs9U
         7NC4CyOqRLASUri2/JMN3f7Ql7PsiSznGUqeYW5+/ZO5Qg0n2ByCONBDj00XVUsyJAfC
         3lyWhcOPmDHIkFy7cG2Jweb8evbnRk7dbTOHHTX03eFqx4Xg58NT/g6jEqnzt57qyzL2
         rEtyxrPwfBH5ISTrvZiRNCSePsq0/WYdYBmd2+g7DGn9TONGVy4i2H5PGxISwLQSuvQP
         r/dg==
X-Gm-Message-State: APjAAAV8tQ0Qp/qdsERPmqYgbOX5sJghueTOyq9S7K9pADLR/jScqzOk
        vIkZ/TN9LPY0jHoKLNA5Ml66MlS4/bm2aeUIFZC67A==
X-Google-Smtp-Source: APXvYqyLjG8TW8y6ZZZStDYIxWlokHSLZm+fmA95mQfN+lU9yJTIGL9r/ufVImeu65SgjqAu01oR6rlwQ//2mSWckOc=
X-Received: by 2002:a9f:204a:: with SMTP id 68mr5000627uam.19.1556878028026;
 Fri, 03 May 2019 03:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190502190714.181664-1-rrangel@chromium.org>
In-Reply-To: <20190502190714.181664-1-rrangel@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 12:06:32 +0200
Message-ID: <CAPDyKFqNZeOZLgY4ntn=OPmP9Zo5S8HbtUtZ5MFVtz=BJ78LzQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix tag set memory leak
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Ming Lei <ming.lei@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019 at 21:07, Raul E Rangel <rrangel@chromium.org> wrote:
>
> The tag set is allocated in mmc_init_queue but never freed. This results
> in a memory leak. This change makes sure we free the tag set when the
> queue is also freed.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for fixes (it may not make it for v5.1 unless there is a rc8), thanks!

I also dropped the white space fixup, for the reasons explained by Adrian.

Kind regards
Uffe

> ---
> I found this using kmemleak and plugging and unplugging an SD card in a
> few times.
>
> Here is an example of the output of kmemleak:
> unreferenced object 0xffff888125be4ce8 (size 8):
>   comm "kworker/1:0", pid 17, jiffies 4294901575 (age 204.773s)
>   hex dump (first 8 bytes):
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<0000000061cb8887>] blk_mq_alloc_tag_set+0xe9/0x234
>     [<00000000cf532a0f>] mmc_init_queue+0xa9/0x2f0
>     [<000000001e085171>] mmc_blk_alloc_req+0x125/0x2f9
>     [<00000000eae1bd01>] mmc_blk_probe+0x1e2/0x6c1
>     [<00000000a0b4a87d>] really_probe+0x1bd/0x3b0
>     [<00000000e58f3eb9>] driver_probe_device+0xe1/0x115
>     [<00000000358f3b3c>] bus_for_each_drv+0x89/0xac
>     [<00000000ef52ccbe>] __device_attach+0xb0/0x14a
>     [<00000000c9daafa7>] bus_probe_device+0x33/0x9f
>     [<0000000008ac5779>] device_add+0x34b/0x5e2
>     [<00000000b42623cc>] mmc_add_card+0x1f5/0x20d
>     [<00000000f114ebc3>] mmc_attach_sd+0xc5/0x14b
>     [<000000006e915e0d>] mmc_rescan+0x261/0x2b6
>     [<00000000e5b49c26>] process_one_work+0x1d3/0x31f
>     [<0000000068c8cd3c>] worker_thread+0x1cd/0x2bf
>     [<00000000326e2e22>] kthread+0x14f/0x157
>
> Once I applied this patch the leak went away.
>
> p.s., I included a small white space fix. Hope that's ok.
>
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 7c364a9c4eeb..176a08748cf1 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -402,7 +402,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>
>         mq->card = card;
>         mq->use_cqe = host->cqe_enabled;
> -
> +
>         spin_lock_init(&mq->lock);
>
>         memset(&mq->tag_set, 0, sizeof(mq->tag_set));
> @@ -472,6 +472,7 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>                 blk_mq_unquiesce_queue(q);
>
>         blk_cleanup_queue(q);
> +       blk_mq_free_tag_set(&mq->tag_set);
>
>         /*
>          * A request can be completed before the next request, potentially
> --
> 2.21.0.593.g511ec345e18-goog
>
