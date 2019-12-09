Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CDCC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8848207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VPLU7VDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfLILJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:36 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:20226 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727731AbfLILJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B9QlU029232;
        Mon, 9 Dec 2019 05:09:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=ytfwSFfXRj6bDTvmt8cvHWOAoK0OCuFICJ+RmAJfG3A=;
 b=VPLU7VDxE4xf0fcuFHaeZtrIQoetjjKCEUz+Qxo7BVMhBUR60CksHdp32PAUixK1dIHO
 h4b7F1gFTk9rYU12HKbeWoj8Ryn6H74sjQr6YjHMpTJL0YtNM4HlZ68ItLEdTEkQt5fN
 2Au1QpxloE6umj2Bc1b7DKR9WcnXe3sT83dgbrATEg2TSY8iuuG5F7+rRGZbe/a5HNAN
 cUCG+kJaHkLIl85apPiaKl3dRNVVoRYwV5O7/4B933ttop6GsUDybM6Arip8HFkMusHi
 1djah/bpqCjleMyAaDp/01iBHDRyvlWhMWGHOAv/qjQgr7UteQW4mIHWbIjqMjEDEVX5 WA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:27 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 93BD02A1;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] extcon: arizona: Factor out microphone impedance into a function
Date:   Mon, 9 Dec 2019 11:09:15 +0000
Message-ID: <20191209110916.29524-9-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=537
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The microphone detection handler is very long, start breaking it up
by factoring out the actual reading of the impedance value into a
separate functions. Additionally, this also fixes a minor bug and
ensures that the microphone timeout will be rescheduled in all error
cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 125 +++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index a0135f44cba1e..b09a9a8ce98bc 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -804,70 +804,55 @@ static void arizona_micd_timeout_work(struct work_struct *work)
 	mutex_unlock(&info->lock);
 }
 
