Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6A4ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131912190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PKMm3t0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfJKIsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:48:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17314 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbfJKIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:48:45 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9B8jVnm018619;
        Fri, 11 Oct 2019 10:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=dn57trJDwkZf1zTqrirKMCOuNO/LkBA2sd55GnG6NrU=;
 b=PKMm3t0OsAVAyHFmAAlnAP0bWm6GHiWzxQmRPaq1eXJD1wgLj5zdV8OvDjkWAtvgOdYR
 8ii3smM+kk5ljgpYs+HOATNvoJG1BIBTlvlNi5mpmQjjy+hfac7Q8+qFBWsipIUzfiHj
 O0ALWBKDhiIs4PSeevSExUmfbcjbPTMd5lPnaRXzk8LUox7HIeg4Ld0GtTL/O9sWaZhb
 UL0yG/OJC35RRR8oSNysU+ktBDANlgq1OsXl4f7LdpTdr0esEJfaJtfJI1RY7S67PXY1
 s6wuaRxaW+wNtVD/l8xUtM5vlCPjHopuYdMhPFBHRgcJB9yizr6MDxRfp/d7ERK2ZhpC EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vegahhecn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 10:48:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A6F1710002A;
        Fri, 11 Oct 2019 10:48:19 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19BF12AF4B7;
        Fri, 11 Oct 2019 10:48:19 +0200 (CEST)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 10:48:19 +0200
Received: from localhost (10.201.21.218) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct 2019 10:48:18
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH] ASoC: stm32: spdifrx: retry synchronization in sync state
Date:   Fri, 11 Oct 2019 10:48:16 +0200
Message-ID: <20191011084816.14279-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.218]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_06:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When STM32 SPDIFRX is in sync state, allow multiple
synchro attempts, instead of exiting on first unsuccessful
trial. This is useful when spdif signal is not immediately
available on input. This also allows Pulseaudio to check
iec capture device availability when no signal is present.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index cd4b235fce57..3fd28ee01675 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -351,6 +351,8 @@ static int stm32_spdifrx_start_sync(struct stm32_spdifrx_data *spdifrx)
 		     SPDIFRX_CR_CUMSK | SPDIFRX_CR_PTMSK | SPDIFRX_CR_RXSTEO;
 		cr_mask = cr;
 
+		cr |= SPDIFRX_CR_NBTRSET(SPDIFRX_NBTR_63);
+		cr_mask |= SPDIFRX_CR_NBTR_MASK;
 		cr |= SPDIFRX_CR_SPDIFENSET(SPDIFRX_SPDIFEN_SYNC);
 		cr_mask |= SPDIFRX_CR_SPDIFEN_MASK;
 		ret = regmap_update_bits(spdifrx->regmap, STM32_SPDIFRX_CR,
@@ -666,7 +668,7 @@ static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
 	struct snd_pcm_substream *substream = spdifrx->substream;
 	struct platform_device *pdev = spdifrx->pdev;
 	unsigned int cr, mask, sr, imr;
-	unsigned int flags;
+	unsigned int flags, sync_state;
 	int err = 0, err_xrun = 0;
 
 	regmap_read(spdifrx->regmap, STM32_SPDIFRX_SR, &sr);
@@ -726,11 +728,23 @@ static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
 	}
 
 	if (err) {
-		/* SPDIFRX in STATE_STOP. Disable SPDIFRX to clear errors */
+		regmap_read(spdifrx->regmap, STM32_SPDIFRX_CR, &cr);
+		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) &&
+			     SPDIFRX_SPDIFEN_SYNC;
+
+		/* SPDIFRX is in STATE_STOP. Disable SPDIFRX to clear errors */
 		cr = SPDIFRX_CR_SPDIFENSET(SPDIFRX_SPDIFEN_DISABLE);
 		regmap_update_bits(spdifrx->regmap, STM32_SPDIFRX_CR,
 				   SPDIFRX_CR_SPDIFEN_MASK, cr);
 
+		/* If SPDIFRX was in STATE_SYNC, retry synchro */
+		if (sync_state) {
+			cr = SPDIFRX_CR_SPDIFENSET(SPDIFRX_SPDIFEN_SYNC);
+			regmap_update_bits(spdifrx->regmap, STM32_SPDIFRX_CR,
+					   SPDIFRX_CR_SPDIFEN_MASK, cr);
+			return IRQ_HANDLED;
+		}
+
 		if (substream)
 			snd_pcm_stop(substream, SNDRV_PCM_STATE_DISCONNECTED);
 
-- 
2.17.1

