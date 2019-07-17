Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4DC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B16820818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563357785;
	bh=NCz+/qyUYefzxnwUGAYv3ttjqTH35P9ZY0JImQSzg+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hgdtWtSfLwfpr9MBXhb69qQIDEwKfYi/qCF7WCZHxiifusBrzRcAPsjPrEsVIsBEA
	 U4BR7xThyntNFlf5tIpkN080MENxRBpB63UQDJ2v3JxVVu+Gu8ivhfSbFbZiQIqHzX
	 +EtUOP32rgjKYYp85gxgo0/tZXfAPrS80G1sUUHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGQKDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfGQKDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:03:02 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE43421841;
        Wed, 17 Jul 2019 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563357781;
        bh=NCz+/qyUYefzxnwUGAYv3ttjqTH35P9ZY0JImQSzg+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sOofdmjAyc3VxH7un9C/GsVWaOAuRKhoZen/6U8N0nnxZcKOoQa7R8eX0+vRiTxTB
         tXXHlEd9es9CZNRR7G3eSkRRnXbiOSWpNQJ49Sftyyh9PdcN9ivmwWP+lJTNJy7mtg
         Qe40JNLJi0cJ4RvUdWSdBUkm82nwZxugeHZLcwOo=
Received: by mail-lf1-f52.google.com with SMTP id h28so15967258lfj.5;
        Wed, 17 Jul 2019 03:03:00 -0700 (PDT)
X-Gm-Message-State: APjAAAU+xZbR3UzKAChNuBdWh+7GWqAW72Ee8QJzX1rdQW3ePUbZAfZT
        oto7wnJ2S3W5HkBIlOkQjf+rH91W57lDefIU0M4=
X-Google-Smtp-Source: APXvYqyfLXa1g6BfJ5mBA85Kb0T2X5T4F2Y48Ege4Izqj7dAHq+EW8Ogwx/5Kmpks+6IYktMG7J9ZoO5iZ63myk+05Q=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr17980541lfc.60.1563357779221;
 Wed, 17 Jul 2019 03:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715124509eucas1p1f2e44af951158fbef1a245467956ef93@eucas1p1.samsung.com>
 <20190715124417.4787-1-l.luba@partner.samsung.com> <20190715124417.4787-44-l.luba@partner.samsung.com>
In-Reply-To: <20190715124417.4787-44-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Jul 2019 12:02:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcsH9YRzLOA1P5xc0Y3Zqh9+5o0RSxP-JcYOVEm7eO0Sw@mail.gmail.com>
Message-ID: <CAJKOXPcsH9YRzLOA1P5xc0Y3Zqh9+5o0RSxP-JcYOVEm7eO0Sw@mail.gmail.com>
Subject: Re: [PATCH v1 43/50] ARM: dts: exynos: add bus_isp in Exynos5422
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

On Mon, 15 Jul 2019 at 14:45, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add bus_isp which changes ACLK400_ISP clock speed according to the bus
> documentation in the documentation. The bus_isp OPP table has been
> aligned to the new parent rate.

Title and msg needs fixing.

Please squash it with patch 18.

Best regards,
Krzysztof

> This patch sets the proper parent and
> picks the init frequency before the devfreq governor starts working.
> It sets also parent rate (DPLL to 1200MHz).
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index 990fe03fce75..852cb3dd495d 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -166,6 +166,18 @@
>         status = "okay";
>  };
>
> +&bus_isp {
> +       devfreq = <&bus_wcore>;
> +       assigned-clocks = <&clock CLK_MOUT_ACLK400_ISP>,
> +                         <&clock CLK_MOUT_SW_ACLK400_ISP>,
> +                         <&clock CLK_DOUT_ACLK400_ISP>,
> +                         <&clock CLK_FOUT_DPLL>;
> +       assigned-clock-parents = <&clock CLK_MOUT_SCLK_DPLL>,
> +                                <&clock CLK_DOUT_ACLK400_ISP>;
> +       assigned-clock-rates = <0>, <0>, <400000000>, <1200000000>;
> +       status = "okay";
> +};
> +
>  &cpu0 {
>         cpu-supply = <&buck6_reg>;
>  };
> --
> 2.17.1
>
