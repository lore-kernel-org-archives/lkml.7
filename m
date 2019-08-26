Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0B921852
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Uy9YJ97H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbfHZPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1355 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733084AbfHZPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:39:21 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QFPrA8018373;
        Mon, 26 Aug 2019 17:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=C0FjddlLz1tmGjWDBbox9NlNRBYo5AeX1gKNZtaLU5g=;
 b=Uy9YJ97HWifGqiNE2bZDoI7Goq6JnRM7BYzJuFG+KghxPxQpMXRocx54nTa7JjhnaXH9
 pPWn55lKtkr86gbQ0Q9xTfq9ue4Wjj5DBRFvLb27ZNa0aCBE5vLQSpdGoU60SWHC7SyC
 gs/+4Co71mrbqGPctuDkriAajhGNNVpk9F4B/x4ANnsPksHO8u/LErIQhrgi1ivgQF2r
 XUKzG4wyUm7W+TJra1/zVOWlAG4wmBJlFNv5hr8ScymlZn083D4mrfcRXizwk5EOwODd
 zxciaIIANo/FGysi1csooiGWhF0x27CYRUjUZgz4fXC6xHuItnr3v7GXNnUEfyz1+wJr KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uju0vmgf6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 26 Aug 2019 17:39:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 274E01D1;
        Mon, 26 Aug 2019 15:38:42 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A29F52D3762;
        Mon, 26 Aug 2019 17:38:25 +0200 (CEST)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug
 2019 17:38:25 +0200
Received: from localhost (10.201.23.25) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 17:38:21
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
Subject: [PATCH] remoteproc: stm32: clear MCU PDDS at firmware start
Date:   Mon, 26 Aug 2019 17:38:06 +0200
Message-ID: <1566833886-16571-1-git-send-email-fabien.dessenne@st.com>
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

When remoteproc stops a firmware, it sets the MCU PDDS flag, allowing
the platform to reach the Standby power mode if needed.
Symmetrically, clear this flag before running a firmware.
This fixes the issue where the system goes to Standby mode when the
MCU crashes while MPU is in CSTOP mode.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/remoteproc/stm32_rproc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index e2da719..1c95913 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -383,10 +383,21 @@ static void stm32_rproc_add_coredump_trace(struct rproc *rproc)
 
 static int stm32_rproc_start(struct rproc *rproc)
 {
+	struct stm32_rproc *ddata = rproc->priv;
 	int err;
 
 	stm32_rproc_add_coredump_trace(rproc);
 
+	/* clear remote proc Deep Sleep */
+	if (ddata->pdds.map) {
+		err = regmap_update_bits(ddata->pdds.map, ddata->pdds.reg,
+					 ddata->pdds.mask, 0);
+		if (err) {
+			dev_err(&rproc->dev, "failed to clear pdds\n");
+			return err;
+		}
+	}
+
 	err = stm32_rproc_set_hold_boot(rproc, false);
 	if (err)
 		return err;
-- 
2.7.4

