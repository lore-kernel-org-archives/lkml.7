Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD16C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781FD2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfJFK4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:56:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbfJFK4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:56:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B54B5739D6D5E177BA0;
        Sun,  6 Oct 2019 18:56:02 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:55:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <timur@kernel.org>, <nicoleotsuka@gmail.com>,
        <Xiubo.Lee@gmail.com>, <festevam@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: fsl_mqs: remove set but not used variable 'bclk'
Date:   Sun, 6 Oct 2019 18:55:22 +0800
Message-ID: <20191006105522.58560-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/fsl/fsl_mqs.c: In function fsl_mqs_hw_params:
sound/soc/fsl/fsl_mqs.c:54:6: warning: variable bclk set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/fsl_mqs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index c1619a5..7b9cab3 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -51,10 +51,9 @@ static int fsl_mqs_hw_params(struct snd_pcm_substream *substream,
 	struct fsl_mqs *mqs_priv = snd_soc_component_get_drvdata(component);
 	unsigned long mclk_rate;
 	int div, res;
-	int bclk, lrclk;
+	int lrclk;
 
 	mclk_rate = clk_get_rate(mqs_priv->mclk);
-	bclk = snd_soc_params_to_bclk(params);
 	lrclk = params_rate(params);
 
 	/*
-- 
2.7.4


