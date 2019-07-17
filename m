Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC3C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B5021743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563358553;
	bh=cgTcOvfKUWnyc6EhodXbcn/gUVIS698J1CpP1nKMC00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H2iJQu/2L0rBTp0SXsVHMt5HGRQ1Gb+rs5FDyOLGCvtuBrx2Sz9vtBeFx5Ejil+7Q
	 6/SCqgRF0UcSnovHkm2+JKGFYFg/lcnhf6reNIRGRSfBexFWsBUg++662zscKc2D6V
	 brTgYBMDWFTmpAAn13pNyPkTtEUYY0rVHKSv2090=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfGQKPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfGQKPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:15:51 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD0E21848;
        Wed, 17 Jul 2019 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563358551;
        bh=cgTcOvfKUWnyc6EhodXbcn/gUVIS698J1CpP1nKMC00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n/KnnkpPOoDuockCCqvNzFXBhnfMYPkeMF9lPDJWPXMA/6e0LhdOtABgbBmeTBKnj
         6gGW1i/yM9LoqlWU/G6exRQf6dpSJg17b8VF/uH9VIRYXuWQwztjLfetFhpRhLzJ0B
         qUlE9CJjq7yXJDIIwBYW9UaUM5NrPnQ87gI40Dqo=
Received: by mail-lf1-f50.google.com with SMTP id v85so15988090lfa.6;
        Wed, 17 Jul 2019 03:15:50 -0700 (PDT)
X-Gm-Message-State: APjAAAWU5g++XDnCGxNhFy9Evmdh/s48Cc2I0PXGsDO+5ux7GiXEfgVQ
        VDa+YOP0Jb4nu2/CqDoF90zUKAuWx/uEqs4y6bk=
X-Google-Smtp-Source: APXvYqy/paW0xRlOmAzye/v3rIrHH6BF3MFPQ6tlnzcgE7BNiAXPMQ+T+LFCXyQ9N8833KJQn9EroblWQafzagXZMKQ=
X-Received: by 2002:a19:f007:: with SMTP id p7mr17384347lfc.24.1563358548916;
 Wed, 17 Jul 2019 03:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124456eucas1p2acf15d00e3fa7b77fe3a2b10ce1ab74f@eucas1p2.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-28-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-28-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:15:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfFZL8q9hM1vPsLq+Qxe-gMz4c8j0jgFKfdf5qs68MTmA@mail.gmail.com>
Message-ID: <CAJKOXPfFZL8q9hM1vPsLq+Qxe-gMz4c8j0jgFKfdf5qs68MTmA@mail.gmail.com>
Subject: Re: [PATCH v1 27/50] ARM: dts: exynos: align bus_wcore OPPs in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com, Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 at 14:44, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This is the most important bus in the Exynos5x SoC. The whole communication
> inside SoC does through that bus (apart from direct requests from CCI to
> DRAM controller). It is also modeled as a master bus in devfreq framework.
> It is also the only one OPP table throughout other buses which has voltage
> values. The devfreq software controls the speed of that bus and other
> buses. The other buses follows the rate of the master. There is only one
> regulator. The old lowest OPP had pair 925mV, 84MHz which is enough for

s/lowest/slowest/

> this frequency. However, due to the fact that the other buses follows the
> WCORE bus by taking the OPP from their table with the same id, e.g. opp02,
> the children frequency should be stable with the set voltage.
> It could cause random faults very hard to debug.
> Thus, the patch removes the lowest OPP to make other buses' lowest OPPs

s/lowest/slowest/

> working. The new lowest OPP has voltage high enough for buses working up
> to 333MHz. It also changes the frequencies of the OPPs to align them to
> PLL value such that it is possible to set them using only a divider without
> reprogramming OPP.

Reprogramming OPP? What is it?

> Reprogramming the PLL was not set, so the real frequency

I understood from the previous that reprogramming the OPP (PLL?) was
happening... Please rephrase entire sentence.

BR,
Krzysztof

> values were not the one from the OPP table, which could confuse the
> governor algorithms which relay on OPP speed values making the system to
> behave weird.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index f8c36ff0d4c3..a355c76af5a5 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1107,22 +1107,18 @@
>                         compatible = "operating-points-v2";
>
>                         opp00 {
> -                               opp-hz = /bits/ 64 <84000000>;
> -                               opp-microvolt = <925000>;
> +                               opp-hz = /bits/ 64 <150000000>;
> +                               opp-microvolt = <950000>;
>                         };
>                         opp01 {
> -                               opp-hz = /bits/ 64 <111000000>;
> +                               opp-hz = /bits/ 64 <200000000>;
>                                 opp-microvolt = <950000>;
>                         };
>                         opp02 {
> -                               opp-hz = /bits/ 64 <222000000>;
> +                               opp-hz = /bits/ 64 <300000000>;
>                                 opp-microvolt = <950000>;
>                         };
>                         opp03 {
> -                               opp-hz = /bits/ 64 <333000000>;
> -                               opp-microvolt = <950000>;
> -                       };
> -                       opp04 {
>                                 opp-hz = /bits/ 64 <400000000>;
>                                 opp-microvolt = <987500>;
>                         };
> --
> 2.17.1
>
