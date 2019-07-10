Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C67C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265D220693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562749349;
	bh=grJo9qA0dVCvVT51OK6PLtYRTvoyCGPyB+MacpINhxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZAKC9CP5q1gO+I+dzgKNebkhakoTsDrPl2GjkvmU5dCEfbhKrFGbDXRNFuvqe8muu
	 sChFXVS/SM7NzJB8ykRiHdduEB+lgvKNG157Z/I3i4wbwJRZBJcHEsq2izUtu7XJHZ
	 Jm1eqAq1pM8EDrCa3J4T0ZIFQJVeQx9/1Su5wuLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfGJJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfGJJC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 05:02:27 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C0D2084B;
        Wed, 10 Jul 2019 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562749346;
        bh=grJo9qA0dVCvVT51OK6PLtYRTvoyCGPyB+MacpINhxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VY/CJTr0YtoB7QyD/0SL+E4YfwX770XgrKkTWfc5FB/PhxVYHVdUYQ31Q5dXtwoGC
         g9FIGr5uPL4kSxt4grGkGSry9UUUsW4hWOyjl30yu6u1TsXdAug9GICmHEACvlEtJO
         6XHenRQPf22/7kwmHJJ2CFrHG0WFvQ+mqSfuFhEM=
Received: by mail-lj1-f175.google.com with SMTP id m8so1284614lji.7;
        Wed, 10 Jul 2019 02:02:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWIDUntnWq92yaC/qO13RuBzJ02bJd7k33Kth7OTVuhXaQ9y9UA
        rPlJSQ1icD9Ves6zP8KNQ4kcGNmbkvAAEiYeqv0=
X-Google-Smtp-Source: APXvYqzMx4eMmr2iBEqLzt/lJp+fw4LN2JFxzaOjxmxUajPpp5qPQbRZZ2FHahr78e8oGOQvAGBAnOPvhsKRPbwqrBw=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr13258968ljc.210.1562749344748;
 Wed, 10 Jul 2019 02:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141200eucas1p12bf901a2589efe92b133b357d2cbc57e@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com> <20190708141140.24379-4-k.konieczny@partner.samsung.com>
In-Reply-To: <20190708141140.24379-4-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 11:02:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd+KKG4kT6OeE4EZkwdhe3i_XoorJm4B+f7OUi09VOUyg@mail.gmail.com>
Message-ID: <CAJKOXPd+KKG4kT6OeE4EZkwdhe3i_XoorJm4B+f7OUi09VOUyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: exynos: add initial data for coupled
 regulators for Exynos5422/5800
To:     k.konieczny@partner.samsung.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
> bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
> be in 300mV range.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 34 +++++++++----------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  4 +++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |  4 +++
>  arch/arm/boot/dts/exynos5800.dtsi             | 32 ++++++++---------
>  4 files changed, 41 insertions(+), 33 deletions(-)

Looks good, I assume bisectability is not affected, because of
dependency on the driver changes I will take it for next next release
(v5.5). Assuming that driver change goes into v5.4.

Best regards,
Krzysztof
