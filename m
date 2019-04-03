Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D168C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6616D206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDCQDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:03:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:8154 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfDCQDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:03:42 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A8767A272F3D2EB5F913;
        Thu,  4 Apr 2019 00:03:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x33G3XYq028657;
        Thu, 4 Apr 2019 00:03:33 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019040400035945-7533732 ;
          Thu, 4 Apr 2019 00:03:59 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 3/7] drm/msm: a5xx: fix possible object reference leak
Date:   Thu, 4 Apr 2019 00:04:11 +0800
Message-Id: <1554307455-40361-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-04-04 00:03:59,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-04-04 00:03:25,
        Serialize complete at 2019-04-04 00:03:25
X-MAIL: mse01.zte.com.cn x33G3XYq028657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:57:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:66:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:118:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:57:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:66:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.
drivers/gpu/drm/msm/adreno/a5xx_gpu.c:118:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Mamta Shukla <mamtashukla555@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sharat Masetty <smasetty@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index d5f5e56..270da14 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -34,7 +34,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
 {
 	struct device *dev = &gpu->pdev->dev;
 	const struct firmware *fw;
-	struct device_node *np;
+	struct device_node *np, *mem_np;
 	struct resource r;
 	phys_addr_t mem_phys;
 	ssize_t mem_size;
@@ -48,11 +48,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
 	if (!np)
 		return -ENODEV;
 
-	np = of_parse_phandle(np, "memory-region", 0);
-	if (!np)
+	mem_np = of_parse_phandle(np, "memory-region", 0);
+	of_node_put(np);
+	if (!mem_np)
 		return -EINVAL;
 
-	ret = of_address_to_resource(np, 0, &r);
+	ret = of_address_to_resource(mem_np, 0, &r);
+	of_node_put(mem_np);
 	if (ret)
 		return ret;
 
-- 
2.9.5

