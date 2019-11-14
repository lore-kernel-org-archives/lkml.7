Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A30206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3emd+JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfKNLMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:12:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46543 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKNLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:12:40 -0500
Received: by mail-vs1-f65.google.com with SMTP id m6so3564425vsn.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wGJc1b1i6izoCeCYX7Kg1wuag10LQ4c4CnoB2uBxSg=;
        b=Q3emd+JRbaoyBe0PEuLk5BBMgYUllek5nU3jPhXciimdF+b/lq5eO5r3NKsx+uSBn5
         D3f6WghoaOSuUGJRj6zKcw5GsPPRCrgkHvNy5BDcVx7bqYTnLf8ERdyTJu93UXkUqqbp
         v/oGL5DygC5WxU+Q+rGsplMV4LDmssYOwNECNoCDhM8B9aE6br5Xbbe2ue9R8bW1E6lE
         0+FmcdTd+6Bcmt7/c46hs3ABRn5Lg+6PaBshIwwFO9abDrLhDJ7ETy0x/sfwIpD990zt
         Yp/g8D4iP90c449yR/9bJvtWfBDHc2pfx/MPGULgzxB2097UaOVpnDhZHVv++ULIjLu9
         zFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wGJc1b1i6izoCeCYX7Kg1wuag10LQ4c4CnoB2uBxSg=;
        b=eR+qt5zLu8clqcT1mcfF9/xoZW7bcdpte1dP3E9om6hiiEJvo+auC7rpL+97mUgRSP
         04tuRNApUaZIhxk45Eaekh7yJ8lrnKlB620U6+dVu94yMcVIza9AuB7cF4nuet5Ew3X/
         SNov/pSKZO4UGpJeMzeupAIO7g6qkI5exL03PaHBCxKFXLbk6mnNTKEoiWJOK78NntGJ
         qd5J3cPwiWbO3XzXD4HR5p6YPURoUVFxRLWwWdkKDnh+wrmpeJ39yffhMhUctdDyRbfV
         FgeqZULE2qhYGp5tOptotN37b5niLjkl3jZcBO0QQMFT85umF7PNqc09doBCEFCY2JJ+
         WdJg==
X-Gm-Message-State: APjAAAWF0pRNSkBptY8XFzI28mtu0IjtmF/xxlFV8eXducNgW2CRxviU
        TiU4Vbq6I7JeKlnRS/snJ6bceO13Bi7GeVTtagJ+RXw7Br8=
X-Google-Smtp-Source: APXvYqyCJNbtDOAC7W0igpGwVzK49rBCRVOKJlPUyb9DPPalIM+2RwOD2hBhMLOqOXEE9bHyAUoglvI/Bnnn+BNgGDQ=
X-Received: by 2002:a05:6102:36d:: with SMTP id f13mr5458771vsa.34.1573729957703;
 Thu, 14 Nov 2019 03:12:37 -0800 (PST)
MIME-Version: 1.0
References: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
In-Reply-To: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Nov 2019 12:12:01 +0100
Message-ID: <CAPDyKFokrmxu8CLOTVjtbzf3sMQcLahVqAtYP5X=wnqST5+Zdg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix size overflow for mmc partitions
To:     Bradley Bolen <bradleybolen@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>,
        Hongjie Fang <hongjiefang@asrmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 at 04:26, Bradley Bolen <bradleybolen@gmail.com> wrote:
>
> With large eMMC cards, it is possible to create general purpose
> partitions that are bigger than 4GB.  The size member of the mmc_part
> struct is only an unsigned int which overflows for gp partitions larger
> than 4GB.  Change this to a u64 to handle the overflow.
>
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
> ---
>  drivers/mmc/core/mmc.c   | 6 +++---
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c880489..fc02124 100644
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

There is also a cast to a "size_t" while computing the part_size in
mmc_manage_gp_partitions(). Should we remove that as well?

[...]

Kind regards
Uffe
