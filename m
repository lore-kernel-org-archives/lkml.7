Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053CE20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbfB1NUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:20:19 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9597 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbfB1NUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:20:17 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SDGXmp014411;
        Thu, 28 Feb 2019 14:19:36 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvtxcub8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Feb 2019 14:19:36 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55D3431;
        Thu, 28 Feb 2019 13:19:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C5FA56C0;
        Thu, 28 Feb 2019 13:19:36 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb
 2019 14:19:36 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 28 Feb 2019 14:19:35
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 5/5] ASoC: stm32: sai: fix set_sync service
Date:   Thu, 28 Feb 2019 14:19:25 +0100
Message-ID: <1551359965-25228-6-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
References: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error check on set_sync function return.
Add of_node_put() as of_get_parent() takes a reference
which has to be released.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 8 +++++---
 sound/soc/stm/stm32_sai_sub.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 14c9591aae42..d68d62f12df5 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -105,6 +105,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
+		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -113,19 +114,20 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
 		ret = -EINVAL;
-		goto out_put_dev;
+		goto error;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		goto out_put_dev;
+		goto error;
 
 	/* Configure sync provider */
 	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
 
-out_put_dev:
+error:
 	put_device(&pdev->dev);
+	of_node_put(np_provider);
 	return ret;
 }
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cb658463ccd1..55d802f51c15 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1106,7 +1106,7 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
-	int cr1 = 0, cr1_mask;
+	int cr1 = 0, cr1_mask, ret;
 
 	sai->cpu_dai = cpu_dai;
 
@@ -1136,8 +1136,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	/* Configure synchronization */
 	if (sai->sync == SAI_SYNC_EXTERNAL) {
 		/* Configure synchro client and provider */
-		sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
-				     sai->synco, sai->synci);
+		ret = sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
+					   sai->synco, sai->synci);
+		if (ret)
+			return ret;
 	}
 
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
-- 
2.7.4

