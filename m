Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A180C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF0D24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLSLAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:00:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfLSLAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:00:35 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03CD71D9F40D5B438C79;
        Thu, 19 Dec 2019 19:00:33 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 19:00:26 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] drm: of: fix build error without CONFIG_OF
Date:   Thu, 19 Dec 2019 18:57:17 +0800
Message-ID: <20191219105717.175829-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_OF, drm_of_lvds_get_dual_link_pixel_order should be
static inline, otherwise building fails:

drivers/gpu/drm/vc4/vc4_dsi.o: In function `drm_of_lvds_get_dual_link_pixel_order':
vc4_dsi.c:(.text+0xa30): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
drivers/gpu/drm/vc4/vc4_dpi.o:vc4_dpi.c:(.text+0x460): first defined here
make[4]: *** [drivers/gpu/drm/vc4/vc4.o] Error 1
make[3]: *** [drivers/gpu/drm/vc4] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [drivers/gpu/drm] Error 2
make[1]: *** [drivers/gpu] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

Fixes: 6529007522de (drm: of: Add drm_of_lvds_get_dual_link_pixel_order)
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 include/drm/drm_of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 8ec7ca6..3398be9 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -92,7 +92,7 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return -EINVAL;
 }
 
-int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+static inline int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 					  const struct device_node *port2)
 {
 	return -EINVAL;
-- 
2.7.4

