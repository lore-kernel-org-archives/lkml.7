Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697E220989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCSJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:40:27 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50942 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbfCSJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:40:27 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J9cSE4006273;
        Tue, 19 Mar 2019 04:40:24 -0500
Authentication-Results: ppops.net;
        spf=pass smtp.mailfrom=lucas.tanure@cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ratnq09h1-1;
        Tue, 19 Mar 2019 04:40:24 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 8A687611C8B2;
        Tue, 19 Mar 2019 04:41:26 -0500 (CDT)
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 09:40:23 +0000
Received: from ArchLinux.ad.cirrus.com (unknown [198.90.202.153])       by
 ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3C86747E;      Tue, 19 Mar 2019
 09:40:23 +0000 (GMT)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 2/2] regmap: debugfs: Jump to the next readable register
Date:   Tue, 19 Mar 2019 09:41:33 +0000
Message-ID: <20190319094133.8843-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319094133.8843-1-tanureal@opensource.cirrus.com>
References: <20190319094133.8843-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com ip4:141.131.128.20
 ip4:141.131.3.20 ip4:213.128.236.230 ip4:87.246.98.25 ip4:87.246.78.26
 ip4:87.246.76.56 ip4:87.246.98.35 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the speed of the loop jumping to the next
available register

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-debugfs.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 9b3f49ffc4a5f..b5b1cf5aa1f96 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -190,6 +190,28 @@ static inline void regmap_calc_tot_len(struct regmap *map,
 	}
 }
 
+static int regmap_next_readable_reg(struct regmap *map, int reg)
+{
+	struct regmap_debugfs_off_cache *c;
+	int ret = -EINVAL;
+
+	if (regmap_printable(map, reg + map->reg_stride)) {
+		ret = reg + map->reg_stride;
+	} else {
+		mutex_lock(&map->cache_lock);
+		list_for_each_entry(c, &map->debugfs_off_cache, list) {
+			if (reg > c->max_reg)
+				continue;
+			if (reg < c->base_reg) {
+				ret = c->base_reg;
+				break;
+			}
+		}
+		mutex_unlock(&map->cache_lock);
+	}
+	return ret;
+}
+
 static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 				   unsigned int to, char __user *user_buf,
 				   size_t count, loff_t *ppos)
@@ -213,9 +235,8 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	/* Work out which register we're starting at */
 	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
 
-	for (i = start_reg; i <= to; i += map->reg_stride) {
-		if (!regmap_printable(map, i))
-			continue;
+	for (i = start_reg; i >= 0 && i <= to;
+	     i = regmap_next_readable_reg(map, i)) {
 
 		/* If we're in the region the user is trying to read */
 		if (p >= *ppos) {
-- 
2.21.0

