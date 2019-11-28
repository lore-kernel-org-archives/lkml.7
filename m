Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4262C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDEE21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bP5Ky/rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfK1Kry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:47:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58034 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfK1Krw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:47:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASAll4A096685;
        Thu, 28 Nov 2019 04:47:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938067;
        bh=agcoWtKSTenRqtUlTyzEyGcBRm6Q0+Ai3WNO3BmnFjE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bP5Ky/rGWNRIJXiEqUEJ3ULSyhXE+Rtzp8Zic6HwXGobf24j5w9oaqrGKcqZ3L/8y
         Tj2pAvhUnCDG+LRGvFaNIvTBWip7QGaV3oLNydvX6bJdm6YURNewSW/8KylHoPrslk
         Gdd9nJHaazzctcWjYQhH6H1rD18OSwoM1Nb4gJPo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASAllbp126409
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 04:47:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 04:47:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 04:47:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAlX41098163;
        Thu, 28 Nov 2019 04:47:44 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 04/14] phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
Date:   Thu, 28 Nov 2019 16:16:38 +0530
Message-ID: <20191128104648.21894-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128104648.21894-1-kishon@ti.com>
References: <20191128104648.21894-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SERDES_16G in TI's J721E SoC uses Cadence Sierra PHY. Add
support to use Cadence Sierra driver in J721E SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index c60809f615af..d3b0dac2db77 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -553,11 +553,25 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	cdns_usb_regs
 };
 
+static const struct cdns_sierra_data cdns_ti_map_sierra = {
+	SIERRA_MACRO_ID,
+	0x0,
+	0x1,
+	ARRAY_SIZE(cdns_pcie_regs),
+	ARRAY_SIZE(cdns_usb_regs),
+	cdns_pcie_regs,
+	cdns_usb_regs
+};
+
 static const struct of_device_id cdns_sierra_id_table[] = {
 	{
 		.compatible = "cdns,sierra-phy-t0",
 		.data = &cdns_map_sierra,
 	},
+	{
+		.compatible = "ti,sierra-phy-t0",
+		.data = &cdns_ti_map_sierra,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
-- 
2.17.1

