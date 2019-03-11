Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9040C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87BC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552333426;
	bh=sA3Iff64BT1gnF7fQ0T23QZEMB+Hn2JgzhJZjtUbD3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mpgKzdkKMWjk9LSwMG8qdilTKfMIrx9HzY3QhYsPV5SgXJt22pzK9Aniy6jsTH7Gu
	 OfaN2VCqv5M353C3zf5eJSIYQpygg7cP6Tk5Jz0in9VPHtbkKN/1s3cm9EB8aKFAG4
	 3vLLX1eejjMEb7h04PRZFpR95MRiZwTTbbLWYv/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfCKTnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKTnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:43:45 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A4620643;
        Mon, 11 Mar 2019 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552333423;
        bh=sA3Iff64BT1gnF7fQ0T23QZEMB+Hn2JgzhJZjtUbD3Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iHXNiZIcv2gxdVzz1wxKPUtdiQ9Z2/dPlQoj5mFFEuX7/J92rfChJ/EGEiC659NM/
         ti2DMRq3H8Fy3PuofN/mLRqvULOGVVdTKWCf2bM0F4h9AqkM59sCicNWb9jQdJBqq5
         jPKSYeDQA8Hor94qJoJUyZSmMshePS1ZvDHhAfR8=
Received: by mail-wr1-f49.google.com with SMTP id d17so160042wre.10;
        Mon, 11 Mar 2019 12:43:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVhIyal7STDDDZACu79aplBbuu1TLO2Br31MBHWPgf0V17gGhum
        4f2apKMYHHzw8c015gILuB2hprrvgwt1X6u9ck0=
X-Google-Smtp-Source: APXvYqzxG/QqVcPpQUY3GItYPEk17KvzW7g6S0Z5kygN0tzev0OgfusH7lmhwt8YufrLiPjtFfegf2PgSksGVm+j8Po=
X-Received: by 2002:adf:e84a:: with SMTP id d10mr993018wrn.78.1552333421255;
 Mon, 11 Mar 2019 12:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-5-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-5-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 12:43:29 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzorq1QVncvQ56Mu1R+ZyDqXC-=D4X4O9M=KHzjBpuMeFQ@mail.gmail.com>
Message-ID: <CAGp9Lzorq1QVncvQ56Mu1R+ZyDqXC-=D4X4O9M=KHzjBpuMeFQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] regulator: Add document for MT6358 regulator
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

add a dt-bindings prefix and move the patch to the first order in the series.

On Sun, Mar 10, 2019 at 9:03 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> add dt-binding document for MediaTek MT6358 PMIC
>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6358-regulator.txt        | 318 +++++++++++++++++++++
>  1 file changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
>
> diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> new file mode 100644
> index 0000000..3ea8073
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> @@ -0,0 +1,318 @@
> +Mediatek MT6358 Regulator

MediaTek

> +
> +Required properties:
> +- compatible: "mediatek,mt6358-regulator"
> +- mt6358regulator: List of regulators provided by this controller. It is named

mt6358regulator is not a required property, it is just a node alias.

> +  according to its regulator type, buck_<name> and ldo_<name>.
> +  The definition for each of these nodes is defined using the standard binding
> +  for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
> +
> +The valid names for regulators are::
> +BUCK:
> +  buck_vdram1, buck_vcore, buck_vpa, buck_vproc11, buck_vproc12, buck_vgpu,
> +  buck_vs2, buck_vmodem, buck_vs1
> +LDO:
> +  ldo_vdram2, ldo_vsim1, ldo_vibr, ldo_vrf12, ldo_vio18, ldo_vusb, ldo_vcamio,
> +  ldo_vcamd, ldo_vcn18, ldo_vfe28, ldo_vsram_proc11, ldo_vcn28, ldo_vsram_others,
> +  ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18, ldo_vmch, ldo_vbif28,
> +  ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12, ldo_vrf18,
> +  ldo_vcn33_bt, ldo_vcn33_wifi, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28,
> +  ldo_vsim2
> +
> +Example:
> +       pmic {
> +               compatible = "mediatek,mt6358";

it is not necessary to document the PMIC part in the regulator binding

and you can refer to mt6380-regulator.txt or mt6323-regulator.txt
first to make the
style about the PMIC description and example be more consistent.

> +
> +               mt6358regulator: mt6358regulator {
> +                       compatible = "mediatek,mt6358-regulator";

use a generic node, regulators, something like

        regulators {
                compatible = "mediatek,mt6358-regulator";

> +
> +                       mt6358_vdram1_reg: buck_vdram1 {
> +                               regulator-compatible = "buck_vdram1";
> +                               regulator-name = "vdram1";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <2087500>;
> +                               regulator-ramp-delay = <12500>;
> +                               regulator-enable-ramp-delay = <0>;
> +                               regulator-always-on;
> +                       };

add a blank line between subnodes which includes all below occurrences

> +                       mt6358_vcore_reg: buck_vcore {
> +                               regulator-name = "vcore";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vpa_reg: buck_vpa {
> +                               regulator-name = "vpa";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <3650000>;
> +                               regulator-ramp-delay = <50000>;
> +                               regulator-enable-ramp-delay = <250>;
> +                       };
> +                       mt6358_vproc11_reg: buck_vproc11 {
> +                               regulator-name = "vproc11";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vproc12_reg: buck_vproc12 {
> +                               regulator-name = "vproc12";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
> +                               regulator-always-on;
> +                       };
> +                       mt6358_vgpu_reg: buck_vgpu {
> +                               regulator-name = "vgpu";
> +                               regulator-min-microvolt = <500000>;
> +                               regulator-max-microvolt = <1293750>;
> +                               regulator-ramp-delay = <6250>;
> +                               regulator-enable-ramp-delay = <200>;
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
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
