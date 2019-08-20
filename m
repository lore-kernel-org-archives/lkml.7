Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E325C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4767222DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J3N1iqC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbfHTTZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:25:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34772 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHTTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:25:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so3785145pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=04NKhJxX8FlEE8Vel6IHRyr5QWy4tlrGyOfc2JJ0jY8=;
        b=J3N1iqC05G6BlmLY4sLgvPQbfCir9vXlmBgMbXeWoxCrQa0sEfQpvhYryRBxbpnicF
         KuOORxmryuKtItZFU2oRa2OxtQ6WYJdfy4KqAlR2aknhG0Ab2oSROSnsMaM5LCMBouak
         dpqJizoos6Rol3qdOszaw0O39xHjE0bLSATnqqkLejapRal6IhjmidcjQfjgrXss2r6p
         QP3mdqabnWQ/YoB+hjzaku4yxydrxtd39ko7iH9m2Er7EcnN3Q1EasG3/xHdEtFeXFTh
         sQ8AQI1cuLQogqOlgvFwDghCB/7/gQVaL+zTpm02z2j/S/W04vELGTODYaqgexISopwH
         1lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=04NKhJxX8FlEE8Vel6IHRyr5QWy4tlrGyOfc2JJ0jY8=;
        b=a/A28BVNyZOKGSXLd/Df15p/+CkCh0cDOpmpSwmjccTjIPgMBw+slsoQWkaBJZiT6g
         w+KNpxO8MV8z/0YM5jC6+cW7R0TleLPC/Xm9icu7WSn9VkJp8cYoefweKUF5MQQvR2o0
         m4mII5TZE7cadwfo1OPuym1NgAMI2sLCRAExe2k5BLWSt3xExNNLK676w8PrinXTr6WH
         h5d4hiBLHoaRP54XzT+TdKs+BfWJs47eC4OVptTQna0JxE6RwT1QXd6P03GRsmUQFz6L
         N3kuo9tIc03OwY24T5nPXjynIaGxdVHI8+h3fSRVQccek6s28TxpbwTAgsDlUphGGKnD
         386g==
X-Gm-Message-State: APjAAAUUcH52J5yrI3zw6Ca70qrIdUoDOL34F7fp0rVz/bD7q1vDR96/
        OrM9HqG5SQbX4Owzv50gNv1tTQ==
X-Google-Smtp-Source: APXvYqy9P1Z7fPZd3rUvC8bVlPpzVMI8dViZMXku+yepBg0LQT84LhZxNW32ze6tSrgL8aSDhcSDjA==
X-Received: by 2002:a62:c584:: with SMTP id j126mr31758938pfg.21.1566329120713;
        Tue, 20 Aug 2019 12:25:20 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w207sm21516280pff.93.2019.08.20.12.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 12:25:20 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: Add support for Amlogic SM1 SoC Family
In-Reply-To: <20190820144052.18269-1-narmstrong@baylibre.com>
References: <20190820144052.18269-1-narmstrong@baylibre.com>
Date:   Tue, 20 Aug 2019 12:25:19 -0700
Message-ID: <7h4l2bej1c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The new Amlogic SM1 SoC Family is a derivative of the Amlogic G12A
> SoC Family, with the following changes :
> - Cortex-A55 cores instead of A53
> - more power domains, including USB & PCIe
> - a neural network co-processor (NNA)
> - a CSI input and image processor
> - some changes in the audio complex, thus not yet enabled
> - new clocks, for NNA, CSI and a clock tree for each CPU Core
>
> This serie does not add support for NNA, CSI, Audio, USB, Display
> or DVFS, it only aligns with the current G12A Support.
>
> With this serie, the SEI610 Board has supported :
> - Default-boot CPU frequency
> - Ethernet
> - LEDs
> - IR
> - GPIO Buttons
> - eMMC
> - SDCard
> - SDIO WiFi
> - UART Bluetooth
>
> Audio (HDMI, Embedded HP, MIcs), USB, HDMI, IR Output, & RGB Led
> would be supported in following patchsets.
>
> Dependencies:
> - g12-common.dtsi from the DVFS patchset at [1]
>
> Changes from rfc at [2]:
> - Removed Power domain patches & display/USB support, will resend separately
> - Removed applied AO-CEC patches
> - Fixed clk-measure IDs
> - Collected reviewed-by tags
>
> [1] https://patchwork.kernel.org/cover/11025309/
> [2] https://patchwork.kernel.org/cover/11025511/

Series queued for v5.4...
> Neil Armstrong (6):
>   soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
>   dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
>   soc: amlogic: clk-measure: Add support for SM1

... these 3 in v5.4/drivers ...

>   dt-bindings: arm: amlogic: add SM1 bindings
>   dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
>   arm64: dts: add support for SM1 based SEI Robotics SEI610

... and these 3 in v5.4/dt64 with Rob's tag.

Thanks,

Kevin
