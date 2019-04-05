Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E83C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADFF217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gQmeHuuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfDEJVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:21:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51068 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729792AbfDEJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:21:10 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3597abN009606;
        Fri, 5 Apr 2019 11:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bWyYs3FLREqLOO9oEvteJUqDuDSaML0/Ki1ImkwlKEw=;
 b=gQmeHuufyYc1zkAJxLyqIr1KZZuFHy4p1UbL3oHIP/KzQXA8pVSoYY51KaMxZyoDW6DH
 OLKBnWghfJTHBrtjQ/2FyeNCAAxN9/Ymlhfeh1GExHpTXCQniLJ5dNRxJZTzgFJWWY3K
 TamBlV6/YfPX6G3HVpX18pZmx5/ZRxU8uzT88kWOQ5irjfjex7QwvwUNnhMMgr9lh0f3
 S+CNkPtlzbHBg4FSI/JZowrnhAl8RUpbYhjUBQfHoc6aZAu36PLEQ5sQjQEJhrAqiy8Z
 vIol20AR+fvADry39ka8bC+4SfQpcjvOdDBEIs41rgmJ1jyeFc4GPi27UXL/mSmfqKRO Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rmh5yrm0k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Apr 2019 11:20:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C38AA31;
        Fri,  5 Apr 2019 09:20:06 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8EB85164B;
        Fri,  5 Apr 2019 09:20:06 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 5 Apr 2019
 11:20:06 +0200
Received: from localhost (10.48.0.131) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Apr 2019 11:20:06 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH] ASoC: stm32: fix sai driver name initialisation
Date:   Fri, 5 Apr 2019 11:19:11 +0200
Message-ID: <1554455951-2755-1-git-send-email-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.131]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-05_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the sai driver structure overwriting which results in
a cpu dai name equal NULL.

Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 2a90641..3dd54bc 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1420,7 +1420,6 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 	if (!sai->cpu_dai_drv)
 		return -ENOMEM;
 
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 	if (STM_SAI_IS_PLAYBACK(sai)) {
 		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
 		       sizeof(stm32_sai_playback_dai));
@@ -1430,6 +1429,7 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 		       sizeof(stm32_sai_capture_dai));
 		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
 	}
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 
 	return 0;
 }
-- 
2.7.4

