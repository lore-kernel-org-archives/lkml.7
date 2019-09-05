Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF28C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE8C20693
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfIEGoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:44:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfIEGoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:44:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 105E6ECC49D523990C50;
        Thu,  5 Sep 2019 14:44:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:44:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <daniel.baluta@nxp.com>, <yuehaibing@huawei.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: SOF: imx8: Fix COMPILE_TEST error
Date:   Thu, 5 Sep 2019 14:44:00 +0800
Message-ID: <20190905064400.24800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When do compile test, if SND_SOC_SOF_OF is not set, we get:

sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_request':
imx8.c:(.text+0xb0): undefined reference to `snd_sof_ipc_msgs_rx'
sound/soc/sof/imx/imx8.o: In function `imx8_ipc_msg_data':
imx8.c:(.text+0xf4): undefined reference to `sof_mailbox_read'
sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_reply':
imx8.c:(.text+0x160): undefined reference to `sof_mailbox_read'

Make SND_SOC_SOF_IMX_TOPLEVEL always depends on SND_SOC_SOF_OF

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index fd73d84..5acae75 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -2,7 +2,8 @@
 
 config SND_SOC_SOF_IMX_TOPLEVEL
 	bool "SOF support for NXP i.MX audio DSPs"
-	depends on ARM64 && SND_SOC_SOF_OF || COMPILE_TEST
+	depends on ARM64|| COMPILE_TEST
+	depends on SND_SOC_SOF_OF
 	help
           This adds support for Sound Open Firmware for NXP i.MX platforms.
           Say Y if you have such a device.
-- 
2.7.4


