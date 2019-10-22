Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C394CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6365E21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MhoFLSVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfJVNX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:23:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42626 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfJVNX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:23:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MDNROO087130;
        Tue, 22 Oct 2019 08:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571750607;
        bh=IjFogRcV5VPblbZbB1hDvqvhqSLBqIveS+AehjX8pis=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MhoFLSVqvtpPys7QuSBA59p1W8YLj77oQ93Sy2Yhc3QFXGCEYXYUiqpTtkVo06Vec
         KWjo2LjCONXFgTfmPnmYFdgzvd2aCd3hHnI9ypXfBjNoId94jMGdM+y7F9vw7QeofR
         PBP9i0f2oa5nwUhTuRRG2790UVfIfPyvZ9xlNXUc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MDNC5p068138
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 08:23:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 08:23:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 08:23:11 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9MDMplZ126427;
        Tue, 22 Oct 2019 08:22:54 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/3] phy: cadence: Sierra: add phy_reset hook
Date:   Tue, 22 Oct 2019 16:22:47 +0300
Message-ID: <20191022132249.869-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022132249.869-1-rogerq@ti.com>
References: <20191022132249.869-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required if type C driver needs to hold
global reset on J7ES to perform LN10 swap.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index affede8c4368..e6d27bdec22a 100644
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

