Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC89C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw0MMj8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:08:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33053 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:08:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id c25so10994462vsp.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BghPULC5UyPGqCyK1zeAHOjx8ZZLIefg+Am36y5/pbE=;
        b=Pw0MMj8p0LlnfNL5IbJOueH/jHLg1Qa/uTp/EbX9PeEYraZm4/4ucchRNkZd+JXdr5
         5ZlPMG2O4DnKmDogObQljO1T4/UIwSo2B2d45lvJ2cECcebDcTKBuOHn6/BlYS70GzVQ
         zT1fD1WSZc+An41joFH5Ganlb0k+izYv67b3GGueB0eohIGHtnSmIxzhe0JaTSq/Nh2K
         PFMJuIpqKmDTi22uTsfmrjKK5MG2ugKRNofZ5BPWvy0rLbjEwkMypZkBcd1ilvyvQvpq
         9jt8khp2Rti2CkuVZkhtj2f6ki7PtshRfQWTBhbnqC5YHd52RlAUfcB+7eA0HMxGYWhE
         2dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BghPULC5UyPGqCyK1zeAHOjx8ZZLIefg+Am36y5/pbE=;
        b=ietDaYhIUSMDGGJt3NswCtS4s6v2sjJUM0CeL8GrRHI4PzAccaEwZXQhjfmim+WCDo
         9XbF8HPYTzokiX2E6JFjogi6tk6XSefpoHsP0n+DoJlcg6UrMColrcW3NI6Y2Ufh4r9q
         T/i4l4dtFAH2c+GnwltT/WZBMmxgTuQ7Lz5evckSfo5MbkBSYtkNB/+WbYGp2qILAozG
         F6fbtXosRq4ePL+0r9dhXQILSQWmjE6vc6kftK9LnzsSsfLBV0598H+Y8nwlR3W5wVHl
         ILTJ6A5gLHtQgjnXxa2Ff5Z8snEYRA0vgKBpMlEkQGQt97NTpNKQbJ9NYYSzLtewYwCo
         /Big==
X-Gm-Message-State: APjAAAVZNfBdYCmkDZV8amm3XuYvbxoTfnj7O20suMahY88WBgXXA5V/
        v8/Yge5bUcUZ5ySraalRLhKSPsDrS38JBttotGDLGw==
X-Google-Smtp-Source: APXvYqxZ2cPOQDOOgbtbMRMPYyOPuVXbLXuf68UzKvf/TwmE5hxQYuGLkkLxzfpAHMKV3VLA+3FdtAgs3lyTtO7bPxA=
X-Received: by 2002:a67:2087:: with SMTP id g129mr18038208vsg.191.1574068113132;
 Mon, 18 Nov 2019 01:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20191117010045.4902-1-bradleybolen@gmail.com>
In-Reply-To: <20191117010045.4902-1-bradleybolen@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Nov 2019 10:07:57 +0100
Message-ID: <CAPDyKFreYm3EsLO=e97RCOqaKJxkYJ+fqJcgskO7PtO15Tj4fQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Fix size overflow for mmc partitions
To:     Bradley Bolen <bradleybolen@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019 at 02:00, Bradley Bolen <bradleybolen@gmail.com> wrote:
>
> With large eMMC cards, it is possible to create general purpose
> partitions that are bigger than 4GB.  The size member of the mmc_part
> struct is only an unsigned int which overflows for gp partitions larger
> than 4GB.  Change this to a u64 to handle the overflow.
>
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c   | 9 ++++-----
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8804895595f..f6912ded652d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
>         }
>  }
>
> -static void mmc_part_add(struct mmc_card *card, unsigned int size,
> +static void mmc_part_add(struct mmc_card *card, u64 size,
>                          unsigned int part_cfg, char *name, int idx, bool ro,
>                          int area_type)
>  {
> @@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  {
>         int idx;
>         u8 hc_erase_grp_sz, hc_wp_grp_sz;
> -       unsigned int part_size;
> +       u64 part_size;
>
>         /*
>          * General purpose partition feature support --
> @@ -343,8 +343,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>                                 (ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
>                                 << 8) +
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
> -                       part_size *= (size_t)(hc_erase_grp_sz *
> -                               hc_wp_grp_sz);
> +                       part_size *= (hc_erase_grp_sz * hc_wp_grp_sz);
>                         mmc_part_add(card, part_size << 19,
>                                 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
>                                 "gp%d", idx, false,
> @@ -362,7 +361,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  {
>         int err = 0, idx;
> -       unsigned int part_size;
> +       u64 part_size;
>         struct device_node *np;
>         bool broken_hpi = false;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9b6336ad3266..b59d35bb50ba 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -226,7 +226,7 @@ struct mmc_queue_req;
>   * MMC Physical partitions
>   */
>  struct mmc_part {
> -       unsigned int    size;   /* partition size (in bytes) */
> +       u64             size;   /* partition size (in bytes) */
>         unsigned int    part_cfg;       /* partition type */
>         char    name[MAX_MMC_PART_NAME_LEN];
>         bool    force_ro;       /* to make boot parts RO by default */
> --
> 2.17.1
>
