Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CC3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5AF208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561578898;
	bh=KcD7c6hKQWEu008qT9k7dg3vhdqwpsDp6Y4IxD3yQtY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eBSD0SALubvr98yFVjxhral75Rdgv7qlD/ncX6ckU3fKaR58URVE9YrjWx8U16R97
	 /3XjHPYPouHH4B4STkIcUOQrS2CDtGyYhmCCl/DwvvNzbXuFDwgRRbm9iA9yT9Ki3T
	 MTaoBfvpfLQS7FXTE499ZaGLaQqdsSSF7vnKai4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZTy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZTy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:54:56 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ADD521743;
        Wed, 26 Jun 2019 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561578894;
        bh=KcD7c6hKQWEu008qT9k7dg3vhdqwpsDp6Y4IxD3yQtY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bmq634H6AuhkvTnl8ByQlWQL/et5bCg6GiQTU5Wxxehw+bAuRb3PkWlvdgnru+wCQ
         2PQRhYhjDO3qBaziCHuszbI+M2cOK/wL4p1Xc9eMDvtykqpH0hKsutQSyEzWLPlWnY
         zufBuEQ9BqcgM/yNiD7c1mDEb0uCBK/Gy4rSXdO8=
Received: by mail-qt1-f182.google.com with SMTP id h21so3743858qtn.13;
        Wed, 26 Jun 2019 12:54:54 -0700 (PDT)
X-Gm-Message-State: APjAAAWEmaXPrBAYkBIDnLXJx61Xg27o2oO0me0vBE9W0HCQej/v9t23
        79fp8GIN90OO9Hcy0SGCXEyL5/iz+V/u0wjvog==
X-Google-Smtp-Source: APXvYqxvjkkMKsEsiee5jdC+mhyswCFA/6copmi5BDxMTfkflXbixreHTXK1d+tXLtOdZg6I42aAKOCcCo2xPI+9SV4=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr4102705qvf.200.1561578893478;
 Wed, 26 Jun 2019 12:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-3-daniel.baluta@nxp.com>
 <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com> <CAEnQRZBNA4ndSL1vMStHemYkzt9TxqjgdWWjqFwnBFQ+ha+egA@mail.gmail.com>
In-Reply-To: <CAEnQRZBNA4ndSL1vMStHemYkzt9TxqjgdWWjqFwnBFQ+ha+egA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 13:54:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQRbuWKgON+ukZ3GRwyq8SvTZ=PRGwMhQjAxKPSP-Fkw@mail.gmail.com>
Message-ID: <CAL_JsqJQRbuWKgON+ukZ3GRwyq8SvTZ=PRGwMhQjAxKPSP-Fkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add DSP IPC binding support
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 8:49 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> Hi Rob,
>
> This is my first time documenting the bindings using the
> new yaml format so thanks for your patience and explanations!
>
> On Fri, Jun 14, 2019 at 5:53 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Fri, Jun 14, 2019 at 2:15 AM <daniel.baluta@nxp.com> wrote:
> > >
> > > From: Daniel Baluta <daniel.baluta@nxp.com>
> > >
> > > DSP IPC is the layer that allows the Host CPU to communicate
> > > with DSP firmware.
> > > DSP is part of some i.MX8 boards (e.g i.MX8QM, i.MX8QXP)
> > >
> > > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > ---
> > >  .../bindings/arm/freescale/fsl,dsp.yaml       | 43 +++++++++++++++++++
> >
> > bindings/dsp/...
>
> Fair enough. Will fix in v2.
>
> >
> > >  1 file changed, 43 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> > > new file mode 100644
> > > index 000000000000..16d9df1d397b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> > > @@ -0,0 +1,43 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > The preference is to dual license new bindings: GPL-2.0 OR BSD-2-Clause
> >
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NXP i.MX IPC DSP driver
> >
> > This isn't a driver.
>
> I see. This node is actually the representation of DSP IPC so not a driver.
> >
> > > +
> > > +maintainers:
> > > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > > +
> > > +description: |
> > > +  IPC communication layer between Host CPU and DSP on NXP i.MX8 platforms
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx-dsp
> >
> > You can have a fallback, but it needs SoC specific compatible(s).
> Agree. Will fix in v2.
>
> >
> > > +
> > > +  mboxes:
> > > +    description:
> > > +      List of phandle of 2 MU channels for TXDB, 2 MU channels for RXDB
> > > +      (see mailbox/fsl,mu.txt)
> > > +    maxItems: 1
> >
> > Should be 4?
>
> Actually is just a list with 1 item. I think is the terminology:
>
> You can have an example here of the mboxes defined for SCU.
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8qxp.dtsi#L123

mboxes = <&lsio_mu1 0 0
&lsio_mu1 0 1
&lsio_mu1 0 2
&lsio_mu1 0 3
&lsio_mu1 1 0
&lsio_mu1 1 1
&lsio_mu1 1 2
&lsio_mu1 1 3
&lsio_mu1 3 3>;

Logically, this is 9 entries and each entry is 3 cells ( or phandle
plus 2 cells). More below...

> > > +
> > > +  mbox-names

Also, missing a ':' here. This won't build. Make sure you build this
(make dt_binding_check). See
Documentation/devicetree/writing-schemas.md.

> > > +    description:
> > > +      Mailboxes names
> > > +    allOf:
> > > +      - $ref: "/schemas/types.yaml#/definitions/string"
> >
> > No need for this, '*-names' already has a defined type.
> So, should I remove the above two lines ?

Actually, all 4. There's no need to describe what 'mbox-names' is.

> > > +      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]
> >
> > Should be an 'items' list with 4 entries?
>
> Let me better read the yaml spec. But "items" list indeed sounds better.

What you should end up with is:

items:
  - const: txdb0
  - const: txdb1
  - const: rxdb0
  - const: rxdb1

This is saying you have 4 strings in the listed order. The enum you
had would be a single string of one of the 4 values.

> > > +required:
> > > +  - compatible
> > > +  - mboxes
> > > +  - mbox-names
> >
> > This seems incomplete. How does one boot the DSP? Load firmware? No
> > resources that Linux has to manage. Shared memory?
>
> This is only the IPC mailboxes used by DSP to communicate with Linux. The
> loading of the firmware, the resources needed to be managed by Linux, etc
> are part of the DSP node.

You should just add the mailboxes to the DSP node then. I suppose you
didn't because you want 2 drivers? If so, that's the OS's problem and
not part of DT. A Linux driver can instantiate devices for other
drivers.

> To avoid confusion I have renamed this node from dsp to dsp_ipc.
>
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    dsp {
> > > +      compatbile = "fsl,imx-dsp";
> > > +      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> > > +      mboxes = <&lsio_mu13 2 0 &lsio_mu13 2 1 &lsio_mu13 3 0 &lsio_mu13 3 1>;
> >
> > mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
>
> Actually no! It looks like the imx mailbox expects one element with a
> list of phandles directions and index.

There's not actually any difference in what the OS sees. Both source
syntaxes result in the same data encoding in the dtb. It's simply 12
words of data. What's a phandle is only known because the OS knows
what 'mboxes' contains and by reading #mbox-cells in lsio_mu13.

However, we are using this source grouping to maintain type
information to do schema validation. The grouping is kept thru to the
yaml encoding (of the DT, not to be confused with the schemas). So
we're going to have to start being stricter in dts files.

Rob
