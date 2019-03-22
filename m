Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E0DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5699721873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U0BTqqzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCVI6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:58:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52124 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfCVI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:58:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8wLd7071009
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553245101;
        bh=WYQ3YkHVR4l79yltClpUWyBrd1XOrHVgrBA+RFSZlWw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U0BTqqzZvW1OKxoyICXuUreYAbIEUYqv4LOlfRdvQhc0HSabMjlO0IaHtM6XQpQhI
         bGOAWqEN6olG6eBNl2AGn7PpEkMs01tTxLB2du/69uxN6whhhybG6xLAlSuCTGe2pB
         AfTTvp+NNUtAqkF+cjz9gLei0BUdPvTQC8EMGh6I=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M8wLX1065817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:58:21 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:58:18 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:58:18 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M8w9bA016866;
        Fri, 22 Mar 2019 03:58:16 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] phy: ti-pipe3: Fix PCIe power up sequence
Date:   Fri, 22 Mar 2019 10:58:07 +0200
Message-ID: <20190322085807.30216-5-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322085807.30216-1-rogerq@ti.com>
References: <20190322085807.30216-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRM [1] mentions that we need to power up
PCIESS_PHY_TX and PCIESS_PHY_RX before configuring
PCIe_PHY_RX SCP settings.

See "Table 26-81. PCIePHY Subsystem Low-Level Programming Sequence".

[1] DRA75x, DRA74x TRM - http://www.ti.com/lit/ug/sprui30f/sprui30f.pdf

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-ti-pipe3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 71a7634c026d..1718ef36d290 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -341,6 +341,8 @@ static int ti_pipe3_power_off(struct phy *x)
 	return ret;
 }
 
+static void ti_pipe3_calibrate(struct ti_pipe3 *phy);
+
 static int ti_pipe3_power_on(struct phy *x)
 {
 	u32 val;
@@ -386,6 +388,9 @@ static int ti_pipe3_power_on(struct phy *x)
 				   mask, val);
 	}
 
+	if (phy->mode == PIPE3_MODE_PCIE)
+		ti_pipe3_calibrate(phy);
+
 	return 0;
 }
 
@@ -520,12 +525,7 @@ static int ti_pipe3_init(struct phy *x)
 		val = 0x96 << OMAP_CTRL_PCIE_PCS_DELAY_COUNT_SHIFT;
 		ret = regmap_update_bits(phy->pcs_syscon, phy->pcie_pcs_reg,
 					 PCIE_PCS_MASK, val);
-		if (ret)
-			return ret;
-
-		ti_pipe3_calibrate(phy);
-
-		return 0;
+		return ret;
 	}
 
 	/* Bring it out of IDLE if it is IDLE */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

