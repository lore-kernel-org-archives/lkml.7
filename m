Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454AEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1EF20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oTNWEoWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEGFZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:25:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36990 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:25:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so5679388qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 22:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hFqmwNLrgOZ2d4LHKnw2c1GsxJZR0XMM1CJizfkss0=;
        b=oTNWEoWULY5My61dxjSyob+ke4AB8mRsMSGQA39QxxGStJqKwc6brL3ScY9Pf6MlNV
         cHlwWL4HZ2LL18qYr53Bt8gCq0vAEVs49chuSjny1Td+/Havv9W25UPJAwR7YrDl8KVP
         gd5O+H3z2FdeEtB4nJ1685Y+V8/0Vt3jWOwxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hFqmwNLrgOZ2d4LHKnw2c1GsxJZR0XMM1CJizfkss0=;
        b=oqEcTq7/KU4XMr5J6DMqRLe2tm5s8KhBNuGHU+YsJN5uWq9l/ypq1JyBIJs8idLS1d
         OxQLpKs8bGCyKIawLCynRrqHdJv9mFoQoFXWC6aiOekXqzq0NKWU8t7NAXfeGLSQ5/ZP
         mG4IVHgjTjiSIUZG8tvtHEahZkUqUruGtc4AUjmqPg9Q3d22k5T4Z+EXhDi30tpMDyz7
         B3XEnSZr+lhyPGfYidQZGgd6aHZeo5MLRACqi8GFj0LqKv3HIraczvEJn4079+9u74GJ
         mkSzP8kuOWpFIcodzbFrRXm6Cq0OZt+uZgyycLp9obhyOmoOGQvfWSaty2iWzx4k7otI
         Txpw==
X-Gm-Message-State: APjAAAVRaOBJLwvrSEPJFUuXfuC/Uxlqt6WCBYFcI37NJmPfBluNKJo/
        ord2Djw9jP2CxeF94K/5CRNxwPNmT6kiPxokIW7Xhg==
X-Google-Smtp-Source: APXvYqw2tJU/Bf+A/JCr79IIzV4N6cX86Z0Gi/0NwYK3aYJCyNc6+UuOalKy+yiSTLrBH1vrjl87uP7dCzAESuSwzsc=
X-Received: by 2002:ac8:1ae2:: with SMTP id h31mr7545363qtk.75.1557206702363;
 Mon, 06 May 2019 22:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190503093117.54830-1-hsin-hsiung.wang@mediatek.com> <20190503093117.54830-5-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <20190503093117.54830-5-hsin-hsiung.wang@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 7 May 2019 14:24:51 +0900
Message-ID: <CANMq1KCiK69kXkpagccqd1=pKOs7qOOVuJUaCe5JfoGVmPt7mg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: mfd: Add compatible for the
 MediaTek MT6358 PMIC
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 6:34 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> This adds compatible for the MediaTek MT6358 PMIC.
>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 0ebd08af777d..62f1c17c7738 100644
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

Sean had a question about this
(https://patchwork.kernel.org/patch/10846669/#22524299):
"why didn't we use a more consistent naming as mt6358-codec?"

>  - clk
>         Required properties:
>                 - compatible: "mediatek,mt6397-clk"
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
