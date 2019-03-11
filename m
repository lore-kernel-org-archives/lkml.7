Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38483C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130B220857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCKP1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:27:32 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727568AbfCKP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:27:31 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BFLfbn011746;
        Mon, 11 Mar 2019 16:26:38 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r458m4j0p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Mar 2019 16:26:38 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0C1131;
        Mon, 11 Mar 2019 15:26:37 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A56ED54C7;
        Mon, 11 Mar 2019 15:26:37 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Mar
 2019 16:26:37 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 11 Mar 2019 16:26:37
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ASoC: stm32: i2s: use default dai name
Date:   Mon, 11 Mar 2019 16:26:30 +0100
Message-ID: <1552317990-24219-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552317990-24219-1-git-send-email-olivier.moysan@st.com>
References: <1552317990-24219-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use default DAI name based on dev_name function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 06bbbef74b3a..c18e068c1a0d 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -179,7 +179,6 @@ enum i2s_datlen {
 	I2S_I2SMOD_DATLEN_32,
 };
 
-#define STM32_I2S_DAI_NAME_SIZE		20
 #define STM32_I2S_FIFO_SIZE		16
 
 #define STM32_I2S_IS_MASTER(x)		((x)->ms_flg == I2S_MS_MASTER)
@@ -202,7 +201,6 @@ enum i2s_datlen {
  * @phys_addr: I2S registers physical base address
  * @lock_fd: lock to manage race conditions in full duplex mode
  * @irq_lock: prevent race condition with IRQ
- * @dais_name: DAI name
  * @mclk_rate: master clock frequency (Hz)
  * @fmt: DAI protocol
  * @refcount: keep count of opened streams on I2S
@@ -224,7 +222,6 @@ struct stm32_i2s_data {
 	dma_addr_t phys_addr;
 	spinlock_t lock_fd; /* Manage race conditions for full duplex */
 	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
-	char dais_name[STM32_I2S_DAI_NAME_SIZE];
 	unsigned int mclk_rate;
 	unsigned int fmt;
 	int refcount;
@@ -771,12 +768,8 @@ static int stm32_i2s_dais_init(struct platform_device *pdev,
 	if (!dai_ptr)
 		return -ENOMEM;
 
-	snprintf(i2s->dais_name, STM32_I2S_DAI_NAME_SIZE,
-		 "%s", dev_name(&pdev->dev));
-
 	dai_ptr->probe = stm32_i2s_dai_probe;
 	dai_ptr->ops = &stm32_i2s_pcm_dai_ops;
-	dai_ptr->name = i2s->dais_name;
 	dai_ptr->id = 1;
 	stm32_i2s_dai_init(&dai_ptr->playback, "playback");
 	stm32_i2s_dai_init(&dai_ptr->capture, "capture");
-- 
2.7.4

