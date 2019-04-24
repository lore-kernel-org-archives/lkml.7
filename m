Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84373C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5270820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nvJXnldU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfDXPvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:51:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29044 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730625AbfDXPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:51:19 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OFgB5s003581;
        Wed, 24 Apr 2019 17:51:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bJQEIOUyGC9QCXMihF5ETMO6w6LfdXskDZG3ee8y/jo=;
 b=nvJXnldUnFHJefhCeS96gK2Ebqx072PGequqWA7i8kzLv1bQzNuwjc8rTxWSI4jSA/FD
 MJqxmip8TeE8PXukTrgxf3uxZ9gej/nC+B8wxQgzS+GAEbbZoppioSYQsZfZYPDVgMYU
 nlo5pg1FIhFZDkLtFQ1sHn5aFqwWMKts/q45DPsabSdMr5WjniEI53p92B4a7En80j0v
 qU+cRl+lZaO0pUppkS8QniHz68j9/NcUN+cYoNxyPMrLayPmUqCMmI2f4kg8QqV1xAkA
 d9Qgo72YCSukuK8+wYEj8eLeD3e9E2hzWDL/riI8NuHAhghGvrEr5ZqH4EaRBBlnood2 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxef5n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 17:51:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 25B0631;
        Wed, 24 Apr 2019 15:51:10 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07619298E;
        Wed, 24 Apr 2019 15:51:10 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 17:51:09 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 17:51:08
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] mailbox: stm32-ipcc: check invalid irq
Date:   Wed, 24 Apr 2019 17:51:05 +0200
Message-ID: <1556121065-14487-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure of_irq_get() returns a negative value or zero, which is
not handled as an error in the existing implementation.
Instead of using this API, use platform_get_irq() that returns
exclusively a negative value on failure.
Also, do not output an error log in case of defer probe error.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/stm32-ipcc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 210fe50..f91dfb1 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -8,9 +8,9 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
 
@@ -240,9 +240,11 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 
 	/* irq */
 	for (i = 0; i < IPCC_IRQ_NUM; i++) {
-		ipcc->irqs[i] = of_irq_get_byname(dev->of_node, irq_name[i]);
+		ipcc->irqs[i] = platform_get_irq_byname(pdev, irq_name[i]);
 		if (ipcc->irqs[i] < 0) {
-			dev_err(dev, "no IRQ specified %s\n", irq_name[i]);
+			if (ipcc->irqs[i] != -EPROBE_DEFER)
+				dev_err(dev, "no IRQ specified %s\n",
+					irq_name[i]);
 			ret = ipcc->irqs[i];
 			goto err_clk;
 		}
@@ -263,9 +265,10 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 
 	/* wakeup */
 	if (of_property_read_bool(np, "wakeup-source")) {
-		ipcc->wkp = of_irq_get_byname(dev->of_node, "wakeup");
+		ipcc->wkp = platform_get_irq_byname(pdev, "wakeup");
 		if (ipcc->wkp < 0) {
-			dev_err(dev, "could not get wakeup IRQ\n");
+			if (ipcc->wkp != -EPROBE_DEFER)
+				dev_err(dev, "could not get wakeup IRQ\n");
 			ret = ipcc->wkp;
 			goto err_clk;
 		}
-- 
2.7.4

