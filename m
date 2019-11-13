Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE780214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fkc6Y4hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKMIxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:53:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6682 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbfKMIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:53:08 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD8q4kV002304;
        Wed, 13 Nov 2019 09:52:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=BYeo7CKoHGs4edfcP+aKkDDUEeKUTzU/SKHt2YKmBVA=;
 b=fkc6Y4hq5lDPBAXWsDSj4YS8eqLnPCMllUwWjRQmIE4TFOOIarK6eJeCCryHOpECiLwb
 q1B2DqraLTmKXmtZ3YfMtV2EUvns1L+kY/YX4+D6z7SSX978AbfKlvqCoj38h0PfmdZT
 zVzu2Sj8NUFesP8wtIyaX6uL559FfedbR5zC4v+x6/Gv/Yf3whkJXPTfa7yBGjlUnVLD
 HbqH5te8gRHlkxkj2wg90QfjRhlLoNiz/4+IX51r2iWuoIs8SvdR6crDPSSkqGQ2C0Nq
 wFF7jqh7uc6uD+WpQ9CLoxNeRLtG5LYX/ontP0Kzk8V1W4koPNLZ95G9oMY5IF9f09tx tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psb70dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 09:52:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8189010003E;
        Wed, 13 Nov 2019 09:52:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6BEBB2B1B05;
        Wed, 13 Nov 2019 09:52:55 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov 2019 09:52:55
 +0100
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3] remoteproc: stm32: fix probe error case
Date:   Wed, 13 Nov 2019 09:52:47 +0100
Message-ID: <1573635167-24590-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_02:2019-11-13,2019-11-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rproc driver is probed before the mailbox driver and if the rproc
Device Tree node has some mailbox properties, the rproc driver probe
shall be deferred instead of being probed without mailbox support.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
Changes since v2: free other requested mailboxes after one request fails
Changes since v1: test IS_ERR() before checking PTR_ERR()
---
 drivers/remoteproc/stm32_rproc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2cf4b29..4b67480 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -310,7 +310,7 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
 	}
 };
 
-static void stm32_rproc_request_mbox(struct rproc *rproc)
+static int stm32_rproc_request_mbox(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata = rproc->priv;
 	struct device *dev = &rproc->dev;
@@ -329,10 +329,16 @@ static void stm32_rproc_request_mbox(struct rproc *rproc)
 
 		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
 		if (IS_ERR(ddata->mb[i].chan)) {
+			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER) {
+				ddata->mb[i].chan = NULL;
+				return -EPROBE_DEFER;
+			}
 			dev_warn(dev, "cannot get %s mbox\n", name);
 			ddata->mb[i].chan = NULL;
 		}
 	}
+
+	return 0;
 }
 
 static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
@@ -596,7 +602,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	stm32_rproc_request_mbox(rproc);
+	ret = stm32_rproc_request_mbox(rproc);
+	if (ret)
+		goto free_mb;
 
 	ret = rproc_add(rproc);
 	if (ret)
-- 
2.7.4

