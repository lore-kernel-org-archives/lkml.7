Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBDC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B401C2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGVF5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfGVF5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E75CC2E21CA5AA7E315C;
        Mon, 22 Jul 2019 13:57:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Jul 2019
 13:57:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <james.qian.wang@arm.com>, <liviu.dudau@arm.com>,
        <brian.starkey@arm.com>, <airlied@linux.ie>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <daniel@ffwll.ch>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] drm/komeda: remove set but not used variable 'old'
Date:   Mon, 22 Jul 2019 13:56:27 +0800
Message-ID: <20190722055627.38008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190709135808.56388-1-yuehaibing@huawei.com>
References: <20190709135808.56388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/arm/display/komeda/komeda_plane.c:
 In function komeda_plane_atomic_duplicate_state:
drivers/gpu/drm/arm/display/komeda/komeda_plane.c:161:35:
 warning: variable old set but not used [-Wunused-but-set-variable

It is not used since commit 990dee3aa456 ("drm/komeda:
Computing image enhancer internally")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix compile err
---
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
index c095af1..98e915e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
@@ -158,7 +158,7 @@ static void komeda_plane_reset(struct drm_plane *plane)
 static struct drm_plane_state *
 komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
-	struct komeda_plane_state *new, *old;
+	struct komeda_plane_state *new;
 
 	if (WARN_ON(!plane->state))
 		return NULL;
@@ -169,8 +169,6 @@ komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
 
 	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
 
-	old = to_kplane_st(plane->state);
-
 	return &new->base;
 }
 
-- 
2.7.4


