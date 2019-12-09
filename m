Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C878FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBBE2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CaDSy5fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLILc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:32:57 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:17780 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727412AbfLILc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:32:57 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9BUfjx015458;
        Mon, 9 Dec 2019 05:32:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Wfwz0JBha5yb+vEJD1AnM22AO8M2TkTcB/GNhCOoR1M=;
 b=CaDSy5fyRk6uIzHSCPbMsfKBiq5NEY8UxTqtnvyglVxYHPNqWm7lHcROYECVrcIs12Ys
 4j1ILZPQl8SbRtWg7G2UcXpJrIuHsto4HFNOOR9QUbotn7NTXIt9qiJSNtf+pxNT4TEr
 919rBVNcNsuQkySOd7dctZstKnl6KQV87lzddzgncT2UQKW67WIBbLPLb6uhTXyNfGJR
 SnNRbmJw/Y5RzbDP31I0BHdRkmUj2GTDQbOW5YoclGgEfqnhkKDF68GFSWQOKpK1OKaD
 ZocoYmVD3g3JuCfIx7aKd4IRqCR2OWR0LaKi2iuU6TC1hFUmVdAFcqgHZ8w5g9kUtoZC 4w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j1bw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:32:54 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:32:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:32:51 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 46C162A1;
        Mon,  9 Dec 2019 11:32:51 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mfd: madera: Improve handling of regulator unbinding
Date:   Mon, 9 Dec 2019 11:32:50 +0000
Message-ID: <20191209113251.18692-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=1 mlxlogscore=785
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current unbinding process for Madera has some issues. The trouble
is runtime PM is disabled as the first step of the process, but
some of the drivers release IRQs causing regmap IRQ to issue a
runtime get which fails. To allow runtime PM to remain enabled during
mfd_remove_devices, the DCVDD regulator must remain available. In
the case of external DCVDD's this is simple, the regulator can simply
be disabled/put after the call to mfd_remove_devices. However, in
the case of an internally supplied DCVDD the regulator needs to be
released after all the MFD children, except for the regulator child
itself, have been removed. This is achieved by having the regulator
driver itself do the disable/put, as it is the last driver removed from
the MFD.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a8cfadc1fc01e..5170b55836fc1 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -730,18 +730,22 @@ int madera_dev_exit(struct madera *madera)
 	/* Prevent any IRQs being serviced while we clean up */
 	disable_irq(madera->irq);
 
-	/*
-	 * DCVDD could be supplied by a child node, we must disable it before
-	 * removing the children, and prevent PM runtime from turning it back on
-	 */
+	pm_runtime_get_sync(madera->dev);
+
+	mfd_remove_devices(madera->dev);
+
 	pm_runtime_disable(madera->dev);
 
-	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
+	if (!madera->internal_dcvdd) {
+		regulator_disable(madera->dcvdd);
+		regulator_put(madera->dcvdd);
+	}
 
-	regulator_disable(madera->dcvdd);
-	regulator_put(madera->dcvdd);
+	pm_runtime_set_suspended(madera->dev);
+	pm_runtime_put_noidle(madera->dev);
+
+	clk_disable_unprepare(madera->mclk[MADERA_MCLK2].clk);
 
-	mfd_remove_devices(madera->dev);
 	madera_enable_hard_reset(madera);
 
 	regulator_bulk_disable(madera->num_core_supplies,
-- 
2.11.0

