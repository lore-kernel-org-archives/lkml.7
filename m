Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3009C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EFD20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0kSxlvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgAHUyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:54:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35229 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAHUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so4945662wro.2;
        Wed, 08 Jan 2020 12:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8uH8Ohf0/3msxdVq/elVtV9phQ+l7EJ3TnSIFW8Fo0=;
        b=e0kSxlvMjAEUSAiUAW4ICM7lkFZ2+g0/XlA56tjVT6RbtvXsMljyPPsICZYaqnXjEx
         1Pl4fd1uchMzmbVCnXpwAADD3730auQp71lV3yeD/fHM/5DzT19YSdDVsjQTAzwJEWRI
         CQmC7v74Akdutq2yKBONZZjXl/KmT5+BX3AiQ80n6/RQGUXtd7pxwsvwMPq1UuRnE0iY
         OM84XVb8kdffdl/ij1JdieMxy4k8CZ++CcuyzQYtaAZ9Bv0NnEH6p+6w68lBsC60WvZM
         stZMy9Q8f9Cj2VTkBiDlSmAXUxENYvar+5YXCp8XxRMxh1XOXQhRKynw0+g0w0gdAyZn
         RMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8uH8Ohf0/3msxdVq/elVtV9phQ+l7EJ3TnSIFW8Fo0=;
        b=MBvbwUNpwoyWeN5GinT18SqzpK2bHzD7Ck24/wpPffkrfnI2PrOs53QeuA3yMtnTCF
         bb4M5vTPi2m4a9atPmIEWdT8nzB11Yn2NI7CeeKi7IJkUvnY1P3BLVoN1qLbJUMyfo6N
         UM8mjF6j/D1RUdBe9bdTY+llGOOi2j1L4HR0GZ8S5AwZerfKYIx7qIbeWWDBcRDvJqZg
         L/hw82RW6JCcwKv0jPlbiKFDMovKVVX7n/9vhtNyW28mv3T2JJnRhYMI9gF59NaI1ret
         KBLTdVnN2KArVOFuoZXgMZfNobBPruTaN/aIG8JNccnWm2PhAwPNOI20BDP4/Gz8UPRs
         fTCw==
X-Gm-Message-State: APjAAAWa1Vv8KR4Ily2E79vd3Isebroy7X+xnMtlrCuReiRQT3+SJcY/
        6CmwKjlUp1bBbObPC9n+Vck=
X-Google-Smtp-Source: APXvYqzc+xNsRHv3qmj0V/9o6spPl+YMOp2ERxVsBuT5Qvll3hQ2GWvJTQUwG9znzVyhruZwbxDrog==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr6657980wrt.229.1578516834066;
        Wed, 08 Jan 2020 12:53:54 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:53 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 07/10] arm64: dts: rockchip: add nandc node for px30
Date:   Wed,  8 Jan 2020 21:53:35 +0100
Message-Id: <20200108205338.11369-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dingqiang Lin <jon.lin@rock-chips.com>

Add nandc node for px30.

Signed-off-by: Dingqiang Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9a0f77ea4..3f46b8852 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -25,6 +25,7 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		nandc0 = &nandc0;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -924,6 +925,20 @@
 		status = "disabled";
 	};
 
+	nandc0: nand-controller@ff3b0000 {
+		compatible = "rockchip,nandc-v9";
+		reg = <0x0 0xff3b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC>, <&cru HCLK_NANDC>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		assigned-clocks = <&cru SCLK_NANDC>;
+		assigned-clock-parents = <&cru SCLK_NANDC_DIV50>;
+		power-domains = <&power PX30_PD_MMC_NAND>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	vopb: vop@ff460000 {
 		compatible = "rockchip,px30-vop-big";
 		reg = <0x0 0xff460000 0x0 0xefc>;
-- 
2.11.0

