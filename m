Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5ECC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0FF207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jsUH8twq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfLILJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1622 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727667AbfLILJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:21 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B3UZj022346;
        Mon, 9 Dec 2019 05:09:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=d4+Caqw0hJU802CgHU5kAEcGYPQkdHY1suuasB+tLhA=;
 b=jsUH8twqDBhxJ9MXfbhDN8vPo4RfUNhd1fC4BiTg9/kdNzQFmGRE0RethVHOsaD48Ihb
 T3uGMSPc3h6reJg6L2b4f2OOmTc15LYd+jPZb2ExSWlJDae+AOSlBpmORMuAhO9cOx4b
 gVi0QDywM/uZ4tLIs2hy95ctVcE7MTyybvaYN9u7RU0KDIBsg9lh5kUYNFlDX/HWDAYl
 e3aH2sLApI5BHhznMuwzZlMW45Suj/sDA5illFgFDvmSWCda4RAU1lOShamj4cuWGGW7
 DKyk+MrbpH6fyHsX3Q7AOsQ+kE+B+LKru6OGEyv6OaxtDb7TFZIVD1PNNokkfHL65mfq ww== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 315EC2C8;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] extcon: arizona: Correct clean up if arizona_identify_headphone fails
Date:   Mon, 9 Dec 2019 11:09:07 +0000
Message-ID: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=733
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the error path of arizona_identify_headphone, neither the clamp nor
the PM runtime are cleaned up. Add calls to clean up both of these.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index e970134c95fab..79e9a24101823 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -724,6 +724,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
 	return;
 
 err:
+	arizona_extcon_hp_clamp(info, false);
+	pm_runtime_put_autosuspend(info->dev);
+
 	regmap_update_bits(arizona->regmap, ARIZONA_ACCESSORY_DETECT_MODE_1,
 			   ARIZONA_ACCDET_MODE_MASK, ARIZONA_ACCDET_MODE_MIC);
 
-- 
2.11.0

