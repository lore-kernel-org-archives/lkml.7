Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07C8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEC020B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE2JqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:46:11 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51466 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725874AbfE2JqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:46:10 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T9e2uY018012;
        Wed, 29 May 2019 04:46:07 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sq340mmf2-1;
        Wed, 29 May 2019 04:46:07 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail1.cirrus.com (Postfix) with ESMTP id 6756E611C8BD;
        Wed, 29 May 2019 04:46:06 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 29 May
 2019 10:46:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 29 May 2019 10:46:05 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC5B044;
        Wed, 29 May 2019 10:46:05 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] extcon: arizona: Correct error handling on regmap_update_bits_check
Date:   Wed, 29 May 2019 10:46:05 +0100
Message-ID: <20190529094605.9838-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the case when regmap_update_bits_check fails and the change
variable is not updated is handled correctly.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Print error message in driver remove

Thanks,
Charles

 drivers/extcon/extcon-arizona.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 9327479c719c2..519e89aedd4a0 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -335,10 +335,12 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
 
 	arizona_extcon_pulse_micbias(info);
 
-	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				 ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
-				 &change);
-	if (!change) {
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, ARIZONA_MICD_ENA,
+				       &change);
+	if (ret < 0) {
+		dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
+	} else if (!change) {
 		regulator_disable(info->micvdd);
 		pm_runtime_put_autosuspend(info->dev);
 	}
@@ -350,12 +352,14 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 	const char *widget = arizona_extcon_get_micbias(info);
 	struct snd_soc_dapm_context *dapm = arizona->dapm;
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
-	bool change;
+	bool change = false;
 	int ret;
 
-	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				 ARIZONA_MICD_ENA, 0,
-				 &change);
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, 0,
+				       &change);
+	if (ret < 0)
+		dev_err(arizona->dev, "Failed to disable micd: %d\n", ret);
 
 	ret = snd_soc_component_disable_pin(component, widget);
 	if (ret != 0)
@@ -1727,12 +1731,15 @@ static int arizona_extcon_remove(struct platform_device *pdev)
 	struct arizona *arizona = info->arizona;
 	int jack_irq_rise, jack_irq_fall;
 	bool change;
+	int ret;
 
-	regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
-				 ARIZONA_MICD_ENA, 0,
-				 &change);
-
-	if (change) {
+	ret = regmap_update_bits_check(arizona->regmap, ARIZONA_MIC_DETECT_1,
+				       ARIZONA_MICD_ENA, 0,
+				       &change);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to disable micd on remove: %d\n",
+			ret);
+	} else if (change) {
 		regulator_disable(info->micvdd);
 		pm_runtime_put(info->dev);
 	}
-- 
2.11.0

