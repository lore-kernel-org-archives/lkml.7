Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68975C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4D21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mf/P/3Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfEVQVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:21:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfEVQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:21:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKdev102267;
        Wed, 22 May 2019 11:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558542039;
        bh=VCnEYJi1HcEwa5Iq6WKWhniPEkwL4k0FanrWfiqf6K0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Mf/P/3FrkUIXW+4ewz5KuRrQNOyEVulTEvST+4lJY0UrfaqaTtyGv1adilwWDWgK3
         e9FmQgBOxYd0v5uH1mX1lfQNxaTHTczQ3NuqPLMlYEK2cFefsYDiSH2V+i6cAbbGxQ
         nkswLRTNCwaPTYS0Jejs7+ZqqCWn+gmjC/0IYIZE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4MGKdxC099357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 May 2019 11:20:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 22
 May 2019 11:20:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 22 May 2019 11:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKcsX122870;
        Wed, 22 May 2019 11:20:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/6] dt-bindings: arm: ti: Add bindings for J721E SoC
Date:   Wed, 22 May 2019 11:19:16 -0500
Message-ID: <20190522161921.20750-2-nm@ti.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J721E SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration to enable lower system costs
of automotive applications such as infotainment, cluster, premium
Audio, Gateway, industrial and a range of broad market applications.
This SoC is designed around reducing the system cost by eliminating
the need of an external system MCU and is targeted towards ASIL-B/C
certification/requirements in addition to allowing complex software
and system use-cases.

Some highlights of this SoC are:
* Dual Cortex-A72s in a single cluster, three clusters of lockstep
  capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
  C7x floating point Vector DSP, Two C66x floating point DSPs.
* 3D GPU PowerVR Rogue 8XE GE8430
* Vision Processing Accelerator (VPAC) with image signal processor and Depth
  and Motion Processing Accelerator (DMPAC)
* Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
  PRUs and dual RTUs
* Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
  up to two DPI interfaces.
* Integrated Ethernet switch supporting up to a total of 8 external ports in
  addition to legacy Ethernet switch of up to 2 ports.
* System MMU (SMMU) Version 3.0 and advanced virtualisation
  capabilities.
* Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
  16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
  I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
* Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
  management.
* Configurable L3 Cache and IO-coherent architecture with high data throughput
  capable distributed DMA architecture under NAVSS
* Centralized System Controller for Security, Power, and Resource
  Management (DMSC)

See J721E Technical Reference Manual (SPRUIL1, May 2019)
for further details: http://www.ti.com/lit/pdf/spruil1

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
index 6a059cabb2da..333e7256126a 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.txt
+++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
@@ -13,6 +13,9 @@ architecture it uses, using one of the following compatible values:
 - AM654
   compatible = "ti,am654";
 
+- J721E
+  compatible = "ti,j721e";
+
 Boards
 ------
 
-- 
2.21.0.777.g83232e38648b

