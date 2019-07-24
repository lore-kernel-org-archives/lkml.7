Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA30C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A1229F3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfGXBlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:41:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbfGXBlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:41:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 71246B0D356AE83596C3;
        Wed, 24 Jul 2019 09:41:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Jul 2019 09:40:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] drm/mga: remove set but not used variable 'buf_priv'
Date:   Wed, 24 Jul 2019 01:46:19 +0000
Message-ID: <20190724014619.32665-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/mga/mga_state.c: In function 'mga_dma_iload':
drivers/gpu/drm/mga/mga_state.c:945:22: warning:
 variable 'buf_priv' set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/mga/mga_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/mga/mga_state.c b/drivers/gpu/drm/mga/mga_state.c
index 77a0b006f066..0dec4062e5a2 100644
--- a/drivers/gpu/drm/mga/mga_state.c
+++ b/drivers/gpu/drm/mga/mga_state.c
@@ -942,7 +942,6 @@ static int mga_dma_iload(struct drm_device *dev, void *data, struct drm_file *fi
 	struct drm_device_dma *dma = dev->dma;
 	drm_mga_private_t *dev_priv = dev->dev_private;
 	struct drm_buf *buf;
-	drm_mga_buf_priv_t *buf_priv;
 	drm_mga_iload_t *iload = data;
 	DRM_DEBUG("\n");
 
@@ -959,7 +958,6 @@ static int mga_dma_iload(struct drm_device *dev, void *data, struct drm_file *fi
 		return -EINVAL;
 
 	buf = dma->buflist[iload->idx];
-	buf_priv = buf->dev_private;
 
 	if (mga_verify_iload(dev_priv, iload->dstorg, iload->length)) {
 		mga_freelist_put(dev, buf);



