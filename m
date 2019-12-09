Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECFC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231642080D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nnLF9cVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLILJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:3452 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727668AbfLILJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B3UZi022346;
        Mon, 9 Dec 2019 05:09:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=AgBjm1aK7bZZ7f+px93wU1N6DNXUidy3fXqWwe3+eFs=;
 b=nnLF9cVNg6lVbyRk29psfurT3dvYMOX9BsdtVQsSt8YcbOYjul0BC/jP5SdOh4L48atM
 9tp3d9oFvulp44reVE8L/kh3xDZj8r8unPyEMz2CX9p1UqNXgWDCFdeqpFwuvF3na/Rk
 dEnN9trx0vm0DrL2GOtNJ773EfQFozS3qD56nQLYzZEf4X/AMzBaHNWbn+FFxgKQRC1d
 DAg4/xlTWPlKkqWY0SG81/s4mnl7jKCiUNRTisy95AsASY9pfYwhMbBE4A92SBwGeuSP
 +is7iUTitxxy3QgmEE6qCsfB4L8drssy77q9fAPUPUS0qV8Ocl6d4KDpPg3GH4b00vuw 2Q== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3F01D2A1;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] extcon: arizona: Make rev A register sequences atomic
Date:   Mon, 9 Dec 2019 11:09:08 +0000
Message-ID: <20191209110916.29524-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=562
 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The special register sequences that are applied for rev A of wm5102
should be applied atomically with respect to any other register writes.
Use regmap_multi_reg_write to ensure all writes happen under the regmap
lock.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 79e9a24101823..a8b0bc2d4323b 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -310,9 +310,13 @@ static void arizona_start_mic(struct arizona_extcon_info *info)
 	}
 
 	if (info->micd_reva) {
-		regmap_write(arizona->regmap, 0x80, 0x3);
-		regmap_write(arizona->regmap, 0x294, 0);
-		regmap_write(arizona->regmap, 0x80, 0x0);
+		const struct reg_sequence reva[] = {
+			{ 0x80,  0x3 },
+			{ 0x294, 0x0 },
+			{ 0x80,  0x0 },
+		};
+
+		regmap_multi_reg_write(arizona->regmap, reva, ARRAY_SIZE(reva));
 	}
 
 	if (info->detecting && arizona->pdata.micd_software_compare)
@@ -361,9 +365,13 @@ static void arizona_stop_mic(struct arizona_extcon_info *info)
 	snd_soc_dapm_sync(dapm);
 
 	if (info->micd_reva) {
-		regmap_write(arizona->regmap, 0x80, 0x3);
-		regmap_write(arizona->regmap, 0x294, 2);
-		regmap_write(arizona->regmap, 0x80, 0x0);
+		const struct reg_sequence reva[] = {
+			{ 0x80,  0x3 },
+			{ 0x294, 0x2 },
+			{ 0x80,  0x0 },
+		};
+
+		regmap_multi_reg_write(arizona->regmap, reva, ARRAY_SIZE(reva));
 	}
 
 	ret = regulator_allow_bypass(info->micvdd, true);
-- 
2.11.0

