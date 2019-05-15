Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B932084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L5dYEcvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEOKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:08:34 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53700 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:08:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4FA8Tg3031049;
        Wed, 15 May 2019 05:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557914909;
        bh=5pBMxCh2c/vGT3vCMvtbBf+ST8lnuJ/P/LZ+J1DjGYQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L5dYEcvtZ8Jc4an1+RR2GbXCwvc7K/KQaUUkODxAWSn9DGPVmGLEv+zWrLxPuHQMW
         RGlb8UsfXDtN9pv74QKCfWSIiF+rsBsKE3L4v20nLiUaMjxGJY2t4HAexaDwiqFHVf
         t9nDfy1vASoT1OdhCjNe9wgtafpCTWJk8BOK3Q2Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4FA8SuE123755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 May 2019 05:08:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 15
 May 2019 05:08:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 15 May 2019 05:08:28 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4FA8Jda030606;
        Wed, 15 May 2019 05:08:26 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 2/3] mfd: lp87565: Add support for 4-phase lp87561 combination
Date:   Wed, 15 May 2019 15:38:47 +0530
Message-ID: <20190515100848.19560-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515100848.19560-1-j-keerthy@ti.com>
References: <20190515100848.19560-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 4-phase lp87561 combination.

Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/lp87565.c       | 4 ++++
 include/linux/mfd/lp87565.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 32d2a07d4354..8ad688fe75f9 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -33,6 +33,10 @@ static const struct of_device_id of_lp87565_match_table[] = {
 		.compatible = "ti,lp87565-q1",
 		.data = (void *)LP87565_DEVICE_TYPE_LP87565_Q1,
 	},
+	{
+		.compatible = "ti,lp87561-q1",
+		.data = (void *)LP87565_DEVICE_TYPE_LP87561_Q1,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_lp87565_match_table);
diff --git a/include/linux/mfd/lp87565.h b/include/linux/mfd/lp87565.h
index d0c91ba65525..976447607ea2 100644
--- a/include/linux/mfd/lp87565.h
+++ b/include/linux/mfd/lp87565.h
@@ -17,6 +17,7 @@
 
 enum lp87565_device_type {
 	LP87565_DEVICE_TYPE_UNKNOWN	= 0,
+	LP87565_DEVICE_TYPE_LP87561_Q1,
 	LP87565_DEVICE_TYPE_LP87565_Q1,
 };
 
@@ -249,6 +250,7 @@ enum LP87565_regulator_id {
 	LP87565_BUCK_3,
 	LP87565_BUCK_10,
 	LP87565_BUCK_23,
+	LP87565_BUCK_3210,
 };
 
 /**
-- 
2.17.1

