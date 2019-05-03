Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19939C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604920675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFsaDfJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfECIEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:04:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44540 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:04:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id a26so3380544qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyYnh8hGNxo4y79JyoBAvnyJOsqV/eKCHgC2055Dj70=;
        b=TFsaDfJktcepJhaSVkSy9jmcH5WklitGZ2BBIrKTkDmfye484EI32NBvqAF18RhDM4
         icz2jBCDxSTj6qmQVp0LN0YlkJPVgxnXUunfIEesZ1FOAC5727DnzDgNJ++yI7ZM9nil
         K47/JWKZTYl0cyTlCD15zHWhm1WvSpjJECOdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyYnh8hGNxo4y79JyoBAvnyJOsqV/eKCHgC2055Dj70=;
        b=QBzj9/99avVfKtgQqQpqrtQeAf0mU4XUverxJcb343JgQw87q1vmaplo0B97186WRM
         lkNFMlkM8M8YE9M/63RXifsTC6NFtojPnZ6s9Ii+5HN8HvyO183mOE6loaG62nBBC8H+
         WmTZDd6x1EBfCR1rqIEPHCJqv5I0kXZVJV7NuGdw9BxGi4qcs7kED1SWF06U45nuXaFw
         qtX3SWebFW3LK3LOJFQMLIU64olaG6UZFvn6kBkvD0AUrnBZ3KulKO2HpAF8UmWmfF1M
         8KNzhj0KO0K1FeZh/ZwkMYo70Y10niqWj6r16FPLDweZpflozzvBtexo2vtIVGiizUEr
         KtRQ==
X-Gm-Message-State: APjAAAWGueto4SP23lELRaaYjjIcM5w7z4D81QYM3Y++gYGisQInjz1l
        vro6SCmzAX8hK7Emz+Bai1WTjjRHQsVmeXKv9G8OAw==
X-Google-Smtp-Source: APXvYqwK9NYfQA/9uIkz+E3ZSXoSVmvGacXxJP1bm9lZj8RtDGEHaMjRHL1WIrVFMhk5ZLbA20X7lzzIyVAj/Hr6Db0=
X-Received: by 2002:ac8:3822:: with SMTP id q31mr7331051qtb.0.1556870649914;
 Fri, 03 May 2019 01:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 3 May 2019 16:03:58 +0800
Message-ID: <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, jamesjj.liao@mediatek.com,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>
> Add thermal zone node to Mediatek MT8183 dts file.
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 926df75..b92116f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -334,6 +334,67 @@
>                         status = "disabled";
>                 };
>
> +               thermal: thermal@1100b000 {
> +                       #thermal-sensor-cells = <1>;
> +                       compatible = "mediatek,mt8183-thermal";
> +                       reg = <0 0x1100b000 0 0x1000>;
> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&infracfg CLK_INFRA_THERM>,
> +                                <&infracfg CLK_INFRA_AUXADC>;
> +                       clock-names = "therm", "auxadc";
> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> +                       mediatek,auxadc = <&auxadc>;
> +                       mediatek,apmixedsys = <&apmixedsys>;
> +                       mediatek,hw-reset-temp = <117000>;
> +                       nvmem-cells = <&thermal_calibration>;
> +                       nvmem-cell-names = "calibration-data";
> +               };
> +
> +               thermal-zones {
> +                       cpu_thermal: cpu_thermal {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +
> +                               thermal-sensors = <&thermal 0>;
> +                               sustainable-power = <1500>;
> +                       };
> +
> +                       tzts1: tzts1 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 1>;
Is sustainable-power required for tzts? Though it's an optional
property, kernel would have warning:
[    0.631556] thermal thermal_zone1: power_allocator:
sustainable_power will be estimated
[    0.639586] thermal thermal_zone2: power_allocator:
sustainable_power will be estimated
[    0.647611] thermal thermal_zone3: power_allocator:
sustainable_power will be estimated
[    0.655635] thermal thermal_zone4: power_allocator:
sustainable_power will be estimated
[    0.663658] thermal thermal_zone5: power_allocator:
sustainable_power will be estimated
if no sustainable-power assigned.

> +                       };
> +
> +                       tzts2: tzts2 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 2>;
> +                       };
> +
> +                       tzts3: tzts3 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 3>;
> +                       };
> +
> +                       tzts4: tzts4 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 4>;
> +                       };
> +
> +                       tzts5: tzts5 {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 5>;
> +                       };
> +
> +                       tztsABB: tztsABB {
> +                               polling-delay-passive = <1000>;
> +                               polling-delay = <1000>;
> +                               thermal-sensors = <&thermal 6>;
> +                       };
> +               };
>                 audiosys: syscon@11220000 {
>                         compatible = "mediatek,mt8183-audiosys", "syscon";
>                         reg = <0 0x11220000 0 0x1000>;
> @@ -368,6 +429,9 @@
>                         compatible = "mediatek,mt8183-efuse",
>                                      "mediatek,efuse";
>                         reg = <0 0x11f10000 0 0x1000>;
> +                       thermal_calibration: calib@180 {
> +                               reg = <0x180 0xc>;
> +                       };
>                 };
>
>                 mfgcfg: syscon@13000000 {
