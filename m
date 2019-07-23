Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31705C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5922387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563921152;
	bh=KRGyoog8m5Y5cpAsI7fSu8XujIiwfwHpdopSDKGv8lI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gN/GCzzAojq/Xnio52ePw4D244RTmxafyGNPUeAy/KoXN3loy1Or8O3q+4Pnayf+v
	 oavZFb2kVleNfannYnx2mfR+qoApdghax0PVgSyJ5ze+N/2ENi4FAwTs2JDwHGhoe/
	 3StUyfs8gO/7QasXVXMTwztIyxPzlhA0T5Dd56tU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392524AbfGWWca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfGWWca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:32:30 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01526229F5;
        Tue, 23 Jul 2019 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563921149;
        bh=KRGyoog8m5Y5cpAsI7fSu8XujIiwfwHpdopSDKGv8lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DjBjihMrAblKU2YRuoTftYTHNzv1uEcbWnmbdLP12bpNuAEunBCRPBMBaUk+oi7ej
         nDCr0BYMWeFCRtffKUbuAMfeMGDqP8lzVm5GDzL5VTlOsT0zriKNPgbH+y6Cj5jw5c
         sncv/xIfPhuf3MM07b+Dm0aKaHn8tld3jGI2M7BQ=
Received: by mail-qt1-f176.google.com with SMTP id 44so12509250qtg.11;
        Tue, 23 Jul 2019 15:32:28 -0700 (PDT)
X-Gm-Message-State: APjAAAU6lkmPZQJF54nXx1ZEqQNbTDklbNg/+Tm9DhtqZkN25CKiMOPH
        Hwc9a7P5lySbkgvduL3ZkDBwEQyO7MYhiqUJ7Q==
X-Google-Smtp-Source: APXvYqwfoClSOrKbu6CT9RTzisAhHFe5/alrfNoWmvSRZ0JhTVbIQjdWY8lSXYWQs5CGy8HyiUVSlShpxw7B4w0OWGk=
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr55862838qtc.300.1563921148138;
 Tue, 23 Jul 2019 15:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190723084104.12639-1-daniel.baluta@nxp.com> <20190723084104.12639-6-daniel.baluta@nxp.com>
In-Reply-To: <20190723084104.12639-6-daniel.baluta@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Jul 2019 16:32:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ0A8MikmZb0KZd5r72J2o73GJ_E0o4CzW_=OVu2OcPKA@mail.gmail.com>
Message-ID: <CAL_JsqJ0A8MikmZb0KZd5r72J2o73GJ_E0o4CzW_=OVu2OcPKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: dsp: fsl: Add DSP core binding support
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, paul.olaru@nxp.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 2:41 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
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

This needs updating to match the path.

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
> +    maxItems: 4

Need a blank line here.

With those 2 fixes:

Reviewed-by: Rob Herring <robh@kernel.org>

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
