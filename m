Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAADDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A7A208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355412;
	bh=UjqVqgdhztbhUdrL+ufrQI7PcTgq8W31OFAvib2seIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhfRA16Cq4uBNBJ1HzJi+fOv3VBkH0sZYXuJWMu1I2SaVyKeTnVnJ2Qk9v9xKPEJO
	 7S7iFcecEpUISEAnhB7gb/ZBuayhZMDvwSHDyTXN1arhLfmB+zRl6jP4e+veEoeWjk
	 e3967WZgHGOJhY2ren03SrNEA0TGoWfx+40sYDAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfKJDKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfKJCoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:44:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7844221848;
        Sun, 10 Nov 2019 02:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353855;
        bh=UjqVqgdhztbhUdrL+ufrQI7PcTgq8W31OFAvib2seIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G28Xl2AV5e8IcUYGHvfgOMVTiuu+WUvvARYikBfTNH61saPNfx6f4fwcW9CYM7ABf
         MK6Bar4JyVa0MqNXKizeV0HZSd+Z9WfStE1hC39UA43qS1cUUF2lFMxktR9bIzd2cY
         fCB265F1EVeNAN/+2B8V2krxR8uod3tDrl/BxGQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 140/191] ARM: tegra: apalis_t30: fix mcp2515 can controller interrupt polarity
Date:   Sat,  9 Nov 2019 21:39:22 -0500
Message-Id: <20191110024013.29782-140-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

[ Upstream commit b38f6aa4b60a1fcc41f5c469981f8f62d6070ee3 ]

Fix the MCP2515 SPI CAN controller interrupt polarity which according
to its datasheet defaults to low-active aka falling edge.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e749e047db7ab..f810bbf8212bd 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -659,7 +659,7 @@
 			reg = <1>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_RISING>;
+			interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
@@ -674,7 +674,7 @@
 			reg = <0>;
 			clocks = <&clk16m>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_RISING>;
+			interrupts = <TEGRA_GPIO(W, 2) IRQ_TYPE_EDGE_FALLING>;
 			spi-max-frequency = <10000000>;
 		};
 	};
-- 
2.20.1

