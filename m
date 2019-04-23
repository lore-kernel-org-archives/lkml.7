Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847DCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B7120843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nzWJKQEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfDWGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:06:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38586 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:06:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3N65vW4097926;
        Tue, 23 Apr 2019 01:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555999557;
        bh=J2zT+LR12Ogn3aduBhqlwatG9kR5GFN1+eqq1CoI5Co=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nzWJKQEENR/6uT1PFzzt3hZGTH1AfrMna/S2tv5UlfdHV+L6B0end96s1zzZw85V3
         qX+z6Of69jIvJMU8eg9b96L6l/+pJGRKVOvlNFf+xX6PcdkvH0KEl804yfadm7J7XZ
         PP/z/JE1V6c16DU53HfJ4+ld0ClEeAJE0PS+zx4U=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3N65vEt069464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 01:05:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 01:05:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 01:05:57 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3N65gFC091279;
        Tue, 23 Apr 2019 01:05:52 -0500
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] dt-bindings: mtd: Add binding documentation for HyperFlash
Date:   Tue, 23 Apr 2019 11:36:35 +0530
Message-ID: <20190423060638.18197-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423060638.18197-1-vigneshr@ti.com>
References: <20190423060638.18197-1-vigneshr@ti.com>
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
 .../devicetree/bindings/mtd/cypress,hyperflash.txt          | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt

diff --git a/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
new file mode 100644
index 000000000000..7fb7d82bb042
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
@@ -0,0 +1,6 @@
+Bindings for HyperFlash NOR flash chips compliant with Cypress HyperBus
+specification and supports Cypress CFI specification 1.5 command set.
+
+Required properties:
+- compatible : "cypress,hyperflash", "cfi-flash" for HyperFlash NOR chips
+- reg : Address where flash's memory mapped space
-- 
2.21.0

