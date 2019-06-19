Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FCA2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kFj2Lc1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfFSLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:41:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1355 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfFSLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:41:23 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JBV2Qb027524;
        Wed, 19 Jun 2019 13:40:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=STywHjeMiZssNI+UTkVh5oLxGP1CkwSOM/Df8W6afIc=;
 b=kFj2Lc1xJjAFkVEonzO/1hpGabemD/IxS2GvtHTU1BMV3Fivl7IpaHhW3INs+YX1kOHN
 Y+XBU6LSjqGikqRXPxjawzWrgXRWjnF1H2ukTZmpFl/r69C7wOJ5NiwxIZqRKbsmA7x9
 ls0Mr4Nt5N922wdRW6QYM7sj+vikuuSl+XQRSnA6nP07iHWeoumOzTwXMKkANWjLANlC
 uz2L0bwNxPVD8y9BtEmpml+1vdz+8wayCToZhD594HDY+y8a3whiMoCgQ/x4BJWSkZre
 77yEGx6wOGouhBmOR7X14GxWNktWodim7UPRef7TG8Qh4uLJLaHE0uTYrwEuO7yaiG+l 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t7813bkt4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 13:40:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F017731;
        Wed, 19 Jun 2019 11:40:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AF8A826C0;
        Wed, 19 Jun 2019 11:40:05 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 13:40:05 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 13:40:05
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>
Subject: [PATCH] ASoC: stm32: dfsdm: add 16 bits audio record support
Date:   Wed, 19 Jun 2019 13:40:02 +0200
Message-ID: <1560944402-8115-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of audio 16 bits format record to STM32
DFSDM driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 49 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index cc517e007039..3c9a9deec9af 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -45,7 +45,7 @@ struct stm32_adfsdm_priv {
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
-	.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rate_min = 8000,
 	.rate_max = 32000,
@@ -141,7 +141,8 @@ static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
 	.capture = {
 		    .channels_min = 1,
 		    .channels_max = 1,
-		    .formats = SNDRV_PCM_FMTBIT_S32_LE,
+		    .formats = SNDRV_PCM_FMTBIT_S16_LE |
+			       SNDRV_PCM_FMTBIT_S32_LE,
 		    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 			      SNDRV_PCM_RATE_32000),
 		    },
@@ -152,30 +153,58 @@ static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
 	.name = "stm32_dfsdm_audio",
 };
 
+static void memcpy_32to16(void *dest, const void *src, size_t n)
+{
+	unsigned int i = 0;
+	u16 *d = (u16 *)dest, *s = (u16 *)src;
+
+	s++;
+	for (i = n; i > 0; i--) {
+		*d++ = *s++;
+		s++;
+	}
+}
+
 static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 {
 	struct stm32_adfsdm_priv *priv = private;
 	struct snd_soc_pcm_runtime *rtd = priv->substream->private_data;
 	u8 *pcm_buff = priv->pcm_buff;
 	u8 *src_buff = (u8 *)data;
-	unsigned int buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
-	unsigned int period_size = snd_pcm_lib_period_bytes(priv->substream);
 	unsigned int old_pos = priv->pos;
-	unsigned int cur_size = size;
+	size_t buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
+	size_t period_size = snd_pcm_lib_period_bytes(priv->substream);
+	size_t cur_size, src_size = size;
+	snd_pcm_format_t format = priv->substream->runtime->format;
+
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		src_size >>= 1;
+	cur_size = src_size;
 
 	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
-		__func__, &pcm_buff[priv->pos], priv->pos, size);
+		__func__, &pcm_buff[priv->pos], priv->pos, src_size);
 
-	if ((priv->pos + size) > buff_size) {
-		memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
+	if ((priv->pos + src_size) > buff_size) {
+		if (format == SNDRV_PCM_FORMAT_S16_LE)
+			memcpy_32to16(&pcm_buff[priv->pos], src_buff,
+				      buff_size - priv->pos);
+		else
+			memcpy(&pcm_buff[priv->pos], src_buff,
+			       buff_size - priv->pos);
 		cur_size -= buff_size - priv->pos;
 		priv->pos = 0;
 	}
 
-	memcpy(&pcm_buff[priv->pos], &src_buff[size - cur_size], cur_size);
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		memcpy_32to16(&pcm_buff[priv->pos],
+			      &src_buff[src_size - cur_size], cur_size);
+	else
+		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size],
+		       cur_size);
+
 	priv->pos = (priv->pos + cur_size) % buff_size;
 
-	if (cur_size != size || (old_pos && (old_pos % period_size < size)))
+	if (cur_size != src_size || (old_pos && (old_pos % period_size < size)))
 		snd_pcm_period_elapsed(priv->substream);
 
 	return 0;
-- 
2.7.4

