Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59229CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2627420640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="feccwS9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405482AbfJWM6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:58:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405447AbfJWM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:58:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9NCwblk040880;
        Wed, 23 Oct 2019 07:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571835517;
        bh=P6eFdtK+KQxmYKfuUnnvAtDNy0O8X0nYyKSWPvRJKzQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=feccwS9eartm0CHg3TNaBNKDEvBSxz1DZR8iDZAw+onlM3l+aXBHnwXmC0zj2eQJH
         r8BkI9wLm2D5TWYX9XC9wh56NvPp3iLobs4eYJZXV/LWm9ec5nZJ1G49iODWs4yJ6O
         +s6vpVrIvv1V2rvbvwyGmCsg6GVYh0sQRnWRurc8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9NCwbUo042820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 07:58:37 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 07:58:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 07:58:27 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9NCw5oG061147;
        Wed, 23 Oct 2019 07:58:35 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 12/14] phy: cadence: Sierra: Use correct dev pointer in cdns_sierra_phy_remove()
Date:   Wed, 23 Oct 2019 18:27:33 +0530
Message-ID: <20191023125735.4713-13-kishon@ti.com>
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

commit 44d30d622821d3b ("phy: cadence: Add driver for Sierra PHY"),
incorrectly used parent device pointer to get driver data. Fix it here.

Fixes: 44d30d622821d3b ("phy: cadence: Add driver for Sierra PHY")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index affede8c4368..04c28cbb6d39 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -623,7 +623,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 static int cdns_sierra_phy_remove(struct platform_device *pdev)
 {
-	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+	struct cdns_sierra_phy *phy = platform_get_drvdata(pdev);
 	int i;
 
 	reset_control_assert(phy->phy_rst);
-- 
2.17.1

