Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038FCC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC7520842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XFEH746m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfJANUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:20:23 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:22996 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbfJANUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:20:22 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DECxi031379;
        Tue, 1 Oct 2019 08:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=3EoE7FWYxNK59f42gp98Tt85HWsrCEBJg/yVd+I5GCQ=;
 b=XFEH746mClPj03139K4kgmrvEkwACx7DSn5FPmsy22V0yc/53BfsgvIbp7IWa53A9I7h
 U2ywRLRB8wSGImKpdKN92zh1FbeU2Y0eAP/g3hvBN74gzS3F1naOTYNng4oeXTkKc2NR
 JY+C0g/JzJI2VTLHIQI2EOD39LZXtSYAjun4VFo4hzY5oNWUV4SMu2Mat/hEzvyPvQky
 orZY9yS1+QQdprp7KShq/A2yqIvBaFSNEnkW+LYCQ6lh0mH3CNa4e2nlilMwbWieH81K
 U1Qevk97rdsBRHUO2Dnm6tkZ6Qsp0KWw+zolunCD8IGLA6TUrBDFmm80Jl0unA3iKdtx Uw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4nbmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Oct 2019 08:20:20 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 1 Oct
 2019 14:20:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 1 Oct 2019 14:20:18 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 001492A1;
        Tue,  1 Oct 2019 13:20:17 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: lochnagar: Add on_off_delay for VDDCORE
Date:   Tue, 1 Oct 2019 14:20:17 +0100
Message-ID: <20191001132017.1785-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=887
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VDDCORE regulator takes a good length of time to discharge down, so
add an on_off_delay to ensure DCVDD is removed before it is powered on
again.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/lochnagar-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index ff97cc50f2eb9..9b05e03ba8305 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -210,6 +210,7 @@ static const struct regulator_desc lochnagar_regulators[] = {
 
 		.enable_time = 3000,
 		.ramp_delay = 1000,
+		.off_on_delay = 15000,
 
 		.owner = THIS_MODULE,
 	},
-- 
2.11.0

