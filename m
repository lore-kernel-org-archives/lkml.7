Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3EC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A4D207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="i6gezNq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfLILJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:59 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7924 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727678AbfLILJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:22 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B3UZm022346;
        Mon, 9 Dec 2019 05:09:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=0v6TcqX+2q4zO9kQfJmYbgUU2bsSyCYLIYQGiirJCJk=;
 b=i6gezNq93Tx8U1ELAa70UF76ndB8APrC7LH/VhNCEleKqPiSCkrAlDeA4PdS4As/HbUC
 OTL432tHOuGJZwJx7gPuY1pb8lT/s/IWlWv/O7k1BiIEqCZZax70NNBsjG8GKmtNi+rA
 veD5wAIbqYLdtKJirQNwPnS9/S/mTF/H6uwNc0eKBUhq4TfgpJa4tER2y31/vrksiJDa
 hgVOnbiG0sbGupem1zqB2exV+XkRDsArjXErBE6H3qCpj0auOM1jBJdU2FL5O5NUVPwi
 RYn3bbRbviuFEyWWm9xiqVfNbExjKF0T69qY36LkBxXElhdXK4S/SfLONFCwwl5SsBzQ Vg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mu-3
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7B22B2D5;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] extcon: arizona: Remove excessive WARN_ON
Date:   Mon, 9 Dec 2019 11:09:13 +0000
Message-ID: <20191209110916.29524-7-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=652
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A WARN_ON is very strong for simply finding a button that is out of
range, downgrade this to a simple error message in the log.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index e7c198e798e27..3f7ced35e0b86 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -960,14 +960,13 @@ static void arizona_micd_detect(struct work_struct *work)
 				input_report_key(info->input,
 						 info->micd_ranges[i].key, 0);
 
-			WARN_ON(!lvl);
-			WARN_ON(ffs(lvl) - 1 >= info->num_micd_ranges);
 			if (lvl && ffs(lvl) - 1 < info->num_micd_ranges) {
 				key = info->micd_ranges[ffs(lvl) - 1].key;
 				input_report_key(info->input, key, 1);
 				input_sync(info->input);
+			} else {
+				dev_err(arizona->dev, "Button out of range\n");
 			}
-
 		} else if (info->detecting) {
 			dev_dbg(arizona->dev, "Headphone detected\n");
 			info->detecting = false;
-- 
2.11.0

