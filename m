Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282ACA9EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B1208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 10:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oz0vzEPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfJ1KWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:22:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36652 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbfJ1KWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:22:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9SAM4lq017831;
        Mon, 28 Oct 2019 05:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572258124;
        bh=aZ5vSfLI7IEX6A4bp3VeoImtgXF8hKwoS6ngiBVedGY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oz0vzEPJx+/9rGcvRua6itw2qL4/vz8gw8aLfzc8CTBdslytd/5VsJDXtyCJd8IXp
         UN5pfKhiAhrzlgsPK0mRw4Fusy2/0nN8YAl5leQzQ5JGhRIx1v5pYFyshkWr2Y1fhR
         vafiXQruPDbOKvF+lh6ustTf/UpRTKKDR83ft6qc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9SAM48Z077369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Oct 2019 05:22:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 28
 Oct 2019 05:21:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 28 Oct 2019 05:21:52 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9SALwqG024783;
        Mon, 28 Oct 2019 05:22:01 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 1/3] phy: cadence: Sierra: add phy_reset hook
Date:   Mon, 28 Oct 2019 12:21:51 +0200
Message-ID: <20191028102153.24866-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028102153.24866-1-rogerq@ti.com>
References: <20191028102153.24866-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms e.g. J721e need lane swap register
to be programmed before reset is deasserted.
This patch ensures that we propagate the phy_reset
back to the reset controller driver.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 04c28cbb6d39..7fed61211716 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -339,10 +339,20 @@ static int cdns_sierra_phy_off(struct phy *gphy)
 	return reset_control_assert(ins->lnk_rst);
 }
 
+static int cdns_sierra_phy_reset(struct phy *gphy)
+{
+	struct cdns_sierra_phy *sp = dev_get_drvdata(gphy->dev.parent);
+
+	reset_control_assert(sp->phy_rst);
+	reset_control_deassert(sp->phy_rst);
+	return 0;
+};
+
 static const struct phy_ops ops = {
 	.init		= cdns_sierra_phy_init,
 	.power_on	= cdns_sierra_phy_on,
 	.power_off	= cdns_sierra_phy_off,
+	.reset		= cdns_sierra_phy_reset,
 	.owner		= THIS_MODULE,
 };
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

