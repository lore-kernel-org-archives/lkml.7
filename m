Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6EC218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfCUCBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:01:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5161 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbfCUCBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:01:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE1BE748927B4875688A;
        Thu, 21 Mar 2019 10:01:19 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 10:01:10 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] ASoC: wm_adsp: Make some variables static
Date:   Thu, 21 Mar 2019 10:01:06 +0800
Message-ID: <20190321020106.11096-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: make variables static
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1..c41bffc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -306,9 +306,9 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
-struct wm_adsp_ops wm_adsp1_ops;
-struct wm_adsp_ops wm_adsp2_ops[];
-struct wm_adsp_ops wm_halo_ops;
+static struct wm_adsp_ops wm_adsp1_ops;
+static struct wm_adsp_ops wm_adsp2_ops[];
+static struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
@@ -4407,13 +4407,13 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 }
 EXPORT_SYMBOL_GPL(wm_halo_wdt_expire);
 
-struct wm_adsp_ops wm_adsp1_ops = {
+static struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
 	.region_to_reg = wm_adsp_region_to_reg,
 };
 
-struct wm_adsp_ops wm_adsp2_ops[] = {
+static struct wm_adsp_ops wm_adsp2_ops[] = {
 	{
 		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
@@ -4474,7 +4474,7 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 	},
 };
 
-struct wm_adsp_ops wm_halo_ops = {
+static struct wm_adsp_ops wm_halo_ops = {
 	.sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr),
 	.parse_sizes = wm_adsp2_parse_sizes,
 	.validate_version = wm_halo_validate_version,
-- 
2.7.0


