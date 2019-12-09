Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E300C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53DF214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T6Gt5Nj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfLILJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:52 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50580 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbfLILJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B9QlS029232;
        Mon, 9 Dec 2019 05:09:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=ym6kfIQD42mj/pTe4a7KrSmx9htHfF/a91M496Omccc=;
 b=T6Gt5Nj9sNxMEedMWulkpTmY3eaUGfXXT7RxmFtdbjdwSMhMeAuhuABUO1/EsFqrgK1k
 9nobaQJiqPtRnymNKmIQhM61t4mAZzAeg7Apqj5VZ+q9G0YD1Fm6EYX0On7nzYjPdDvo
 8vCl71hVWUbjMPW9jo7clNqUF8Ze3yZbi+fQuh1hNOlze6+0MnAfpTI4IpO54GXmbyBc
 LF15K11gQ2dktND/oYRKz81SCmBNvEyUpC9Lj8kr+fyBHlU/yf64dYE3SX9/F8iGP2sc
 XT+pwJODOzYaYXoGQjefC4a9+IL5Sg3KF7hnkUjOSqcUjP04Zihyeuq3OIwaqmHpRqqe JQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 871302C8;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/10] extcon: arizona: Invert logic of check in arizona_hpdet_do_id
Date:   Mon, 9 Dec 2019 11:09:14 +0000
Message-ID: <20191209110916.29524-8-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=886
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the check of hpdet_acc_id at the top of arizona_hpdet_do_id to
reduce the identation within the function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 92 ++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 3f7ced35e0b86..a0135f44cba1e 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -533,67 +533,65 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
 	struct arizona *arizona = info->arizona;
 	int id_gpio = arizona->pdata.hpdet_id_gpio;
 
+	if (!arizona->pdata.hpdet_acc_id)
+		return 0;
+
 	/*
 	 * If we're using HPDET for accessory identification we need
 	 * to take multiple measurements, step through them in sequence.
 	 */
-	if (arizona->pdata.hpdet_acc_id) {
-		info->hpdet_res[info->num_hpdet_res++] = *reading;
+	info->hpdet_res[info->num_hpdet_res++] = *reading;
 
-		/* Only check the mic directly if we didn't already ID it */
-		if (id_gpio && info->num_hpdet_res == 1) {
-			dev_dbg(arizona->dev, "Measuring mic\n");
-
-			regmap_update_bits(arizona->regmap,
-					   ARIZONA_ACCESSORY_DETECT_MODE_1,
-					   ARIZONA_ACCDET_MODE_MASK |
-					   ARIZONA_ACCDET_SRC,
-					   ARIZONA_ACCDET_MODE_HPR |
-					   info->micd_modes[0].src);
+	/* Only check the mic directly if we didn't already ID it */
+	if (id_gpio && info->num_hpdet_res == 1) {
+		dev_dbg(arizona->dev, "Measuring mic\n");
 
-			gpio_set_value_cansleep(id_gpio, 1);
+		regmap_update_bits(arizona->regmap,
+				   ARIZONA_ACCESSORY_DETECT_MODE_1,
+				   ARIZONA_ACCDET_MODE_MASK |
+				   ARIZONA_ACCDET_SRC,
+				   ARIZONA_ACCDET_MODE_HPR |
+				   info->micd_modes[0].src);
 
-			regmap_update_bits(arizona->regmap,
-					   ARIZONA_HEADPHONE_DETECT_1,
-					   ARIZONA_HP_POLL, ARIZONA_HP_POLL);
-			return -EAGAIN;
-		}
+		gpio_set_value_cansleep(id_gpio, 1);
 
-		/* OK, got both.  Now, compare... */
-		dev_dbg(arizona->dev, "HPDET measured %d %d\n",
-			info->hpdet_res[0], info->hpdet_res[1]);
+		regmap_update_bits(arizona->regmap, ARIZONA_HEADPHONE_DETECT_1,
+				   ARIZONA_HP_POLL, ARIZONA_HP_POLL);
+		return -EAGAIN;
+	}
 
-		/* Take the headphone impedance for the main report */
-		*reading = info->hpdet_res[0];
+	/* OK, got both.  Now, compare... */
+	dev_dbg(arizona->dev, "HPDET measured %d %d\n",
+		info->hpdet_res[0], info->hpdet_res[1]);
 
-		/* Sometimes we get false readings due to slow insert */
-		if (*reading >= ARIZONA_HPDET_MAX && !info->hpdet_retried) {
-			dev_dbg(arizona->dev, "Retrying high impedance\n");
-			info->num_hpdet_res = 0;
-			info->hpdet_retried = true;
-			arizona_start_hpdet_acc_id(info);
-			pm_runtime_put(info->dev);
-			return -EAGAIN;
-		}
+	/* Take the headphone impedance for the main report */
+	*reading = info->hpdet_res[0];
 
-		/*
-		 * If we measure the mic as high impedance
-		 */
-		if (!id_gpio || info->hpdet_res[1] > 50) {
-			dev_dbg(arizona->dev, "Detected mic\n");
-			*mic = true;
-			info->detecting = true;
-		} else {
-			dev_dbg(arizona->dev, "Detected headphone\n");
-		}
+	/* Sometimes we get false readings due to slow insert */
+	if (*reading >= ARIZONA_HPDET_MAX && !info->hpdet_retried) {
+		dev_dbg(arizona->dev, "Retrying high impedance\n");
+		info->num_hpdet_res = 0;
+		info->hpdet_retried = true;
+		arizona_start_hpdet_acc_id(info);
+		pm_runtime_put(info->dev);
+		return -EAGAIN;
+	}
 
-		/* Make sure everything is reset back to the real polarity */
-		regmap_update_bits(arizona->regmap,
-				   ARIZONA_ACCESSORY_DETECT_MODE_1,
-				   ARIZONA_ACCDET_SRC,
-				   info->micd_modes[0].src);
+	/*
+	 * If we measure the mic as high impedance
+	 */
+	if (!id_gpio || info->hpdet_res[1] > 50) {
+		dev_dbg(arizona->dev, "Detected mic\n");
+		*mic = true;
+		info->detecting = true;
+	} else {
+		dev_dbg(arizona->dev, "Detected headphone\n");
 	}
 
+	/* Make sure everything is reset back to the real polarity */
+	regmap_update_bits(arizona->regmap, ARIZONA_ACCESSORY_DETECT_MODE_1,
+			   ARIZONA_ACCDET_SRC, info->micd_modes[0].src);
+
 	return 0;
 }
 
-- 
2.11.0

