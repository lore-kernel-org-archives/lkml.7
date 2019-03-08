Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8882120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D36ef2t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCHGAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:00:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40833 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHGAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:00:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so10563018qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 22:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJYlzDu9YbkzO82ISmD3yyfoe4fNowe/ukm/U3OC36s=;
        b=D36ef2t3lahyHKJer0RBlKqCaYBOwdjmzBb9K+0SFHwBKTWXpuEuwOBwWVUkb4L0Wl
         /aB1+aCONHEH5drJ1LtLQ2sjTd4ToOUEVMnujTXuLnb+a2H/jeUA2clUOPIij5D9uynX
         BrturceBcxBGruZFUXvlFCzAviOliX/ZcUffA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJYlzDu9YbkzO82ISmD3yyfoe4fNowe/ukm/U3OC36s=;
        b=EwL4xpbkgqp39BgCYkc04dLPbpogUjfW8iwhFPuxdbVnFxbxZMje4H9U+Qi6Jg3bDY
         zuOGpi9Z60Kx9vK0X5bdrK7I0HJ/VjupvbVdVG5Zz3a89aZOhEM/QxM5RmYvvSi1B3Gh
         OBikPKmSWxZS2F4LCAyEHnpXfqsiYHOkmOcwm9HZIGJ8IouKjTTF7thWId3DBOtl+zRf
         727tkx/Z5IbdHJooq8YDTiByR9mBLg1Nj6VUuHFPyvSWFrOEf95TxEd1KkSGY/f9J/Oq
         uLutgEdZRBQIe0w7JV55jU2A+SRu/TpqIscRQdj1hpfNvZoTzIfMtD4nnY9EJFXkYcJY
         TyOw==
X-Gm-Message-State: APjAAAUdOvMeZBffnZZp7g575gUHN34UQPr6eLS8u4FgMjGKugEpfkz8
        wSkUyTD8hg9d7T1CfYzKinqBahpkxMmmWFRPF6pyAA==
X-Google-Smtp-Source: APXvYqx/Dj+KMbdrYN38gMGjqxoy/uyHmXZuYCmgrGhfG0jKXNwhXakEnVzAyKCGfJT9sdpzb9D4GYKSrWghoFrH+CE=
X-Received: by 2002:a37:9682:: with SMTP id y124mr4303743qkd.288.1552024809757;
 Thu, 07 Mar 2019 22:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20190303015341.986-1-zhiyong.tao@mediatek.com> <20190303015341.986-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20190303015341.986-2-zhiyong.tao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 8 Mar 2019 13:59:58 +0800
Message-ID: <CANMq1KAyvBLzGKOp=LXy3Ft3khs=QsUgTLXMq1mTd7o2_phcsg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add drive for I2C related pins on MT8183
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        liguo.zhang@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        hongkun.cao@mediatek.com, biao.huang@mediatek.com,
        hongzhou.yang@mediatek.com, chuanjia.liu@mediatek.com,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a v3, I think, please make sure the update the email title,
and add a changelog below ---.

On Sun, Mar 3, 2019 at 9:54 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> This patch provides the advanced drive for I2C used pins on MT8183.
> The detail strength specification description of the I2C pin is as follows.
> When E1=0/E0=0, the strength is 0.125mA.
> When E1=0/E0=1, the strength is 0.25mA.
> When E1=1/E0=0, the strength is 0.5mA.
> When E1=1/E0=1, the strength is 1mA.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
>  drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
>  4 files changed, 128 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3678ea..f034574fc593 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> @@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
>         PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
>  };
[snip]
>  static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>         [PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
>         [PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
> @@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
>         [PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
>         [PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
>         [PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
> +       [PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_e1e0en_range),

I find the name EN_DIS confusing: I think it means ENable_DISable, but
when I read the code, I see stuff like (MANY_WORDS)_DIS = enable ? 1 :
0, which make me think that the polarity is wrong.

Can we just call this PINCTRL_PIN_REG_DRV_EN?

> +       [PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_e0_range),
> +       [PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_e1_range),
>  };
>
[snip]
