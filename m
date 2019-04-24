Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B45AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD56C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KmlRDeTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfDXJgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:36:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44518 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbfDXJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:36:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9WKkc009571;
        Wed, 24 Apr 2019 11:36:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=hK5t7y+11Q/jBOjgXpZKT6Kzk/a5+Fki4gzrmRWBWus=;
 b=KmlRDeTOQrhw4ziBx+keBfZ83Jz1TeCeu6VKfinPWH54nkhmu+n4XgyYHtChNmqmAnfP
 yiuphLTJ8iq6PD4FQdDzYPP+mPcto6uB0MmUg7JU2ybQ8OCfmIjA3MbQmxcZS/X0Vd5f
 yVcnfyD7c2Fm/sQm8Topoq+LVL3l2/bdWIXDBDrsdXA2IHVC0WZoVsFI9ZYUY7iggzPz
 Jj/EbzVStiv6tnQdR+T0PN/++YCc2u+nfOSWVOBweFIsEBa48D5yXOmZAysANomr2lgA
 6C0S9BMM7rVv3BoWZtvTNAg8HgxXMhY+GqyvqdX2RvjaStmZbHa3eaOhJo9XLQkq+TUI hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad5m1p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 11:36:01 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88DEC31;
        Wed, 24 Apr 2019 09:36:00 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D59915AF;
        Wed, 24 Apr 2019 09:36:00 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 11:36:00 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 11:35:59
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] net: ethernet: stmmac: manage the get_irq probe defer case
Date:   Wed, 24 Apr 2019 11:35:49 +0200
Message-ID: <1556098549-18385-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manage the -EPROBE_DEFER error case for "stm32_pwr_wakeup"  IRQ.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 062a600f..2142853 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -333,6 +333,9 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	 */
 	dwmac->irq_pwr_wakeup = platform_get_irq_byname(pdev,
 							"stm32_pwr_wakeup");
+	if (dwmac->irq_pwr_wakeup == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!dwmac->clk_eth_ck && dwmac->irq_pwr_wakeup >= 0) {
 		err = device_init_wakeup(&pdev->dev, true);
 		if (err) {
-- 
2.7.4

