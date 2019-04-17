Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FADC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCA5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbfDQO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:27:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729940AbfDQO1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:27:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78F162AAB16E820BD67A;
        Wed, 17 Apr 2019 22:27:13 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 22:27:03 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jglisse@redhat.com>, <jgg@mellanox.com>, <rcampbell@nvidia.com>,
        <leonro@mellanox.com>, <akpm@linux-foundation.org>,
        <sfr@canb.auug.org.au>
CC:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-mm@kvack.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] drm/nouveau: Fix DEVICE_PRIVATE dependencies
Date:   Wed, 17 Apr 2019 22:26:32 +0800
Message-ID: <20190417142632.12992-1-yuehaibing@huawei.com>
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

During randconfig builds, I occasionally run into an invalid configuration

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
  Selected by [y]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=y] && STAGING [=y]

mm/memory.o: In function `do_swap_page':
memory.c:(.text+0x2754): undefined reference to `device_private_entry_fault'

commit 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring from device memory")
split CONFIG_DEVICE_PRIVATE dependencies from
ARCH_HAS_HMM to ARCH_HAS_HMM_DEVICE and ZONE_DEVICE,
so enable DRM_NOUVEAU_SVM will trigger this warning,
cause building failed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5da25090ab04 ("mm/hmm: kconfig split HMM address space mirroring from device memory")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 00cd9ab..99e30c1 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -74,7 +74,8 @@ config DRM_NOUVEAU_BACKLIGHT
 
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
-	depends on ARCH_HAS_HMM
+	depends on ARCH_HAS_HMM_DEVICE
+	depends on ZONE_DEVICE
 	depends on DRM_NOUVEAU
 	depends on STAGING
 	select HMM_MIRROR
-- 
2.7.4


