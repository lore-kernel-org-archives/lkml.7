Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF6CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF36206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329642;
	bh=YNtoK4IrYXOk6oBFJRviNod+DwilNejl0im70URh+LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apAzYCvL8uMz0KlU2376wS/uMcFbAHJkIBTz4lyere5/Mq7nXbQx74omAcm3ddyz6
	 O6qJceOfOQ/+Ab4BLVmBLhAXFRY3aAqZHAatPflpCMqyvAAbCi3BqhB9rkH1qZZSEE
	 UKEDoLA8UY+tPhRzcSiadGvnOp4qxuBPYhtxkoKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfD0BnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfD0BnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8729216C4;
        Sat, 27 Apr 2019 01:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329380;
        bh=YNtoK4IrYXOk6oBFJRviNod+DwilNejl0im70URh+LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMPaWXjlFrLJktinrc5VQoaYSFJR1k2G1wEGAXuJwNylrvxrb/6r4Y8OfFhWFjyG2
         LSHMCxPDnnwmPAeE/1pvmZ4bWR9i7O1wFSDxe1GHY2ROLAehiQYVcKGAX4jRSXHYAQ
         rwwgGJ357ZfDKAxL3+Yun2Cok140+jsN3cftPniQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/32] ASoC: stm32: fix sai driver name initialisation
Date:   Fri, 26 Apr 2019 21:42:10 -0400
Message-Id: <20190427014224.8274-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

[ Upstream commit 17d3069ccf06970e2db3f7cbf4335f207524279e ]

This patch fixes the sai driver structure overwriting which results in
a cpu dai name equal NULL.

Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 90d439613899..48b4286100d4 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -873,7 +873,6 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 	if (!sai->cpu_dai_drv)
 		return -ENOMEM;
 
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 	if (STM_SAI_IS_PLAYBACK(sai)) {
 		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
 		       sizeof(stm32_sai_playback_dai));
@@ -883,6 +882,7 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 		       sizeof(stm32_sai_capture_dai));
 		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
 	}
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 
 	return 0;
 }
-- 
2.19.1

