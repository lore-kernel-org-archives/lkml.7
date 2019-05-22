Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D70F20862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558555017;
	bh=t5xengB7nNuo2KSH7Jj1ZxDwNMwXO7ggXnUm8qMUaWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=182J9m2GuFJMJO9THtEPYzssfYXBXiGawiPCQaV459IVz4F5zCCHiio0Rb2UmO8nE
	 SE5LV/i1tmBZz1GDohSNtBcDSQJFDscDpwUG9u3kZ4CN0Jek3BPVTUPaXVkWqzmWC9
	 lwbzpaMr2ZS2yXY4xMx6/u8O7JR6RqyHClbch7xI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfEVT44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfEVTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:24:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8712020675;
        Wed, 22 May 2019 19:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553081;
        bh=t5xengB7nNuo2KSH7Jj1ZxDwNMwXO7ggXnUm8qMUaWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpGq74nhZkZAvlGyOeYseG3B54bTIb6iKyceKicJqyHy0C9iAoi6QrXQJ4x/GKY0Q
         Cx8XoqqMUAyFokmXTweZw3y6qZY0iObevjMMNDKokoj4BC4XkPDtP2MfwCsPwQ20U9
         n8TGHcP2DXmP4ZsT6u877lZ0NWBDWjmdHT2e+Hd0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 037/317] drm/nouveau/bar/nv50: ensure BAR is mapped
Date:   Wed, 22 May 2019 15:18:58 -0400
Message-Id: <20190522192338.23715-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Derrick <jonathan.derrick@intel.com>

[ Upstream commit f10b83de1fd49216a4c657816f48001437e4bdd5 ]

If the BAR is zero size, it indicates it was never successfully mapped.
Ensure that the BAR is valid during initialization before attempting to
use it.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c
index 157b076a12723..38c9c086754b6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c
@@ -109,7 +109,7 @@ nv50_bar_oneinit(struct nvkm_bar *base)
 	struct nvkm_device *device = bar->base.subdev.device;
 	static struct lock_class_key bar1_lock;
 	static struct lock_class_key bar2_lock;
-	u64 start, limit;
+	u64 start, limit, size;
 	int ret;
 
 	ret = nvkm_gpuobj_new(device, 0x20000, 0, false, NULL, &bar->mem);
@@ -127,7 +127,10 @@ nv50_bar_oneinit(struct nvkm_bar *base)
 
 	/* BAR2 */
 	start = 0x0100000000ULL;
-	limit = start + device->func->resource_size(device, 3);
+	size = device->func->resource_size(device, 3);
+	if (!size)
+		return -ENOMEM;
+	limit = start + size;
 
 	ret = nvkm_vmm_new(device, start, limit-- - start, NULL, 0,
 			   &bar2_lock, "bar2", &bar->bar2_vmm);
@@ -164,7 +167,10 @@ nv50_bar_oneinit(struct nvkm_bar *base)
 
 	/* BAR1 */
 	start = 0x0000000000ULL;
-	limit = start + device->func->resource_size(device, 1);
+	size = device->func->resource_size(device, 1);
+	if (!size)
+		return -ENOMEM;
+	limit = start + size;
 
 	ret = nvkm_vmm_new(device, start, limit-- - start, NULL, 0,
 			   &bar1_lock, "bar1", &bar->bar1_vmm);
-- 
2.20.1

