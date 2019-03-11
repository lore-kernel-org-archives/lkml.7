Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59768C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156092147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552335829;
	bh=Q0UiOH0KPnSrhFAeHfE0aKf5g/hkXpjqgDXSIjEFaII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LgpF/F72XXd7UPVXfPtrapSNUtxgpqJrVg2JHjpOICpLKQc+a59wTpgja4f60+9Jx
	 lCP4AOO6h65AKRzIUUT5ie9cTmluuQOPHJ5goKOHL73NAEcsxPf5x7lub2xgvHMyTk
	 M3ZtFX85kusCYNkDk4VxGonfUGInS+VEWhKYccGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfCKUXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfCKUXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:23:47 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD982147C;
        Mon, 11 Mar 2019 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552335825;
        bh=Q0UiOH0KPnSrhFAeHfE0aKf5g/hkXpjqgDXSIjEFaII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=edKOMQYvskXfIZntNn4g+mJySGxlRGog0XYLcrJry9VEHASyjk8Ub0WaY2EafCzve
         3AIN8Y5TXTUNO0nIVcVl16cvbHFNGIRFq4A7q59A/u7TjGdE9pG4ltYgr6UUccI0CF
         +mwrdttJNuTKN7yE9mVRRv3FVjEpQG2X5qDBO42s=
Received: by mail-wr1-f45.google.com with SMTP id p8so298142wrq.6;
        Mon, 11 Mar 2019 13:23:44 -0700 (PDT)
X-Gm-Message-State: APjAAAVAQljeNgl0MC3RJUrEyP/AR/rDoDzfqjbCAcUY0jjwst35LZug
        2Nxl398r2c9zuqUuDJy2dGDbnhEtTv9WvljCO0Y=
X-Google-Smtp-Source: APXvYqzS3+6rk29KSch680SDptrJpjHJaKCreEoxv3soKGgarXldZacmv1JOBe4WSuJaCU8AN1T5deQdiRu9Lz6AYGs=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr20637077wrm.291.1552335823148;
 Mon, 11 Mar 2019 13:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-8-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-8-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 13:23:31 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrHq3Ey2ZqKBa6sk1WsOPtuViOc5KUGV-FF7kPXNXkm6Q@mail.gmail.com>
Message-ID: <CAGp9LzrHq3Ey2ZqKBa6sk1WsOPtuViOc5KUGV-FF7kPXNXkm6Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: mt6358: add PMIC MT6358 related nodes
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 10, 2019 at 8:49 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> add PMIC MT6358 related nodes which is for mt8183 platform
>

s/MT8183/mt8183/

> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi | 318 +++++++++++++++++++++++++++++++
>  1 file changed, 318 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6358.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> new file mode 100644
> index 0000000..a7c02ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */
> +
> +&pwrap {
> +       pmic: mt6358 {

use a generic name

pmic {

> +               compatible = "mediatek,mt6358";
> +               interrupt-controller;
> +               interrupt-parent = <&pio>;
> +               interrupts = <182 IRQ_TYPE_LEVEL_HIGH 190 0>;
> +               #interrupt-cells = <2>;
> +
> +               mt6358codec: mt6358codec {

use a generic name

audio-codec {

> +                       compatible = "mediatek,mt6358-sound";
> +               };
> +
> +               mt6358regulator: mt6358regulator {

use a generic name

regulators {

> +                       compatible = "mediatek,mt6358-regulator";
> +
> +                       mt6358_vdram1_reg: buck_vdram1 {
> +                               regulator-compatible = "buck_vdram1";
> +                               regulator-name = "vdram1";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <2087500>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <0>;
> +                               regulator-always-on;
> +                               regulator-allowed-modes = <0 1>;
> +                       };

add a blank line here and for all below occurrences

> +                       mt6358_vcore_reg: buck_vcore {
> +                               regulator-name = "vcore";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vpa_reg: buck_vpa {
> +                               regulator-name = "vpa";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <3650000>;
> +                               regulator-ramp-delay = <50000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vproc11_reg: buck_vproc11 {
> +                               regulator-name = "vproc11";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vproc12_reg: buck_vproc12 {
> +                               regulator-name = "vproc12";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vgpu_reg: buck_vgpu {
> +                               regulator-name = "vgpu";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vs2_reg: buck_vs2 {
> +                               regulator-name = "vs2";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <2087500>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <0>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vmodem_reg: buck_vmodem {
> +                               regulator-name = "vmodem";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <900>;
> +                               regulator-always-on;
> +                               regulator-allowed-modes = <0 1>;
> +                       };
> +                       mt6358_vs1_reg: buck_vs1 {
> +                               regulator-name = "vs1";
> +                               regulator-min-microvolt = <1000000>;
> +                               regulator-max-microvolt = <2587500>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <0>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vdram2_reg: ldo_vdram2 {
> +                               regulator-name = "vdram2";
> +                               regulator-min-microvolt = <600000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <3300>;
> +                       };
> +                       mt6358_vsim1_reg: ldo_vsim1 {
> +                               regulator-name = "vsim1";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <3100000>;
> +                               regulator-enable-ramp-delay = <540>;
> +                       };
> +                       mt6358_vibr_reg: ldo_vibr {
> +                               regulator-name = "vibr";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <60>;
> +                       };
> +                       mt6358_vrf12_reg: ldo_vrf12 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vrf12";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +                       mt6358_vio18_reg: ldo_vio18 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vio18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <2700>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vusb_reg: ldo_vusb {
> +                               regulator-name = "vusb";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3100000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vcamio_reg: ldo_vcamio {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vcamio";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vcamd_reg: ldo_vcamd {
> +                               regulator-name = "vcamd";
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vcn18_reg: ldo_vcn18 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vcn18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vfe28_reg: ldo_vfe28 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vfe28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vsram_proc11_reg: ldo_vsram_proc11 {
> +                               regulator-name = "vsram_proc11";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <240>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vcn28_reg: ldo_vcn28 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vcn28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vsram_others_reg: ldo_vsram_others {
> +                               regulator-name = "vsram_others";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <240>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vsram_gpu_reg: ldo_vsram_gpu {
> +                               regulator-name = "vsram_gpu";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <240>;
> +                       };
> +                       mt6358_vxo22_reg: ldo_vxo22 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vxo22";
> +                               regulator-min-microvolt = <2200000>;
> +                               regulator-max-microvolt = <2200000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vefuse_reg: ldo_vefuse {
> +                               regulator-name = "vefuse";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <1900000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vaux18_reg: ldo_vaux18 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vaux18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vmch_reg: ldo_vmch {
> +                               regulator-name = "vmch";
> +                               regulator-min-microvolt = <2900000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <60>;
> +                       };
> +                       mt6358_vbif28_reg: ldo_vbif28 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vbif28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vsram_proc12_reg: ldo_vsram_proc12 {
> +                               regulator-name = "vsram_proc12";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <240>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vcama1_reg: ldo_vcama1 {
> +                               regulator-name = "vcama1";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vemc_reg: ldo_vemc {
> +                               regulator-name = "vemc";
> +                               regulator-min-microvolt = <2900000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <60>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vio28_reg: ldo_vio28 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vio28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_va12_reg: ldo_va12 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "va12";
> +                               regulator-min-microvolt = <1200000>;
> +                               regulator-max-microvolt = <1200000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vrf18_reg: ldo_vrf18 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vrf18";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <1800000>;
> +                               regulator-enable-ramp-delay = <120>;
> +                       };
> +                       mt6358_vcn33_bt_reg: ldo_vcn33_bt {
> +                               regulator-name = "vcn33_bt";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3500000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
> +                               regulator-name = "vcn33_wifi";
> +                               regulator-min-microvolt = <3300000>;
> +                               regulator-max-microvolt = <3500000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vcama2_reg: ldo_vcama2 {
> +                               regulator-name = "vcama2";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vmc_reg: ldo_vmc {
> +                               regulator-name = "vmc";
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-enable-ramp-delay = <60>;
> +                       };
> +                       mt6358_vldo28_reg: ldo_vldo28 {
> +                               regulator-name = "vldo28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <3000000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vaud28_reg: ldo_vaud28 {
> +                               compatible = "regulator-fixed";
> +                               regulator-name = "vaud28";
> +                               regulator-min-microvolt = <2800000>;
> +                               regulator-max-microvolt = <2800000>;
> +                               regulator-enable-ramp-delay = <270>;
> +                       };
> +                       mt6358_vsim2_reg: ldo_vsim2 {
> +                               regulator-name = "vsim2";
> +                               regulator-min-microvolt = <1700000>;
> +                               regulator-max-microvolt = <3100000>;
> +                               regulator-enable-ramp-delay = <540>;
> +                       };
> +               };
> +       };
> +};
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
