Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA5C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC961206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578279646;
	bh=8YANkl89iwxe3dndcojVuSNVMnw/MSIeyN/ppnKf2jk=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=arpoLc4HmYiE5b0PGbBrwIawPX6Xezy80S9wOZUdyRVbEyKEn21mWFspQcepakrEn
	 X8o5x9v+IJU0A0LmcRF+zpDTmrFYPWyKtki0Vb1nXi9JTC1fmMe9gjPI3zJ/YwOlla
	 YE3ctUP5u3S9QgwolIBo2pxH2Fj42C5q7R8Ob+vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAFDAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:00:43 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 774D8206F0;
        Mon,  6 Jan 2020 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578279642;
        bh=8YANkl89iwxe3dndcojVuSNVMnw/MSIeyN/ppnKf2jk=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=oJZCOjtCELktDjSt6kYgGQPI3DEltjOBAg1lnsZdVUGN1I/FOOROK4fxBkX8dQx4j
         VkdfHRuvyP/HcLc+meedc2mcaYGW34OKvRwOpQlf+Efkl1CB6ZQrEgNCiSBXWwVfYJ
         Mr8dQBOTBJZZhTPijB9n4s5PDzg0Xz5VH68ONw9U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1577412748-28213-1-git-send-email-Anson.Huang@nxp.com>
References: <1577412748-28213-1-git-send-email-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
        mark.rutland@arm.com, maxime@cerno.tech, mturquette@baylibre.com,
        olof@lixom.net, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, will@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: imx: Add clock binding doc for i.MX8MP
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:00:41 -0800
Message-Id: <20200106030042.774D8206F0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-12-26 18:12:26)
> diff --git a/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml b/=
Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
> new file mode 100644
> index 0000000..5e01995
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/imx8mp-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Plus Clock Control Module Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +description: |
> +  NXP i.MX8M Plus clock control module is an integrated clock controller=
, which
> +  generates and supplies to all modules.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8mp-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: 32k osc
> +      - description: 24m osc
> +      - description: ext1 clock input
> +      - description: ext2 clock input
> +      - description: ext3 clock input
> +      - description: ext4 clock input
> +
> +  clock-names:
> +    items:
> +      - const: osc_32k
> +      - const: osc_24m
> +      - const: clk_ext1
> +      - const: clk_ext2
> +      - const: clk_ext3
> +      - const: clk_ext4
> +
> +  '#clock-cells':
> +    const: 1
> +    description: |

I think we can drop the bar here. Newlines shouldn't matter.

> +      The clock consumer should specify the desired clock by having the =
clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx=
8mp-clock.h
> +      for the full list of i.MX8M Plus clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    clk: clock-controller@30380000 {
> +        compatible =3D "fsl,imx8mp-ccm";
> +        reg =3D <0x30380000 0x10000>;
> +        #clock-cells =3D <1>;
> +        clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>,
> +                 <&clk_ext2>, <&clk_ext3>, <&clk_ext4>;
> +        clock-names =3D "osc_32k", "osc_24m", "clk_ext1",
> +                      "clk_ext2", "clk_ext3", "clk_ext4";
> +    };
> +
> +  # Required external clocks for Clock Control Module node:
> +  - |
> +    osc_32k: clock-osc-32k {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <32768>;
> +        clock-output-names =3D "osc_32k";
> +    };

Do we need these in the example? They don't seem too useful.

> +
> +    osc_24m: clock-osc-24m {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <24000000>;
> +        clock-output-names =3D "osc_24m";
> +    };
> +
> +    clk_ext1: clock-ext1 {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <133000000>;
