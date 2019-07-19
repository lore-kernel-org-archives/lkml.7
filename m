Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A59C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DAC2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7qYAD+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfGSLT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:19:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43279 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfGSLT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:19:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so5859773ljk.10;
        Fri, 19 Jul 2019 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oa7kpDXrcCy8McuyUn5ga3FPCCt3ADMPU6Hul/X/yUM=;
        b=j7qYAD+kzQ5zFcCG7d0p/5oYJbPJHNhQ8vG9lABZv5JKBjUe0FPzX8M7kjRFL0Ic56
         PUxBY9hnbA+7mZ2UeH/j+OM6TQUga19wXGUyfj3lS935uRemxKXrgxQJVVb+kvgKTCVj
         4qtA4weK0qCFLGLht52WVfvlYxwDF7lwY6bTcpWReEsdLs0Y/HGXoquLm9fCUjkGH7DJ
         QEsTs4aN9JFk7Vu3DOnXBjJzzNF0aq2GdLeB/bY/bFfHpEN8dQTKn/vgJy699XoPZdwT
         +aAUjkAUkYL6v3vVIM6W/5x4MeUbBykMRvqbCiH6oIroveMIcFN23c5L21xLg2jGBOos
         SKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oa7kpDXrcCy8McuyUn5ga3FPCCt3ADMPU6Hul/X/yUM=;
        b=e3nZsXbMqwLlUXnGRtcywFCLFDPIhhBt83oBWMd4Ohqr39sJD/jzBZrSDj8afvGi5T
         6SEGd8YfbbG9G172KoMucEdahsP3BuifIkEe4S9+hRWMFLcj8AgHRs9e+As42d5JBfvE
         kRxWGXUKCF3OxtYwy0XEMzP0tsZq7IdGjSgMp5vihwOs09Gq5J2wBiNHOCmrZPXEYzWH
         cK90ULppRWo7woWAczvlUCJatgdrbgc5N8bKOXxXcl6LJHI0HRRsZLRhhFdTZxd/LwH4
         C7r5O82pG1NpgJTLdgj5Km31f1kaIbtnTHjca+PER3BAt1hzCw6mmb+9TJplC/+XzGDg
         9i1g==
X-Gm-Message-State: APjAAAUy69M3EjpfPbfXP3f9016y9RUAkFuKsoNUjpZlOlDFqyJsQq+A
        dpzSGnutc2rdNaochtCVNOBvHpP9HcCWEUa1V34=
X-Google-Smtp-Source: APXvYqzBHXvvyxC4iFcPJJjFihiAgUmb5NF6oXKVWMbQdzkDX3RFp21crAVVLA28yDHF9lGH5qeEQdPJDZGMAPBIX9k=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr26523151lje.214.1563535194358;
 Fri, 19 Jul 2019 04:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190719104802.18070-1-andradanciu1997@gmail.com> <20190719104802.18070-2-andradanciu1997@gmail.com>
In-Reply-To: <20190719104802.18070-2-andradanciu1997@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 19 Jul 2019 08:19:43 -0300
Message-ID: <CAOMZO5Btu1Shou=dGRrG74e5UjHnh7NtR4+4ETK0t_1Zt48Crw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     andradanciu1997 <andradanciu1997@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ping Bai <ping.bai@nxp.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>,
        Li Yang <leoyang.li@nxp.com>, sriram.dash@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>, pankaj.bansal@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
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

On Fri, Jul 19, 2019 at 7:48 AM andradanciu1997
<andradanciu1997@gmail.com> wrote:

> +       pmic: pmic@4b {
> +               reg = <0x4b>;
> +               compatible = "rohm,bd71837";
> +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pmic>;
> +               clocks = <&pmic_osc>;
> +               clock-names = "osc";
> +               clock-output-names = "pmic_clk";
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <3 GPIO_ACTIVE_LOW>;
> +               interrupt-names = "irq";
> +
> +               regulators {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;

#address-cells and  #size-cells are not needed and they cause warnings with W=1:

  DTC     arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts:77.14-196.5: Warning
(avoid_unnecessary_addr_size):
/soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators: unnecessary
#address-cells/#size-cells without "ranges" or child "reg" property

Please remove them.
