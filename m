Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C166AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9138D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560523987;
	bh=xXLXuR+L8hhQa1ErD+u0rcoh9h0mBsxWabprP9kW9MI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EWAdZjxmGzCerv/pkzuXShgJL7GPfGLv9eLwiDCuT04UBvP+PryRZlDwfJYIKQPv7
	 iftMhJdyhTdJ5wOriAgnMhByr10RlbGTzgs08YUUaRN/fDxXgTPj3vaj+dpEHuLdbM
	 iDxsgojpeSg8yGkFbJYXl+97snwqtpcNyaB21y2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfFNOxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfFNOxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:53:06 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35872173C;
        Fri, 14 Jun 2019 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560523985;
        bh=xXLXuR+L8hhQa1ErD+u0rcoh9h0mBsxWabprP9kW9MI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wk/1a4shWxNb0N1kY/k/UaqXtQEShtWb2wrMVi6jUYzhWtd/6z8tKQrLCEehTBjkV
         R2+kOEa/LD4aQEKDgGDxy2BNF5fk8xXRdVl7rjbHpb6Iy8bSon9qs9Rvs7em8b86ro
         WWbH3PUw3t8OP6hKhg8PNzM0SLcRKPAcSRepSB6E=
Received: by mail-qk1-f173.google.com with SMTP id s22so1807517qkj.12;
        Fri, 14 Jun 2019 07:53:04 -0700 (PDT)
X-Gm-Message-State: APjAAAUHuY/WPABBbVO8I889v6MQt93RYcq4+x9bfNvEbhI7aZuUtWKC
        Ch8VopGzF/kHt4YjCHyEhVBL2HG0LrZZRQq11g==
X-Google-Smtp-Source: APXvYqzCzbjmjEqoh/p0P1ONf9SWsDRWOXpqAjANf0PIAA9ZEPQPgEKQ4Fa+P/aQgf5tr5TAK/wuQsBfgtzZ/HtFS+4=
X-Received: by 2002:a05:620a:13d1:: with SMTP id g17mr21296388qkl.121.1560523984156;
 Fri, 14 Jun 2019 07:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-3-daniel.baluta@nxp.com>
In-Reply-To: <20190614081650.11880-3-daniel.baluta@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 14 Jun 2019 08:52:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
Message-ID: <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add DSP IPC binding support
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:15 AM <daniel.baluta@nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> DSP IPC is the layer that allows the Host CPU to communicate
> with DSP firmware.
> DSP is part of some i.MX8 boards (e.g i.MX8QM, i.MX8QXP)
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,dsp.yaml       | 43 +++++++++++++++++++

bindings/dsp/...

>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> new file mode 100644
> index 000000000000..16d9df1d397b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,dsp.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0

The preference is to dual license new bindings: GPL-2.0 OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/freescale/fsl,dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX IPC DSP driver

This isn't a driver.

> +
> +maintainers:
> +  - Daniel Baluta <daniel.baluta@nxp.com>
> +
> +description: |
> +  IPC communication layer between Host CPU and DSP on NXP i.MX8 platforms
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-dsp

You can have a fallback, but it needs SoC specific compatible(s).

> +
> +  mboxes:
> +    description:
> +      List of phandle of 2 MU channels for TXDB, 2 MU channels for RXDB
> +      (see mailbox/fsl,mu.txt)
> +    maxItems: 1

Should be 4?

> +
> +  mbox-names
> +    description:
> +      Mailboxes names
> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/string"

No need for this, '*-names' already has a defined type.

> +      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]

Should be an 'items' list with 4 entries?

> +required:
> +  - compatible
> +  - mboxes
> +  - mbox-names

This seems incomplete. How does one boot the DSP? Load firmware? No
resources that Linux has to manage. Shared memory?

> +
> +examples:
> +  - |
> +    dsp {
> +      compatbile = "fsl,imx-dsp";
> +      mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> +      mboxes = <&lsio_mu13 2 0 &lsio_mu13 2 1 &lsio_mu13 3 0 &lsio_mu13 3 1>;

mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;

> +    };
> --
> 2.17.1
>
