Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E648233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566497643;
	bh=E0tPMOEUv3jrqDmtrvwzedPZXnnURm97wF7wyeFfPrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MRZ8/TylcvMl7C9f1XXYSUQGNVG8GMrOYti0rJEYLHZ30FTCEgWBUjbaFx38C4c3g
	 Fd/hlpDD0SdNYxv17NLr1RWgTqy4TQGcQCooGEnvSI3msXMrIMgbvPqAuErxDzKfCG
	 IXc/MzFKXbDnanF3QDy97UgcJyn9o/M5vrLqKwyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbfHVSOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387698AbfHVSOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:14:02 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409AE23402;
        Thu, 22 Aug 2019 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566497641;
        bh=E0tPMOEUv3jrqDmtrvwzedPZXnnURm97wF7wyeFfPrI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rEPVrIANqHOqSJfeCRLws+WJyuKUk9JaQQsjGBRJIAiIp+qTcPJ0Ku4Zk5YQoAi1q
         h7+N4yk/T1mHKy8RmeDqvaL6cpy41HvdOEsvnEdLQC1wegcqCSnXpOkIY8/PBcRKps
         7DwpiqK+JvLZer+86GGJmODZiAY7inkt8TlzuFFQ=
Received: by mail-wm1-f52.google.com with SMTP id 10so6535609wmp.3;
        Thu, 22 Aug 2019 11:14:01 -0700 (PDT)
X-Gm-Message-State: APjAAAUoO+fIIGM50V+5PSJlj/pg909msZELIpN/CjI05wZZE8zlByg2
        WrHgo2fN0GwErXxHExCKGaefAT8J0Ydzm/C/zfs=
X-Google-Smtp-Source: APXvYqz9VKO+A36Lao8izp41Osz7VfriIA6pPPz+vN/d2kRbuSlNxEbSGedMUhbQXO1m65E/CzbYTQQNziZlZ0ZLYKk=
X-Received: by 2002:a1c:2314:: with SMTP id j20mr394213wmj.152.1566497639822;
 Thu, 22 Aug 2019 11:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-8-git-send-email-mars.cheng@mediatek.com>
In-Reply-To: <1566206502-4347-8-git-send-email-mars.cheng@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 22 Aug 2019 11:13:48 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzpsg2ZjP3Ydj+Fo88FXT_jrV=GnJ+vf4AsSNacwEEx=BA@mail.gmail.com>
Message-ID: <CAGp9Lzpsg2ZjP3Ydj+Fo88FXT_jrV=GnJ+vf4AsSNacwEEx=BA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] pinctrl: mediatek: add mt6779 eint support
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, mtk01761 <wendell.lin@mediatek.com>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 2:22 AM Mars Cheng <mars.cheng@mediatek.com> wrote:
>
> add driver setting to support mt6779 eint
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>

Acked-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/pinctrl/mediatek/pinctrl-mt6779.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
> index 145bf22..49ff3cc 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt6779.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
> @@ -731,11 +731,19 @@
>         "iocfg_rt", "iocfg_lt", "iocfg_tl",
>  };
>
> +static const struct mtk_eint_hw mt6779_eint_hw = {
> +       .port_mask = 7,
> +       .ports     = 6,
> +       .ap_num    = 209,
> +       .db_cnt    = 16,
> +};
> +
>  static const struct mtk_pin_soc mt6779_data = {
>         .reg_cal = mt6779_reg_cals,
>         .pins = mtk_pins_mt6779,
>         .npins = ARRAY_SIZE(mtk_pins_mt6779),
>         .ngrps = ARRAY_SIZE(mtk_pins_mt6779),
> +       .eint_hw = &mt6779_eint_hw,
>         .gpio_m = 0,
>         .ies_present = true,
>         .base_names = mt6779_pinctrl_register_base_names,
> --
> 1.7.9.5
>
