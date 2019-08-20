Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE6C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1162822DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mPg2aaUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfHTOk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:40:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51702 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfHTOk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:40:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so2571751wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jltHvKjAETJIx5Aet1GM8of7AnTVjLWtzilPhXCAmqM=;
        b=mPg2aaUcDg9KPuw/ljLGLzHEcQaFd1NWEWs3t2VQLRZI8Xd2HImbkHIX6nScifgjdZ
         1NG7y5ix+iuzhExQIMYUYT+WxNMGQ1m1TmPkANC/TI0KIR8LUT0Xxyw3PjmdJVdSonGs
         QmJ9NNUpJ4oaZ1cv7pacPq8JqqOb+KGm42I7ZKBPbo5aW5tafgTPjvHJw6rpdXtHLxRg
         5uk/udLjT8NimcTB4a9ncKfuk2PoqSSljGseBqjWL+fa9E3hEjn9gQ2qY8yrcxKD4qO/
         /ICO76K3nEL0jBQ92+a2QlF42DVj6BKq9/1KmqTffu3/EJwtafChhjP3c+HYXh0XR9h7
         ezQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jltHvKjAETJIx5Aet1GM8of7AnTVjLWtzilPhXCAmqM=;
        b=a9k6afk38y9+L8tQ4NtYwXti6ZQeumP7mfJp+GpM8ZejW2XgZwx0FhXaEUEEllLsK7
         eQq40Vviifd+gQFFrMXQo2CS3RcofA+8m9TkHsp3X/fQO+43vwfTbvcdfMF8oafhEcHn
         +N7RQyaHLaO6NATogqljzfXyGcskHmflhup0EHZIsxJTrQY9WdA+hrhpbcegbTh9Euc/
         /JdVxaNjAScfZaVwdhTrJdV5T1WyrIrk6N/X/1tRe2dHlVrQMl0QVCJAK1V+62VsYbOA
         gwaBIbDF+ccsLwLyWfTTU3OKZSbTpLRs0RHKYc75d0aXnb1kSl/0c30QGHntUUBlwbNi
         JPjg==
X-Gm-Message-State: APjAAAXEQu3vIIJcUrwTSUIPabxOIUtH4QsEhI2WXejRle7hQSp0Ybwq
        HzcGXYAOEmzI0AbVSXosIVQgfg==
X-Google-Smtp-Source: APXvYqzUXEINr7YBgbQt2flcEowzuqsRnsIwXi4jeC62BVn9us9eqyO5LZjv+Whh8Im/bLMUexKj4w==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr349178wmb.41.1566312055209;
        Tue, 20 Aug 2019 07:40:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a18sm21826750wrt.18.2019.08.20.07.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 07:40:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: Add support for Amlogic SM1 SoC Family
Date:   Tue, 20 Aug 2019 16:40:46 +0200
Message-Id: <20190820144052.18269-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Amlogic SM1 SoC Family is a derivative of the Amlogic G12A
SoC Family, with the following changes :
- Cortex-A55 cores instead of A53
- more power domains, including USB & PCIe
- a neural network co-processor (NNA)
- a CSI input and image processor
- some changes in the audio complex, thus not yet enabled
- new clocks, for NNA, CSI and a clock tree for each CPU Core

This serie does not add support for NNA, CSI, Audio, USB, Display
or DVFS, it only aligns with the current G12A Support.

With this serie, the SEI610 Board has supported :
- Default-boot CPU frequency
- Ethernet
- LEDs
- IR
- GPIO Buttons
- eMMC
- SDCard
- SDIO WiFi
- UART Bluetooth

Audio (HDMI, Embedded HP, MIcs), USB, HDMI, IR Output, & RGB Led
would be supported in following patchsets.

Dependencies:
- g12-common.dtsi from the DVFS patchset at [1]

Changes from rfc at [2]:
- Removed Power domain patches & display/USB support, will resend separately
- Removed applied AO-CEC patches
- Fixed clk-measure IDs
- Collected reviewed-by tags

[1] https://patchwork.kernel.org/cover/11025309/
[2] https://patchwork.kernel.org/cover/11025511/

Neil Armstrong (6):
  soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
  dt-bindings: soc: amlogic: clk-measure: Add SM1 compatible
  soc: amlogic: clk-measure: Add support for SM1
  dt-bindings: arm: amlogic: add SM1 bindings
  dt-bindings: arm: amlogic: add SEI Robotics SEI610 bindings
  arm64: dts: add support for SM1 based SEI Robotics SEI610

 .../devicetree/bindings/arm/amlogic.yaml      |   5 +
 .../bindings/soc/amlogic/clk-measure.txt      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-sm1-sei610.dts     | 300 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  68 ++++
 drivers/soc/amlogic/meson-clk-measure.c       | 134 ++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        |   2 +
 7 files changed, 511 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi

-- 
2.22.0

