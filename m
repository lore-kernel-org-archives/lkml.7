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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC26C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F339C20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzt9Pq8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgAHUx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:53:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40751 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgAHUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:53:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4914398wrn.7;
        Wed, 08 Jan 2020 12:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C5fo2kz/QWgODg+pTRTkY/0WFd4gP4/o5NDNIjif8yU=;
        b=Zzt9Pq8z2X+9hwX1ST5OGPyVjrA4QVsYfsU5Wmyd3tl0c6equBtUPevbjEtiYvzq0V
         F4ZoiRMpeC1kWGUttJA/fkBaJH9ZbkCgpoVWHNF1yb/53vw00PaCsrZXs8eoBGeDohyj
         ak8k7t99ff5pwAliM9p+OyFpP9n2o+QGIWatkTwhaZQCkPSY+QMQPgkt5TvvZZl4AbRX
         Q4oPPhYByTA/wo0xeHiX6o1iWb0S50jScOoSDg0ZHHu1kw7/H2aK9fKdV1nVlWNZIy38
         rUDk8g4sQ9B1n0eCJLX4jloIxHW2SJoOPp8nvAoq6RdovfL4jjy4IGr+AvFLgkFwSRy8
         TiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C5fo2kz/QWgODg+pTRTkY/0WFd4gP4/o5NDNIjif8yU=;
        b=O/c3ExSYDcEqq4ENDu6D7QP5ikyTTgKRHyJI1sbrXvldefgxpbGKbw1TvkBhW+mXZ9
         39LlOVZwFYIoKIBd5+rV2k4DmM0IgbSXAeV7eE1//75oh76kgedONQ1Y6sVCJavJpleY
         efbXt2ogd+H9PeZNnUbAY0ZweoiefsOsnm7WUOrYJgnKmv79ExkUcjldVPYwVV5E1ts+
         Y6BMyqjbe7cnANrGN70vK/R93fWVX4Ro/Z/WKLB8vIRXHOg4KI7SVRx8jL6CtUM/5Mgp
         2VaIK9ihu7h1Yi6L/CO842ReEtnoGDE+CxMeNWh8VOeXLi8rMdCLwjNjA3f4W24xl+t0
         C+jg==
X-Gm-Message-State: APjAAAXxGx20GmTQtLGgZO1uYYSWw4RtV6TnvjBrJgH9JFI1iivaCQmu
        e4VFcE7f2OS+UJ1IUrPKroo=
X-Google-Smtp-Source: APXvYqxKzkRDBbLxFJJQrh3Cz/Joy5n0D+rLPkz5VnUoFXE6pFE8tWT1ElySl90OFe+0xb5oe68WBA==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr7021758wrx.109.1578516833133;
        Wed, 08 Jan 2020 12:53:53 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c5sm311835wmd.42.2020.01.08.12.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 12:53:52 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 06/10] ARM: dts: rockchip: add nandc node for rv1108
Date:   Wed,  8 Jan 2020 21:53:34 +0100
Message-Id: <20200108205338.11369-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200108205338.11369-1-jbx6244@gmail.com>
References: <20200108205338.11369-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Lin <jon.lin@rock-chips.com>

Add nandc node for rv1108.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 5876690ee..391073ada 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -456,6 +456,17 @@
 		#reset-cells = <1>;
 	};
 
+	nandc: nand-controller@30100000 {
+		compatible = "rockchip,nandc-v6";
+		reg = <0x30100000 0x1000>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_NANDC>, <&cru HCLK_NANDC>;
+		clock-names = "clk_nandc", "hclk_nandc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	emmc: dwmmc@30110000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30110000 0x4000>;
-- 
2.11.0

