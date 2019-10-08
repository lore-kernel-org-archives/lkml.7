Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD6C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650F20867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfJHCmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:42:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbfJHCmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:42:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 991DDDCAB4BC3935C2E2;
        Tue,  8 Oct 2019 10:42:01 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 8 Oct 2019
 10:41:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <airlied@redhat.com>, <kraxel@redhat.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <virtualization@lists.linux-foundation.org>,
        <spice-devel@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/qxl: Fix randbuild error
Date:   Tue, 8 Oct 2019 10:40:54 +0800
Message-ID: <20191008024054.32368-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DEM_QXL is y and DRM_TTM_HELPER is m, building fails:

drivers/gpu/drm/qxl/qxl_object.o: undefined reference to `drm_gem_ttm_print_info'

Select DRM_TTM_HELPER to fix this.

Fixes: 78d54f1f6a33 ("drm/qxl: use drm_gem_ttm_print_info")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/qxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
index d0d691b..ca3f51c 100644
--- a/drivers/gpu/drm/qxl/Kconfig
+++ b/drivers/gpu/drm/qxl/Kconfig
@@ -4,6 +4,7 @@ config DRM_QXL
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_TTM
+	select DRM_TTM_HELPER
 	select CRC32
 	help
 	  QXL virtual GPU for Spice virtualization desktop integration.
-- 
2.7.4


