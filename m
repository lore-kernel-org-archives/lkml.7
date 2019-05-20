Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B5C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F720644
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfETJGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:06:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54824 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731816AbfETJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:06:44 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K93j0p021634;
        Mon, 20 May 2019 04:06:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sjff1t4wc-1;
        Mon, 20 May 2019 04:06:30 -0500
Received: from EDIEX01.ad.cirrus.com (unknown [198.61.84.80])
        by mail2.cirrus.com (Postfix) with ESMTP id ACD60605A6A8;
        Mon, 20 May 2019 04:06:29 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 20 May
 2019 10:06:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 20 May 2019 10:06:28 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC10444;
        Mon, 20 May 2019 10:06:28 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <arnd@arndb.de>, <natechancellor@gmail.com>,
        <ottosabart@seberm.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/4] mfd: madera: Add supply mapping for MICVDD
Date:   Mon, 20 May 2019 10:06:28 +0100
Message-ID: <20190520090628.29061-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
References: <20190520090628.29061-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=366 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are relying on the exact match of the regulator name to
find MICVDD, we should add an explicit supply mapping to allow this to
be found more reliably.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 1b78c5c844a81..515283e595aa0 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -59,7 +59,11 @@ static const struct mfd_cell cs47l35_devs[] = {
 	{ .name = "madera-irq", },
 	{ .name = "madera-micsupp", },
 	{ .name = "madera-gpio", },
-	{ .name = "madera-extcon", },
+	{
+		.name = "madera-extcon",
+		.parent_supplies = cs47l35_supplies,
+		.num_parent_supplies = 1, /* We only need MICVDD */
+	},
 	{
 		.name = "cs47l35-codec",
 		.parent_supplies = cs47l35_supplies,
@@ -83,7 +87,11 @@ static const struct mfd_cell cs47l85_devs[] = {
 	{ .name = "madera-irq", },
 	{ .name = "madera-micsupp" },
 	{ .name = "madera-gpio", },
-	{ .name = "madera-extcon", },
+	{
+		.name = "madera-extcon",
+		.parent_supplies = cs47l85_supplies,
+		.num_parent_supplies = 1, /* We only need MICVDD */
+	},
 	{
 		.name = "cs47l85-codec",
 		.parent_supplies = cs47l85_supplies,
@@ -105,7 +113,11 @@ static const struct mfd_cell cs47l90_devs[] = {
 	{ .name = "madera-irq", },
 	{ .name = "madera-micsupp", },
 	{ .name = "madera-gpio", },
-	{ .name = "madera-extcon", },
+	{
+		.name = "madera-extcon",
+		.parent_supplies = cs47l90_supplies,
+		.num_parent_supplies = 1, /* We only need MICVDD */
+	},
 	{
 		.name = "cs47l90-codec",
 		.parent_supplies = cs47l90_supplies,
-- 
2.11.0

