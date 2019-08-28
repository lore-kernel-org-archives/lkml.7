Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023142189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eKtsYmKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1IzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:55:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40432 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1IzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:55:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so920849pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K4ivBVU5Ss+sLpYS30yLEkqdAEqwtQS/JgJ+Fiby4j4=;
        b=eKtsYmKJW0aXI/8/L6zIXUgqsErFCuAabhw6VyiEfl29rSzE77wDmpO1G75Pr/OCFl
         KvIo42UO0xcqE2MOpGPBUJhwnU4MeJhS2RfUxKCfNDlkMDmMrvMKah1jy9vXj1e5HA+M
         Mu31KEcxx1NlrT6ZkGUnO5inBWC6MkJ4ixjB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K4ivBVU5Ss+sLpYS30yLEkqdAEqwtQS/JgJ+Fiby4j4=;
        b=IpdKvnDIjCtuIFCoPA474ZiFLmR5sZWX2Mra87omJ5yw4dlpKKDqBEVMs1T7eRusBX
         PfztXLjUthaLqV1QsZDoGfOpPUVVtaWZvlpZ4vk1ZZtalPV2LUYAB9yzkYAaTU8/gUmU
         b3mo+XiAx88v3UsXai6nZ7luqNqF15F6PI8k7MN8RlK4Ws8XH6wFS+vrrC+MGJFCEocg
         a1IW5YdOzx0hBxEAFZaI7mKx5tPVYLvp4LQnZMm5T9GYJ5mN45PLqawqXJjOJNww3JeO
         Z0KIayJtFAsPsuj+DolXu5kx2Sv+/db9Utuda83VrGWNKhBLezAoq4c/ccvYHXh0+wQ8
         V7Qw==
X-Gm-Message-State: APjAAAWrJ67QcBacCvhZU1oUS1yhGYolgW9yAuF8hl29VqjC57oSCC1A
        7aVPHKGnjFm8NszURAgDPwJHAA==
X-Google-Smtp-Source: APXvYqz+7LioVOAuI3QiU89rfrqiB0N93ADo1DKZMN2YenWqSAyLfoBhEt48lDz4CAnZm6xE4t3VDQ==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr3214093plk.109.1566982522329;
        Wed, 28 Aug 2019 01:55:22 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z189sm2431386pfb.137.2019.08.28.01.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 01:55:21 -0700 (PDT)
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
Subject: [PATCH v2 5/6] arm: dts: Change PCIe INTx mapping for HR2
Date:   Wed, 28 Aug 2019 14:24:47 +0530
Message-Id: <1566982488-9673-6-git-send-email-srinath.mannam@broadcom.com>
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
 arch/arm/boot/dts/bcm-hr2.dtsi | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index e4d4973..eb449d0 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -299,8 +299,11 @@
 		reg = <0x18012000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 1>,
+				<0 0 0 2 &pcie0_intc 2>,
+				<0 0 0 3 &pcie0_intc 3>,
+				<0 0 0 4 &pcie0_intc 4>;
 
 		linux,pci-domain = <0>;
 
@@ -328,6 +331,14 @@
 				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie1: pcie@18013000 {
@@ -335,8 +346,11 @@
 		reg = <0x18013000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 1>,
+				<0 0 0 2 &pcie1_intc 2>,
+				<0 0 0 3 &pcie1_intc 3>,
+				<0 0 0 4 &pcie1_intc 4>;
 
 		linux,pci-domain = <1>;
 
@@ -364,5 +378,13 @@
 				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie1_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.7.4

