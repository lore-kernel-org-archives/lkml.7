Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D00206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 06:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLaGmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 01:42:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfLaGmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 01:42:51 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BBB959DF03C5317FAABC;
        Tue, 31 Dec 2019 14:42:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 31 Dec 2019 14:42:42 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] drm/hisilicon: Add new clock/resolution configurations
Date:   Tue, 31 Dec 2019 14:42:51 +0800
Message-ID: <1577774571-60493-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the three new pll config for corresponding resolution 1440x900 and
1600x900, 640x480 for hibmc

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Gong junjie <gongjunjie2@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 3 +++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index f1ce6cb..6bf4334 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -40,6 +40,7 @@ struct hibmc_dislay_pll_config {
 };
 
 static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
+	{640, 480, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
 	{800, 600, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
 	{1024, 768, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
 	{1152, 864, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
@@ -47,6 +48,8 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
 	{1280, 720, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
 	{1280, 960, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
 	{1280, 1024, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
+	{1440, 900, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
+	{1600, 900, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
 	{1600, 1200, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
 	{1920, 1080, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
 	{1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
index 9b7e859..17b30c3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_regs.h
@@ -179,6 +179,7 @@
 #define CRT_PLL1_HS_74MHZ			0x23941dc2
 #define CRT_PLL1_HS_80MHZ			0x23941001
 #define CRT_PLL1_HS_80MHZ_1152			0x23540fc2
+#define CRT_PLL1_HS_106MHZ			0x237C1641
 #define CRT_PLL1_HS_108MHZ			0x23b41b01
 #define CRT_PLL1_HS_162MHZ			0x23480681
 #define CRT_PLL1_HS_148MHZ			0x23541dc2
@@ -191,6 +192,7 @@
 #define CRT_PLL2_HS_78MHZ			0x50E147AE
 #define CRT_PLL2_HS_74MHZ			0x602B6AE7
 #define CRT_PLL2_HS_80MHZ			0x70000000
+#define CRT_PLL2_HS_106MHZ			0x0075c28f
 #define CRT_PLL2_HS_108MHZ			0x80000000
 #define CRT_PLL2_HS_162MHZ			0xA0000000
 #define CRT_PLL2_HS_148MHZ			0xB0CCCCCD
-- 
2.7.4

