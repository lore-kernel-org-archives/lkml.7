Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B79C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EC324639
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186209;
	bh=PDQKFwTZ+4tb8UFV3uA4gFWymgWjmywDPoUt7qwHpMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DaEFIYZ/enfaJri+v79ijxRk+Qltm6ZW/+uVosmei3rzdeXR8dhkXlFvL3YiJ8Ipp
	 OE+SMH0Le+bVEc9bkpnKZ8jB+EAEg2TEbQ3nafeuerBG7/O4wHMqXOdNBotTCyDr/f
	 hjoEaUelSYq1wmxPa6AL3J14hUXp0vuwuWMY56Nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfE3DQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbfE3DNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:32 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D9E24546;
        Thu, 30 May 2019 03:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186012;
        bh=PDQKFwTZ+4tb8UFV3uA4gFWymgWjmywDPoUt7qwHpMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ksBItEBctIUhCgxxIfcEYjxchdeLD/GAVlMVVF0ZOjDtEt8R8a3pLu4WFDvrptIV
         VJxsHfbM/bZimbysRYF5yEreWeUcDnJkhqI1UtRJO+0q6cE1YwHPld3ouCa0utY1Mp
         eC07eUTX0sdsoZPSFn7dmgRSF96+XvH4DLXqSgjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Derrick <jonathan.derrick@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 075/346] drm/nouveau/bar/nv50: ensure BAR is mapped
Date:   Wed, 29 May 2019 20:02:28 -0700
Message-Id: <20190530030544.892889046@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



