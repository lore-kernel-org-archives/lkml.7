Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtVU33mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKRJIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:08:43 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34084 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:08:42 -0500
Received: by mail-vs1-f67.google.com with SMTP id y23so11002666vso.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiRimydgFdno6bvI6gKo4R2vqPbw7lQEZc/Gs5mBjrU=;
        b=gtVU33mcyHavsljlrlVx0/w4USSbSwwZTNhCrFRSgBpKAiBUKbxvY7g6tJjI9GHWxJ
         7NBobcQSOywhnkKajiEEkYnaDrUnpyoe/zMJHoEOzbl1u7BcunE0CSTjiK5KJNmvRQCB
         kwQPIPfdR8kWFyzWj119Ky1jBojrsL5ev7xnEc8ho587Qk5Lql6RYemyBorDWdV32gGq
         ye1CulY8LjbFBhlRqYvMid4oI3qYPd5Kte9ClpVHKnS+KVVxUVXsoGplsBPlTFFt3To0
         rsku+cUYHrP/5TFSdk0BPjEigVpfgCk1KGcaI/OzCjjI2uFE+fjqhqH7sKEjenMhantj
         b5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiRimydgFdno6bvI6gKo4R2vqPbw7lQEZc/Gs5mBjrU=;
        b=MKRGWTJhE2PTKT2Ow8DhLXzvncuasq79c7MdS9Y9snRpMcEg/apLHlH3qTedA0+c9W
         UZ/bQLqjcUGzhrRYBrRZLVZDnG+Zz3DhK/2T7SNzgtY78ntK0vxV8jX1y+WGf3xhxFrg
         6xCgTqmMcwZnyTAGU67koGEO9DRJ0NaShoHg+AbldlTPE3CQ+lo+ND07IsJObauG+yYK
         9J8gP/LyXbnaKDK57qF5E2WWwIvwPnsDMBXhQ574g0jXXGK8BwTcKAhje3Aj5swLhhDg
         O7Hz6eTiqRGjWkNcbcem3Q5sauJbsyUbIl2XirkzPcKsbFfZ2G5P72VdMpkZ9heSQOyL
         Jrjw==
X-Gm-Message-State: APjAAAXPzqhiDZq3S45HJQK3nw8eKaCmeoH74nZgzoVCHVUt3mIT4JAO
        bw0URcwtybAS681EBDcC3UqiawANZRMNFeMNb76FXQ==
X-Google-Smtp-Source: APXvYqwg+wGm3SQ93DJdDKW8XXBbh2rNBTc9kjxvFlr61CPE4bsCOWK40AJ57W9zrxVniGzpOyDYleo/vaCcvN4PXg8=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr18340969vsa.34.1574068120643;
 Mon, 18 Nov 2019 01:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20191115134430.12621-1-erosca@de.adit-jv.com>
In-Reply-To: <20191115134430.12621-1-erosca@de.adit-jv.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 10:08:04 +0100
Message-ID: <CAPDyKFpGi+Eio-wkr_xmiq5axJohaZwg+etU9Y3b=uq-2WEiWQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: Add MMC_CAP_ERASE to allow
 erase/discard/trim requests
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Harish Jenny K N <harish_kandiga@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 14:45, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> Isolated initially to renesas_sdhi_internal_dmac [1], Ulf suggested
> adding MMC_CAP_ERASE to the TMIO mmc core:
>
> On Fri, Nov 15, 2019 at 10:27:25AM +0100, Ulf Hansson wrote:
>  -- snip --
>  This test and due to the discussions with Wolfram and you in this
>  thread, I would actually suggest that you enable MMC_CAP_ERASE for all
>  tmio variants, rather than just for this particular one.
>
>  In other words, set the cap in tmio_mmc_host_probe() should be fine,
>  as it seems none of the tmio variants supports HW busy detection at
>  this point.
>  -- snip --
>
> Testing on R-Car H3ULCB-KF doesn't reveal any issues (v5.4-rc7):
>
> root@rcar-gen3:~# lsblk
> NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> mmcblk0      179:0    0 59.2G  0 disk  <--- eMMC
> mmcblk0boot0 179:8    0    4M  1 disk
> mmcblk0boot1 179:16   0    4M  1 disk
> mmcblk1      179:24   0   30G  0 disk  <--- SD card
>
> root@rcar-gen3:~# time blkdiscard /dev/mmcblk0
> real    0m8.659s
> user    0m0.001s
> sys     0m1.920s
>
> root@rcar-gen3:~# time blkdiscard /dev/mmcblk1
> real    0m1.176s
> user    0m0.001s
> sys     0m0.124s
>
> [1] https://lore.kernel.org/linux-renesas-soc/20191112134808.23546-1-erosca@de.adit-jv.com/
>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Originally-by: Harish Jenny K N <harish_kandiga@mentor.com>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 9b6e1001e77c..dec5a99f52cf 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1184,7 +1184,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         if (ret == -EPROBE_DEFER)
>                 return ret;
>
> -       mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
> +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_4_BIT_DATA | pdata->capabilities;
>         mmc->caps2 |= pdata->capabilities2;
>         mmc->max_segs = pdata->max_segs ? : 32;
>         mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
> --
> 2.24.0
>
