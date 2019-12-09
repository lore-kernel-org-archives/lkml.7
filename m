Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB139C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68B2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="oPPnBwHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfLILJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:09:33 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1272 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727419AbfLILJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9B9QlT029232;
        Mon, 9 Dec 2019 05:09:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=RZEy6NIe0TsukhJOQNQ0CtrUgcxjzAl40QbDntRJD1M=;
 b=oPPnBwHvV/tP/KyVkSmB1NYY9UpcnMkpvZWoEYVBtKn8ckuSkQ3sCKrC4BCn1hf52Uu5
 PXQmx6FdZTszNnE59Bfog2hKHhrH3Y78fQwnt+WdjgwUe/Z0knYHipmhqo6Wx7UqqGYV
 cBPatdvCmhqnJczkVmxL59eeJyxkLxqa9+zNCufxJ5f68HmGpPjBy2QEIgoBOG3Pz1yG
 HgJNcFl9QLyUGf2ta1ZRrgFaeLtnxhgA49s/dVOYZNL+m83qcFOxaic1Wa/gtYPynGTv
 CJOADgGxsCR8vmvc5cwBxzVufBNRZ0FeKE9oLxICS9fYxz2b0nwSeBFYEgCy3YztNpJj sg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wrac6j0mt-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 09 Dec 2019 05:09:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 9 Dec
 2019 11:09:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 9 Dec 2019 11:09:16 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 540102D1;
        Mon,  9 Dec 2019 11:09:16 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/10] extcon: arizona: Clear jack status regardless of detection type
Date:   Mon, 9 Dec 2019 11:09:10 +0000
Message-ID: <20191209110916.29524-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
References: <20191209110916.29524-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=907
 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912090095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to clear the internal state of the jack detection
regardless of if the headphone detect based accessory detection or
the normal microphone detect based flow is used.

No issues are currently known because of this but the change makes
more logical sense and eases future refactoring of the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/extcon/extcon-arizona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
index 121c417069478..11f1d753aa102 100644
--- a/drivers/extcon/extcon-arizona.c
+++ b/drivers/extcon/extcon-arizona.c
@@ -1154,11 +1154,11 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 			dev_err(arizona->dev, "Mechanical report failed: %d\n",
 				ret);
 
-		if (!arizona->pdata.hpdet_acc_id) {
-			info->detecting = true;
-			info->mic = false;
-			info->jack_flips = 0;
+		info->detecting = true;
+		info->mic = false;
+		info->jack_flips = 0;
 
+		if (!arizona->pdata.hpdet_acc_id) {
 			arizona_start_mic(info);
 		} else {
 			queue_delayed_work(system_power_efficient_wq,
-- 
2.11.0

