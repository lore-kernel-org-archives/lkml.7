Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B9FCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE072166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="g71xQgbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfJUN6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:58:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:3184 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728096AbfJUN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:58:20 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LDsQgr030658;
        Mon, 21 Oct 2019 08:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=K+byys6fVG4Ov27yeo/tfyjnL+g5uekxLjyr3Tu6noo=;
 b=g71xQgbUIYSeXw5AViN5kjY0JDuwDzAZRDQdmv4wVW3J0a1/nRX/AQOexactkVpoXa+r
 mg6Zd9x0KlT5jxy5MhdZrc0aggh2ZTdPaAFjy2alVPOprHlQ+Owc0PQxhxYBJMstFdHW
 WKMc4hzyN6+YBvjc5jBqDJBaL//uMJsqCq9gKdKq3YAZpn+QX69Kk2LRHCd4SArplsbS
 WCWd6jN4QJNJdKnKTsJZv/gIKTsnNPD/OXmWisMmxLkLD8XGP9w7Yzj8s/hfWxwy6S4c
 A2eaH9NHSrhkJBC3MEVmhvQ191/JGWrKC7w04WPxb/96oxrwJX5Ge+/BGGXrkZGH3gal Kg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2vqxwnjv0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Oct 2019 08:58:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 21 Oct
 2019 14:58:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 21 Oct 2019 14:58:13 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F7912A1;
        Mon, 21 Oct 2019 13:58:13 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH RESEND v4 1/3] mfd: wm8998: Remove some unused registers
Date:   Mon, 21 Oct 2019 14:58:11 +0100
Message-ID: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=1
 phishscore=0 malwarescore=0 mlxlogscore=691 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910210132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save a few bytes by removing some registers from the driver that are not
currently used and not intended to be used at any point in the future.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
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

