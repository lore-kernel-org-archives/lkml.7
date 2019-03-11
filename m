Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE59C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9312087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552331988;
	bh=3VoV940QiZWFfm7xMD9/q5v2QS/73GE/Au7NtQaXohE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iiXAZPx+sZjw0s8jP58fav5vtQbaKmBsCtCuqlAe/WEfWwz1h//pK9tumONBrJ0i6
	 eHpjPsPQe2JrYA9sfq6/RmFfp6HgusV5Xu7ADcZjTzfrHLzgh6wL8nn0LSzFEWGkTw
	 bwQnTKVfzZA0cA6Ykqpqfbh7cnTj61qJsMf4OkyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCKTTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfCKTTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:19:46 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACDB32175B;
        Mon, 11 Mar 2019 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552331985;
        bh=3VoV940QiZWFfm7xMD9/q5v2QS/73GE/Au7NtQaXohE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HfIBb3CRQZhCv73HEc9GgL8z0YxM2GD2gmsT73ggxUpqxUofKhQeDU5YiueFrQKVr
         9+AoVgayAMoOTY4p6ZFP33VInJrBld1LHUrKFzuOamny82llTx4oYypM3eyFDNcf6x
         lBqBAxSBn2H5Ax/HYR3Wpos8wdfxmv619DbMSrLs=
Received: by mail-wr1-f42.google.com with SMTP id g12so123070wrm.5;
        Mon, 11 Mar 2019 12:19:44 -0700 (PDT)
X-Gm-Message-State: APjAAAWDKLVECJqwlf1Upuz2I9izfTauXDhOQ5zV+9+BiI2wS9mRUNNJ
        pFf38ksTwKuU1jwtcaMoC1adMN/vdf6Q5d8pHX0=
X-Google-Smtp-Source: APXvYqx2+V4/jEQmFUX0QkndLO44Tomtx66qIM7yPtzG9gvua669Phf3uut0g1xJVooav8XP3UmZDKPu7Ty6S88lM5M=
X-Received: by 2002:a5d:5410:: with SMTP id g16mr20590084wrv.214.1552331983076;
 Mon, 11 Mar 2019 12:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-4-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 12:19:32 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrWawWy+mX5VpLeqdV85f0iEdRv6JtJbjS5pamN5xfKjA@mail.gmail.com>
Message-ID: <CAGp9LzrWawWy+mX5VpLeqdV85f0iEdRv6JtJbjS5pamN5xfKjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: Add compatible for the MediaTek
 MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Always put the patches about dt-binding changes at the head of the
series to let the related maintainer more easily find them.

On Sun, Mar 10, 2019 at 8:48 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds compatible for the MediaTek MT6358 PMIC.
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0ebd08a..62f1c17 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -17,22 +17,27 @@ Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
>  This document describes the binding for MFD device and its sub module.
>
>  Required properties:
> -compatible: "mediatek,mt6397" or "mediatek,mt6323"
> +compatible:
> +       "mediatek,mt6323" for PMIC MT6323
> +       "mediatek,mt6358" for PMIC MT6358
> +       "mediatek,mt6397" for PMIC MT6397

don't change anything not related MT6358

>
>  Optional subnodes:
>
>  - rtc
>         Required properties:
> -               - compatible: "mediatek,mt6397-rtc"
> +               - compatible: "mediatek,mt6397-rtc" or "mediatek,mt6358-rtc"
>  - regulators
>         Required properties:
>                 - compatible: "mediatek,mt6397-regulator"
>         see Documentation/devicetree/bindings/regulator/mt6397-regulator.txt
> +               - compatible: "mediatek,mt6358-regulator"
> +       see Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
>                 - compatible: "mediatek,mt6323-regulator"
>         see Documentation/devicetree/bindings/regulator/mt6323-regulator.txt
>  - codec
>         Required properties:
> -               - compatible: "mediatek,mt6397-codec"
> +               - compatible: "mediatek,mt6397-codec" or "mediatek,mt6358-sound"

why didn't we use a more consistent naming as mt6358-codec?

>  - clk
>         Required properties:
>                 - compatible: "mediatek,mt6397-clk"
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
