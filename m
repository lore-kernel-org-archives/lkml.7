Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC204C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031420836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wb/rLx1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLILJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:27 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:30674 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727669AbfLILJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B3UZl022346;
        Mon, 9 Dec 2019 05:09:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=u98Zlai6AnzDuyzssugL693T8z+Kg6zyDvoqCe8lS9A=;
 b=Wb/rLx1EnOoQt2EtYTDO5qvox859XJdFfZ9LxnDQqSeNv3OQCKG4faPugSfSzqpw2Sam
 UI1FB8zxoiObIIgC/6VTXbdu8J/fYLFuGEmmX1kCjbya/uYDpuoDNfLCfxZXrp43yS7f
 Zf8koJzinfEVjucsdfLVquJHL2fvCuBWLxfj/zM54w0L6D5G73RQZXyQ4lEJ2TnYpoDe
 SRuf6qW7XNXQxhAcWNP0M+OD/KeoiAtQzVYXFAvscmvHoyEO/XQgkVggUvgNtUl+5JcY
 O0Q+Pn7QgJmGfjyqhk90qm43TBRSaRBbJbb/fVEzTIvwTL82FEL41E6QqlPduT2PwTZU zA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 464432D5;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] extcon: arizona: Move pdata extraction to probe
Date:   Mon, 9 Dec 2019 11:09:09 +0000
Message-ID: <20191209110916.29524-3-ckeepax@opensource.cirrus.com>
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

It makes no sense to be extracting values from pdata for the first time
in the jack detection handler function, move this to probe time where it
belongs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index a8b0bc2d4323b..121c417069478 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -77,8 +77,6 @@ struct arizona_extcon_info {
 	const struct arizona_micd_range *micd_ranges;
 	int num_micd_ranges;
 
-	int micd_timeout;
-
 	bool micd_reva;
 	bool micd_clamp;
 
@@ -1016,7 +1014,7 @@ static void arizona_micd_detect(struct work_struct *work)
 
 		queue_delayed_work(system_power_efficient_wq,
 				   &info->micd_timeout_work,
-				   msecs_to_jiffies(info->micd_timeout));
+				   msecs_to_jiffies(arizona->pdata.micd_timeout));
 	}
 
 	pm_runtime_mark_last_busy(info->dev);
@@ -1136,7 +1134,7 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 					   msecs_to_jiffies(HPDET_DEBOUNCE));
 
 		if (cancelled_mic) {
-			int micd_timeout = info->micd_timeout;
+			int micd_timeout = arizona->pdata.micd_timeout;
 
 			queue_delayed_work(system_power_efficient_wq,
 					   &info->micd_timeout_work,
@@ -1213,11 +1211,6 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 				   ARIZONA_MICD_CLAMP_DB | ARIZONA_JD1_DB);
 	}
 
-	if (arizona->pdata.micd_timeout)
-		info->micd_timeout = arizona->pdata.micd_timeout;
-	else
-		info->micd_timeout = DEFAULT_MICD_TIMEOUT;
-
 out:
 	/* Clear trig_sts to make sure DCVDD is not forced up */
 	regmap_write(arizona->regmap, ARIZONA_AOD_WKUP_AND_TRIG,
@@ -1446,6 +1439,9 @@ static int arizona_extcon_probe(struct platform_device *pdev)
 	info->input->name = "Headset";
 	info->input->phys = "arizona/extcon";
 
+	if (!pdata->micd_timeout)
+		pdata->micd_timeout = DEFAULT_MICD_TIMEOUT;
+
 	if (pdata->num_micd_configs) {
 		info->micd_modes = pdata->micd_configs;
 		info->micd_num_modes = pdata->num_micd_configs;
-- 
2.11.0

