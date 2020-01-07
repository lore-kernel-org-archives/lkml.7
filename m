Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA69DC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937EF206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578435671;
	bh=NkKTf9JtMWy3QWBJ1X8z0Xyh/O2MvFDSh5L3xkxXEFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jNQ1SEE+vsTMET2BfM3ZTtLLBznp1/vozKucMN0uzLxmTWdgO62/kEwwu3YiyJobe
	 R7F5bFQABRpWpx3XnDszczsXN42YeV6a/2n+WMeK4gYOPH8pQjsWSoeTrLs4+NQxTj
	 7lPhhh/iiDTMRI3DclZ+gX//Wh8FSZXxMtkf8E2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgAGWVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:21:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgAGWVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:21:10 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFC52077B;
        Tue,  7 Jan 2020 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578435668;
        bh=NkKTf9JtMWy3QWBJ1X8z0Xyh/O2MvFDSh5L3xkxXEFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=du3SlLusQi5E6+0/ummXqIs96p4I75CtDzKtnmeoTLT0WkCfttIcAvBM72tluulHn
         cZDu0WfQuioUuBZnTmtGTTjczaIe3CaXULwGxi8Sz4cdFzoyF78aNpfGXb0g6egY1t
         mS5+2+pbW/Ts4YPW9NA4j4IvYeeGhV/2YFQRyVJE=
Received: by mail-qk1-f170.google.com with SMTP id k6so930129qki.5;
        Tue, 07 Jan 2020 14:21:08 -0800 (PST)
X-Gm-Message-State: APjAAAVJS+jNVkIfW1e5B6nMZ8gnHVuFq6lC+XBE+RXupIhBHabui3HN
        EMhm95pDynVSsEKv4SOYvL7V2tKiMagonq11Fw==
X-Google-Smtp-Source: APXvYqxaeVkPuYsl3xVEY7yZlxgOA/L3HpU+5g5utASwlUWkzj0ouG5Hvzh6bHZNzhtY1FLiuQwmORZs9a76vab4yn8=
X-Received: by 2002:a37:a70b:: with SMTP id q11mr1500663qke.393.1578435667832;
 Tue, 07 Jan 2020 14:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20191220065314.237624-1-lkundrak@v3.sk> <20191220065314.237624-4-lkundrak@v3.sk>
In-Reply-To: <20191220065314.237624-4-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Jan 2020 16:20:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LduJhf_LawZ+Ofu-70J3c1L3NuqAw3_jzYpC0Gy3x0A@mail.gmail.com>
Message-ID: <CAL_Jsq+LduJhf_LawZ+Ofu-70J3c1L3NuqAw3_jzYpC0Gy3x0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: phy: Add binding for marvell,mmp3-hsic-phy
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 1:01 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> This is the PHY chip for USB HSIC on MMP3 platform.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../bindings/phy/marvell,mmp3-hsic-phy.yaml   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml

Seems this is already in -next, but it breaks dt_binding_check.

>
> diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
> new file mode 100644
> index 0000000000000..7917a95cda78d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright 2019 Lubomir Rintel <lkundrak@v3.sk>
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/marvell,mmp3-hsic-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Marvell MMP3 HSIC PHY
> +
> +maintainers:
> +  - Lubomir Rintel <lkundrak@v3.sk>
> +
> +properties:
> +  compatible:
> +    const: marvell,mmp3-hsic-phy
> +
> +  reg:
> +    maxItems: 1
> +    description: base address of the device

Drop description. That's *every* 'reg' property.

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to reset
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    hsic-phy@f0001800 {
> +            compatible = "marvell,mmp3-hsic-phy";
> +            reg = <0xf0001800 0x40>;
> +            reset-gpios = <&gpio 63 GPIO_ACTIVE_HIGH>;

Examples are built now and this one doesn't. You need the include for
the define. Check with 'make dt_binding_check'.

> +            #phy-cells = <0>;
> +    };
> --
> 2.24.1
>
