Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875692075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zlONF8A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfC0KdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:33:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0KdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:33:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so15586767wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o137uva63juW93zS7C+0X9Xktfg/ljv44fOwKD1OTCM=;
        b=zlONF8A3Nt8bDK5P9VU0SFMt96DS+Y3By+98O1lbKJN0YDlsMnXavpm++5/mMToNKa
         JTQGB4RvIMzqYSX4qdHDuKRTlmbj9AeAoH6R1vn5bqkLyxDhuh/Ifgx5OfUl0KUPOUj7
         l7ytOEH9wcuzgNDJqfFOZmMs+b8HJ1ZhSlcdNQBPQrRe7L0PDWGkR5lzhRU2yMuAD5NK
         0eP1Zrc85PIUYRyFJDhcVY92+J7dFhU32sz56xVT82E/BN5toIp1PhUVRXsLb+pjJPdo
         V3xB6vg1m4xTmDSkZV4qrDvuOn2pgL+gtX0F1WpxIfT1A2waUnKjvk42UQFMvnbLoU/a
         08tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o137uva63juW93zS7C+0X9Xktfg/ljv44fOwKD1OTCM=;
        b=m4dYKZV2fdP0uCIR+k7IfolJW34KOR0BxzRSRZ6pdqn5rtLvonZ/MDUtVMQ4jKJmMT
         dY/8TTo1DlUILsPkp0FaCgUkldMFVaAYwk6UioiTiyYBTyTFGIUTxFk6N0AryOotoUiu
         +Fk36nxVPALaBNfMFP3QWnY0h77po5vOeGDcw70fVv9aWfnJClR2JkYRFhQ3o+QFyCa1
         dMcs8a04WMO8j0GY8w1w7cvQSjo5L8wMKo2kMb5z+xdpcz/KDe/77Dawf222NDukBhip
         oX093PuAzi854d8skRlxZ/STwp1UY61gZsMFSZ0/rwM3zCzY78jVGjOhScS60VQTMyyc
         7GWw==
X-Gm-Message-State: APjAAAXRVJ91C0WBNOw74iXYGgNBC77zA3OxaNRkPlNl9zfHOKMQ30c4
        uAVg8obXiuZ5ng9WY58Oedf1qg==
X-Google-Smtp-Source: APXvYqxBjvjVbbq2HrJnePVNzZsvZDvrKjzkQS4V25pQD2mdZxL4dsYp9YbkWpTCjPon63XiuOUFcQ==
X-Received: by 2002:a1c:9c0e:: with SMTP id f14mr18752585wme.78.1553682790182;
        Wed, 27 Mar 2019 03:33:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a20sm27017513wmb.17.2019.03.27.03.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:33:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/6] arm64: Add initial support for Odroid-N2
Date:   Wed, 27 Mar 2019 11:33:02 +0100
Message-Id: <20190327103308.25058-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds basic support for :
- Amlogic G12B, which is very similar to G12A
- The HardKernel Odroid-N2 based on the S922X SoC

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture, but with these differences :
- The first CPU cluster only has 2xCortex-A53 instead of 4
- G12B has a second cluster of 4xCortex-A73
- Both cluster can achieve 2GHz instead of 1,8GHz for G12A
- CPU Clock architecture is difference, thus needing a different
  compatible to handle this slight difference
- Supports a MIPI CSI input
- Embeds a Mali-G52 instead of a Mali-G31, but integration is the same

Actual support is done in the same way as for the GXM support, including
the G12A dtsi and redefining the CPU clusters.
Unlike GXM, the first cluster is different, thus needing to remove
the last 2 cpu nodes of the first cluster.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Neil Armstrong (6):
  dt-bindings: clk: meson: add g12b periph clock controller bindings
  clk: meson: g12a: Add support for G12B CPUB clocks
  clk: meson: g12a: mark fclk_div3 as critical
  dt-bindings: arm: amlogic: add G12B bindings
  dt-bindings: arm: amlogic: add Odroid-N2 binding
  arm64: dts: meson: Add minimal support for Odroid-N2

 .../devicetree/bindings/arm/amlogic.txt       |   6 +
 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 178 +++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++
 drivers/clk/meson/g12a.c                      | 466 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  20 +-
 7 files changed, 753 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

-- 
2.21.0

