Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE320700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfC2MkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:40:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52515 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729384AbfC2MkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:40:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TCWjgM004410;
        Fri, 29 Mar 2019 13:39:52 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rddhc4xqc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 13:39:52 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9691B38;
        Fri, 29 Mar 2019 12:39:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B663DDC;
        Fri, 29 Mar 2019 12:39:51 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar
 2019 13:39:51 +0100
Received: from localhost (10.201.23.97) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar 2019 13:39:51
 +0100
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Subject: [PATCH] media: platform: stm32: wait end of transmission
Date:   Fri, 29 Mar 2019 13:39:42 +0100
Message-ID: <1553863182-6544-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is mandatory to write CEC_CFGR only when CECEN=0. To protect
transmission, a check have been added to delayed logical address
modification. This patch is necessary tp pass all tests of compliance.

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/media/platform/stm32/stm32-cec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-cec.c b/drivers/media/platform/stm32/stm32-cec.c
index 7c496bc..8a86b2c 100644
--- a/drivers/media/platform/stm32/stm32-cec.c
+++ b/drivers/media/platform/stm32/stm32-cec.c
@@ -56,6 +56,13 @@
 #define ALL_TX_IT	(TXEND | TXBR | TXACKE | TXERR | TXUDR | ARBLST)
 #define ALL_RX_IT	(RXEND | RXBR | RXACKE | RXOVR)
 
+/*
+ * 400 ms is the time it takes for one 16 byte message to be
+ * transferred and 5 is the maximum number of retries. Add
+ * another 100 ms as a margin.
+ */
+#define CEC_XFER_TIMEOUT_MS (5 * 400 + 100)
+
 struct stm32_cec {
 	struct cec_adapter	*adap;
 	struct device		*dev;
@@ -188,7 +195,11 @@ static int stm32_cec_adap_log_addr(struct cec_adapter *adap, u8 logical_addr)
 {
 	struct stm32_cec *cec = adap->priv;
 	u32 oar = (1 << logical_addr) << 16;
+	u32 val;
 
+	/* Poll every 100µs the register CEC_CR to wait end of transmission */
+	regmap_read_poll_timeout(cec->regmap, CEC_CR, val, !(val & TXSOM),
+				 100, CEC_XFER_TIMEOUT_MS * 1000);
 	regmap_update_bits(cec->regmap, CEC_CR, CECEN, 0);
 
 	if (logical_addr == CEC_LOG_ADDR_INVALID)
-- 
2.7.4

