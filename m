Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249ECC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D09206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bNB47ZmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDWKtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:49:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35630 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfDWKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:48:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NAmcfj122723;
        Tue, 23 Apr 2019 05:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556016518;
        bh=xpPNBkG1Y2+HbPauF3JjjEGmy6v6mgstKeWM5f9esj8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bNB47ZmMUo1hLJ7K4b6BPWWsG/gNqzgTcULVdbrZ3xvucMZyXaVoITxYx57g4wnxc
         JJ1HSYWcNtqN3oDMEgmyeaIsTnTsPImzpdXiA0tLwpGB8sB97RlCzSE22ozhiW8fez
         3ac+JruBAlooigibvmANclt/5iKu8hGu7mcAObTU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NAmcGb092935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 05:48:38 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 05:48:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 05:48:38 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NAmNNP070020;
        Tue, 23 Apr 2019 05:48:33 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 2/5] dt-bindings: mtd: Add binding documentation for HyperFlash
Date:   Tue, 23 Apr 2019 16:18:11 +0530
Message-ID: <20190423104814.5762-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423104814.5762-1-vigneshr@ti.com>
References: <20190423104814.5762-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for HyperFlash devices.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../devicetree/bindings/mtd/cypress,hyperflash.txt  | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt

diff --git a/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
new file mode 100644
index 000000000000..ad42f4db32f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
@@ -0,0 +1,13 @@
+Bindings for HyperFlash NOR flash chips compliant with Cypress HyperBus
+specification and supports Cypress CFI specification 1.5 command set.
+
+Required properties:
+- compatible : "cypress,hyperflash", "cfi-flash" for HyperFlash NOR chips
+- reg : Address of flash's memory map
+
+Example:
+
+	flash@0 {
+		compatible = "cypress,hyperflash", "cfi-flash";
+		reg = <0x0 0x4000000>;
+	};
-- 
2.21.0

