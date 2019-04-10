Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1ABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851CD217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj7BLUf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbfDJM5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:57:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45439 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfDJM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:57:34 -0400
Received: by mail-ed1-f66.google.com with SMTP id o26so1911979edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZx0o2O6bRo9EgKQQOxxMtLh9VWY2maG+dgyRyhxfWI=;
        b=Yj7BLUf6pdR67dCM5HlIoA9eB18XipwdFmYFjTiKpPNpqN57eEJCHBSlkFPnMFxHPA
         4NsO6QIHqzWVPhyndQwKmvqVouEp36lcMe7kDmNQy1LG1OBviig25sdMuy/wxKB1/ouk
         dnmwY6cMSA+boNeuXFtOuJYSK+Y1mejpBWb5AAEvBEz5t6XwwBTb6cDzF9AsEdvvYxlu
         fzJ1kPxxrfInxiMkGHdbmltj/UvpNTf4aPeDAzHxuOhbFffvrWJeH225CC+kfiLsMK8o
         vkqZ2yjx+3L8/1IyGBeGnqHnnKwz7WNRBi0HXKeEAapBCpV+QI+OVbeKANF6JiJCWSNZ
         rm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZx0o2O6bRo9EgKQQOxxMtLh9VWY2maG+dgyRyhxfWI=;
        b=nqrO6nUCRx72X+9AtlBJciD/8TVOt36+WVC/WpCdCUt3qmxdOHfPh1EDfTRLl9l5yK
         DD3o3C8mavCZfBUq1MIHSGaqviA5v08/z15FMFcKkh0lX8B2NczxAbPvBrtnTaKBL1hU
         DVZlkCED2lPFI8TTu6YgPOy77kLeW6lhhouEyXbAVdx8fvEJvMSY8LOaOHiomHnADMJJ
         sIbkP+H0hRXjsu4TyXto5YW0+MZ0aj1kfxY4d1UXfS35d3E7nOx6PEy4A6AnLtc7oYtc
         ExMscsc+F7LZEs71/0cHDBkfVoVJlynWn9KaUb5kWfqziUwKZ+ODJMokpZvwW+fbBIJK
         SL3g==
X-Gm-Message-State: APjAAAWsNsEXk8lCYBJbEg/2cWLu/9fwR+WJjxahqSPcIZB41SPZQXVF
        iUTIeZFmf069V3kcC/Hufv+17tFwSRZB4TO7rp7HfW5n13A=
X-Google-Smtp-Source: APXvYqxokPdGqlXWMlAYkAGLWWwRHfPAfwO6Ozr6LfZUYdNA36mYT0W2YBQLYuD8G0PIOjAU/RqpSNlWEOaoAFI+PpA=
X-Received: by 2002:a05:6402:12d5:: with SMTP id k21mr12604733edx.75.1554901053253;
 Wed, 10 Apr 2019 05:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
In-Reply-To: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 10 Apr 2019 15:57:21 +0300
Message-ID: <CAEnQRZDWHkWqL=v7PiuiW6-Ke+c0wZrEJ+SeTirdNnTzYdOgeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sound: Add hikey960 i2s audio driver
To:     Pengcheng Li <lipengcheng8@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, john.stultz@linaro.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liyuequan@hisilicon.com, cash.qianli@hisilicon.com,
        huangli295@hisilicon.com, hantanglei@huawei.com,
        wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com,
        xuwei5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pengcheng,

Make sure you run ./scripts/checkpatch.pl --strict yourpatchfile.patch

On Thu, Feb 28, 2019 at 4:15 PM Pengcheng Li <lipengcheng8@huawei.com> wrote:
>
> From: Youlin Wang <wangyoulin1@hisilicon.com>
>
> Add i2s driver for hisi3660 soc found on the hikey960 board.
> Add conpile line in make file.
> Technical support by Guangke Ji.

Care to add here some documentation pointers to I2S IP on the SOC?

> diff --git a/sound/soc/hisilicon/Kconfig b/sound/soc/hisilicon/Kconfig
> index 4356d5a..b023ef9 100644
> --- a/sound/soc/hisilicon/Kconfig
> +++ b/sound/soc/hisilicon/Kconfig
> @@ -1,5 +1,11 @@
>  config SND_I2S_HI6210_I2S
> -       tristate "Hisilicon I2S controller"
> +       tristate "Hisilicon Hi6210 I2S controller"
> +       select SND_SOC_GENERIC_DMAENGINE_PCM
> +       help
> +         Hisilicon I2S

Can you enahance the help text? Something like "I2S controller driver
for hisi3600 SoC"
<snip>

> + * Copyright (c) 2001-2021, Huawei Tech. Co., Ltd.

2021? :) IANAL but this looks strange :).

> +struct hi3660_i2s {
> +       struct device *dev;
> +       struct reset_control *rc;
> +       int clocks;
> +       struct regulator *regu_asp;
> +       struct pinctrl *pctrl;
> +       struct pinctrl_state *pin_default;
> +       struct pinctrl_state *pin_idle;
> +       struct clk *asp_subsys_clk;
> +       struct snd_soc_dai_driver dai;
> +       void __iomem *base;
> +       void __iomem *base_syscon;
> +       phys_addr_t base_phys;
> +       struct snd_dmaengine_dai_dma_data dma_data[2];
> +       spinlock_t lock;

What is this lock used for? Please add some docs.

> +       int rate;
> +       int format;
> +       int bits;
> +       int channels;
> +       u32 master;
> +       u32 status;
> +};
> +
> +static void update_bits(struct hi3660_i2s *i2s, u32 ofs, u32 reset, u32 set)
> +{
> +       u32 val = readl(i2s->base + ofs) & ~reset;
> +
> +       writel(val | set, i2s->base + ofs);
> +}
> +
> +static void update_bits_syscon(struct hi3660_i2s *i2s,
> +                       u32 ofs, u32 reset, u32 set)
> +{
> +       u32 val = readl(i2s->base_syscon + ofs) & ~reset;
> +
> +       writel(val | set, i2s->base_syscon + ofs);
> +}

Look at the snd_soc_component_update_bits. You can make these two
functions following the same
pattern for parameters.
