Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BECAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E9720684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfDPO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:59:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729785AbfDPO7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:59:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B70F135278DF6EE9B4A2;
        Tue, 16 Apr 2019 22:59:35 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:59:29 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <maxime.ripard@bootlin.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <wens@csie.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/sun4i: Make some symbols static
Date:   Tue, 16 Apr 2019 22:58:55 +0800
Message-ID: <20190416145855.20852-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/sun4i/sun8i_tcon_top.c:271:36: warning: symbol 'sun8i_r40_tcon_top_quirks' was not declared. Should it be static?
drivers/gpu/drm/sun4i/sun8i_tcon_top.c:276:36: warning: symbol 'sun50i_h6_tcon_top_quirks' was not declared. Should it be static?
drivers/gpu/drm/sun4i/sun4i_tcon.c:239:6: warning: symbol 'sun4i_tcon_set_mux' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c     | 4 ++--
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index fa92e99..9d8d812 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -236,8 +236,8 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 	return NULL;
 }
 
-void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
-			const struct drm_encoder *encoder)
+static void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
+			       const struct drm_encoder *encoder)
 {
 	int ret = -ENOTSUPP;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index b1e7c76..3267d0f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -269,12 +269,12 @@ static int sun8i_tcon_top_remove(struct platform_device *pdev)
 	return 0;
 }
 
-const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks = {
+static const struct sun8i_tcon_top_quirks sun8i_r40_tcon_top_quirks = {
 	.has_tcon_tv1	= true,
 	.has_dsi	= true,
 };
 
-const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
+static const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
 	/* Nothing special */
 };
 
-- 
2.7.4


