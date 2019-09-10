Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0136C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5C2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NopmjHDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394058AbfIJPzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:55:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfIJPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:55:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id r195so163293wme.2;
        Tue, 10 Sep 2019 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJ/xSRj04hb+Vjp0G8v57BGzk2RHL40NPxcaQuTTxb0=;
        b=NopmjHDf1N0d3pOf0ECTnZpkWbC5PPwUogiwZsUwDTIwgEgQ47sCN/WtEU/LQLlPSv
         fZ9X9O89kZTEP6e7o3p9jm+rLnGIDG4++Rxp/zhxPi8gUhsz3x1lbkfKW3RtvUOKYtb/
         Q53V94Qyzox2PxZnj6wzk0UiwSuCBZT1oQJ8M/mIyqnarV1hZuegeQj8J9SUyIV48f09
         yVnsIrEGiUAWTJb81dWQdA9Y541KxvANRRMTlpY5vX1yHTjkB2/7v8ZvBXwQLqOXq7u9
         uqboVrDdxLwGW1pquRt+1L+t0qtJ0+3ugritCgb7zcDdqRYZJTTFcaGyvz5stIAtXU/S
         J4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJ/xSRj04hb+Vjp0G8v57BGzk2RHL40NPxcaQuTTxb0=;
        b=kBwxLO9hEZVGswYPgvkRDae9JR139ZzRRdKln2dik7IX0/ks8gNe0I0vp06yZIjsG5
         /cFds0QtSIjhiDL7ARb+Gt7LjBmsRUVXR7/WWd7mb2uztAp2DQlFPVF38PqwTrD4U8/p
         b2wf2nbZfnnO0HohrgiEdn6P2R7Bc1755QEgzQJx7FSQvNJdrrvKEdAzcuU8k/Ampf19
         PjojXvCOTpYXWjl+LwKrpGsy8FPM+uuvPd9r5SrUoHFtE0hzEc19DQaIGNWs6BVf0wyZ
         QwxRoWidobP1TQHN23F9L76SwxL3PJ2F62u37/qW7AqP2TaCdV3VnxHcdF2XIo2ZPyRD
         6npA==
X-Gm-Message-State: APjAAAUsHnUemcjWzSRDey0wycsKw6GH4VgtsfsE9UkGfWHElxRhddcU
        MBzXvsiq+eTomsWzhEwdzxSjD8r5Uy8=
X-Google-Smtp-Source: APXvYqwRgrZHxJJlCCWWTIdvJK1X8hVtJn4cq1fyPIBd0nfF2LAchwsIZdzc9hsmxdjosHFLCGuzAw==
X-Received: by 2002:a7b:c094:: with SMTP id r20mr143261wmh.134.1568130930147;
        Tue, 10 Sep 2019 08:55:30 -0700 (PDT)
Received: from arch-dsk-01.twb ([77.126.41.65])
        by smtp.gmail.com with ESMTPSA id y3sm17167133wrw.83.2019.09.10.08.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:55:29 -0700 (PDT)
From:   tinywrkb <tinywrkb@gmail.com>
Cc:     tinywrkb@gmail.com, Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s max-speed
Date:   Tue, 10 Sep 2019 18:55:07 +0300
Message-Id: <20190910155507.491230-1-tinywrkb@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the
Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.

Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.

This adds a phy node to the MicroSoM DTS and a 100Mb/s max-speed limit
to the Cubox-i Solo/DualLite carrier DTS.

Signed-off-by: tinywrkb <tinywrkb@gmail.com>
---
This patch fixes ethernet on my Cubox-i2-300-D which is limited to 100Mb/s,
afaik due to the carrier board  magnetics, and was since commit 5502b218e001
("net: phy: use phy_resolve_aneg_linkmode in genphy_read_status")

The AR8035 PHY on the CPU module reports to the driver as 1GbE capable
via MII_BSMR's BMSR_ESTATEN status bit, the auto-negotiation sets the
speed at 1GbE while the carrier board can't support it.
Same behavior with the generic phy_device and the at803x drivers.

While the PHY is on the CPU module board I added the max-speed limit to
the cubox-i carrier DTS as I suspect that if the Solo or DualLite v1.3
MicroSoM will be connected to a 1GbE capable carrier board then it would
work correctly with 1GbE.

I can confirm that this commit doesn't break networking on the my
Cubox-i4Pro Quad (i4P-300-D) with it's 1GbE capable carrier board, and
was tested separately with the generic phy_device and at803x drivers.

 arch/arm/boot/dts/imx6dl-cubox-i.dts  | 4 ++++
 arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
index 2b1b3e193f53..cfc82513c78c 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
@@ -49,3 +49,7 @@
 	model = "SolidRun Cubox-i Solo/DualLite";
 	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
 };
+
+&ethphy {
+	max-speed = <100>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
index 6d7f6b9035bc..969bc96c3f99 100644
--- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
@@ -57,6 +57,15 @@
 	phy-reset-duration = <2>;
 	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	status = "okay";
+	phy-handle = <&ethphy>;
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethphy: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+		};
+	};
 };
 
 &iomuxc {
-- 
2.23.0

