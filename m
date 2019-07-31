Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17985C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD48D206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KJZc4a+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGaMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54018 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfGaMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so60679159wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWI8GcxEz+8gc9lvCcOoQING9GchM8UZJzjKufeSqmc=;
        b=KJZc4a+DmVn+4+DGSWDg3GlzhLG6glcKG0j5wUAHME+JibRtdrXRNjSx+a7MyRFDuI
         hd9NV9MqzrJ/yfhsVmI9FywxsVr8GndD0kH+2ROkya1T14Jp7p2MDg0M9asAFCeTsBOp
         6xgrnxr12N5wi8/DD0EsAOL4YSdL51rXYOv4g3mJ+5yoqYlFDs9cZ5oz9Gp32hG3cL2l
         Kqamv6Q1+LgceZ1bIeqvgoTi0+iVmCw4OHvf9OwuAMQBQOXO/8BSoIHiC6NcngAl40Hv
         QBl3FZ8ix9alal5rJIZ0/1oOJ+GxtrSvzwFXNioZ0F2lX78iYTH1+d8jz2zSAL/GpAnb
         YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWI8GcxEz+8gc9lvCcOoQING9GchM8UZJzjKufeSqmc=;
        b=RWvRZWodHtYXF/LQUEgs4QZpuHGgORQB8xUQYpzDVGpVJd91uUTYNsLiGrx2OxvSF8
         o1mMYFoOU9MIWf9N1FGfLbG4Ay34FPSAWa8MRHhkQdAY1RoOCwa9CpjCitEIG5NHhC8+
         1SAiNKZB8QAstFLXVRCfh1FxjsTxZXBT7IJ8skxyqYKpigJXwmSJUQLK+8MDmmGB+/0q
         haRZbU1EXqC9rgouoeUYIXgOIOWGcmWMsaA5CPMSbrWdFHlbZSFDVThyeZgR7Utb2pb/
         gN0PjGpctlx2lbflIIM36LxFs6hLt0xznlAmloNBg/GAsd2usu/63sDADuzFfVXsRYZ1
         OzAw==
X-Gm-Message-State: APjAAAXJUvLS228fa7dtWr0FGsaMJJClBraXXorXJxhPJ+RBwLJl6cqF
        ASfk/c+JvQtc+F+HNmOowzbfDhl+7ic=
X-Google-Smtp-Source: APXvYqy978uWNvioeZ+pGIg+DyWJ20pUO7ItCJsalId7cA/5/FSwIaSFd8Ad245l+bIIqRqGxzP6Aw==
X-Received: by 2002:a1c:1d4f:: with SMTP id d76mr15481312wmd.127.1564576803831;
        Wed, 31 Jul 2019 05:40:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 0/6] arm64: add support for the Khadas VIM3
Date:   Wed, 31 Jul 2019 14:39:54 +0200
Message-Id: <20190731124000.22072-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM3 uses the Amlogic S922X or A311S SoC, both based on the
Amlogic G12B SoC family, on a board with the same form factor as the
VIM/VIM2 models. It ships in two variants; basic and
pro which differ in RAM and eMMC size:

- 2GB (basic) or 4GB (pro) LPDDR4 RAM
- 16GB (basic) or 32GB (pro) eMMC 5.1 storage
- 16MB SPI flash
- 10/100/1000 Base-T Ethernet
- AP6398S Wireless (802.11 a/b/g/n/ac, BT5.0)
- HDMI 2.1 video
- 1x USB 2.0 + 1x USB 3.0 ports
- 1x USB-C (power) with USB 2.0 OTG
- 3x LED's (1x red, 1x blue, 1x white)
- 3x buttons (power, function, reset)
- IR receiver
- M2 socket with PCIe, USB, ADC & I2C
- 40pin GPIO Header
- 1x micro SD card slot

First of all, the S922X and A311D are now specified since they differ
by some HW features and the capable operating points.

A common meson-g12b-khadas-vim3.dtsi is added to support both S922X and
A311D SoCs supported by two variants of the board.

Odroid-N2 is changed to use the s922x.dtsi include.

Dependencies:
- patch 5 & 6: "arm64: g12a: add support for DVFS" at [1]

[1] https://patchwork.kernel.org/cover/11063837/

Christian Hewitt (4):
  soc: amlogic: meson-gx-socinfo: add A311D id
  dt-bindings: arm: amlogic: add support for the Khadas VIM3
  arm64: dts: meson-g12b: support a311d and s922x cpu operating points
  arm64: dts: meson-g12b-khadas-vim3: add initial device-tree

Neil Armstrong (2):
  dt-bindings: arm: amlogic: add bindings for G12B based S922X SoC
  dt-bindings: arm: amlogic: add bindings for the Amlogic G12B based
    A311D SoC

 .../devicetree/bindings/arm/amlogic.yaml      |   9 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  15 +
 .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 149 +++++
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 542 ++++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |   2 +-
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |  15 +
 .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 124 ++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   | 115 ----
 drivers/soc/amlogic/meson-gx-socinfo.c        |   1 +
 10 files changed, 858 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi

-- 
2.22.0

