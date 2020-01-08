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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA0C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C72070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOLe1VNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgAHUx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46326 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgAHUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so4852606wrl.13;
        Wed, 08 Jan 2020 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6wZ7x22wSXIg5bl9Oow5ZKhvHAS5XTDENGb2Cb6nT5M=;
        b=kOLe1VNJ78Dhvq4QYaA8kd+GrZDXdFnLdaMSxdj9vIFC69Ismok3BjzzU7GMw0oKif
         k4mxQm8XjndK9iiVCjRHL4Lh1gzaDDD//2CzGtuXg4JuaaAJqK5KDBnstz28OzlEgFsE
         zfO5/JVdsbN20xILLbDCsOTqGHJpL3tLJWoGhYoG5Cc0pUflX06IzdzZcc1RUVYwS28+
         yclPK7y9D5XuVrgHlV+wqg7cJArx1ZlPl/yejz7kDeYPVEch/yKA4dQyy3YTWHYjgwf/
         5pj/FLaZ36chPFoSyWV+HkLs3x2rUzoRgK5zcALjA8CRw1DXS8OKJ48SJmu+Cx0/CTQs
         a7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6wZ7x22wSXIg5bl9Oow5ZKhvHAS5XTDENGb2Cb6nT5M=;
        b=lXG+pHO5AW/LhB2bKys/D27v/5OHv3Z6Bu33hQ3bLpPKfnNnUMOEJkaJVPz+I72bn7
         zjUD8mwUd/AVIu5eON08ZmZ/VJt2bWWW3g00y2mCy/fNi2iUQ/tHeb0vi/ug/0EJlqWb
         Lm/eKHab0a1uCnnjtZFmBZDJUKuBlUry1zwgYfMp/MaDHhh3d0jUpb1OmSFwX5QJlt/8
         XDHLN2BIOaMo9nLhtJMExzvC9D/1rvydIp/yeBJOh4lmk8Ky9ig5cDuh5+9rqq5t9jas
         euTmPu1edAbVkyO9xJ/+mGOPE6qblE7iuCe6u+nrWxm+M+hyrL0NhPbx3hXxQAb8MBIu
         MhMg==
X-Gm-Message-State: APjAAAWDDaGPybGSLnG4eMTLPoVs7g++Fw9pXsdKgvZ5aptIyl5dFBNA
        8//h2aGQwqK3h/5w9vu29OY=
X-Google-Smtp-Source: APXvYqy2OynSIqj7hv4Oh/Z1uZuPF0gapDkWQQTlinfn9ySqo2/ZfkPS/B0kyZUjHdYpsFFpyQngBQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr6594981wro.209.1578516832028;
        Wed, 08 Jan 2020 12:53:52 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:51 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 05/10] ARM: dts: rockchip: add nandc nodes for rk3288
Date:   Wed,  8 Jan 2020 21:53:33 +0100
Message-Id: <20200108205338.11369-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianqun Xu <jay.xu@rock-chips.com>

Add nandc nodes for rk3288.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 415c75f57..704a101d8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -30,6 +30,8 @@
 		mshc1 = &sdmmc;
 		mshc2 = &sdio0;
 		mshc3 = &sdio1;
+		nandc0 = &nandc0;
+		nandc1 = &nandc1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -596,6 +598,28 @@
 		status = "disabled";
 	};
 
+	nandc0: nand-controller@ff400000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x0 0xff400000 0x0 0x4000>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC0>, <&cru HCLK_NANDC0>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	nandc1: nand-controller@ff410000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x0 0xff410000 0x0 0x4000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC1>, <&cru HCLK_NANDC1>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	usb_host0_ehci: usb@ff500000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xff500000 0x0 0x100>;
-- 
2.11.0

