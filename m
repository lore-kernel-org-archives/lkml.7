Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4648E2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kVaxjB2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfLILJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:37 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:23858 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727580AbfLILJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B9QlV029232;
        Mon, 9 Dec 2019 05:09:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=E8Gko3t1/vmDhbyLkG6oaY0YzKBD04P+NBZ0WSQsnZk=;
 b=kVaxjB2mSa5m1m9e/QApHdfxaCeDCVMllOTyPtvFofJFpIwwXtLVveAh1rcKcrs8+gy/
 V1VzCA6FPL+z346wstGSnpNbVZPKyuVoHrOg8z/CR3TOyTBl7xDQOYo8a53roou23vV6
 AqXTIPokhLQQZUbGPxO5UxKRZG6YdAYLnhh9KlM9JCe98rJEkfryW859Sjp8gm4CzYEZ
 rR+RJFwa5LdJgViRU9Wsgi6msUJAdL61H6tlzcX8oFb48/akVAcTlEXhJiO4SocoOD/2
 x2Hb+5IOg/8aVT4Gfskr4Mm10I/jgylps3cNZ2JlZ3I9veUR4OmQIbAYeflrcsNgSq1q RQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:28 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A0E832D1;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] extcon: arizona: Factor out microphone and button detection
Date:   Mon, 9 Dec 2019 11:09:16 +0000
Message-ID: <20191209110916.29524-10-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue refactoring the microphone detect handling by factoring
out the handling for microphone detection and button detection
into separate functions. This both makes the code a little clearer
and prepares for some planned future refactoring to make the state
handling in the driver more explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 115 +++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 44 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index b09a9a8ce98bc..7401733db08bb 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -872,38 +872,18 @@ static int arizona_micd_read(struct arizona_extcon_info *info)
 	return val;
 }
 
-static void arizona_micd_detect(struct work_struct *work)
+static int arizona_micdet_reading(void *priv)
 {
-	struct arizona_extcon_info *info = container_of(work,
-						struct arizona_extcon_info,
-						micd_detect_work.work);
+	struct arizona_extcon_info *info = priv;
 	struct arizona *arizona = info->arizona;
-	unsigned int val = 0, lvl;
-	int ret, i, key;
-
-	cancel_delayed_work_sync(&info->micd_timeout_work);
-
-	mutex_lock(&info->lock);
-
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
-	}
+	int ret, val;
 
 	if (info->detecting && arizona->pdata.micd_software_compare)
 		ret = arizona_micd_adc_read(info);
 	else
 		ret = arizona_micd_read(info);
 	if (ret < 0)
-		goto handled;
+		return ret;
 
 	val = ret;
 
@@ -913,11 +893,11 @@ static void arizona_micd_detect(struct work_struct *work)
 		info->mic = false;
 		info->detecting = false;
 		arizona_identify_headphone(info);
-		goto handled;
+		return 0;
 	}
 
 	/* If we got a high impedence we should have a headset, report it. */
-	if (info->detecting && (val & ARIZONA_MICD_LVL_8)) {
+	if (val & ARIZONA_MICD_LVL_8) {
 		info->mic = true;
 		info->detecting = false;
 
@@ -936,7 +916,7 @@ static void arizona_micd_detect(struct work_struct *work)
 				ret);
 		}
 
-		goto handled;
+		return 0;
 	}
 
 	/* If we detected a lower impedence during initial startup
@@ -945,7 +925,7 @@ static void arizona_micd_detect(struct work_struct *work)
 	 * plain headphones.  If both polarities report a low
 	 * impedence then give up and report headphones.
 	 */
-	if (info->detecting && (val & MICD_LVL_1_TO_7)) {
+	if (val & MICD_LVL_1_TO_7) {
 		if (info->jack_flips >= info->micd_num_modes * 10) {
 			dev_dbg(arizona->dev, "Detected HP/line\n");
 
@@ -959,13 +939,45 @@ static void arizona_micd_detect(struct work_struct *work)
 			arizona_extcon_set_mode(info, info->micd_mode);
 
 			info->jack_flips++;
+
+			if (arizona->pdata.micd_software_compare)
+				regmap_update_bits(arizona->regmap,
+						   ARIZONA_MIC_DETECT_1,
+						   ARIZONA_MICD_ENA,
+						   ARIZONA_MICD_ENA);
+
+			queue_delayed_work(system_power_efficient_wq,
+					   &info->micd_timeout_work,
+					   msecs_to_jiffies(arizona->pdata.micd_timeout));
 		}
 
-		goto handled;
+		return 0;
 	}
 
 	/*
 	 * If we're still detecting and we detect a short then we've
+	 * got a headphone.
+	 */
+	dev_dbg(arizona->dev, "Headphone detected\n");
+	info->detecting = false;
+
+	arizona_identify_headphone(info);
+
+	return 0;
+}
+
+static int arizona_button_reading(void *priv)
+{
+	struct arizona_extcon_info *info = priv;
+	struct arizona *arizona = info->arizona;
+	int val, key, lvl, i;
+
+	val = arizona_micd_read(info);
+	if (val < 0)
+		return val;
+
+	/*
+	 * If we're still detecting and we detect a short then we've
 	 * got a headphone.  Otherwise it's a button press.
 	 */
 	if (val & MICD_LVL_0_TO_7) {
@@ -986,11 +998,6 @@ static void arizona_micd_detect(struct work_struct *work)
 			} else {
 				dev_err(arizona->dev, "Button out of range\n");
 			}
-		} else if (info->detecting) {
-			dev_dbg(arizona->dev, "Headphone detected\n");
-			info->detecting = false;
-
-			arizona_identify_headphone(info);
 		} else {
 			dev_warn(arizona->dev, "Button with no mic: %x\n",
 				 val);
@@ -1004,19 +1011,39 @@ static void arizona_micd_detect(struct work_struct *work)
 		arizona_extcon_pulse_micbias(info);
 	}
 
-handled:
-	if (info->detecting) {
-		if (arizona->pdata.micd_software_compare)
-			regmap_update_bits(arizona->regmap,
-					   ARIZONA_MIC_DETECT_1,
-					   ARIZONA_MICD_ENA,
-					   ARIZONA_MICD_ENA);
+	return 0;
+}
 
-		queue_delayed_work(system_power_efficient_wq,
-				   &info->micd_timeout_work,
-				   msecs_to_jiffies(arizona->pdata.micd_timeout));
+static void arizona_micd_detect(struct work_struct *work)
+{
+	struct arizona_extcon_info *info = container_of(work,
+						struct arizona_extcon_info,
+						micd_detect_work.work);
+	struct arizona *arizona = info->arizona;
+	int ret;
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
+		mutex_unlock(&info->lock);
+		return;
 	}
 
+	if (info->detecting)
+		arizona_micdet_reading(info);
+	else
+		arizona_button_reading(info);
+
 	pm_runtime_mark_last_busy(info->dev);
 	mutex_unlock(&info->lock);
 }
-- 
2.11.0

