Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B09C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E78B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCJ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:59:22 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47040 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfDCJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:59:22 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x339xJaU000375;
        Wed, 3 Apr 2019 04:59:19 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2rm5n5snv1-1;
        Wed, 03 Apr 2019 04:59:18 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 2EF7B611C8B4;
        Wed,  3 Apr 2019 04:59:18 -0500 (CDT)
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 10:59:17 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7D0FA2DB;    Wed,  3 Apr 2019
 10:59:17 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mfd: cs47l35: Make DAC_AEC_CONTROL_2 readable
Date:   Wed, 3 Apr 2019 10:59:16 +0100
Message-ID: <20190403095917.6351-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=667 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

There is a second AEC loopback on cs47l35 so the registers for it should
be readable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs47l35-tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/cs47l35-tables.c b/drivers/mfd/cs47l35-tables.c
index 604c9dd14df55..338b825127f13 100644
--- a/drivers/mfd/cs47l35-tables.c
+++ b/drivers/mfd/cs47l35-tables.c
@@ -178,6 +178,7 @@ static const struct reg_default cs47l35_reg_default[] = {
 	{ 0x00000448, 0x0a83 }, /* R1096 (0x448) - eDRE Enable */
 	{ 0x0000044a, 0x0000 }, /* R1098 (0x44a) - eDRE Manual */
 	{ 0x00000450, 0x0000 }, /* R1104 (0x450) - DAC AEC Control 1 */
+	{ 0x00000451, 0x0000 }, /* R1105 (0x451) - DAC AEC Control 2 */
 	{ 0x00000458, 0x0000 }, /* R1112 (0x458) - Noise Gate Control */
 	{ 0x00000490, 0x0069 }, /* R1168 (0x490) - PDM SPK1 CTRL 1 */
 	{ 0x00000491, 0x0000 }, /* R1169 (0x491) - PDM SPK1 CTRL 2 */
@@ -970,6 +971,7 @@ static bool cs47l35_16bit_readable_register(struct device *dev,
 	case MADERA_EDRE_ENABLE:
 	case MADERA_EDRE_MANUAL:
 	case MADERA_DAC_AEC_CONTROL_1:
+	case MADERA_DAC_AEC_CONTROL_2:
 	case MADERA_NOISE_GATE_CONTROL:
 	case MADERA_PDM_SPK1_CTRL_1:
 	case MADERA_PDM_SPK1_CTRL_2:
-- 
2.11.0

