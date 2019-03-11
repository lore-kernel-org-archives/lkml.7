Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B246218D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCKPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:41:06 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbfCKPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:41:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BFaTm6022733;
        Mon, 11 Mar 2019 16:39:55 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r458m4kv1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Mar 2019 16:39:55 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A82EC38;
        Mon, 11 Mar 2019 15:39:53 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7929952D1;
        Mon, 11 Mar 2019 15:39:53 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 11 Mar
 2019 16:39:53 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 11 Mar 2019 16:39:52
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH] ASoC: stm32: i2s: fix registers declaration in regmap
Date:   Mon, 11 Mar 2019 16:39:28 +0100
Message-ID: <1552318768-25404-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Declare SR as volatile, as it is changed by hardware.
- Remove TXDR from readable and volatile register list,
as it is intended for write accesses only.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index c18e068c1a0d..952634258b02 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -278,7 +278,6 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 	case STM32_I2S_CFG2_REG:
 	case STM32_I2S_IER_REG:
 	case STM32_I2S_SR_REG:
-	case STM32_I2S_TXDR_REG:
 	case STM32_I2S_RXDR_REG:
 	case STM32_I2S_CGFR_REG:
 		return true;
@@ -290,7 +289,7 @@ static bool stm32_i2s_readable_reg(struct device *dev, unsigned int reg)
 static bool stm32_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case STM32_I2S_TXDR_REG:
+	case STM32_I2S_SR_REG:
 	case STM32_I2S_RXDR_REG:
 		return true;
 	default:
-- 
2.7.4

