Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D0ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9FE2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxAUvPHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391904AbfJPJJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:09:33 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46775 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390073AbfJPJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:09:32 -0400
Received: by mail-vk1-f194.google.com with SMTP id o137so4992441vka.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLC2Bd8aTQlMgTV7BobgAGWFlGh3ztvsn8nW9/bKZV0=;
        b=TxAUvPHmWlpqZquEhMqD+x3551R1EZwVaKusNrROTNOeGYR0WQl7D+tujtdR8FSyyF
         2VeE5hAYMcMy3oMmSGWr1wAiipgs7pUOxgq6jJxs33Tx3MPjfT9ckCrvv/C+5gve3kV0
         tNEy86FFXR6/dHrqdTnSg3Gmnr5Asphn8ZSpJJnE+BsLyrAJscBCCdkt4XLiSb5oBFHQ
         RgPAmHOZgQ6FKVhO7pLWmEc3uBpSmSd5Gmud8YcSKygyyn3Y6Fsn7Mu8MGT93UWDJdwe
         QAE2jYUkX6PeuIbZoOt0oyrLbStPJgrPvJ5MOGHT4p02Lgzg6Pg9cqKTEpawJNUUsutW
         5q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLC2Bd8aTQlMgTV7BobgAGWFlGh3ztvsn8nW9/bKZV0=;
        b=Y9fLbHBp2PBU8lt+638fuIi2NrRKF9JFvEyt48D+Xy7W3JxpofZ1ck7XTdQ1SA8hm4
         dnvSgLK2TU802O1bk8MmkJalJGTi7mri78w1r6A82i3vpVej64ORAPUI6UkdqhbzfkXK
         W5ldwpZr5MXznh+VlnjpeAScJaoovXeOGfaecC7NFZ+bL1wLmU3Ezm4H8gXRCS9ErkoG
         MBXTSgnE64DcsNsxNHggh+vB/LaiIFgclCkovqC5fRC9A84Y50f1i/hA4lnXQjznG2oK
         KHE6HeVqkPoVi8issgyPLVHN9jpmMWDGa3S+9xoX9fiKMWtzGDSNabw871pkZoloCEDU
         vSkw==
X-Gm-Message-State: APjAAAUy0FDZ3hWlFppXIvCMtxmN3Bv7GgUg367KW1SdXLHCgPQsQaxo
        TAS+aE6veuay+r3uCiL3lN773xrLsVkLtVqaCiwmfw==
X-Google-Smtp-Source: APXvYqww+h+Iq3oDN0oTKBVKfMcWMcfwYY7YU64RQBVmcDpEJ/mf+loxbnHvtZCcDTC1U4TMBxnPsF30uUlEr20CN5E=
X-Received: by 2002:a1f:f8cd:: with SMTP id w196mr21577811vkh.73.1571216970789;
 Wed, 16 Oct 2019 02:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-6-glaroque@baylibre.com>
In-Reply-To: <20191004090114.30694-6-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 14:39:19 +0530
Message-ID: <CAHLCerMp8K7Gs6cAfDVPGa8zSNEOjyQghy-LoauGB15if0EjKg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] arm64: dts: amlogic: g12a: add cooling properties
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:31 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Add missing #colling-cells field for G12A SoC
> Add cooling-map for passive and hot trip point
>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index 733a9d46fc4b..3ab6497548ca 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -18,6 +18,7 @@
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu1: cpu@1 {
> @@ -26,6 +27,7 @@
>                         reg = <0x0 0x1>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu2: cpu@2 {
> @@ -34,6 +36,7 @@
>                         reg = <0x0 0x2>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu3: cpu@3 {
> @@ -42,6 +45,7 @@
>                         reg = <0x0 0x3>;
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 l2: l2-cache0 {
> @@ -113,3 +117,23 @@
>  &sd_emmc_a {
>         amlogic,dram-access-quirk;
>  };
> +
> +&cpu_thermal {
> +       cooling-maps {
> +               map0 {
> +                       trip = <&cpu_passive>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +
> +               map1 {
> +                       trip = <&cpu_hot>;
> +                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +               };
> +       };
> +};
> --
> 2.17.1
>
