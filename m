Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4555FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF1520989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c6zG+A5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfCSJQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:16:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38068 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfCSJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:16:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so15556406wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yta3K0Zdx35RD0mlt7dDQK3LE8z4Fq3s3CEHa4rCWFc=;
        b=c6zG+A5PuKVcfhkK8qOn4X0YBvV2T9XIZSqu5dDbLPTSccL/7jvpEQ24MJtPMSt4zP
         vKb0McZ6qeLWMGyDFYmAEKZaH6jg+Pqc8dmP61K4vSJbIqZxEr0ShSI/jhgSCCIrdtAx
         AZ5eaPLxsgNzSXza47VkN0U8bi4HoQAgT1IZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yta3K0Zdx35RD0mlt7dDQK3LE8z4Fq3s3CEHa4rCWFc=;
        b=itmDjzFF11U1kvDcnvkDtpcPyQ7lwT0wJ/VFmjBXC8ycFvVFdX6cc8QpS2+GT0R7Kn
         qStQJvP+XAinxqL7nvuJME6gyd3+6qt7qCprcro0jclPYs2+2WL5AlIYZQ7s6rjCfyNn
         RKjuPZug4SIdU7lLnjkr9WuJRP0ZG5g+VTjjTUGaf8aRsrs/p79d7rK5R4VbhExFWNvQ
         FiN2YD2Ois6YUakg05JKUH+ITo5TWBUPn3OxAy/u01rdO8/EL4yYdHBlWPXWxDkOkGKY
         pSBYx0TIYQ2Hg8itq4siek5TlZgVUY/cfSoI2TcnYyG6+xungdHCXAgYIh8Vq0mmCee6
         NMjg==
X-Gm-Message-State: APjAAAUaKGovcMhWMxiiHeIyPhM3fzOXieAag9ZZZepbRYbT7ZfYCz8U
        Uvwu1maLQfksi2ooA71ywJEj7w==
X-Google-Smtp-Source: APXvYqxZLQqiRWbWIghFKQs4iz8xzLzKmS0DNOp80McJdFwZv6wt5baxy1CCcoohCFIkwW9Ce6x3dg==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr2494392wmb.23.1552986991311;
        Tue, 19 Mar 2019 02:16:31 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w10sm14875743wrn.32.2019.03.19.02.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 02:16:30 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Tue, 19 Mar 2019 14:45:44 +0530
Message-Id: <1552986944-3398-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for
  - Two xHCI host controllers
  - Two BDC Broadcom USB device controller
  - Five USB PHY controllers

[xHCI0]      [BDC0]            [xHCI1]            [BDC1]
   |           |                  |                 |
  ---------------               -----------------------
   |           |                 |         |         |
[SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]

[SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs has one SS and
one HS PHYs. [HS-PHY2] is a single HS PHY.

xHCI use SS-PHY to detect SS devices and HS-PHY to detect HS/FS/LS
devices. BDC use SS-PHY in SS mode and HS-PHY in HS mode.

xHCI0 port1 is SS-PHY0, port2 is HS-PHY0.
xHCI1 port1 is SS-PHY1, port2 is HS-PHY2 and port3 is HS-PHY1.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   | 72 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
new file mode 100644
index 0000000..55259f9
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+	usb {
+		compatible = "simple-bus";
+		dma-ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x68500000 0x00400000>;
+
+		usbphy0: usb-phy@0 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00000000 0x100>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		xhci0: usb@1000 {
+			compatible = "generic-xhci";
+			reg = <0x00001000 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0 1>, <&usbphy0 0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc0: usb@2000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00002000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0 0>, <&usbphy0 1>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@10000 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00010000 0x100>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		usbphy2: usb-phy@20000 {
+			compatible = "brcm,sr-usb-hs-phy";
+			reg = <0x00020000 0x100>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11000 {
+			compatible = "generic-xhci";
+			reg = <0x00011000 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy1 1>, <&usbphy2>, <&usbphy1 0>;
+			phy-names = "phy0", "phy1", "phy2";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc1: usb@21000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00021000 0x1000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy2>;
+			phy-names = "phy0";
+			dma-coherent;
+			status = "disabled";
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa85..21dbb12 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -287,6 +287,7 @@
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
+	#include "stingray-usb.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.7.4

