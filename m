Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70905C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A92222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gmVLY3ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbfJDPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:38:06 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:40556 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389799AbfJDPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:38:02 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94FXxfG009052;
        Fri, 4 Oct 2019 10:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=8oJ8VNAoL+Qun16fD++NXU8SOSQW+XmUXWqeRFYOxt8=;
 b=gmVLY3ZRm7AzKIwaI2pAE+NUqdX77RA0bESzcCaK9qibQDTpyPqkvWyWcbeoqrJvjEDH
 yITLsNezfOy0baIhwbcVXsB7sY18NAp9HMtFu734YUJaDdPwfm49Y6CjAFDh4rl1pIFx
 U/VtmKoEd+463boU95veJ9ySBBFm1ju8Zg5Y8TH5v5U3SwBT64HTlujlxKp+cN+DZmn/
 t2/cOWVJodmPxKDqljzr7R9f/OJ8avdrXqhNJf5Nhn6J6vzzJL2t/hsIADARXfbWQkmJ
 xTac03tehId1kQ9mPDmQidY38qMxNvQHLD+SVImIx4ngiYQWsUfGfzpRWjm/Atc9ZJbc iA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4t8r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Oct 2019 10:37:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 4 Oct
 2019 16:37:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 4 Oct 2019 16:37:54 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0A37F2A1;
        Fri,  4 Oct 2019 15:37:54 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/3] mfd: wm8998: Remove some unused registers
Date:   Fri, 4 Oct 2019 16:37:51 +0100
Message-ID: <20191004153753.8369-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=751
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save a few bytes by removing some registers from the driver that are not
currently used and not intended to be used at any point in the future.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Add more commit message

 drivers/mfd/wm8998-tables.c           | 12 ------------
 include/linux/mfd/arizona/registers.h |  7 -------
 2 files changed, 19 deletions(-)

diff --git a/drivers/mfd/wm8998-tables.c b/drivers/mfd/wm8998-tables.c
index ebf0eadd2075c..9b34a6d760949 100644
--- a/drivers/mfd/wm8998-tables.c
+++ b/drivers/mfd/wm8998-tables.c
@@ -806,12 +806,6 @@ static const struct reg_default wm8998_reg_default[] = {
 	{ 0x00000EF3, 0x0000 },    /* R3827  - ISRC 2 CTRL 1 */
 	{ 0x00000EF4, 0x0001 },    /* R3828  - ISRC 2 CTRL 2 */
 	{ 0x00000EF5, 0x0000 },    /* R3829  - ISRC 2 CTRL 3 */
-	{ 0x00001700, 0x0000 },    /* R5888  - FRF_COEFF_1 */
-	{ 0x00001701, 0x0000 },    /* R5889  - FRF_COEFF_2 */
-	{ 0x00001702, 0x0000 },    /* R5890  - FRF_COEFF_3 */
-	{ 0x00001703, 0x0000 },    /* R5891  - FRF_COEFF_4 */
-	{ 0x00001704, 0x0000 },    /* R5892  - DAC_COMP_1 */
-	{ 0x00001705, 0x0000 },    /* R5893  - DAC_COMP_2 */
 };
 
 static bool wm8998_readable_register(struct device *dev, unsigned int reg)
@@ -1492,12 +1486,6 @@ static bool wm8998_readable_register(struct device *dev, unsigned int reg)
 	case ARIZONA_ISRC_2_CTRL_1:
 	case ARIZONA_ISRC_2_CTRL_2:
 	case ARIZONA_ISRC_2_CTRL_3:
-	case ARIZONA_FRF_COEFF_1:
-	case ARIZONA_FRF_COEFF_2:
-	case ARIZONA_FRF_COEFF_3:
-	case ARIZONA_FRF_COEFF_4:
-	case ARIZONA_V2_DAC_COMP_1:
-	case ARIZONA_V2_DAC_COMP_2:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index bb1a2530ae279..49e24d1de8d47 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -1186,13 +1186,6 @@
 #define ARIZONA_DSP4_SCRATCH_1                   0x1441
 #define ARIZONA_DSP4_SCRATCH_2                   0x1442
 #define ARIZONA_DSP4_SCRATCH_3                   0x1443
-#define ARIZONA_FRF_COEFF_1                      0x1700
-#define ARIZONA_FRF_COEFF_2                      0x1701
-#define ARIZONA_FRF_COEFF_3                      0x1702
-#define ARIZONA_FRF_COEFF_4                      0x1703
-#define ARIZONA_V2_DAC_COMP_1                    0x1704
-#define ARIZONA_V2_DAC_COMP_2                    0x1705
-
 
 /*
  * Field Definitions.
-- 
2.11.0

