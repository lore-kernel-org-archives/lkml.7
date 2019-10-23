Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99473CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7014821872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="veHln+b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfJWIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:49:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390331AbfJWIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:49:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nOFc093697;
        Wed, 23 Oct 2019 03:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571820564;
        bh=Vg5p/9UukhFhBnfEC9XZnlFxpQ+4sUdE5PCioPm1To8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=veHln+b8aWMlD1JjoyyZnRwTAYw7/7ZJ9V88dcI17pE6QJKZtu1Wbb0PBEUxsPN99
         gBF5MWZxsfG+WpVGDh32G0/5gM8Hvyw3vTb52trhdKdd/qDouCVpkiVhTnxkZmLUcw
         IX/yA0VS9sptF8RqohqOckiBIAUnQMGnEnxjcrkE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9N8nNQE127748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Oct 2019 03:49:24 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 03:49:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 23 Oct 2019 03:49:21 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9N8nHVu061069;
        Wed, 23 Oct 2019 03:49:19 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <aniljoy@cadence.com>, <adouglas@cadence.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 1/3] phy: cadence: Sierra: add phy_reset hook
Date:   Wed, 23 Oct 2019 11:49:14 +0300
Message-ID: <20191023084916.26895-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023084916.26895-1-rogerq@ti.com>
References: <20191023084916.26895-1-rogerq@ti.com>
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

