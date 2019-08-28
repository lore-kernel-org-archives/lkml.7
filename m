Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B6cG3EEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfH1IzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:55:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45611 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfH1IzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:55:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so911621plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bHvbfgR0puFODQmQ5oUgG4pJ5KLJ8B+neI77o1rOHwA=;
        b=B6cG3EELu++3gVW/iX0sxgs3TTSaJEg2uVopyXE5Q1XAw29RlBxcUQOYl5xB+yFVpf
         7OH6TruTeJv+XckLXbJUffUvN3stwFIl/WNj+LJB0vpQdnTCCDCXxWL2Sgr+nrSnFnoL
         OCXNlCjvTVIT6zHh6y21au0wI304I7nc+94k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bHvbfgR0puFODQmQ5oUgG4pJ5KLJ8B+neI77o1rOHwA=;
        b=KwX66MThQR3AurIM5cwMiV+ao/bUuIq5ONj7FaDVF4KtWsBJIdluKfR6BNz3Ij8TyN
         xTAtzqLNKCEad48l6WFCvzU2/f6NwI6d8CvE8LmC8pC9dnI0yculQWmmfiCpKJL/RCqy
         CZUpMUMJ4MPKSWulxh2m6YoewQBj4mMmG3frvQhBLW21m5sUgbgY8K0iOfzQUvMNCCHB
         6xOUENCG/UajOiYRX++wug8+mC+hT5HQWBfWxQ0cWma7Noo+HJAQoSs1JIjoWwSN3Phl
         N252loT/L6ocixaSYIrwwVjm4W3TE+HWsbtRAFOlhvsYCxVzHS5WrFPqzMq5ZeEtuIHi
         NM1g==
X-Gm-Message-State: APjAAAUdMpksYwoxL8C+fXjnnyOdvoOigiSCEXsCSH9a4eTkX2LD4lHI
        hu5yDteoHWt4KrRagYyPI7a28Q==
X-Google-Smtp-Source: APXvYqy4RLvpIcLa0QnSesOupyvzYRt8WfODa0jBdGLy/7THR/JXgVAtKRWCSzo4J344VnpKwE7oJw==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr3350534pld.56.1566982514296;
        Wed, 28 Aug 2019 01:55:14 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
Date:   Wed, 28 Aug 2019 14:24:45 +0530
Message-Id: <1566982488-9673-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
References: <1566982488-9673-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 5f7b465..9d3d9ef 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -264,8 +264,11 @@
 			reg = <0x18012000 0x1000>;
 
 			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie0_intc 1>,
+					<0 0 0 2 &pcie0_intc 2>,
+					<0 0 0 3 &pcie0_intc 3>,
+					<0 0 0 4 &pcie0_intc 4>;
 
 			linux,pci-domain = <0>;
 
@@ -292,6 +295,14 @@
 					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			pcie0_intc: interrupt-controller {
+				compatible = "brcm,iproc-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		pcie1: pcie@18013000 {
@@ -299,8 +310,11 @@
 			reg = <0x18013000 0x1000>;
 
 			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie1_intc 1>,
+					<0 0 0 2 &pcie1_intc 2>,
+					<0 0 0 3 &pcie1_intc 3>,
+					<0 0 0 4 &pcie1_intc 4>;
 
 			linux,pci-domain = <1>;
 
@@ -327,6 +341,14 @@
 					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			};
+
+			pcie1_intc: interrupt-controller {
+				compatible = "brcm,iproc-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupt-parent = <&gic>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		dma0: dma@18018000 {
-- 
2.7.4

