Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E84C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A1420659
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8xa0PBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfGTPKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:10:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40002 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfGTPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:10:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so33439665lji.7;
        Sat, 20 Jul 2019 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/7F1h731rG/x69E6APl09eLqjBzw1oq0m56KVTtYAE=;
        b=q8xa0PBUE3+La1glLJhHb/PNioRTIcZGbLAsAZLOYPwms0tK2P7fl/103CgCnIYNZh
         LmtkV4Q58qViOfLju0o3tu3PNMbiYPh5uCt+CcnZ/cjSZT4OBZ3ac6Frfr7JkkP58uQ0
         BGk6HpjOt81M6xtg5Z1jrftH+HQiuyLiMQ6TxgmxM9C4/dxwISz1CwyVxzX9K81g6lq2
         Crdl9bq8kHBxQoa4iUnSDEaWGuPBjic8orDzehvAlpt3fbLnm31ZhXaGyJwb1HATMx2P
         bpP5AHNpo8uBs2UuBA7W14NHirzCUk+PCUXHFipR2U+/A0rrC6xoMOyuzDI2Wxuom3AC
         BeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/7F1h731rG/x69E6APl09eLqjBzw1oq0m56KVTtYAE=;
        b=GZrmM7an4wdEer0WIVDmMnVzEyaBNi64o2qWssouVZXhk0M7FrvDU0Oq800SgQGXKA
         VxOFEHoQ56MpbigrKeHzZ031LwDUkm9YMKaT3ef+zpvVBmYTK6+HEspNCb9N/JLmpDMf
         pR+9/GWu3NBseVUl0waPRkHgcNpXx648ml9wbCIOLVq4Xr1N2GHsH9lQE4XmihMRdC25
         8y6UE5iUZM6mG1aUsmQUR//U0gNQh6XU48440PkpHDTUGAtPXK6MsS/Dw1MxTujmP3pv
         rcYj6rlOrC0CnyGEr0ZJPRZNrdupCj6vzQHmUgU3a+Q0uj9ZU+zzFROSunxIvbZ6jRZQ
         AVHw==
X-Gm-Message-State: APjAAAWuRBs+5cyerKDttjxPG67tN7xJw5G6lA1xKhmliYfdF1cdRdq4
        oybDhBcmlYU3JXbbilqjOtiAbs7St4Jkqei9WjA=
X-Google-Smtp-Source: APXvYqyYG4v45qqvBkCwlBj9rZwtEIrpLdtk2DT4/lHLxQoF9qrHutZIWi2Ws9aeHEu2lrBtoq76gRJVuQqDRa024A4=
X-Received: by 2002:a2e:8650:: with SMTP id i16mr30702604ljj.178.1563635399310;
 Sat, 20 Jul 2019 08:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190719121430.9318-1-andradanciu1997@gmail.com> <20190719121430.9318-2-andradanciu1997@gmail.com>
In-Reply-To: <20190719121430.9318-2-andradanciu1997@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 20 Jul 2019 12:09:51 -0300
Message-ID: <CAOMZO5CAsTxEegEkBQ1uVaVD52WyLO7tV-GDSzYDDuEVpP6pmg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     andradanciu1997 <andradanciu1997@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, pankaj.bansal@nxp.com,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Richard Hu <richard.hu@technexion.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andra,

Just realized one minor issue:

On Fri, Jul 19, 2019 at 9:14 AM andradanciu1997
<andradanciu1997@gmail.com> wrote:

> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pmic@4b {
> +               reg = <0x4b>;
> +               compatible = "rohm,bd71837";
> +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */

Comment says gpio1 12...

> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pmic>;
> +               clocks = <&pmic_osc>;
> +               clock-names = "osc";
> +               clock-output-names = "pmic_clk";
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <3 GPIO_ACTIVE_LOW>;

but here you use gpio1 3 instead, so there is a mismatch.

Please check against the schematics and pick the correct one.

I would suggest removing the:
/* PMIC BD71837 PMIC_nINT GPIO1_IO12 */

comment entirely.

For the next version you can:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
