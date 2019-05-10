Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42796C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2003B2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfEJNaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:30:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbfEJNaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:30:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 088698B173D41A017B76;
        Fri, 10 May 2019 21:29:57 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 21:29:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH V2] ASoC: SOF: Fix build error with CONFIG_SND_SOC_SOF_NOCODEC=m
Date:   Fri, 10 May 2019 21:29:40 +0800
Message-ID: <20190510132940.28184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190510023657.8960-1-yuehaibing@huawei.com>
References: <20190510023657.8960-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_SND_SOC_SOF_NOCODEC=m

sound/soc/sof/core.o: In function `snd_sof_device_probe':
core.c:(.text+0x4af): undefined reference to `sof_nocodec_setup'

Change IS_ENABLED to IS_REACHABLE to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
V2: use IS_REACHABLE
---
 sound/soc/sof/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 32105e0..38e22f4 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -259,7 +259,7 @@ int snd_sof_create_page_table(struct snd_sof_dev *sdev,
 static int sof_machine_check(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *plat_data = sdev->pdata;
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
+#if IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
 	struct snd_soc_acpi_mach *machine;
 	int ret;
 #endif
@@ -267,7 +267,7 @@ static int sof_machine_check(struct snd_sof_dev *sdev)
 	if (plat_data->machine)
 		return 0;
 
-#if !IS_ENABLED(CONFIG_SND_SOC_SOF_NOCODEC)
+#if !IS_REACHABLE(CONFIG_SND_SOC_SOF_NOCODEC)
 	dev_err(sdev->dev, "error: no matching ASoC machine driver found - aborting probe\n");
 	return -ENODEV;
 #else
-- 
2.7.4


