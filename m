Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D26C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E1215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rsjkF7M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLPJ4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:31 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58798 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfLPJ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uKJU106107;
        Mon, 16 Dec 2019 03:56:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490180;
        bh=xsoCMaeYo5YfhzTn+vSlcz0XqN7p8MMRE1rbf+zv3po=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rsjkF7M/pzDNnWelB/P5Q1MKmcM3KGAZf5b8hrsLGRX4QfYrJrDFj5fBBymqnIMhT
         agdEQrDu6x0RAfqLxL1lizv1X5YqPDVeA/VuH4pbq5ByztbEe5qExDArj5uJH/U5r1
         lrFktN5cmqmuE/m9cwF6Nfpg4vfz7mqbatyil4Po=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBG9uKbt049441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Dec 2019 03:56:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:19 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJR084408;
        Mon, 16 Dec 2019 03:56:17 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 08/14] phy: cadence: Sierra: Get reset control "array" for each link
Date:   Mon, 16 Dec 2019 15:27:06 +0530
Message-ID: <20191216095712.13266-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A link may have multiple lanes each with a separate reset. Get
reset control "array" in order to reset all the lanes associated
with the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index fdca3bd178c6..497c83827670 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -499,7 +499,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		struct phy *gphy;
 
 		sp->phys[node].lnk_rst =
-			of_reset_control_get_exclusive_by_index(child, 0);
+			of_reset_control_array_get_exclusive(child);
 
 		if (IS_ERR(sp->phys[node].lnk_rst)) {
 			dev_err(dev, "failed to get reset %s\n",
-- 
2.17.1

