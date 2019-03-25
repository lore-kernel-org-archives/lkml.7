Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F96C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D5B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kIk7vXj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfCYIJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:09:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47934 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfCYIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:09:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2P89FRU091487;
        Mon, 25 Mar 2019 03:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553501355;
        bh=uf3kjAaOPFCPxUbTLMm7tK0cexSLaZI+4gMmasE/zBA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kIk7vXj7bFQRnf4zxkZhKmUqlmpKly/I82wFOBloMUZZSZ4XUibzXwMsBaNuxW7j/
         l26yGJGVpq6HhMvb968h7omh5LA4vtZXTYVCUYIcOS6Aex4Aq+3cERV3eIVPldQ4xJ
         bo6hByKqwjzNlHNT9onvt6XFVE4SxfTaKTAQ08bw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2P89FiU053857
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 03:09:15 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 03:09:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 03:09:15 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2P89AkX019470;
        Mon, 25 Mar 2019 03:09:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/5] phy: core: Add *release* phy_ops invoked when the consumer relinquishes PHY
Date:   Mon, 25 Mar 2019 13:38:11 +0530
Message-ID: <20190325080815.6056-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325080815.6056-1-kishon@ti.com>
References: <20190325080815.6056-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new phy_ops *release* invoked when the consumer relinquishes the
PHY using phy_put/devm_phy_put. The initializations done by the PHY
driver in of_xlate call back can be can be cleaned up here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c  | 5 +++++
 include/linux/phy/phy.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index cb38f6e8614c..b9a4ebf35dd3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -564,6 +564,11 @@ void phy_put(struct phy *phy)
 	if (!phy || IS_ERR(phy))
 		return;
 
+	mutex_lock(&phy->mutex);
+	if (phy->ops->release)
+		phy->ops->release(phy);
+	mutex_unlock(&phy->mutex);
+
 	module_put(phy->ops->owner);
 	put_device(&phy->dev);
 }
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 3f350e2749fe..ef13aea1d370 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -64,6 +64,7 @@ union phy_configure_opts {
  * @set_mode: set the mode of the phy
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
+ * @release: ops to be performed while the consumer relinquishes the PHY
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -105,6 +106,7 @@ struct phy_ops {
 			    union phy_configure_opts *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
+	void	(*release)(struct phy *phy);
 	struct module *owner;
 };
 
-- 
2.17.1

