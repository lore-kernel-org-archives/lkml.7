Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3BC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAC5206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmhgDzpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgAHJXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:23:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43279 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgAHJXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:23:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so1988031qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dvmLFRNf8+MHZpd2KwDUGsjP9seJu3x0QfwV/busyw=;
        b=MmhgDzpkb3QF+Fx2mfbonhzmTOXYwPOM2REqoidoQz6LZAt7G7Ay1D8WBd0mZmksqC
         Rof5oKMwOHnpbdQeMCW8L+9nP+ZhffuGVq6Dfvcr0PDISyMVL52kKOBHyl6jt/XD4xKO
         OZ6DNx4eETnFloWf4905hXGH+RVD0Pc95Lm9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dvmLFRNf8+MHZpd2KwDUGsjP9seJu3x0QfwV/busyw=;
        b=je6p9d7CKWbYW98siZZxQ7yygoifT9clpdD7QNg0WRlIyoUE+61RVmE1F2UjkampSK
         LqDgW6sBum/rJKIfrFwwYlNRPuD9ESeqLTpP+aGXMbqI+XvfzhAsx6uXtg+m0RcsuVbU
         3hiWZEKAezx0PYLwWa8By4S83K607Q2tMWHm49ImsNghoJnBjzZn9f6NSMPA68jUeAoJ
         OctS9vDiOH9QmTO4uJUpWud9EO03EIdiYoFJ0QWwFK5zkcHM3iB1rPN/NeG6PnfFLkNe
         Ry3VMuOzGamr0+6dqJ0OxGErVxehZR2E/CgTYhX0X4vaFO3trVpoxMCUC3ZDSTrpkHWL
         X0aA==
X-Gm-Message-State: APjAAAVAi6LVNTyP9EYwfBpvp9+6Fs1ewGwj8ou/9U048p0stTRGmIep
        swNo0NFoQHnN2Mj/4DJ978HUw26aWe0AX+IdBZTqAQ==
X-Google-Smtp-Source: APXvYqwWV6FSAKUDlqYUh8WnnbcO3wfHfUcUiiCVl4DG3IsL8LYVYSB1P9HskH2Zm2P9Z19FZbHbYqQp7dcB68MOHlo=
X-Received: by 2002:ae9:f003:: with SMTP id l3mr3352513qkg.457.1578475425523;
 Wed, 08 Jan 2020 01:23:45 -0800 (PST)
MIME-Version: 1.0
References: <1578280296-18946-1-git-send-email-jiaxin.yu@mediatek.com> <1578280296-18946-2-git-send-email-jiaxin.yu@mediatek.com>
In-Reply-To: <1578280296-18946-2-git-send-email-jiaxin.yu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 8 Jan 2020 17:23:34 +0800
Message-ID: <CANMq1KCrDX+svufQEeqHYgAFmFaBS0paEz0EBBte73ehA5PiGw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: mediatek: mt8183: Add #reset-cells
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Yong Liang <yong.liang@mediatek.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        chang-an.chen@mediatek.com, freddy.hsin@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 11:11 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
>
> Add #reset-cells property and update example
>
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 10 ++++++---
>  .../reset-controller/mt2712-resets.h          | 22 +++++++++++++++++++
>  .../reset-controller/mt8183-resets.h          | 17 ++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/reset-controller/mt2712-resets.h
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> index 92181b648f52..5a76ac262f8d 100644
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> @@ -4,6 +4,7 @@ Required properties:
>
>  - compatible should contain:
>         "mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
> +       "mediatek,mt2712-wdt", "mediatek,mt6589-wdt": for MT2712

Doesn't look related?

>         "mediatek,mt6589-wdt": for MT6589
>         "mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
>         "mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> @@ -14,11 +15,14 @@ Required properties:
>
>  Optional properties:
>  - timeout-sec: contains the watchdog timeout in seconds.
> +- #reset-cells: Should be 1.
>
>  Example:
>
> -wdt: watchdog@10000000 {
> -       compatible = "mediatek,mt6589-wdt";
> -       reg = <0x10000000 0x18>;
> +watchdog: watchdog@10007000 {
> +       compatible = "mediatek,mt8183-wdt",

Well mt8183-wdt compatible is not yet upstream, do you want to work
with Yong Liang to send both these bindings in the same series? (you
can add mt2712 in the same patch as mt8183 binding maybe?)

> +                    "mediatek,mt6589-wdt";
> +       reg = <0 0x10007000 0 0x100>;
>         timeout-sec = <10>;
> +       #reset-cells = <1>;
>  };
> diff --git a/include/dt-bindings/reset-controller/mt2712-resets.h b/include/dt-bindings/reset-controller/mt2712-resets.h
> new file mode 100644
> index 000000000000..9e7ee762f076
> --- /dev/null
> +++ b/include/dt-bindings/reset-controller/mt2712-resets.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + * Author: Yong Liang <yong.liang@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT2712
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT2712
> +
> +#define MT2712_TOPRGU_INFRA_SW_RST                             0
> +#define MT2712_TOPRGU_MM_SW_RST                                        1
> +#define MT2712_TOPRGU_MFG_SW_RST                               2
> +#define MT2712_TOPRGU_VENC_SW_RST                              3
> +#define MT2712_TOPRGU_VDEC_SW_RST                              4
> +#define MT2712_TOPRGU_IMG_SW_RST                               5
> +#define MT2712_TOPRGU_INFRA_AO_SW_RST                          8
> +#define MT2712_TOPRGU_USB_SW_RST                               9
> +#define MT2712_TOPRGU_APMIXED_SW_RST                           10
> +
> +#define MT2712_TOPRGU_SW_RST_NUM                               11
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2712 */
> diff --git a/include/dt-bindings/reset-controller/mt8183-resets.h b/include/dt-bindings/reset-controller/mt8183-resets.h
> index 8804e34ebdd4..a1bbd41e0d12 100644
> --- a/include/dt-bindings/reset-controller/mt8183-resets.h
> +++ b/include/dt-bindings/reset-controller/mt8183-resets.h
> @@ -78,4 +78,21 @@
>  #define MT8183_INFRACFG_AO_I2C7_SW_RST                         126
>  #define MT8183_INFRACFG_AO_I2C8_SW_RST                         127
>
> +#define MT8183_INFRACFG_SW_RST_NUM                             128
> +
> +#define MT8183_TOPRGU_MM_SW_RST                                        1
> +#define MT8183_TOPRGU_MFG_SW_RST                               2
> +#define MT8183_TOPRGU_VENC_SW_RST                              3
> +#define MT8183_TOPRGU_VDEC_SW_RST                              4
> +#define MT8183_TOPRGU_IMG_SW_RST                               5
> +#define MT8183_TOPRGU_MD_SW_RST                                        7
> +#define MT8183_TOPRGU_CONN_SW_RST                              9
> +#define MT8183_TOPRGU_CONN_MCU_SW_RST                          12
> +#define MT8183_TOPRGU_IPU0_SW_RST                              14
> +#define MT8183_TOPRGU_IPU1_SW_RST                              15
> +#define MT8183_TOPRGU_AUDIO_SW_RST                             17
> +#define MT8183_TOPRGU_CAMSYS_SW_RST                            18
> +
> +#define MT8183_TOPRGU_SW_RST_NUM                               19
> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8183 */
> --
> 2.18.0
