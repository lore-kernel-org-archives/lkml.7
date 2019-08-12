Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E96C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E2320820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GBNR6ARi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfHLJYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:24:14 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57632 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727072AbfHLJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:24:14 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7C98xjJ016681;
        Mon, 12 Aug 2019 04:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=mVcblQCNG/+sWQKT9shvueTk+7Ob6+A9LjiY8ZS4aTU=;
 b=GBNR6ARidGgZ34igx2vMEGgU4YJS3AyU2ZP+fuk+FFjuucTz0lRfegNZC+nx470XJnUS
 8/C4iFCtGKGOSpWo7Xz+JC2SqpJMOoXVUZW+v01P282WT8iZ7wSkK0MYUdTZCyg8FHCv
 IBLHlZZ69Tl7iiU7z7u65Muk5rgBw8UgrHgnL9gmgF9ZmfmtcGy9qhEYnQIiR3H+tVgI
 0GJTxp+RxF6MDtIIHRj9lyahj6zmu49OiNccVAAuvcSCSiXKT1Oxwg6m4hlrBj5c/PWJ
 SJKW7T7yUlBGnjeSkSp5LjO+MoiY4sdFjG9vm/2opc1lSH2tDFAZBxPDC1Cj/HwUIbA5 2w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2u9ub22hqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Aug 2019 04:24:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 12 Aug
 2019 10:24:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 12 Aug 2019 10:24:10 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0ADBB7C;
        Mon, 12 Aug 2019 10:24:10 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] regmap-irq: Correct error paths in regmap_irq_thread for pm_runtime
Date:   Mon, 12 Aug 2019 10:24:09 +0100
Message-ID: <20190812092409.21593-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=1
 adultscore=0 spamscore=0 mlxlogscore=863 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908120103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error paths in regmap_irq_thread put the pm_runtime others do not,
there is no reason to leave the pm_runtime enabled in some cases so
update those paths to also put the pm_runtime.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-irq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c9dc70ceca5f1..3d64c9331a82a 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -370,7 +370,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (ret < 0) {
 			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
 				ret);
-			pm_runtime_put(map->dev);
 			goto exit;
 		}
 	}
@@ -425,8 +424,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 					dev_err(map->dev,
 						"Failed to read IRQ status %d\n",
 						ret);
-					if (chip->runtime_pm)
-						pm_runtime_put(map->dev);
 					goto exit;
 				}
 			}
@@ -478,8 +475,6 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status: %d\n",
 					ret);
-				if (chip->runtime_pm)
-					pm_runtime_put(map->dev);
 				goto exit;
 			}
 		}
@@ -513,10 +508,10 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		}
 	}
 
+exit:
 	if (chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
-exit:
 	if (chip->handle_post_irq)
 		chip->handle_post_irq(chip->irq_drv_data);
 
-- 
2.11.0

