Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655EC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7955E2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="U6AS4hho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfLILJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:15728 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727674AbfLILJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B3UZk022346;
        Mon, 9 Dec 2019 05:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=NpGnmX4h5Asv3Jmb0COAbu34D0iF1UVdc6wCTEKapcI=;
 b=U6AS4hhoNclX3+mqhbUwUOSaebTdYd1G47hzAvEIzGHZqaXW+mdim5MrdqGQ/5elytaJ
 Luv8hjPU7O4MGvkZVIviV+FZiF13TZAEmQTIZHT52Z6o2S2DrEQ4j8IlrFjsXZA77oLh
 MdT61kj5RkYVIU5G/zOZvZBUWVUx93kk4opHFxPlR9nIDO/4xWQmi+OECvFcLWgIfaqP
 bvLjzbyfNMzkqMr0IAL/BsHQX0nPrvbsKHRSlr3YxSsVUy67+IKeWK6QQUsplPT1svMJ
 NKaiQlIN5BgRgR2c+BYYnL/7Fx7g6PwlkLzRgWlmIGii8834Gcxdpq+9rOmXHYVj/6H9 sQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6D7842A1;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] extcon: arizona: Remove unnecessary sets of ACCDET_MODE
Date:   Mon, 9 Dec 2019 11:09:12 +0000
Message-ID: <20191209110916.29524-6-ckeepax@opensource.cirrus.com>
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
 definitions=main-1912090094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arizona_start_mic sets ACCDET_MODE as required for the microphone
detection as such it is redundant to set this outside of this function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 5ae111ee3d631..e7c198e798e27 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -668,11 +668,6 @@ static irqreturn_t arizona_hpdet_irq(int irq, void *data)
 	if (id_gpio)
 		gpio_set_value_cansleep(id_gpio, 0);
 
-	/* Revert back to MICDET mode */
-	regmap_update_bits(arizona->regmap,
-			   ARIZONA_ACCESSORY_DETECT_MODE_1,
-			   ARIZONA_ACCDET_MODE_MASK, ARIZONA_ACCDET_MODE_MIC);
-
 	/* If we have a mic then reenable MICDET */
 	if (mic || info->mic)
 		arizona_start_mic(info);
@@ -732,9 +727,6 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	arizona_extcon_hp_clamp(info, false);
 	pm_runtime_put_autosuspend(info->dev);
 
-	regmap_update_bits(arizona->regmap, ARIZONA_ACCESSORY_DETECT_MODE_1,
-			   ARIZONA_ACCDET_MODE_MASK, ARIZONA_ACCDET_MODE_MIC);
-
 	/* Just report headphone */
 	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
 	if (ret != 0)
@@ -789,9 +781,6 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
 	return;
 
 err:
-	regmap_update_bits(arizona->regmap, ARIZONA_ACCESSORY_DETECT_MODE_1,
-			   ARIZONA_ACCDET_MODE_MASK, ARIZONA_ACCDET_MODE_MIC);
-
 	/* Just report headphone */
 	ret = extcon_set_state_sync(info->edev, EXTCON_JACK_HEADPHONE, true);
 	if (ret != 0)
-- 
2.11.0

