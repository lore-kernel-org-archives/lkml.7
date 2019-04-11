Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDF62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtK9KpmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDKX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:27:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52251 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDKX1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:27:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so8826833wma.2;
        Thu, 11 Apr 2019 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/lbmnj1rLjQX0s5PohleCzRZ9gqTtd7gfwSug1zEu/Y=;
        b=LtK9KpmGjIiB33Vvtm1Jq2Kyjv0eMbMK+y8pzNetIlgS6n9PMPE79+c8Cg4TJ2dbnC
         KpV1nWM+zrLqxGRtkOMdsfolm8Vp6N4Osn8JYIJSuNwooMrcM1ZioUJ5fE0F/Bz9sDVs
         hnlEjBuqHknX1SaQGAtyR86/HHGJrS5Dc1WSXo3Qf3r1WrjuS7nocHz4QgmWiLuqbHBC
         trP4HmOKfPEaX3AGv9tnFIOD1GC0HsvOmOk0ZOfd7T4EZ5uAN4RsCkUGifmL8qUshfRm
         AEbXGXdtTrZPaehbG28GHKPNPy8DnFIZ0yqBQZH2dkaKDlSgnBygVBYdPN75SxwuWFHt
         wbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/lbmnj1rLjQX0s5PohleCzRZ9gqTtd7gfwSug1zEu/Y=;
        b=UvItZe8cMfqX0aiHI4kCyQ3voxHMJj1aR2faX0cJY8spQ33b6vodQ70+ywBomPbLNw
         bSmswfa/Dc2RJtjKtWhO1X+TRUzB8hkYQSeA1HhZxBbTg2lo40eZYIo5QqbuQCR2n24e
         JVnGdmLNL9yaeYwZ4Z0zPiD6R8odWGCaguxh4j4gkliGq4/BKx404reoPYjtEjLAAx0/
         GadIBOjEd5bEGEaQ1CCHTlIAWC7wPy6FB1P36kCIzZw4GQ3IUqvueLG3/VxQhpGi0AKa
         K5osRW3gEcVunjMmoxzvb4gpunWivNrET4S364qZAAqXIRoOiYR7sJxt08gcDNf7bCrR
         rG4Q==
X-Gm-Message-State: APjAAAWD+ncakxxGdYomI/BsUbcaCM2841w03NN/q1QRY8FAYD+bPOrk
        qF464li1pcTqYnIViHZCjW8=
X-Google-Smtp-Source: APXvYqzJyM4x/CBFyK4kJB2ZrWNFiVb26+6ChkUAusDvQlTrygrfq3Gu147C02/ZxZQ6XzM76sI2NA==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr8578973wmj.2.1555025238891;
        Thu, 11 Apr 2019 16:27:18 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id g132sm6355642wme.3.2019.04.11.16.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:27:18 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, claudiu.manoil@nxp.com
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: ls1021: Fix SGMII PCS link remaining down after PHY disconnect
Date:   Fri, 12 Apr 2019 02:23:15 +0300
Message-Id: <20190411232315.19588-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411232315.19588-1-olteanv@gmail.com>
References: <20190411232315.19588-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each eTSEC MAC has its own TBI (SGMII) PCS and private MDIO bus.
But due to a DTS oversight, both SGMII-compatible MACs of the LS1021 SoC
are pointing towards the same internal PCS. Therefore nobody is
controlling the internal PCS of eTSEC0.

Upon initial ndo_open, the SGMII link is ok by virtue of U-boot
initialization. But upon an ifdown/ifup sequence, the code path from
ndo_open -> init_phy -> gfar_configure_serdes does not get executed for
the PCS of eTSEC0 (and is executed twice for MAC eTSEC1). So the SGMII
link remains down for eTSEC0. On the LS1021A-TWR board, to signal this
failure condition, the PHY driver keeps printing
'803x_aneg_done: SGMII link is not ok'.

Fixes: 055223d4d22d ("ARM: dts: ls1021a: Enable the eTSEC ports on QDS and TWR")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 9 ++++++++-
 arch/arm/boot/dts/ls1021a.dtsi    | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 97e1fb7ea932..9b1fe99d55b1 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -145,7 +145,7 @@
 };
 
 &enet0 {
-	tbi-handle = <&tbi1>;
+	tbi-handle = <&tbi0>;
 	phy-handle = <&sgmii_phy2>;
 	phy-connection-type = "sgmii";
 	status = "okay";
@@ -225,6 +225,13 @@
 	sgmii_phy2: ethernet-phy@2 {
 		reg = <0x2>;
 	};
+	tbi0: tbi-phy@1f {
+		reg = <0x1f>;
+		device_type = "tbi-phy";
+	};
+};
+
+&mdio1 {
 	tbi1: tbi-phy@1f {
 		reg = <0x1f>;
 		device_type = "tbi-phy";
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 1a2a9509d9c2..89eab1fd1f7f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -709,6 +709,15 @@
 			      <0x0 0x2d10030 0x0 0x4>;
 		};
 
+		mdio1: mdio@2d64000 {
+			compatible = "fsl,etsec2-mdio";
+			device_type = "mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2d64000 0x0 0x4000>,
+			      <0x0 0x2d50030 0x0 0x4>;
+		};
+
 		ptp_clock@2d10e00 {
 			compatible = "fsl,etsec-ptp";
 			reg = <0x0 0x2d10e00 0x0 0xb0>;
-- 
2.17.1

