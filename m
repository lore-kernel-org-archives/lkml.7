Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vWSg8wKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfHTNQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:16:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTNQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:16:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so12350266wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9qx4eMERV4IYSxubbJ9kymQuWPOVCkxnIO1q9A2cokQ=;
        b=vWSg8wKkLC+Q2n3D8QUTcZRdX2JVEE3J2rLrIPwBjBAfQaMWu67tDpIq8ee/CUWRVI
         RTDDfRbnTnvTwAXuXAkDLLOJ6NIM2+GCaNMLlX+oJqccI1dwdJCQeR3q4l3hLf+0k8R/
         WfttgLU3RzKiyzTRlco5dRx+PvX6d3flpD4Fp5LiyjVAx1ozm1ivjyHl1ynPC5/vs2HG
         ruvMPISG0/7yhwebAPIBHh2t470bkF9mRDnI7odqkSAd1VYfPXaOLohM8pHKzeh5IJmQ
         LMgG7AZKzSIyo3gf7s9vvcCtI9JeMbcSS4Ejl+fc6xVnC49vSmWM1yZ+trLqWgaeFZDH
         /TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9qx4eMERV4IYSxubbJ9kymQuWPOVCkxnIO1q9A2cokQ=;
        b=GS5P+r1SdWpC1cvGdRWt+gfvMK5iaBOBfgAvmzl/jNAsndOMKDMVQlqTi2413aAidD
         Iz7x0kMjC3EV3wgXfC44+WyaUwLkLb8qHbTWYCLFglDJfGIWFbQ8cScLeJb1QTYetiuR
         GQggPwIOgANHiY4KejXIdCNjAjvE17nEbo2uH3o01Be3HeDeYQdjX/JhRMDdGX6EjsH1
         LXkvaSAFILGYJJIQXTRKqjvRpJjBYEGBtbEABk6xXhH5h3H2DPbTU+pOOFEyLNzZ1a6O
         jbz5yvtePiKFdnsfiT4heRuyvMKwCHdKe9h/dd7/KcDxDvxUXbAR+Tf8HwX2z3jHrCN2
         Yxhg==
X-Gm-Message-State: APjAAAWMuIzB6leFIB7J/CEu17uH5hI0xCHBWgHzTncGVYpSKeMUJFfb
        0FuH83aJKMOK7x0v6OSdkCRSx//tI1x6Fg==
X-Google-Smtp-Source: APXvYqyXs7pIVMqpwrAgZepW9zZ8Bkzc64T4uhTcQwCeDt52DU4X/tVmTamdwwNqzNtkjq6yyFlkCg==
X-Received: by 2002:a5d:6a12:: with SMTP id m18mr34553082wru.306.1566307007265;
        Tue, 20 Aug 2019 06:16:47 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c187sm24644224wmd.39.2019.08.20.06.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 06:16:46 -0700 (PDT)
Subject: Re: [RFC 00/11] arm64: Add support for Amlogic SM1 SoC Family
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190701104705.18271-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <66111697-00b8-4874-f7f9-bc8573e562c7@baylibre.com>
Date:   Tue, 20 Aug 2019 15:16:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190701104705.18271-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He Kevin, Martin,

On 01/07/2019 12:46, Neil Armstrong wrote:
> The new Amlogic SM1 SoC Family is a derivative of the Amlogic G12A
> SoC Family, with the following changes :
> - Cortex-A55 cores instead of A53
> - more power domains, including USB & PCIe
> - a neural network co-processor (NNA)
> - a CSI input and image processor
> - some changes in the audio complex, thus not yet enabled
> - new clocks, for NNA, CSI and a clock tree for each CPU Core
> 
> This serie does not add support for NNA, CSI or DVFS, it only
> aligns with the current G12A Support.
> 
> With thie serie, the SEI610 Board has supported :
> - Default-boot CPU frequency
> - 4k60 HDMI without audio
> - USB3 & USB-C OTG
> - Ethernet
> - LEDs
> - IR
> - GPIO Buttons
> - eMMC
> - SDCard
> - SDIO WiFi
> - UART Bluetooth
> 
> Audio (HDMI, Embedded HP, MIcs), IR Output, & RGB Led would be
> supported in following patchsets.

Following the comments in the power domain patches, I'll respin in 2 distinct
patches :
- initial support without USB, Display & power domain updated
- power domain support with USB & Display support

Neil

> 
> Dependencies:
> - g12-common.dtsi from the DVFS patchset at [1]
> 
> [1] https://patchwork.kernel.org/cover/11025309/
> 
> Neil Armstrong (11):
>   soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
>   dt-bindings: power: amlogic, meson-gx-pwrc: Add SM1 bindings
>   soc: amlogic: gx-pwrc-vpu: add SM1 support
>   soc: amlogic: Add support for SM1 power controller
>   dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
>   soc: amlogic: clk-measure: Add support for SM1
>   dt-bindings: media: meson-ao-cec: add SM1 compatible
>   media: platform: meson-ao-cec-g12a: add support for SM1
>   dt-bindings: arm: amlogic: add SM1 bindings
>   dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
>   arm64: dts: add support for SM1 based SEI Robotics SEI610
> 
>  .../devicetree/bindings/arm/amlogic.yaml      |   5 +
>  .../bindings/media/meson-ao-cec.txt           |   8 +-
>  .../bindings/power/amlogic,meson-gx-pwrc.txt  |  35 ++
>  .../bindings/soc/amlogic/clk-measure.txt      |   1 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../boot/dts/amlogic/meson-sm1-sei610.dts     | 329 ++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  77 ++++
>  drivers/media/platform/meson/ao-cec-g12a.c    |  37 +-
>  drivers/soc/amlogic/Kconfig                   |  11 +
>  drivers/soc/amlogic/Makefile                  |   1 +
>  drivers/soc/amlogic/meson-clk-measure.c       | 134 +++++++
>  drivers/soc/amlogic/meson-gx-pwrc-vpu.c       | 120 +++++++
>  drivers/soc/amlogic/meson-gx-socinfo.c        |   2 +
>  drivers/soc/amlogic/meson-sm1-pwrc.c          | 245 +++++++++++++
>  include/dt-bindings/power/meson-sm1-power.h   |  15 +
>  15 files changed, 1017 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
>  create mode 100644 drivers/soc/amlogic/meson-sm1-pwrc.c
>  create mode 100644 include/dt-bindings/power/meson-sm1-power.h
> 

