Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C30C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC6E215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYBdEglh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbfI3QBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:01:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45214 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3QBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:01:41 -0400
Received: by mail-io1-f67.google.com with SMTP id c25so39608434iot.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnfwRpOiVhzSq7yygW2M/1gINbsCP3ZQ5gkXsHGZxJs=;
        b=dYBdEglhUYpSy0INW+yK74hB3CdSy+r/QO8Zo9r5FIOSlVx1p2W+Xzcbjj06u6jgM4
         l8GveDHB9sLBByGbL90uMoHcBDAdFOG3H0RTCUy4hlgVQ3USKq9cHI0d9wCa+j51cy/s
         2ICMPIRjftJhwl1WP9iBQouFNZbem9sxdLJ/me/uXWaJwEop9aRvJLFgvCuxj5iEMsae
         XuOizUF4m5Xl1HXPOMhfG24z2WWYjR41c9PgE0DLduf6RzZN9cwFAJfXFh+8mpLj6xGw
         Jrrd2C43s7eWUYBhQ9z9VjXOLc4ECd14QvyVsw1xYMCkp7wMop9AT7p64Ebw/3QxYOQA
         dHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnfwRpOiVhzSq7yygW2M/1gINbsCP3ZQ5gkXsHGZxJs=;
        b=XQFvr4yUlw++PUJaG3LjxMpXwCNsaYx7nsSA5/ZFMHwJSyLqM6feHPwUfWBjGzeRuK
         5ohPbszwYeUJSTs/HqfObCsS3pEEd/dXTOizdi36d5N8/lPrpVUa+/Hx6UmfWsfr0uDV
         8q0uHBd9TSkxs0eT2r+5XuWpFTnUcY2K7l+F7zLIZqsuJrpUyZD58laRb7ZpQQq8IGkc
         XADeJVMzbjyUwt6Qyi/BJViNwG1EYnMnz16Uj5LOyusHzdNl3FWqVCku/Kvb1ZnvKq3V
         n3Dy4y2eAmjBsYwwXnFD5uNfALmTfd/69betUm7a0wbaS2OS2kOjfFaqJiI8s2HZ5dRZ
         d0Bw==
X-Gm-Message-State: APjAAAWXSuMlZnzlpFyBk/uXfonXVNZQf+SHwsvm2Wr5huFmU4PjrM5w
        FlXYIrdPf4X3xopPMBu+p79rJolfsQGshwPKQHc=
X-Google-Smtp-Source: APXvYqwuKjWoiKoCRE1f+IJv84JJlBUHCHUW6vMe7XeC+PbLK/yWHxS4qE9tnUS+HMSXMd+TZko0FwHTkgB0/utT36c=
X-Received: by 2002:a02:7797:: with SMTP id g145mr20081907jac.60.1569859301056;
 Mon, 30 Sep 2019 09:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190906194719.15761-1-kdasu.kdev@gmail.com> <20190906194719.15761-2-kdasu.kdev@gmail.com>
In-Reply-To: <20190906194719.15761-2-kdasu.kdev@gmail.com>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Mon, 30 Sep 2019 12:01:28 -0400
Message-ID: <CAC=U0a1qvKO+t_62df_JcQBETAuNq0pwRkAb-Ofi3ski2rfdEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: use bounce buffer when vmalloced data
 buf detected
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have any comments on this patch ?.

Kamal

On Fri, Sep 6, 2019 at 3:49 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> For controller drivers that use DMA and set NAND_USE_BOUNCE_BUFFER
> option use data buffers that are not vmalloced, aligned and have
> valid virtual address to be able to do DMA transfers. This change
> adds additional check and makes use of data buffer allocated
> in nand_base driver when it is passed a vmalloced data buffer for
> DMA transfers.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 91f046d4d452..46f6965a896a 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -45,6 +45,12 @@
>
>  #include "internals.h"
>
> +static int nand_need_bounce_buf(const void *buf, struct nand_chip *chip)
> +{
> +       return !virt_addr_valid(buf) || is_vmalloc_addr(buf) ||
> +               !IS_ALIGNED((unsigned long)buf, chip->buf_align);
> +}
> +
>  /* Define default oob placement schemes for large and small page devices */
>  static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
>                                  struct mtd_oob_region *oobregion)
> @@ -3183,9 +3189,7 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
>                 if (!aligned)
>                         use_bufpoi = 1;
>                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> -                       use_bufpoi = !virt_addr_valid(buf) ||
> -                                    !IS_ALIGNED((unsigned long)buf,
> -                                                chip->buf_align);
> +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
>                 else
>                         use_bufpoi = 0;
>
> @@ -4009,9 +4013,7 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
>                 if (part_pagewr)
>                         use_bufpoi = 1;
>                 else if (chip->options & NAND_USE_BOUNCE_BUFFER)
> -                       use_bufpoi = !virt_addr_valid(buf) ||
> -                                    !IS_ALIGNED((unsigned long)buf,
> -                                                chip->buf_align);
> +                       use_bufpoi = nand_need_bounce_buf(buf, chip);
>                 else
>                         use_bufpoi = 0;
>
> --
> 2.17.1
>
