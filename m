Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E7FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8CB2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zEKBpL15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKOKD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:03:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43758 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbfKOKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:03:27 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFA2jj5028719;
        Fri, 15 Nov 2019 11:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=7gCFVo1c3feoHsazY70FKsMn5zRITBygco7FGXQsWm0=;
 b=zEKBpL150QmvwnsFu7TMaV8SIS07qJ3LT1foyO0sA4n/tyHJlD16P8/cFAgzPq3hu9fk
 7jdJ5kkF7X99XG4QQrLDCS5YN6lKJx2jpsIcLdQD1aRByDZotv1DangvGCbHL1M3NpCj
 1B2ICn1Xa8JGZxXjHmNRj83XmRIkTQM3DpFfFURcdOPsY0intlCxt8hDB1YmMWeYvCY9
 cpgsmdj+TrIQJLNe1KLKkQzEwCzdoKGxaU9GLArCQq+ytbLX6wm/85BXy8bvEVyn6XaK
 raLpNasCa2H6Dsjrsz0cDOSmp6l3krFiQRBdEe1Oqo3P+9s55te9K5P26A4XDbD8Bf6I ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w7psubc95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 11:03:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E740100038;
        Fri, 15 Nov 2019 11:03:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D5EA2B1887;
        Fri, 15 Nov 2019 11:03:14 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov 2019 11:03:13
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
Subject: [PATCH v4] remoteproc: stm32: fix probe error case
Date:   Fri, 15 Nov 2019 11:03:08 +0100
Message-ID: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_02:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rproc driver is probed before the mailbox driver and if the rproc
Device Tree node has some mailbox properties, the rproc driver probe
shall be deferred instead of being probed without mailbox support.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
Changes since v3: on error, free mailboxes from stm32_rproc_request_mbox()
Changes since v2: free other requested mailboxes after one request fails
Changes since v1: test IS_ERR() before checking PTR_ERR()
---
 drivers/remoteproc/stm32_rproc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 2cf4b29..bcebb78 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -310,11 +310,12 @@ static const struct stm32_mbox stm32_rproc_mbox[MBOX_NB_MBX] = {
 	}
 };
 
-static void stm32_rproc_request_mbox(struct rproc *rproc)
+static int stm32_rproc_request_mbox(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata = rproc->priv;
 	struct device *dev = &rproc->dev;
 	unsigned int i;
+	int j;
 	const unsigned char *name;
 	struct mbox_client *cl;
 
@@ -329,10 +330,20 @@ static void stm32_rproc_request_mbox(struct rproc *rproc)
 
 		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
 		if (IS_ERR(ddata->mb[i].chan)) {
+			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER)
+				goto err_probe;
 			dev_warn(dev, "cannot get %s mbox\n", name);
 			ddata->mb[i].chan = NULL;
 		}
 	}
+
+	return 0;
+
+err_probe:
+	for (j = i - 1; j >= 0; j--)
+		if (ddata->mb[j].chan)
+			mbox_free_channel(ddata->mb[j].chan);
+	return -EPROBE_DEFER;
 }
 
 static int stm32_rproc_set_hold_boot(struct rproc *rproc, bool hold)
@@ -596,7 +607,9 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	stm32_rproc_request_mbox(rproc);
+	ret = stm32_rproc_request_mbox(rproc);
+	if (ret)
+		goto free_rproc;
 
 	ret = rproc_add(rproc);
 	if (ret)
-- 
2.7.4

