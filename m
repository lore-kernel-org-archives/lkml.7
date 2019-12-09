Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F1C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C83B2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="d9m8G3HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfLILJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:32 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44958 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727720AbfLILJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:28 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B9QlR029232;
        Mon, 9 Dec 2019 05:09:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=CgB3L703HeDt5lyFK/zu8R826fVW84RZQJOEDFZQmvQ=;
 b=d9m8G3HYZhiGYwZpr/D5C0OC+yVBtqAo4yDsxAEl0266I2XgKr7aE1w39+izNrSvw96i
 uIFOO2iThUHO+uRN/fZPpLQJsTkuCqtE1pEJB5w9va+TJ+x/m8agaLgIU5kRfhbmWX72
 yIpO7AzJwMygjCRVbmLM5tmVBo1QQCHcN88Wogi+4//ZdeuD3CMfmrjtNQOns7zAdcaI
 HzQ7YZGl5KIiCvw14GImv/1SPCqNTs7NfGsmsaeGnWPCpql7Q2MBqV+MB5rYKuljEe1R
 VTd5xjNuJSJP2ACcWxLQ4a/KqXRCIXZBqx1qYWiOO/DAN1tBFGnK5RW4FbAc+Hh0+N/s ZA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 60F0E45A;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/10] extcon: arizona: Tidy up transition from mic to headphone detect
Date:   Mon, 9 Dec 2019 11:09:11 +0000
Message-ID: <20191209110916.29524-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=564
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving from microphone detection to headphone detection is done fairly
haphazardly at the moment, sometimes calling arizona_stop_mic at the
call site sometimes relying on a call inside arizona_identify_headphone.
Simplify all this and always call arizona_stop_mic at the top of
arizona_identify_headphone.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 11f1d753aa102..5ae111ee3d631 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -705,8 +705,7 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 
 	info->hpdet_active = true;
 
-	if (info->mic)
-		arizona_stop_mic(info);
+	arizona_stop_mic(info);
 
 	arizona_extcon_hp_clamp(info, true);
 
@@ -815,8 +814,6 @@ static void arizona_micd_timeout_work(struct work_struct *work)
 
 	arizona_identify_headphone(info);
 
-	arizona_stop_mic(info);
-
 	mutex_unlock(&info->lock);
 }
 
@@ -906,7 +903,6 @@ static void arizona_micd_detect(struct work_struct *work)
 	if (!(val & ARIZONA_MICD_STS)) {
 		dev_warn(arizona->dev, "Detected open circuit\n");
 		info->mic = false;
-		arizona_stop_mic(info);
 		info->detecting = false;
 		arizona_identify_headphone(info);
 		goto handled;
@@ -948,8 +944,6 @@ static void arizona_micd_detect(struct work_struct *work)
 			info->detecting = false;
 
 			arizona_identify_headphone(info);
-
-			arizona_stop_mic(info);
 		} else {
 			info->micd_mode++;
 			if (info->micd_mode == info->micd_num_modes)
@@ -988,7 +982,6 @@ static void arizona_micd_detect(struct work_struct *work)
 		} else if (info->detecting) {
 			dev_dbg(arizona->dev, "Headphone detected\n");
 			info->detecting = false;
-			arizona_stop_mic(info);
 
 			arizona_identify_headphone(info);
 		} else {
-- 
2.11.0

