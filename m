Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA3C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362562070B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyXABD20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLUPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 10:07:12 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37587 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfLUPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 10:07:12 -0500
Received: by mail-il1-f194.google.com with SMTP id t8so10572953iln.4;
        Sat, 21 Dec 2019 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkyVqaGL8pSvqNm/GP/crRw2qKqaYhVFS2IL3esjjss=;
        b=YyXABD20DXHsGL/j/uU2X9GW2vWtYA4/REvABc1SKH1P+gDQRaUgyfvrN7RNZLFcCr
         FE3Ac/vjCvKi0GIE4tdWnfyEliulLr1lEucydp2qpyI7uSmil51FTU+YufrF/ol7cPYy
         3jz+O/ZDGl2N1kwK12gqNbDo3O8rHDRgtO5Fe0DrbWNwIkgPjcy/2MowkPNut2ycdeuL
         eqmZrYwjta8g6lG0nudReRNfMSQDnkAFG2qpH0rAbJh0rZcE6EcqVg6K1jJMoiAj3aN8
         a8vlolsXPlaKOLYXNXOiYc3ufw2b1w12tDjhlMw09kGop1Ok33ZFy8Afo/1KDncRMmMH
         bLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkyVqaGL8pSvqNm/GP/crRw2qKqaYhVFS2IL3esjjss=;
        b=fA3CYqN1NIuqfdvBWro1nTcZ9r8YB1nRuBk9kXfgp2aL/2Rx0Q9Yzn+yWmtzNgfa+a
         YOKBOSWAnytiJEZERbK5ABD2rfRoDuEjpcIIp/J+HlOmeGk/kECEg0Glq1Q5NMQav64b
         WQD9UcpmnLNv1E0IwkMxWpRb5SGFKh2/QTYqoUDNBGuojeUC5rx38xhZF8OrNgnn3YKZ
         aYn6ktQU7ZbwSwrywmYInqomIOeAbhvJmPeB4rbYZsMFS5iRK0Zc2uN9Sg/5MtJ1Bg60
         XEfh5B6kdxto/s1AwHuIenu2szPXolbIEe3eZk0wB8t7mrk+BoJHr141lVpt4tqACFjH
         teBg==
X-Gm-Message-State: APjAAAX+mz2k7vEas0QFGuLPdJaChRwlTAlJSeYxaslVxU+qEcaUnAqy
        XTvO/KwI6virHS24X5VZEewqvY8VMHRBhkfLqQ3pPA==
X-Google-Smtp-Source: APXvYqwvQf5cIvO4uRO1C7m1YDUP8Y4ctwyyWjl1EAYmu/rnU1BO5cqKngYGLE5EGBXHkD57AG4IlXjPHwoNstd3jeY=
X-Received: by 2002:a92:1547:: with SMTP id v68mr16711743ilk.58.1576940831051;
 Sat, 21 Dec 2019 07:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20191213160542.15757-1-aford173@gmail.com>
In-Reply-To: <20191213160542.15757-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 21 Dec 2019 09:06:58 -0600
Message-ID: <CAHCN7xKuVCGqgRpixa9UPkWq92Gg=dm4XxAczBKAZCoMzcBVJg@mail.gmail.com>
Subject: Re: [PATCH V2 0/7] soc: imx: Enable additional functionality of
 i.MX8M Mini
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:05 AM Adam Ford <aford173@gmail.com> wrote:
>
> The GPCv2 controller on the i.MX8M Mini is compatible with the driver
> used for the i.MX8MQ except for the register locations and names.
> The GPCv2 controller is used to enable additional periperals currently
> unavailable on the i.MX8M Mini.  In order to make them function,
> the GPCv2 needs to be adapted so the drivers can associate their
> power domain to the GPCv2 to enable them.
>
> This series makes one include file slightly more generic,
> adds the iMX8M Mini entries, updates the bindings, adds them
> to the device tree, then associates the new power domain to
> both the OTG and PCIe controllers.
>
> Some peripherals may need additional power domain drivers in the future
> due to limitations of the GPC driver, but the drivers for VPU and others are
> not available yet.

Before I do a V3 to address Rob's comments, I am thinking I'll drop
the items on the GPC that Jacky suggested would not work, and we don't
have drivers for those other peripherals (GPU, VPU, etc.) anyway.  My
main goal here was to try and get the USB OTG ports working, so I'd
like to enabled enough of the items on the GPC that are similar to the
i.MX8MQ and leave the more challenging items until we have either a
better driver available and/or actual peripheral support coming.  I
haven't seen LCDIF or DSI drivers pushed upstream yet, so I doubt
we'll see GPU or VPU yet until those are done.

Does anyone from the NXP team have any other comments/concerns?

adam
>
> Adam Ford (7):
>   soc: imx: gpcv2: Rename imx8mq-power.h to imx8m-power.h
>   soc: imx: gpcv2: Update imx8m-power.h to include iMX8M Mini
>   soc: imx: gpcv2: add support for i.MX8M Mini SoC
>   dt-bindings: imx-gpcv2: Update bindings to support i.MX8M Mini
>   arm64: dts: imx8mm: add GPC power domains
>   ARM64: dts: imx8mm: Fix clocks and power domain for USB OTG
>   arm64: dts: imx8mm: Add PCIe support
>
>  .../bindings/power/fsl,imx-gpcv2.txt          |   6 +-
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 127 ++++++++-
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   2 +-
>  drivers/soc/imx/gpcv2.c                       | 246 +++++++++++++++++-
>  .../power/{imx8mq-power.h => imx8m-power.h}   |  14 +
>  5 files changed, 387 insertions(+), 8 deletions(-)
>  rename include/dt-bindings/power/{imx8mq-power.h => imx8m-power.h} (57%)
>
> --
> 2.20.1
>
