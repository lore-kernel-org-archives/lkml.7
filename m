Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C477C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDCE20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="poVOrEX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfE0OCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:02:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39569 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0OCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:02:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so11898095wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uTBfIzkKswT7Ff1/QE2n2AouJ/Ougb4/VDEgUdIRqs=;
        b=poVOrEX1TwfxN0/t4+KDONVIES7GtfU0ZA+8LNhgcYVWDVKeytEMClNThxyj0JUlSa
         0dx0wCZKUtXOM76Deh5ALVPWOBovWox8e/5ggcpNpF9wbMdHg/OrOZyRS8Q3kIR2g5hS
         XJ5LJZ8oLCDV/A5f8z7AiD1TDA4nmYD7GexXPgB/byniXe3TyBtOJ/SFHXo71qBXJo/c
         C/Ix1NFkPeD4JEqNQcqAoJ8KL2m1/4hBV06KI6q+dt0azYDKwpt5/na1H11V/EE/5+gF
         lzAeWOJ/AtqWs1bGJUZ+oUsOJzz51VV357ESWnForolZ/GnT3WNxDI2srGDEKtM17TvJ
         os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uTBfIzkKswT7Ff1/QE2n2AouJ/Ougb4/VDEgUdIRqs=;
        b=B70ys/QyylzGhbRY3xNFDYE+kUlEaWUDxiSnzkoHeuPgnC2wWwvpElqqaIbwUDNzk0
         CuRJWpanNcEO8oSIf9906adM5vTpuHZQJPB5qnt+moc2R+pGL22ThvnHziNeBCayZK9d
         E/Ll3CeZU027WiE9YtFNhQUkZSD2nyCawAAXDwjE5oHDcdAijKP4Nl8Cejd7htLKZHyo
         bgkIIisdKsuuT6CwiJcfkz/7LnFcVfTgcs3khAb13OW0GQMcXFrCiNAjYTP0StwaVk7+
         4RAg2SLLjmsu1X6/4F/1dOVQ6bX8DxQOQI4gDzlLowwkAeYyo2NLdVOTs4hVfL7O5phf
         jnvA==
X-Gm-Message-State: APjAAAX4ABmjP9sPJNiEQkHcGfned1alAtPZwFmdRXCB17AZKqBbm5Dg
        3voY0WbtMubz1/ClDL/PB+CKbg==
X-Google-Smtp-Source: APXvYqzOpNufEDr+eiQXqZvSsV1YciB2MT0meHySLn86nd8G7TrvMMyWvAGHcfExDUbQ9R5TEgTCEA==
X-Received: by 2002:a1c:65c3:: with SMTP id z186mr1504553wmb.116.1558965730045;
        Mon, 27 May 2019 07:02:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s17sm8231628wmj.15.2019.05.27.07.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 07:02:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: Add initial support for Odroid-N2
Date:   Mon, 27 May 2019 16:02:03 +0200
Message-Id: <20190527140206.30392-1-narmstrong@baylibre.com>
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

Dependencies :
- Patch 1, 2 : YAML rewrite of amlogic.txt bindings at [7]
- Patch 3 : None since clock + g12b bindings has been acked

Changes since v3 at [8]:
- Dropped arm,armv8
- Dropped eee disable, not needed in further tests
- Add comments about where are connected the regulators pins
- Moved the phy0 regulator to the usb vbus regulator

Changes since v2 at [5]:
- sent the clk patches in standalone at [6]
- rewrote the bindings on top of the YAML rewrite at [7]
- Added MMC, SDCard and Network support to Odroid-N2

Changes since v1 at [3]:
- Renamed the g12b cpu clocks like g12a counterparts
- Rebased clock patches on top of Guillaume's Temperature sensor Clock patches at [4]
- Added AO-CEC-B support to N2 DTS

Changes since RFC at [1]:
- Added bindings review tags
- Moved the fclk_div3 CRITICAL flags to the gate
- Removed invalid CRITICAL flags on the cpu clocks

[1] https://lkml.kernel.org/r/20190327103308.25058-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190325145914.32391-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190404150518.30337-1-narmstrong@baylibre.com
[4] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com
[5] https://lkml.kernel.org/r/20190423091503.10847-1-narmstrong@baylibre.com
[6] https://lkml.kernel.org/r/20190521150130.31684-1-narmstrong@baylibre.com
[7] https://lkml.kernel.org/r/20190517152723.28518-2-robh@kernel.org
[8] https://lkml.kernel.org/r/20190521151952.2779-1-narmstrong@baylibre.com

Neil Armstrong (3):
  dt-bindings: arm: amlogic: add G12B bindings
  dt-bindings: arm: amlogic: add Odroid-N2 binding
  arm64: dts: meson: Add minimal support for Odroid-N2

 .../devicetree/bindings/arm/amlogic.yaml      |   6 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 288 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
 4 files changed, 377 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

-- 
2.21.0

