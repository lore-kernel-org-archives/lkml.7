Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B695B20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a8IbOPkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfCYSRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:17:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41321 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfCYSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:17:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so11443681qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEDHhlU9kUtW59S2GYGE8OrxQMGqUWph5lX1gbrO9q0=;
        b=a8IbOPkXxXExB5zE7jE8WL4ECxSPU2uGG1m82SkUxBxHQCTpfPVwJRn9FjxzKCqFS6
         t+0uPPlm4nyKjSxWtdc4jrRYsFyEj/35rkR1LuV6dYmO1hlTuFA7gr+O2+Y6PheC8f5h
         04mg7d2IR3mcgnamlF5Omz6CC/glca+pWXlyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEDHhlU9kUtW59S2GYGE8OrxQMGqUWph5lX1gbrO9q0=;
        b=KrOEoMH+7XaDqWGEAIF81LxtZZG9eL/t3p89NXZlbQWMJhkYhsF1j9H46OgXCPiZ20
         rBCHJsBdge/zbgWTYGSAOm5b+Covch/ACoDf03kFOn+ebNTB7mgwN43WCoFhU8YjuPjx
         r3WFGh2dRCFDYBtIFoSNHKnvvId5Gj7uEMScQDlf3bFU7h9MHZK4mALAcm2LBdaVizXz
         8hzuBWNEOgbGBCbkfW/Sc5tOCJolMSHkJqbl9RoCHiKQ9nJyp3w5hsoeE9sIyrImn/Jz
         vVWsLIXiMD7wagoG2YyrO65t7xcZcEjH/IVN2X8r802DDIK2rId2077JU1jX4oDfY8Tn
         1rwQ==
X-Gm-Message-State: APjAAAVV2ACtcLRfuuCvcExyxCJZVcpGg2uU8kBMIL9VTrzzPcxC/IHf
        AoJYtzqLZFglcajnKnASuBNct8R0U/ROn1yW4tB7LA==
X-Google-Smtp-Source: APXvYqyIyKuwTmHCNxxqJh7nWohG21bsDEM+b+Ju6QZgnpkln/tmm1VZhUBwH4MzXqaFrgsHC4wXSoNw7vSLyc8Febg=
X-Received: by 2002:ac8:f3c:: with SMTP id e57mr21635392qtk.75.1553537868163;
 Mon, 25 Mar 2019 11:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190325124137.6117-1-zhiyong.tao@mediatek.com> <20190325124137.6117-4-zhiyong.tao@mediatek.com>
In-Reply-To: <20190325124137.6117-4-zhiyong.tao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 25 Mar 2019 11:17:37 -0700
Message-ID: <CANMq1KCSN11fH0JS72iheDwKjo06ShKiFu+Yn51xVObcvV37GA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 3/4] arm64: dts: mt8183: add pintcrl device node
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        chuanjia.liu@mediatek.com, biao.huang@mediatek.com,
        hongzhou.yang@mediatek.com, Erin Lo <erin.lo@mediatek.com>,
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

On Mon, Mar 25, 2019 at 5:41 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> The commit adds pintcrl device node for mt8183

Minor nit: This should say pinctrl (in the commit title as well).

>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 75c4881bbe5e..cf92504e2a9b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -9,7 +9,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/power/mt8183-power.h>
> -
> +#include "mt8183-pinfunc.h"
>  / {
>         compatible = "mediatek,mt8183";
>         interrupt-parent = <&sysirq>;
> @@ -197,6 +197,30 @@
>                         #clock-cells = <1>;
>                 };
>
> +               pio: pinctrl@10005000 {
> +                       compatible = "mediatek,mt8183-pinctrl";
> +                       reg = <0 0x10005000 0 0x1000>,
> +                             <0 0x11f20000 0 0x1000>,
> +                             <0 0x11e80000 0 0x1000>,
> +                             <0 0x11e70000 0 0x1000>,
> +                             <0 0x11e90000 0 0x1000>,
> +                             <0 0x11d30000 0 0x1000>,
> +                             <0 0x11d20000 0 0x1000>,
> +                             <0 0x11c50000 0 0x1000>,
> +                             <0 0x11f30000 0 0x1000>,
> +                             <0 0x1000b000 0 0x1000>;
> +                       reg-names = "iocfg0", "iocfg1", "iocfg2",
> +                                   "iocfg3", "iocfg4", "iocfg5",
> +                                   "iocfg6", "iocfg7", "iocfg8",
> +                                   "eint";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&pio 0 0 192>;
> +                       interrupt-controller;
> +                       interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
> +                       #interrupt-cells = <2>;
> +               };
> +
>                 scpsys: syscon@10006000 {
>                         compatible = "mediatek,mt8183-scpsys", "syscon";
>                         #power-domain-cells = <1>;
> --
> 2.12.5
>
