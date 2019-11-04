Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFCCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AAE2184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MRlR2bfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfKDNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:38:06 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19420 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbfKDNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:38:06 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4DWFkJ026453;
        Mon, 4 Nov 2019 14:37:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=0V0+n6EoG5ZZ+IdpLsOxLEtGg4+FYYg6VUMRseHZqHA=;
 b=MRlR2bfvQfp6TmzTJF+TAOFdz7iv72iApjX1BtIml+gWAdhk6XTdhD5zMwAGlWJn7hiX
 72UnCam408Cz3k86Sv/6Df6UmeXtjiQTeCRxKGJMKJ0rAzRPuIFznZ0ivwESy9yDBJUD
 6WHkjeIAnKqOqsl2s79PQbqLg+RiaU2K9BglSVceDVFx7HykUvbMsjVgTpgNtL4REiSc
 LeGoYL3b7+3oeUNsdWMVjNhPBDxOlAaJyibOnJo0Yg67CVkpH7C8j+9f/wHfBRmPn/7q
 1NycHLFlHspA50/WNl2EZ+FGz2bCxW4Dd+L3nMHohxAZip2sbdKxUu+PEI3F769J0Rma hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w10f19mg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 14:37:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 496CB100042;
        Mon,  4 Nov 2019 14:37:06 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C5C12FF5DB;
        Mon,  4 Nov 2019 14:37:06 +0100 (CET)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019
 14:37:06 +0100
Received: from localhost (10.201.21.218) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 4 Nov 2019 14:37:05
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>
Subject: [PATCH] ASoC: stm32: sai: add restriction on mmap support
Date:   Mon, 4 Nov 2019 14:36:54 +0100
Message-ID: <20191104133654.28750-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.218]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not support mmap in S/PDIF mode. In S/PDIF mode
the buffer has to be copied, to allow the channel status
bits insertion.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index a4060813bc74..48e629ac2d88 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1218,6 +1218,16 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+/* No support of mmap in S/PDIF mode */
+static const struct snd_pcm_hardware stm32_sai_pcm_hw_spdif = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED,
+	.buffer_bytes_max = 8 * PAGE_SIZE,
+	.period_bytes_min = 1024,
+	.period_bytes_max = PAGE_SIZE,
+	.periods_min = 2,
+	.periods_max = 8,
+};
+
 static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP,
 	.buffer_bytes_max = 8 * PAGE_SIZE,
@@ -1270,7 +1280,7 @@ static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config = {
 };
 
 static const struct snd_dmaengine_pcm_config stm32_sai_pcm_config_spdif = {
-	.pcm_hardware = &stm32_sai_pcm_hw,
+	.pcm_hardware = &stm32_sai_pcm_hw_spdif,
 	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.process = stm32_sai_pcm_process_spdif,
 };
-- 
2.17.1

