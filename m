Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF690C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6852253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB9YzoSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgACSTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45654 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgACSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so19306231pls.12;
        Fri, 03 Jan 2020 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKrfYN5NKMOM4AZeJYolb/pgmT2FewkRG32XrCjhEHA=;
        b=AB9YzoSX4kLj6oVOxtPoVAWAM3o/gxxjctKo6bsf3DpMOmGcon5fI8XiEbAqIdnaWQ
         qBSuyxmf085UoiuIdLMX9Xu+gC1R/CKCTV+9GPYuk4APr/nEOlm42uSs7FLZ8kHVFVbJ
         JABkupYvmapibVtxXpG33Ma6ovFe+nY1kdeOxlvIuT7+8rlN0YMocTMGtAjKdXZPu3+C
         tcHjhR8zCACWGCYodMzwHcwBvyoaYHSkOQZfZRPtC9q3fEZQnxiSZxMPSHbjmSN53Omi
         ZNdaMo2R5szNob1POcSV9wMKGHYRndfhFI4AIYRSAuW+W+lStxDEZvnAXinDexePRsd/
         Pz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKrfYN5NKMOM4AZeJYolb/pgmT2FewkRG32XrCjhEHA=;
        b=OH+Bjzqh7JpA1RhrZGMPQt3nm1r/UmNxy1fN+1Q2stxCXDRegwtY58WQPKhPnZH+F6
         fqTbbyNLFJmPEhbaPkWHpxsgZ8zSjJbwR/SxEQzItsfiPvEsUycgwZJ3oVLKJ9EZSr7T
         XCpe/Oy2FTIg3v+1dlkaDwYXnu6pN9uE5SVTQ7knSjbjPdD80z/wBHs2u2AxnTbOSKx4
         MaSojccw2eKMYO+coRizzIJziCvVFPX82qiroE7UjPwY4mg7XjBY0K4NmE9B2OJHdTL1
         CWbXsPNlIdjIpnyAKzk0bAYVjHI+4m+nDSC1sLo25TyK63/YL9/xOUwd537P3kMF3Kvq
         6L0w==
X-Gm-Message-State: APjAAAUcBsDPk/EgrDHF3Ypqu/ZX/gWkZkVsEoLm7NiEein/kCwo4NmK
        /bD/sBtlDZ8KO2ilwA1qppzZpZKmewg=
X-Google-Smtp-Source: APXvYqwN4mS+x4iXXe2BYRodbaGWWgNcazdDbzVKpkcxaQB7XSvvF6Fo6S2mUjs7pPnRfC6hJTDTmw==
X-Received: by 2002:a17:902:343:: with SMTP id 61mr41120721pld.332.1578075573151;
        Fri, 03 Jan 2020 10:19:33 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:32 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 06/13] dt-bindings: Add Broadcom STB USB PHY binding document
Date:   Fri,  3 Jan 2020 13:18:04 -0500
Message-Id: <20200103181811.22939-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for bcm7216 and bcm7211

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/brcm,brcmstb-usb-phy.txt     | 69 +++++++++++++++----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
index 24a0d06acd1d..698aacbdcfc4 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
@@ -1,30 +1,49 @@
 Broadcom STB USB PHY
 
 Required properties:
- - compatible: brcm,brcmstb-usb-phy
- - reg: two offset and length pairs.
-	The first pair specifies a manditory set of memory mapped
-	registers used for general control of the PHY.
-	The second pair specifies optional registers used by some of
-	the SoCs that support USB 3.x
- - #phy-cells: Shall be 1 as it expects one argument for setting
-	       the type of the PHY. Possible values are:
-	       - PHY_TYPE_USB2 for USB1.1/2.0 PHY
-	       - PHY_TYPE_USB3 for USB3.x PHY
+- compatible: should be one of
+	"brcm,brcmstb-usb-phy"
+	"brcm,bcm7216-usb-phy"
+	"brcm,bcm7211-usb-phy"
+
+- reg and reg-names properties requirements are specific to the
+  compatible string.
+  "brcm,brcmstb-usb-phy":
+    - reg: 1 or 2 offset and length pairs. One for the base CTRL registers
+           and an optional pair for systems with USB 3.x support
+    - reg-names: not specified
+  "brcm,bcm7216-usb-phy":
+    - reg: 3 offset and length pairs for CTRL, XHCI_EC and XHCI_GBL
+           registers
+    - reg-names: "ctrl", "xhci_ec", "xhci_gbl"
+  "brcm,bcm7211-usb-phy":
+    - reg: 5 offset and length pairs for CTRL, XHCI_EC, XHCI_GBL,
+           USB_PHY and USB_MDIO registers and an optional pair
+	   for the BDC registers
+    - reg-names: "ctrl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio", "bdc_ec"
+
+- #phy-cells: Shall be 1 as it expects one argument for setting
+	      the type of the PHY. Possible values are:
+	      - PHY_TYPE_USB2 for USB1.1/2.0 PHY
+	      - PHY_TYPE_USB3 for USB3.x PHY
 
 Optional Properties:
 - clocks : clock phandles.
 - clock-names: String, clock name.
+- interrupts: wakeup interrupt
+- interrupt-names: "wakeup"
 - brcm,ipp: Boolean, Invert Port Power.
   Possible values are: 0 (Don't invert), 1 (Invert)
 - brcm,ioc: Boolean, Invert Over Current detection.
   Possible values are: 0 (Don't invert), 1 (Invert)
-NOTE: one or both of the following two properties must be set
-- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
-- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
 - dr_mode: String, PHY Device mode.
   Possible values are: "host", "peripheral ", "drd" or "typec-pd"
   If this property is not defined, the phy will default to "host" mode.
+- brcm,syscon-piarbctl: phandle to syscon for handling config registers
+NOTE: one or both of the following two properties must be set
+- brcm,has-xhci: Boolean indicating the phy has an XHCI phy.
+- brcm,has-eohci: Boolean indicating the phy has an EHCI/OHCI phy.
+
 
 Example:
 
@@ -41,3 +60,27 @@ usbphy_0: usb-phy@f0470200 {
 	clocks = <&usb20>, <&usb30>;
 	clock-names = "sw_usb", "sw_usb3";
 };
+
+usb-phy@29f0200 {
+	reg = <0x29f0200 0x200>,
+		<0x29c0880 0x30>,
+		<0x29cc100 0x534>,
+		<0x2808000 0x24>,
+		<0x2980080 0x8>;
+	reg-names = "ctrl",
+		"xhci_ec",
+		"xhci_gbl",
+		"usb_phy",
+		"usb_mdio";
+	brcm,ioc = <0x0>;
+	brcm,ipp = <0x0>;
+	compatible = "brcm,bcm7211-usb-phy";
+	interrupts = <0x30>;
+	interrupt-parent = <&vpu_intr1_nosec_intc>;
+	interrupt-names = "wake";
+	#phy-cells = <0x1>;
+	brcm,has-xhci;
+	syscon-piarbctl = <&syscon_piarbctl>;
+	clocks = <&scmi_clk 256>;
+	clock-names = "sw_usb";
+};
-- 
2.17.1

