Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C5FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9195A2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214602;
	bh=J8Af5rd+geu2PFA2CWpOAT2ClSBICxyzyklJSlfvkZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kd008D4XvlBMh6qjpz5PU3sy31qJAEKkZwrj1wpQ9hIkgm2fRC4qxcCErwLj76+jM
	 kpBn9kN97hlEliq8ufCmjWVtC84gkUaEEGMurkc5qmTuyzUjyqSU2GZvTIu1WFb1rT
	 Uinw36IkU2O+lirDwyXLxftzpomI1um7F96dxg6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbfKHMDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390141AbfKHLmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2864222CF;
        Fri,  8 Nov 2019 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213364;
        bh=J8Af5rd+geu2PFA2CWpOAT2ClSBICxyzyklJSlfvkZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQSBPKQPEEioI0jnKOOvHfu3j6T88Sdt+2xkQkc2v6qE/vtdV1CAFQtDdzGVoAWRf
         wniNULcPVJxluGZA5+Rn/XpyLXLEsr0qBHBfFaJQ/mKAMvbZocWd7yRdeqt4RwcMuf
         aWMtt78t2PQJ7bdvIHE0kAy1MXJ6UkEaYVOvusbM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 192/205] arm64: dts: meson: Fix erroneous SPI bus warnings
Date:   Fri,  8 Nov 2019 06:37:39 -0500
Message-Id: <20191108113752.12502-192-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 68ecb5c1920c5b98b1e717fd2349fba2ee5d4031 ]

dtc has new checks for SPI buses. The meson dts files have a node named
spi' which causes false positive warnings. As the node is a pinctrl child
node, change the node name to be 'spi-pins' to fix the warnings.

arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: Warning (spi_bus_bridge): /soc/periphs@c8834000/pinctrl@4b0/spi: incorrect #address-cells for SPI bus

Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 98cbba6809caa..1ade7e486828c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -390,7 +390,7 @@
 			};
 		};
 
-		spi_pins: spi {
+		spi_pins: spi-pins {
 			mux {
 				groups = "spi_miso",
 					"spi_mosi",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c87a80e9bcc6a..8f0bb3c44bd6d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -337,7 +337,7 @@
 			};
 		};
 
-		spi_pins: spi {
+		spi_pins: spi-pins {
 			mux {
 				groups = "spi_miso",
 					"spi_mosi",
-- 
2.20.1

