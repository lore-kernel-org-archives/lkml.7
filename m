Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA5C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A52220718
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eka7RtLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfKQOHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:07:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38417 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfKQOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:07:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so4425025pls.5;
        Sun, 17 Nov 2019 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ogk/eEmzUsDEdl7w08E984I9cFzzy44g9Efvz8aG1qM=;
        b=eka7RtLZ3C0mryfGOdnbrQqku4FdYrS7Vm6nD0pAM0Sj+UMjIj+3/CujSB4F4/KhsP
         VihO8HhcTglrOu6EQH0p/TXHD/ahFd15q4S5iruKQCe+sH7ywazKmQc2UqXnSnVDkZ7T
         EsqzAoIHwQFcaskIfLqbQRH1RreWUXvfh6EulG3Z1G4qfi0pUjhoyTIHS+KyKLSO0BXE
         PBh+UdJdxwiu3mGlWta2oQXcfRxlt9b1PQs38Ry04PyYJOfw5p3G+H65TjaCQ3VekzZ/
         Sn26NijXk12QhcSb4ZrZLGcMBMZ8YgEUa7sc1h/G0j+sq+NWeT5kdI0ubKTwQ5AjPNFv
         ZQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ogk/eEmzUsDEdl7w08E984I9cFzzy44g9Efvz8aG1qM=;
        b=tkOE/Shzk4Qm9NYrneNQ6bcvzBKDmPf1xpUqpvU5D5P1qUqw+nGjexvNKAriMdzAIR
         jzs9KhO4DGdl76M5Urm60WzqlWAn/+51Sv8NxhkEnxEMxp0M9AXjYzXp2L5uIvgtYGXF
         tiUxUkCB/5h3aVlZL854JEpVlBXQILCfOBJ4OXE/tSq4BgvT1Ef+3MqoFnAKXD5ypE0i
         zvQquIqpgZF96HqspawoEk19RzZlZUQuCtOw+pjXRC9NbVa/tC2pi/nIZExq24oQnV98
         /FUyDdNpN9WJyyusMDNW7qjgiCYza/kXd4hV44mpEUFxI1sNXj1EguEgSqJ8eY6jE1yU
         rUog==
X-Gm-Message-State: APjAAAXlGNdqUYlrzfj9RhXJtpw4pmAIZ9iWraYB+8do5iJUOGBNtdtS
        Xn43l323WTNB4jxDrTSXQhA=
X-Google-Smtp-Source: APXvYqyJN1xtglkHOj6ND7doXENJ2CNNHqYqpj3JsmiEA+gpCe9JSyNJo7gybj7eLRamQUOLJFYM4w==
X-Received: by 2002:a17:90a:1a56:: with SMTP id 22mr33929410pjl.100.1573999656893;
        Sun, 17 Nov 2019 06:07:36 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.169])
        by smtp.gmail.com with ESMTPSA id i102sm16486708pje.17.2019.11.17.06.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 06:07:36 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add regulators for pcie on rk3399-rock960
Date:   Sun, 17 Nov 2019 14:07:28 +0000
Message-Id: <20191117140728.917-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Rock960 schematics add 0V9 and 1V8 voltage supplies to the
RK3399 PCIe block.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Schematics [0] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index c7d48d41e184..2f76cccebbee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -53,6 +53,15 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	vcc_0v9: vcc-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_0v9";
+		regulator-always-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -385,6 +394,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn_cpm>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
+	vpcie1v8-supply = <&vcca_1v8>;
+	vpcie0v9-supply = <&vcc_0v9>;
 	status = "okay";
 };
 
-- 
2.24.0

