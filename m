Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97403C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D6E2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYU6vlIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfDASUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:20:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40930 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfDASUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:20:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so452213wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSh5VVkG9WipijbhAmyfU9722WPS5gvQw5koNSuFkG0=;
        b=GYU6vlIcs5FpHcGpqJxeul7ekQGSiEZ7VXOdwyXb0idZrG2JOVbgtju4qj6U1sDp87
         95cjAv3oUhfC8aw1Ae8UacYGOOoSMBLiw50ppzcLVU+Igslr0j0dPRYGzwmTnv+WXpAA
         BdI/kRI+4nPdg/a3A6w6f7EPcn8vgmVdhbTmdzI1WPqxd03FD+0rS7XavIWzmhphlH50
         fgronN4aYU3U+9RjF5HH1jYL4Fh7iPJWiUyX+4iN/4hHHEV80TjRfSS4S3lPRk/jlWsI
         AFVr85takNEhloZPPgU3IdYvfi9SFEkg/Ghkbpm41twdkPzlKDzUigD9/9w59XzZjDbC
         raWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rSh5VVkG9WipijbhAmyfU9722WPS5gvQw5koNSuFkG0=;
        b=Qx+xIcViYWKMKgW42lYDGv9TpCiLvfuARrxxWFSG3o6+d3dX/hY5u/gB2GCok8aYzm
         nCuNVcMFNxvT/u2C+kfcZ6dB7hZm3smQJYfE6CsWzibHxVLstXrzFkAg8Wcr2nvCQrmW
         Qb8SViWHD9O9/c/kUd0S+0cB6NhbSqQy1C/ZzQoD/KChl1yEps112+l0x/BbeZNMOMMf
         0MKEzcV2z35c/9n+6RjHjleyO8yslyJOBWdr+NFs/Lw/vouMeUUwmQ3xnxM7J9xETwCn
         MG5H2T7w1sISGimrBxGd9iIlOll02k4m3PW2sHeiiVpkMSsAaDWO1mbWdv8cXkCb0+BX
         GUvg==
X-Gm-Message-State: APjAAAUFOMlLwC4MbKeFn2dJJrDM1sY7AeATk0+WNmJl/xdDnnplY1B5
        f9260nQR2keUzuuB4uq0xBA=
X-Google-Smtp-Source: APXvYqwqYh96HPZKMNxmRjyjD/n4AOfKDED/5Q2kVgud1+sGD68OWaS1ARWKzIACEEh9OYFpK6mK3w==
X-Received: by 2002:a1c:a8d3:: with SMTP id r202mr670490wme.106.1554142843173;
        Mon, 01 Apr 2019 11:20:43 -0700 (PDT)
Received: from X555LD.home ([2a02:85f:510:b900:c095:2934:58ba:cfa6])
        by smtp.gmail.com with ESMTPSA id t15sm16353558wmt.2.2019.04.01.11.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:20:42 -0700 (PDT)
From:   "Leonidas P. Papadakos" <papadakospan@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: disable TX offload for mtu bigger than 1498 for some SoCs
Date:   Mon,  1 Apr 2019 21:20:29 +0300
Message-Id: <20190401182029.31362-1-papadakospan@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>

Some rockchip boards (like the rock64, and the renegade) exhibit an issue where
tx checksuming does not work with packets larger than 1498.

This is bad for network stability.

The previous approach was using force_thresh_dma_mode, which does more than
disable TX offload, something we do not need

this patch depends on patch:
stmmac: introduce flag to dynamically disable TX offload for rockchip devices

Signed-off-by: Leonidas P. Papadakos <papadakospan@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index c213ad74d..16ced107d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -136,7 +136,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,force_thresh_dma_mode;
+	rockchip,bugged_tx_coe;
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 7cfd5ca6c..cab2e1da6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -150,7 +150,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmiim1_pins>;
-	snps,force_thresh_dma_mode;
+	rockchip,bugged_tx_coe;
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 791fb0ee9..a1221dca1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -207,6 +207,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
+	rockchip,bugged_tx_coe;
 	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
-- 
2.21.0

