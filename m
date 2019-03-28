Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2653C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B045A217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800669;
	bh=pko2GDOk5oAEPmlGbjhr9sBqylFw6iA0CXlW3ZgD5/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2YODmmfKW1tPm59+S3sdyme2fc/mNSVD108Ep3j2nKdEcz7PmG5ccfxwHRNOianj3
	 ChiTFB0LSVbmsUunmQJOnOB01eO5Dv8ze9Qa8ueqhHKd+Uyu0xnikGJ1xeV8zafgiz
	 hEUT3gyH6/qh4JduqxByVkU59QDwakV2tipFMaL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfC1TRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfC1TRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:17:47 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926AC2183F;
        Thu, 28 Mar 2019 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800665;
        bh=pko2GDOk5oAEPmlGbjhr9sBqylFw6iA0CXlW3ZgD5/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S4Mb8xUcGor//kV1mgTYGn5FlGQpl7SV1np/HGFR+dfgbix5GLRZv7jNrvKeIEBtc
         jBDu+8fctvVmNohvcC5e954EzjYINIJi72kJ3GOQZRHcu9ynymHL//5R03xf0Wvuxo
         EnBly+b2zOURbwQN1pBbYm7mzCQVHMVqEVuvS06E=
Received: by mail-qt1-f176.google.com with SMTP id v20so24431117qtv.12;
        Thu, 28 Mar 2019 12:17:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWfTvrKGS/uHVOqPUznBHgreQJJBQ+qeXEw5AhvboHC1Dprmcq8
        Np7i8S2+Wn3Fp4Z/0Wf/dU+yDEiK7jEZEVZCzg==
X-Google-Smtp-Source: APXvYqypVSpcLiCqp8pG0Yel355QYBUVvbK7lfWpS61Wo2s6OiEJjXjLo73smcPOuhaMxgzxizDzgncbZpWu1EAqMNk=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr38037155qte.144.1553800664817;
 Thu, 28 Mar 2019 12:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-2-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-2-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:17:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ72_qMgN0+R41UiickZhY_B88=twyEj9yYS3qPrT4LPQ@mail.gmail.com>
Message-ID: <CAL_JsqJ72_qMgN0+R41UiickZhY_B88=twyEj9yYS3qPrT4LPQ@mail.gmail.com>
Subject: Re: [PATCH 01/24] dt-bindings: regulator: add support for MT6392
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:16 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add binding documentation of the regulator for MT6392 SoCs.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/regulator/mt6392-regulator.txt   | 220 ++++++++++++++++++
>  1 file changed, 220 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
>
> diff --git a/Documentation/devicetree/bindings/regulator/mt6392-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
> new file mode 100644
> index 000000000000..edf207c838dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
> @@ -0,0 +1,220 @@
> +Mediatek MT6392 Regulator
> +
> +Required properties:
> +- compatible: "mediatek,mt6392-regulator"
> +- mt6392regulator: List of regulators provided by this controller. It is named
> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  The definition for each of these nodes is defined using the standard binding
> +  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +The valid names for regulators are::
> +BUCK:
> +  buck_vproc, buck_vsys, buck_vcore
> +LDO:
> +  ldo_vxo22, ldo_vaud22, ldo_vcama, ldo_vaud28, ldo_vadc18, ldo_vcn35,
> +  ldo_vio28. ldo_vusb, ldo_vmc, ldo_vmch, ldo_vemc3v3, ldo_vgp1, ldo_vgp2,
> +  ldo_vcn18, ldo_vcamaf, ldo_vm, ldo_vio18, ldo_vcamd, ldo_vcamio, ldo_vm25,
> +  ldo_vefuse
> +
> +Example:
> +       pmic: mt6392 {

pmic {

> +               compatible = "mediatek,mt6392", "mediatek,mt6323";
> +               mediatek,system-power-controller;
> +
> +               mt6392_regulator: mt6392_regulator {

regulators {

> +                       compatible = "mediatek,mt6392-regulator";
> +
> +                       mt6392_vproc_reg: buck_vproc {

buck-vproc {

And similar for the rest.

> +                               regulator-name = "buck_vproc";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vsys_reg: buck_vsys {
> +                               regulator-name = "buck_vsys";
> +                               regulator-min-microvolt = <1400000>;
> +                               regulator-max-microvolt = <2987500>;
> +                               regulator-ramp-delay = <25000>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcore_reg: buck_vcore {
> +                               regulator-name = "buck_vcore";
> +                               regulator-min-microvolt = < 700000>;
> +                               regulator-max-microvolt = <1350000>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vxo22_reg: ldo_vxo22 {
> +                               regulator-name = "ldo_vxo22";
> +                               regulator-min-microvolt = <2200000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <110>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vaud22_reg: ldo_vaud22 {
> +                               regulator-name = "ldo_vaud22";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcama_reg: ldo_vcama {
> +                               regulator-name = "ldo_vcama";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vaud28_reg: ldo_vaud28 {
> +                               regulator-name = "ldo_vaud28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vadc18_reg: ldo_vadc18 {
> +                               regulator-name = "ldo_vadc18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcn35_reg: ldo_vcn35 {
> +                               regulator-name = "ldo_vcn35";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3600000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vio28_reg: ldo_vio28 {
> +                               regulator-name = "ldo_vio28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vusb_reg: ldo_vusb {
> +                               regulator-name = "ldo_vusb";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmc_reg: ldo_vmc {
> +                               regulator-name = "ldo_vmc";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vmch_reg: ldo_vmch {
> +                               regulator-name = "ldo_vmch";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vemc3v3_reg: ldo_vemc3v3 {
> +                               regulator-name = "ldo_vemc3v3";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vgp1_reg: ldo_vgp1 {
> +                               regulator-name = "ldo_vgp1";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vgp2_reg: ldo_vgp2 {
> +                               regulator-name = "ldo_vgp2";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcn18_reg: ldo_vcn18 {
> +                               regulator-name = "ldo_vcn18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamaf_reg: ldo_vcamaf {
> +                               regulator-name = "ldo_vcamaf";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm_reg: ldo_vm {
> +                               regulator-name = "ldo_vm";
> +                               regulator-min-microvolt = <1240000>;
> +                               regulator-max-microvolt = <1390000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vio18_reg: ldo_vio18 {
> +                               regulator-name = "ldo_vio18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                       };
> +
> +                       mt6392_vcamd_reg: ldo_vcamd {
> +                               regulator-name = "ldo_vcamd";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vcamio_reg: ldo_vcamio {
> +                               regulator-name = "ldo_vcamio";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vm25_reg: ldo_vm25 {
> +                               regulator-name = "ldo_vm25";
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <2500000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +
> +                       mt6392_vefuse_reg: ldo_vefuse {
> +                               regulator-name = "ldo_vefuse";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <2000000>;
> +                               regulator-enable-ramp-delay = <264>;
> +                       };
> +               };
> +       };
> --
> 2.20.1
>
