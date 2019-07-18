Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB4C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37C421850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563468036;
	bh=SoxBswTgqu3zk9pazxOUTdpNqF8pc1lImoZfHK7GaSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0HOLEqtrc99ssX72dG4eyy8qSKLazSRdfCriPTRrIJDywNo8IjY/cj5zmXaWU90Pc
	 Io+Fja1gVDJLHzd42Lx0mEcmXvP9cOmzri1JSC9xL/hDXEvGzk5Ad10xGlyYVvNDTA
	 bXsj2eGxP2cvkqr24WdJ+oyw3MO2240T44nyc/gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfGRQke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfGRQke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:40:34 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A607221852;
        Thu, 18 Jul 2019 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563468033;
        bh=SoxBswTgqu3zk9pazxOUTdpNqF8pc1lImoZfHK7GaSc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k53XkTAdW2L3x0HMVdmq1AIlRDuUDJ03qy50yY8JIhkN/JizWAkTqVUPrkEqRO3pj
         GQvuvKNtOmZ4vIKqWtaAV4NXQZIdbRoLQ1vVP9/wywGQlL3uLDckVk8msc59H6yUkD
         6tXmtkV4Zt/I97JMrEWrg6J8nSJVQ0dsRu40HcdQ=
Received: by mail-qk1-f170.google.com with SMTP id d15so20960381qkl.4;
        Thu, 18 Jul 2019 09:40:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXrx4kMNa4EgNmprqMycC9ZPk6ozwxARLe0XQ6i2Cctg7iL4QDh
        gPYaeoWYhqroDo+YjBQrzyu7YkqmF2kdsTjHHg==
X-Google-Smtp-Source: APXvYqzYt1/30r8Pv683cCeZXN3F53wLwdoIVf8tHruIuBQFZ/92FMoJmJnLK7FPweOEUpG5T8+Ty50dEcq1H3lbMXs=
X-Received: by 2002:a37:6944:: with SMTP id e65mr29073338qkc.119.1563468032800;
 Thu, 18 Jul 2019 09:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190718151346.3523-1-daniel.baluta@nxp.com> <20190718151346.3523-4-daniel.baluta@nxp.com>
In-Reply-To: <20190718151346.3523-4-daniel.baluta@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 18 Jul 2019 10:40:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6o9mTjLYjnfcYgfSFKb95W8FseZBBb8RLosB__GNBcw@mail.gmail.com>
Message-ID: <CAL_JsqJ6o9mTjLYjnfcYgfSFKb95W8FseZBBb8RLosB__GNBcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Add DSP core binding support
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, paul.olaru@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 9:13 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> This describes the DSP device tree node.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
>
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> new file mode 100644
> index 000000000000..d112486eda0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8 DSP core
> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: |
> +  Some boards from i.MX8 family contain a DSP core used for
> +  advanced pre- and post- audio processing.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qxp-dsp
> +
> +  reg:
> +    description: Should contain register location and length
> +
> +  clocks:
> +    items:
> +      - description: ipg clock
> +      - description: ocram clock
> +      - description: core clock
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ocram
> +      - const: core
> +
> +  power-domains:
> +    description:
> +      List of phandle and PM domain specifier as documented in
> +      Documentation/devicetree/bindings/power/power_domain.txt

How many? 4?

> +
> +  mboxes:
> +    description:
> +      List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
> +      (see mailbox/fsl,mu.txt)
> +    maxItems: 4
> +
> +  mbox-names:
> +    items:
> +      - const: txdb0
> +      - const: txdb1
> +      - const: rxdb0
> +      - const: rxdb1
> +
> +  memory-region:
> +    description:
> +       phandle to a node describing reserved memory (System RAM memory)
> +       used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - mboxes
> +  - mbox-names
> +  - memory-region
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    dsp@596e8000 {
> +        compatbile = "fsl,imx8qxp-dsp";
> +        reg = <0x596e8000 0x88000>;
> +        clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
> +                 <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
> +                 <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
> +        clock-names = "ipg", "ocram", "core";
> +        power-domains = <&pd IMX_SC_R_MU_13A>,
> +                        <&pd IMX_SC_R_MU_13B>,
> +                        <&pd IMX_SC_R_DSP>,
> +                        <&pd IMX_SC_R_DSP_RAM>;
> +        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> +        mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
> +    };
> --
> 2.17.1
>
