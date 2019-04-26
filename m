Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFC206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Kar41bfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfDZHrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:47:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22666 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfDZHrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:47:17 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3Q7k911022870;
        Fri, 26 Apr 2019 09:47:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=dZqMZlMqCmtu4kiUq3G27UXEa35H19PJSKUSzaxdVFU=;
 b=Kar41bfgouT8Xw/IxJdx53Ih1w9nHo1ccELEjVAVWBLEMCS4uvbcPZYFXQ8wC2KSwdmX
 R3LecjO9hSN8oApsWWag7gLb3QxBJCi4tPFvmeUJRhVDPDdhwIyGl3JpRuvjL7I0OnCr
 AUIZaPXEstu8MW5lpbKyuPCXQfJCR54UCHY6hRu0ZtOnn6B//r4yBmKaXJySnG/ghPx/
 /qwzoMmG7AQ+pqIV/xMDJJxdEXUfQvmWLFTQa074xN+pzC0uLzzANCSEuWTcVGXp1nmU
 fBg/IXZKozMubSxUDw+VUVmi1UEplP50hMinBsfM/CPgR72HurGXUTTyycMPLOwuMJ9o 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj6jsxc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 26 Apr 2019 09:47:04 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D156D46;
        Fri, 26 Apr 2019 07:46:49 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A39B013B7;
        Fri, 26 Apr 2019 07:46:49 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Apr
 2019 09:46:49 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 26 Apr
 2019 09:46:49 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH V2 2/5] mmc: mmci: avoid fake busy polling in mmci_irq
Date:   Fri, 26 Apr 2019 09:46:35 +0200
Message-ID: <1556264798-18540-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

mmci_irq function loops until the status is totally cleared.
However the busy_detect_flag could occurred even if no busy
response is expected and that busy d0 line is low (like in
cmd11: voltage switch).
Like busy_detect_flag is handled into mmci_cmd_irq this flag
can be always excluded.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 049f8e3..a040f54 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1535,9 +1535,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Busy_detect_flag has been handled by mmci_cmd_irq,
+		 * it can be excluded to avoid to poll on it
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.7.4

