Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6CC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375821841
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEJChb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:37:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfEJChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:37:31 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F17F1393922CD272DFB;
        Fri, 10 May 2019 10:37:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 10:37:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
        <rdunlap@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: SOF: Fix build error with CONFIG_SND_SOC_SOF_NOCODEC=m
Date:   Fri, 10 May 2019 10:36:57 +0800
Message-ID: <20190510023657.8960-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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

Change SND_SOC_SOF_NOCODEC to bool to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c16211d6226d ("ASoC: SOF: Add Sound Open Firmware driver core")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index b204c65..9c280c9 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -44,7 +44,7 @@ config SND_SOC_SOF_OPTIONS
 if SND_SOC_SOF_OPTIONS
 
 config SND_SOC_SOF_NOCODEC
-	tristate "SOF nocodec mode Support"
+	bool "SOF nocodec mode Support"
 	help
 	  This adds support for a dummy/nocodec machine driver fallback
 	  option if no known codec is detected. This is typically only
-- 
2.7.4


