Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815EDC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E33020828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLZMPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 07:15:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfLZMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 07:15:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12B0587488DA07FE6DF0;
        Thu, 26 Dec 2019 20:15:00 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Dec 2019
 20:14:49 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] drm/bridge: cdns: remove set but not used variable 'nlanes'
Date:   Thu, 26 Dec 2019 20:14:15 +0800
Message-ID: <20191226121415.39483-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/bridge/cdns-dsi.c: In function ‘cdns_dsi_mode2cfg’:
drivers/gpu/drm/bridge/cdns-dsi.c:515:11: warning: variable ‘nlanes’
set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index 3a5bd4e7fd1e..a6ab2d281a9b 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -512,7 +512,7 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	struct cdns_dsi_output *output = &dsi->output;
 	unsigned int tmp;
 	bool sync_pulse = false;
-	int bpp, nlanes;
+	int bpp;
 
 	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
 
@@ -520,7 +520,6 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 		sync_pulse = true;
 
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
-	nlanes = output->dev->lanes;
 
 	if (mode_valid_check)
 		tmp = mode->htotal -
-- 
2.17.2