-static void arizona_micd_detect(struct work_struct *work)
+static int arizona_micd_adc_read(struct arizona_extcon_info *info)
 {
-	struct arizona_extcon_info *info = container_of(work,
-						struct arizona_extcon_info,
-						micd_detect_work.work);
 	struct arizona *arizona = info->arizona;
-	unsigned int val = 0, lvl;
-	int ret, i, key;
-
-	cancel_delayed_work_sync(&info->micd_timeout_work);
+	unsigned int val;
+	int ret;
 
-	mutex_lock(&info->lock);
+	/* Must disable MICD before we read the ADCVAL */
+	regmap_update_bits(arizona->regmap, ARIZONA_MIC_DETECT_1,
+			   ARIZONA_MICD_ENA, 0);
 
-	/* If the cable was removed while measuring ignore the result */
-	ret = extcon_get_state(info->edev, EXTCON_MECHANICAL);
-	if (ret < 0) {
-		dev_err(arizona->dev, "Failed to check cable state: %d\n",
-				ret);
-		mutex_unlock(&info->lock);
-		return;
-	} else if (!ret) {
-		dev_dbg(arizona->dev, "Ignoring MICDET for removed cable\n");
-		mutex_unlock(&info->lock);
-		return;
+	ret = regmap_read(arizona->regmap, ARIZONA_MIC_DETECT_4, &val);
+	if (ret != 0) {
+		dev_err(arizona->dev,
+			"Failed to read MICDET_ADCVAL: %d\n", ret);
+		return ret;
 	}
 
-	if (info->detecting && arizona->pdata.micd_software_compare) {
-		/* Must disable MICD before we read the ADCVAL */
-		regmap_update_bits(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				   ARIZONA_MICD_ENA, 0);
-		ret = regmap_read(arizona->regmap, ARIZONA_MIC_DETECT_4, &val);
-		if (ret != 0) {
-			dev_err(arizona->dev,
-				"Failed to read MICDET_ADCVAL: %d\n",
-				ret);
-			mutex_unlock(&info->lock);
-			return;
-		}
+	dev_dbg(arizona->dev, "MICDET_ADCVAL: %x\n", val);
 
-		dev_dbg(arizona->dev, "MICDET_ADCVAL: %x\n", val);
+	val &= ARIZONA_MICDET_ADCVAL_MASK;
+	if (val < ARRAY_SIZE(arizona_micd_levels))
+		val = arizona_micd_levels[val];
+	else
+		val = INT_MAX;
+
+	if (val <= QUICK_HEADPHONE_MAX_OHM)
+		val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_0;
+	else if (val <= MICROPHONE_MIN_OHM)
+		val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_1;
+	else if (val <= MICROPHONE_MAX_OHM)
+		val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_8;
+	else
+		val = ARIZONA_MICD_LVL_8;
 
-		val &= ARIZONA_MICDET_ADCVAL_MASK;
-		if (val < ARRAY_SIZE(arizona_micd_levels))
-			val = arizona_micd_levels[val];
-		else
-			val = INT_MAX;
-
-		if (val <= QUICK_HEADPHONE_MAX_OHM)
-			val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_0;
-		else if (val <= MICROPHONE_MIN_OHM)
-			val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_1;
-		else if (val <= MICROPHONE_MAX_OHM)
-			val = ARIZONA_MICD_STS | ARIZONA_MICD_LVL_8;
-		else
-			val = ARIZONA_MICD_LVL_8;
-	}
+	return val;
+}
+
+static int arizona_micd_read(struct arizona_extcon_info *info)
+{
+	struct arizona *arizona = info->arizona;
+	unsigned int val = 0;
+	int ret, i;
 
 	for (i = 0; i < 10 && !(val & MICD_LVL_0_TO_8); i++) {
 		ret = regmap_read(arizona->regmap, ARIZONA_MIC_DETECT_3, &val);
 		if (ret != 0) {
 			dev_err(arizona->dev,
 				"Failed to read MICDET: %d\n", ret);
-			mutex_unlock(&info->lock);
-			return;
+			return ret;
 		}
 
 		dev_dbg(arizona->dev, "MICDET: %x\n", val);
@@ -875,17 +860,53 @@ static void arizona_micd_detect(struct work_struct *work)
 		if (!(val & ARIZONA_MICD_VALID)) {
 			dev_warn(arizona->dev,
 				 "Microphone detection state invalid\n");
-			mutex_unlock(&info->lock);
-			return;
+			return -EINVAL;
 		}
 	}
 
 	if (i == 10 && !(val & MICD_LVL_0_TO_8)) {
 		dev_err(arizona->dev, "Failed to get valid MICDET value\n");
+		return -EINVAL;
+	}
+
+	return val;
+}
+
+static void arizona_micd_detect(struct work_struct *work)
+{
+	struct arizona_extcon_info *info = container_of(work,
+						struct arizona_extcon_info,
+						micd_detect_work.work);
+	struct arizona *arizona = info->arizona;
+	unsigned int val = 0, lvl;
+	int ret, i, key;
+
+	cancel_delayed_work_sync(&info->micd_timeout_work);
+
+	mutex_lock(&info->lock);
+
+	/* If the cable was removed while measuring ignore the result */
+	ret = extcon_get_state(info->edev, EXTCON_MECHANICAL);
+	if (ret < 0) {
+		dev_err(arizona->dev, "Failed to check cable state: %d\n",
+				ret);
+		mutex_unlock(&info->lock);
+		return;
+	} else if (!ret) {
+		dev_dbg(arizona->dev, "Ignoring MICDET for removed cable\n");
 		mutex_unlock(&info->lock);
 		return;
 	}
 
+	if (info->detecting && arizona->pdata.micd_software_compare)
+		ret = arizona_micd_adc_read(info);
+	else
+		ret = arizona_micd_read(info);
+	if (ret < 0)
+		goto handled;
+
+	val = ret;
+
 	/* Due to jack detect this should never happen */
 	if (!(val & ARIZONA_MICD_STS)) {
 		dev_warn(arizona->dev, "Detected open circuit\n");
-- 
2.11.0

