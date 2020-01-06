Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD163C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D87520731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WLI4MLEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgAFK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:28:40 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:24856 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgAFK2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:28:38 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006AROxs028101;
        Mon, 6 Jan 2020 04:28:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=cOxcJD+Lc4UC9Fkbdb/jyzG0svJ2Ook/lkEpJNUgUsc=;
 b=WLI4MLEpg9rda78JydxOhPfNHE8Y4WRekwXdshdBWX5nXCCWeIqOZhIdxv+j5hQDXLM9
 otkng7oQiAPi/DLQpFFOhTs+q6UcCvhC2mMwjjHrT/glv97xlnDTbXshscHxgXDRJIxX
 LIWhfd3NYMtUAUkWMDxa1MhfINybmf0eg6PCz+eBF+nYZ3AUlq1BhqEFS4BhouThJ3TN
 WlNI/th14hd1GaXLZ6TOiV4gfklcGiQmQqFS8UaVi/zpMLzhscS8FLohRdpsZitEkO4q
 RTkpkLpN3L5GaJDqQD1ebQBNRDD6tUS33WJKCtBSipQxs86AJ8vsRj0vtqZD+vnicBt+ CA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xar0t9x7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jan 2020 04:28:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 6 Jan
 2020 10:28:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 6 Jan 2020 10:28:34 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6F1272C8;
        Mon,  6 Jan 2020 10:28:34 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] mfd: madera: Allow more time for hardware reset
Date:   Mon, 6 Jan 2020 10:28:33 +0000
Message-ID: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=1
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001060096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both manual and power on resets have a brief period where the chip will
not be accessible immediately afterwards. Extend the time allowed for
this from a minimum of 1mS to 2mS based on newer evaluation of the
hardware and ensure this reset happens in all reset conditions. Whilst
making the change also remove the redundant NULL checks in the reset
functions as the GPIO functions already check for this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a8cfadc1fc01e..f41ce408259fb 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -238,6 +238,11 @@ static int madera_wait_for_boot(struct madera *madera)
 	return ret;
 }
 
+static inline void madera_reset_delay(void)
+{
+	usleep_range(2000, 3000);
+}
+
 static int madera_soft_reset(struct madera *madera)
 {
 	int ret;
@@ -249,16 +254,13 @@ static int madera_soft_reset(struct madera *madera)
 	}
 
 	/* Allow time for internal clocks to startup after reset */
-	usleep_range(1000, 2000);
+	madera_reset_delay();
 
 	return 0;
 }
 
 static void madera_enable_hard_reset(struct madera *madera)
 {
-	if (!madera->pdata.reset)
-		return;
-
 	/*
 	 * There are many existing out-of-tree users of these codecs that we
 	 * can't break so preserve the expected behaviour of setting the line
@@ -269,11 +271,9 @@ static void madera_enable_hard_reset(struct madera *madera)
 
 static void madera_disable_hard_reset(struct madera *madera)
 {
-	if (!madera->pdata.reset)
-		return;
-
 	gpiod_set_raw_value_cansleep(madera->pdata.reset, 1);
-	usleep_range(1000, 2000);
+
+	madera_reset_delay();
 }
 
 static int __maybe_unused madera_runtime_resume(struct device *dev)
@@ -292,6 +292,8 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
+	madera_reset_delay();
+
 	ret = madera_wait_for_boot(madera);
 	if (ret)
 		goto err;
-- 
2.11.0

