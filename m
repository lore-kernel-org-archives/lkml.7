Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D0AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B7721848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="S8XFXpgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbfHZPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53111 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733182AbfHZPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:39:27 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFPxev018386;
        Mon, 26 Aug 2019 17:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tifbBOCihyi3euWjUK2dmnc9nxcr5SJrbcCSflAOoU8=;
 b=S8XFXpgE1a63XmxAh8nMqPjuQfMFYB2N3TTvQS7qbZkf0UHhuRkPfT/7MSJmwSjvX4Vu
 urGKqCn6XZWDEmTuZMPOvaky0r+BzIdAp432ZlS8I5OaiL1GYGoPg+lREiVMHHcozFXq
 37c1jw542Ti4bkCL2AQ698QSUNAMXgGT8QdNo38tgJVI6b1Sd6uIUv4P8c74Bxr1J22Q
 Rl2s74rsq11A1NwvdGVitQnt7bU8uvbGTCyPwS3o3Z9puxEk6+h0Zte8huY6PN9QW6cs
 ICY6B7TVjLa5ZjEUwI406HmBHMivWrUGFgTI2pk1GVi0oBX93QpYp3BHWHUQopwGyiZf mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vmgja-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Aug 2019 17:39:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6A9E918C;
        Mon, 26 Aug 2019 15:39:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFD532BE677;
        Mon, 26 Aug 2019 17:38:34 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 17:38:34 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 17:38:31
 +0200
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
Subject: [PATCH] remoteproc: stm32: manage the get_irq probe defer case
Date:   Mon, 26 Aug 2019 17:38:29 +0200
Message-ID: <1566833909-16644-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage the -EPROBE_DEFER error case for "wdg" IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 1c95913..2cf4b29 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -517,6 +517,9 @@ static int stm32_rproc_parse_dt(struct platform_device *pdev)
 	int err, irq;
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (irq > 0) {
 		err = devm_request_irq(dev, irq, stm32_rproc_wdg, 0,
 				       dev_name(dev), rproc);
-- 
2.7.4

