Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B9D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCSJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:40:27 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50940 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726661AbfCSJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:40:27 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J9cSE5006273;
        Tue, 19 Mar 2019 04:40:24 -0500
Authentication-Results: ppops.net;
        spf=pass smtp.mailfrom=lucas.tanure@cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ratnq09h2-1;
        Tue, 19 Mar 2019 04:40:24 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 94954611C8B5;
        Tue, 19 Mar 2019 04:41:26 -0500 (CDT)
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 09:40:23 +0000
Received: from ArchLinux.ad.cirrus.com (unknown [198.90.202.153])       by
 ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0F11B2DD;      Tue, 19 Mar 2019
 09:40:23 +0000 (GMT)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 1/2] regmap: debugfs: Replace code by already existing function
Date:   Tue, 19 Mar 2019 09:41:32 +0000
Message-ID: <20190319094133.8843-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com ip4:141.131.128.20
 ip4:141.131.3.20 ip4:213.128.236.230 ip4:87.246.98.25 ip4:87.246.78.26
 ip4:87.246.76.56 ip4:87.246.98.35 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=657 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-debugfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 6d3dc1429ae57..9b3f49ffc4a5f 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -214,10 +214,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
 
 	for (i = start_reg; i <= to; i += map->reg_stride) {
-		if (!regmap_readable(map, i) && !regmap_cached(map, i))
-			continue;
-
-		if (regmap_precious(map, i))
+		if (!regmap_printable(map, i))
 			continue;
 
 		/* If we're in the region the user is trying to read */
-- 
2.21.0

