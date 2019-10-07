Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A013DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CA422473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570431972;
	bh=8sW/Eg/VYWUda4EhYFmrvqzQ7MKg2MNc3wIOjrczV4U=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=HNYcbm9J+2DEWPlwA47qeojAQ9rzxWcVQyhQg92hkNTWecAEh0bEzFpJcNbXxBmt3
	 K0garZWP5V6sbNfHBKnEVh+KXW38CcWPGyzO4NxayAcN6e7OA/+wjilLDKgM2bNGcS
	 ft1X2nZXYQzWFaj9YR3J1SSxZFGdUUdvr5gzXA+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJGHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGHGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:06:11 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D268922477;
        Mon,  7 Oct 2019 07:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570431970;
        bh=8sW/Eg/VYWUda4EhYFmrvqzQ7MKg2MNc3wIOjrczV4U=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Qk/+5g5Wq8zUXSUYr1l4rxDkOzI9ACN3zF36YRTiJ1XqzNvsi+KHYXrjmb30fwamU
         h0Tq5bJnkthn7olqepQjD99tOnNnpiHMJ3L+QLUdKgRTujvLg4KCYC8Q3Sb0W2kRtz
         ZZlCHdZQWlSF96KWX6ejOmJwHiTeCrAcPCXcemqc=
Received: by mail-lf1-f47.google.com with SMTP id u28so8435220lfc.5;
        Mon, 07 Oct 2019 00:06:09 -0700 (PDT)
X-Gm-Message-State: APjAAAV6fKxgfLNWnpT04LER4pDG/C6MAFuRXkhHT+FtEP5YWV/z3Bbk
        HznzxC2SWWctnCPcbItzrXoZRKgTUGwgvUXJfv8=
X-Google-Smtp-Source: APXvYqxAfuauMSQ3WZV1NyYj9PyUVq7AtJqvDHhNdltqqFqN36OPpfEhQ8BKMosonlhMTVdoCco8OINcb6EQinzQB0A=
X-Received: by 2002:ac2:4853:: with SMTP id 19mr15582682lfy.69.1570431967954;
 Mon, 07 Oct 2019 00:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191004150040.5833-1-krzk@kernel.org>
In-Reply-To: <20191004150040.5833-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 7 Oct 2019 09:05:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdgsTTmNs+Q5_sshZQSvCMBge9jkNh0=L6F4VewEeXxbg@mail.gmail.com>
Message-ID: <CAJKOXPdgsTTmNs+Q5_sshZQSvCMBge9jkNh0=L6F4VewEeXxbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Enable options for boards
 with Exynos SoC
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 at 17:00, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Sync with exynos_defconfig and enable following options for Samsung
> Exynos SoC based boards:
> 1. NFC_S3FWRN5_I2C (with NFC stack): Samsung S3FWRN5 NCI NFC Controller,
>    used for example on Exynos5433 (if booted in 32-bit mode),
> 2. S3C2410_WATCHDOG: watchdog driver used on S3C, S5P and Exynos SoCs,
> 3. REGULATOR_S2MPA01: Samsung S2MPA01 regulators driver present on
>    Exynos5260 RexNos REX-RED board,
> 4. SND_SOC_ARNDALE: sound support on Arndale boards,
> 5. EXYNOS_IOMMU: IOMMU driver used on all Exynos SocS,,
> 6. EXTCON_MAX14577, EXTCON_MAX77693 and EXTCON_MAX8997: extcon drivers
>    for handling micro USB on mobile Samsung boards (Trats, Trats2,
>    Rinato),
> 7. PHY_EXYNOS5250_SATA: SATA phy for Exynos5250 present on Arndale and
>    SMDK5250 boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> SND_SOC_ARNDALE is in progress (not yet applied)
> ---
>  arch/arm/configs/multi_v7_defconfig | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 198de8e36d92..7f7978dba8ab 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -168,6 +168,14 @@ CONFIG_MAC80211=m
>  CONFIG_RFKILL=y
>  CONFIG_RFKILL_INPUT=y
>  CONFIG_RFKILL_GPIO=y
> +CONFIG_NFC=m
> +CONFIG_NFC_DIGITAL=m
> +CONFIG_NFC_NCI=m
> +CONFIG_NFC_NCI_SPI=m
> +CONFIG_NFC_NCI_UART=m
> +CONFIG_NFC_HCI=m
> +CONFIG_NFC_SHDLC=y
> +CONFIG_NFC_S3FWRN5_I2C=m
>  CONFIG_PCIEPORTBUS=y
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PCI_TEGRA=y
> @@ -491,12 +499,12 @@ CONFIG_BCM2835_THERMAL=m
>  CONFIG_BRCMSTB_THERMAL=m
>  CONFIG_ST_THERMAL_MEMMAP=y
>  CONFIG_UNIPHIER_THERMAL=y
> -CONFIG_WATCHDOG=y
>  CONFIG_DA9063_WATCHDOG=m
>  CONFIG_XILINX_WATCHDOG=y
>  CONFIG_ARM_SP805_WATCHDOG=y
>  CONFIG_AT91SAM9X_WATCHDOG=y
>  CONFIG_SAMA5D4_WATCHDOG=y
> +CONFIG_S3C2410_WATCHDOG=m
>  CONFIG_DW_WATCHDOG=y
>  CONFIG_DAVINCI_WATCHDOG=m
>  CONFIG_ORION_WATCHDOG=y
> @@ -581,6 +589,7 @@ CONFIG_REGULATOR_QCOM_RPM=y
>  CONFIG_REGULATOR_QCOM_SMD_RPM=m
>  CONFIG_REGULATOR_RK808=y
>  CONFIG_REGULATOR_RN5T618=y
> +CONFIG_REGULATOR_S2MPA01=m
>  CONFIG_REGULATOR_S2MPS11=y
>  CONFIG_REGULATOR_S5M8767=y
>  CONFIG_REGULATOR_STM32_BOOSTER=m
> @@ -711,6 +720,7 @@ CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994=m
>  CONFIG_SND_SOC_SMDK_WM8994_PCM=m
>  CONFIG_SND_SOC_SNOW=m
>  CONFIG_SND_SOC_ODROID=m
> +CONFIG_SND_SOC_ARNDALE=m
>  CONFIG_SND_SOC_SH4_FSI=m
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SOC_STI=m
> @@ -933,7 +943,7 @@ CONFIG_BCM2835_MBOX=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_GART=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
> -CONFIG_REMOTEPROC=y

This appeared here by mistake. It's wrong.

I'll send v2.

Best regards,
Krzysztof
