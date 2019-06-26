Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB8DC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5875A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvLQhbNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfFZOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:49:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55623 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:49:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so2408003wmj.5;
        Wed, 26 Jun 2019 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECyt5vpAqWKFoSesBXtQvTFCZ7b8NPpG6514f3+peBM=;
        b=bvLQhbNxtQl2dD5Zacz1NqKOVgyIMvJxzsmO+2Riu4LERygWj6oSSB8dCTnlQRzHBJ
         WBcMIUnVXHzRJq2PnULFDQEFau/8R+M6cBXdjbooJor1DbcFp1O8fWIkcZ1i53zf0IA5
         5oz8pE70hgB30UagR+kfeZ38bPeUYsebU5aRY0ZeeiThmo068Pemx1OgojGZ1CiE+1js
         55uJGDTtgOnsyOiEV5lcLBQOwVxfxVzaPBYRHGynEOdSWJCBC4rnsxa7VlSbB2g0sed8
         tXxh29kQ2ud6ODQQqHFPs8Mko1IwBjKs4tAlDVR64YxnpV4eEubO4KnwE4xqOZYGSPQe
         fzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECyt5vpAqWKFoSesBXtQvTFCZ7b8NPpG6514f3+peBM=;
        b=JIhajcV8Tg9WLi9kzFY0C4UL0vzWy2aL1680Sjgn+LO3KJelBqvTIt8dG8bGpQB/vr
         Q8vbnIw80gCuxytqEX3NUPumdhT0VdTjscIAyh+SG4tz7+qgccN9qty6ZAC8yxNZ2Q7p
         4lYOLh8WgMaa6l9ad3N4pJFDwQO1ypmAJqubZdRANB0w6IISyswFdnBDhcjtiVB2oePQ
         N64ywgg+iotvijiq2Rs963AqrYQsksMDE9kryjH9417OxZSMaRiNmH52+YYzxBNlTm3t
         JqPJbuBXifuZlWMWKOOrxBkTkwujRmGCn5dCwCoAGK7UPi2oX/DOynMUwKIZFvVxRRu2
         gGSQ==
X-Gm-Message-State: APjAAAVSg2gquQzXXIkQjnBNkU+dS5Lh/diCnIkIHoCbppkFihxeytax
        WvaPG6su3DbimOzvndpj1IgDlVsed+YbXnbn2plMDta1Peo=
X-Google-Smtp-Source: APXvYqyCRXdn4IYc4ZYT5kM3lXrCHCJZRWeMSW9Bhp2BTjll4zCHUsAMqPLDD0OJHXb4eGcs5CaX9g+D0C41Y3+WNjg=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr2957974wmc.25.1561560572892;
 Wed, 26 Jun 2019 07:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-3-daniel.baluta@nxp.com>
 <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
In-Reply-To: <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 26 Jun 2019 17:49:21 +0300
Message-ID: <CAEnQRZBNA4ndSL1vMStHemYkzt9TxqjgdWWjqFwnBFQ+ha+egA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add DSP IPC binding support
To:     Rob Herring <robh+dt@kernel.org>
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

Hi Rob,

This is my first time documenting the bindings using the
new yaml format so thanks for your patience and explanations!

On Fri, Jun 14, 2019 at 5:53 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jun 14, 2019 at 2:15 AM <daniel.baluta@nxp.com> wrote:
> >
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > DSP IPC is the layer that allows the Host CPU to communicate
> > with DSP firmware.
> > DSP is part of some i.MX8 boards (e.g i.MX8QM, i.MX8QXP)
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  .../bindings/arm/freescale/fsl,dsp.yaml       | 43 +++++++++++++++++++
>
> bindings/dsp/...

Fair enough. Will fix in v2.

>
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> > new file mode 100644
> > index 000000000000..16d9df1d397b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: GPL-2.0
>
> The preference is to dual license new bindings: GPL-2.0 OR BSD-2-Clause
>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX IPC DSP driver
>
> This isn't a driver.

I see. This node is actually the representation of DSP IPC so not a driver.
>
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > +
> > +description: |
> > +  IPC communication layer between Host CPU and DSP on NXP i.MX8 platforms
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-dsp
>
> You can have a fallback, but it needs SoC specific compatible(s).
Agree. Will fix in v2.

>
> > +
> > +  mboxes:
> > +    description:
> > +      List of phandle of 2 MU channels for TXDB, 2 MU channels for RXDB
> > +      (see mailbox/fsl,mu.txt)
> > +    maxItems: 1
>
> Should be 4?

Actually is just a list with 1 item. I think is the terminology:

You can have an example here of the mboxes defined for SCU.
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8qxp.dtsi#L123


>
> > +
> > +  mbox-names
> > +    description:
> > +      Mailboxes names
> > +    allOf:
> > +      - $ref: "/schemas/types.yaml#/definitions/string"
>
> No need for this, '*-names' already has a defined type.
So, should I remove the above two lines ?
>
> > +      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]
>
> Should be an 'items' list with 4 entries?

Let me better read the yaml spec. But "items" list indeed sounds better.

>
> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - mbox-names
>
> This seems incomplete. How does one boot the DSP? Load firmware? No
> resources that Linux has to manage. Shared memory?

This is only the IPC mailboxes used by DSP to communicate with Linux. The
loading of the firmware, the resources needed to be managed by Linux, etc
are part of the DSP node.

To avoid confusion I have renamed this node from dsp to dsp_ipc.

>
> > +
> > +examples:
> > +  - |
> > +    dsp {
> > +      compatbile = "fsl,imx-dsp";
> > +      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> > +      mboxes = <&lsio_mu13 2 0 &lsio_mu13 2 1 &lsio_mu13 3 0 &lsio_mu13 3 1>;
>
> mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;

Actually no! It looks like the imx mailbox expects one element with a
list of phandles directions and index.

See again, how SCU uses the mailbox node.

https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/freescale/imx8qxp.dtsi#L123

>
> > +    };
> > --
> > 2.17.1
> >
