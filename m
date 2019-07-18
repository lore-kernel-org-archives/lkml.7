Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23056C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD042173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjNL/ouk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbfGRSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:24:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33727 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGRSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:24:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so29797335wru.0;
        Thu, 18 Jul 2019 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1MLsFyrIiqvStGeCSXekqChu7olGe+ghfPuNjb84x8=;
        b=FjNL/oukgm65Nil+7w8dcOOxwccuBKh63CXRVczAIPfM75Zl54MiGe1Z9uQiTxBUU4
         atUrfVS6UcxjtwAlHMlur0lFE7HnNutU5ra5ppuejfqjJMGZR8toKlCsBXxWTvC86DTu
         /+ysKj8yAeD0RBUY2oM/eLfV18qGmzIVqWL44Ceq0iIO+XiveK0Zo/G2R3v2+jKK5smY
         C0/zcSJHebPRYhBtSZ/UZnyrECB9ZjfRyn/ti7Tqnq22HQ/ExzOhn6W43o1GpbcEveP/
         Z3NqvfSJpAiSTw3PWJtCxXt4nP1NcQBDuV3cArPXokV5NWLdfhja69S0GurGicWD/94W
         D7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1MLsFyrIiqvStGeCSXekqChu7olGe+ghfPuNjb84x8=;
        b=WvEbNhnU8gcBpb9mhJ5OqsIf6m0GmrK3i6a+HK/6TuWuPAGbBv+VANznYafh1jiuO1
         kJywFcJierZfPyMd4SDuor81rZttLT5BuJgteZCJ07Aeh+KSyaJyV9BWrm09LUxrutIR
         eL/9UTPsuN0mNXm+IYNzQ+NSNiHBuoSUc6B7qfpSAcwUA5cK2Q5UC8V8tuwRW1A4MoEB
         JGZI87vurU6ZLqtL/eBmw8EUb/czOeJrps/tLB6QBB8oLp1y7jFu7hCtoccInE135xKP
         JjhCFzXIVaTr40yEGLTxkUHJwM1d5u5YsLZzk2y/dNRuPUk9xt6SCCorQE9djCe0pUkC
         YqRA==
X-Gm-Message-State: APjAAAVIZgZ7cxvoTwdt5xPgU2qcM7M86rEDOyJm9IyMh31MiPmwaqlQ
        I6au8DStb8rgejkquXcX1CF2DUZ74knF+R+E4aA=
X-Google-Smtp-Source: APXvYqwwcEOHikHbOz2la4SirUJmOhF3n2AoPZ7ouMvC4ShHI3jKSnpGRLPqufrOZdouzpDb7nl+mJjKrSjFA59b9tI=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr53051168wrs.93.1563474285527;
 Thu, 18 Jul 2019 11:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190718151346.3523-1-daniel.baluta@nxp.com> <20190718151346.3523-4-daniel.baluta@nxp.com>
 <CAL_JsqJ6o9mTjLYjnfcYgfSFKb95W8FseZBBb8RLosB__GNBcw@mail.gmail.com>
In-Reply-To: <CAL_JsqJ6o9mTjLYjnfcYgfSFKb95W8FseZBBb8RLosB__GNBcw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Jul 2019 21:24:34 +0300
Message-ID: <CAEnQRZBubFz90Xf8irDwc=erTXmByXX4rkzZy9r8ymfAuQEsZA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Add DSP core binding support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, paul.olaru@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 7:41 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jul 18, 2019 at 9:13 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> >
> > This describes the DSP device tree node.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > new file mode 100644
> > index 000000000000..d112486eda0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX8 DSP core
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > +
> > +description: |
> > +  Some boards from i.MX8 family contain a DSP core used for
> > +  advanced pre- and post- audio processing.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8qxp-dsp
> > +
> > +  reg:
> > +    description: Should contain register location and length
> > +
> > +  clocks:
> > +    items:
> > +      - description: ipg clock
> > +      - description: ocram clock
> > +      - description: core clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: ocram
> > +      - const: core
> > +
> > +  power-domains:
> > +    description:
> > +      List of phandle and PM domain specifier as documented in
> > +      Documentation/devicetree/bindings/power/power_domain.txt
>
> How many? 4?

Yes, 4 for i.MX8QXP. Also, the same number is for i.MX8QM. Anyhow, I didn't
added added a limit here because I really don't know how many will be
in upcoming
i.MX platforms.

>
> > +
> > +  mboxes:
> > +    description:
> > +      List of <&phandle type channel> - 2 channels for TXDB, 2 channels for RXDB
> > +      (see mailbox/fsl,mu.txt)
> > +    maxItems: 4
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: txdb0
> > +      - const: txdb1
> > +      - const: rxdb0
> > +      - const: rxdb1
> > +
> > +  memory-region:
> > +    description:
> > +       phandle to a node describing reserved memory (System RAM memory)
> > +       used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - mboxes
> > +  - mbox-names
> > +  - memory-region
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    #include <dt-bindings/clock/imx8-clock.h>
> > +    dsp@596e8000 {
> > +        compatbile = "fsl,imx8qxp-dsp";
> > +        reg = <0x596e8000 0x88000>;
> > +        clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
> > +                 <&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
> > +                 <&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
> > +        clock-names = "ipg", "ocram", "core";
> > +        power-domains = <&pd IMX_SC_R_MU_13A>,
> > +                        <&pd IMX_SC_R_MU_13B>,
> > +                        <&pd IMX_SC_R_DSP>,
> > +                        <&pd IMX_SC_R_DSP_RAM>;
> > +        mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> > +        mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
> > +    };
> > --
> > 2.17.1
> >
