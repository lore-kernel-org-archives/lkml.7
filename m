Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B660BC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984CB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfFQMuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:50:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:50:12 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkpvV-1iL0zK3xWR-00mM5r; Mon, 17 Jun 2019 14:50:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/komeda: fix size_t format string
Date:   Mon, 17 Jun 2019 14:49:18 +0200
Message-Id: <20190617125002.1312331-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2IhlH3w9aK7OqAObh0m0vtxUjmwrTi/dYeLzaTbn3KHAugqPA8o
 upoUdMJZ1b6d3NEfaBcd6MZbAuwFtdZ71C++Eh5q12WN8vmMJUEXW6JIe/JpUrIXf++qqi6
 v1bKA5Cxe/HV/9AQpRk7pZqnXeHebYbE+h+L9C19RjPK6emuttIEXdLD+XEnlU7+WS+0MgC
 JtVOPXXnWtvXeN4BfSoVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VaDA1yhVmLA=:g4ishUQg/9y48nkuWTTim9
 CKe+CRr3qNuWCTs0dQomBqhLY9wanMMx5GUPzQq/qae5a6nMVHLumwch9AQ4eV6P2eZ5yANSA
 AuMlEvAKfNJLPVUsyjS3/443uWo0JkXdurg/34XxbCoHvoc5084nNBfdkLmz90Vb6nE7jgAQ9
 cfBn/XmeCS7q3+ST5mO2Lyh6A1Gxdue/hBkHTTL3H0M6KCO2BxJaoG3qwQgjYsiDf3cRknPxY
 9hLgpyL53cbs+ldZUEP6lymD07kZCVNI+w7xWF753jJSUQLXwroprvfCc6EMvJVojnubkq8HL
 BhIjYQnt+ywvFdCwFHU5Y9oZsTPgg3B1IIni+yMFISgPiNHtJPPTdwUsQjxppj+yBeSpSLucn
 SiC7i0Cz+ndzKyjx3bj0WApMANOxp/6dMT0zHcBPhg444ckNXlkHAOFyvTjgVf3JEq3tpY1o2
 6GBjoHmn+IL0j7aZrWYCrDj8LNu1UF5ixzs5jRBAtT1e1d+0mShEWAARFLu6Fito4FtuhHnar
 ScDPkGc3lTHHYy15d+0O5cDDTxX9G7JUJrm1cYIpLb9xU6+oTP4LEDaO2ahBwWg66GN0WsDcT
 sv96/vaORqZhWelqjQa3aHNVzciKGx7yAl5yhwQk9MBd4INeLcG2cNAAd8OoEd8Cvj++UCU97
 3nbXlu/0dkNkZ1RyZ06V4WNIXgOEbXFbfzjz1bCQXNWFKOvEF2PAyV0F33LuCKAKXXNpdW6Hg
 rMJ5lt8Hdptk0L+1RRuMHvWSbKcyTi7BTLMBeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debug output uses the wrong format string for printing a size_t:

In file included from include/drm/drm_mm.h:49,
                 from include/drm/drm_vma_manager.h:26,
                 from include/drm/drm_gem.h:40,
                 from drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:9:
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c: In function 'komeda_fb_afbc_size_check':
drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:96:17: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",

This is harmless in the kernel as size_t and long are always the same
width, but it's always better to use the correct format string
to shut up the warning.

Fixes: 9ccf536e53cb ("drm/komeda: Added AFBC support for komeda driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
index abc8c0ccc053..58ff34e718d0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
@@ -93,7 +93,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
 			       AFBC_SUPERBLK_ALIGNMENT);
 	min_size = kfb->afbc_size + fb->offsets[0];
 	if (min_size > obj->size) {
-		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
+		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%zx. min_size 0x%x.\n",
 			      obj->size, min_size);
 		goto check_failed;
 	}
@@ -137,7 +137,7 @@ komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
 		min_size = komeda_fb_get_pixel_addr(kfb, 0, fb->height, i)
 			 - to_drm_gem_cma_obj(obj)->paddr;
 		if (obj->size < min_size) {
-			DRM_DEBUG_KMS("The fb->obj[%d] size: %ld lower than the minimum requirement: %d.\n",
+			DRM_DEBUG_KMS("The fb->obj[%d] size: %zd lower than the minimum requirement: %d.\n",
 				      i, obj->size, min_size);
 			return -EINVAL;
 		}
-- 
2.20.0

