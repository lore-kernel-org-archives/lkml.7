Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24797CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7D021872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YdOYQ9Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405368AbfJWM6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52238 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404529AbfJWM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:20 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwIsw120358;
        Wed, 23 Oct 2019 07:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835498;
        bh=CeaOaqcl4Uu9ifeSuH7/fVJFutdpe4ac6xNqVwY2mwg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YdOYQ9Msnx4TVPdX5hygISVFBjjmv+hKzZ8ysFwHFROTcd1fZMiuc38Eb2IaqSNxb
         aMrSGCO/2Nwyb8ToOZUd5xp1kqrEmDDE8gjt4S80T/Jl64C9qHMCvBcOCpIVYSGkoT
         SlRGRPM3q68JerFua6GvFkrXZLMJTDi061C4vexM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwI3W070113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:07 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5o8061147;
        Wed, 23 Oct 2019 07:58:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 04/14] phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
Date:   Wed, 23 Oct 2019 18:27:25 +0530
Message-ID: <20191023125735.4713-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023125735.4713-1-kishon@ti.com>
References: <20191023125735.4713-1-kishon@ti.com>
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
index d0e7ae1c67b1..89a3b732c311 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -551,11 +551,25 @@ static const struct cdns_sierra_data cdns_map_sierra = {
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

