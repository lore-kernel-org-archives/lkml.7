Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49947C2D0C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA162053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 10:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fcSvCZuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJKRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:17:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54204 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfLJKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:17:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id n9so2481252wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 02:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xmLlcTghzPFIQ8mfUoSKx274MOGK7c0q1BOLA3zin5c=;
        b=fcSvCZuDu/jCInvDVS5idg2zFC+JxUezgWsEzS5YwYFM1JFAhzC92Nm24kZZOmk094
         RfkjjBX4Tl7pVGKiTXkb6ZXjC8C5cdJ/xvvMdZu5xSlYUlCaPYcv4skpDFMDdUy6wKkE
         j81+cogTRKJl+jY4iIEWkAoeVhuzbSa1Sg3rYZ2J/NAC82qC8k4qMSaQ9SRIMQ1Xs9VM
         XIeopc2OHN73WVTc7bcO1iL6c8KxgROgkxyPTdf8WVQ+OZrbg/S39bH4Efd6uV/iI781
         OYm3bzPYAf5N4zJXWgkloQEMKq6WKNRc1Jp54ueSiHCXeH4J9ka0xLNn64pC13mRi3qz
         2oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xmLlcTghzPFIQ8mfUoSKx274MOGK7c0q1BOLA3zin5c=;
        b=i/p1qX5No6ZqVN08xBuPD/AFR/knJxh0IQBP961n+8dmzsqPditqnNk2og5kj0fwnN
         99Xr29Qaals4x+vUi70y4m1nvfpgruzTKZtSZ+Orh/thGzcToyjrIzvm+2HZRDYhPbam
         Roq/MJ1THB5Jasxy8VqaFRRO/d7hEnLOcRS+cwFw6aDZHnYesCkJobz5JnipeYXM5oK5
         RlsMcY+GwtN1Xd9+N7NfFazvG/g8Iiefvxsh7EHAtCNIJ5E69thz2h9JqACCgmRlpsR7
         3wxCFGc8HyZZrzE+93AhG4Rx7VC+OQQmnYh4tfpYaetMSqBr+5rdtAVH2nFNMWVcbxfw
         VIdQ==
X-Gm-Message-State: APjAAAVsNhFVvM7X4WzUwUDCz1uRTjc6/hACZH0P2TTE4JH3c6MxwcFQ
        iCFrEG1I4S3BFJdgTovtWeehew==
X-Google-Smtp-Source: APXvYqwVnyN4tOCPyX/fALkBBhtIPe2HLM6zr6GYhucBkFtEKMV/e/35eKhQlSa5MVPgf6uQKl+RIQ==
X-Received: by 2002:a05:600c:507:: with SMTP id i7mr4398123wmc.135.1575973037693;
        Tue, 10 Dec 2019 02:17:17 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm2697067wrw.76.2019.12.10.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:17:17 -0800 (PST)
References: <20191202111253.94872-1-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-a1: add I2C nodes
In-reply-to: <20191202111253.94872-1-jian.hu@amlogic.com>
Date:   Tue, 10 Dec 2019 11:17:16 +0100
Message-ID: <1j8snkh4cz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 02 Dec 2019 at 12:12, Jian Hu <jian.hu@amlogic.com> wrote:

> There are four I2C controllers in A1 series,
> Share the same comptible with AXG.The I2C nodes
> depend on pinmux and clock controller.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 149 ++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index eab2ecd36aa8..d0a73d953f5e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -16,6 +16,13 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +	};
> +

I wonder if assigning i2c bus alias in the SoC dtsi is such a good idea.

Such aliases are usually assigned as needed by each board design:
meson-a1-ad401.dts in your case.
