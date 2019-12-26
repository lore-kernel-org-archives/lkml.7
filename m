Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF37C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1263D20740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 12:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLZMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 07:08:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfLZMIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 07:08:36 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 784B49C11E75D703A5D1;
        Thu, 26 Dec 2019 20:08:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Dec 2019
 20:08:24 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] drm/radeon: remove three set but not used variable
Date:   Thu, 26 Dec 2019 20:07:50 +0800
Message-ID: <20191226120750.15106-1-yukuai3@huawei.com>
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

drivers/gpu/drm/radeon/radeon_atombios.c: In function
‘radeon_get_atom_connector_info_from_object_table’:
drivers/gpu/drm/radeon/radeon_atombios.c:651:26: warning: variable
‘grph_obj_num’ set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_atombios.c:651:13: warning: variable
‘grph_obj_id’ set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/radeon_atombios.c:573:37: warning: variable
‘con_obj_type’ set but not used [-Wunused-but-set-variable]

They are never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 072e6daedf7a..848ef68d9086 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -570,7 +570,7 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 		path_size += le16_to_cpu(path->usSize);
 
 		if (device_support & le16_to_cpu(path->usDeviceTag)) {
-			uint8_t con_obj_id, con_obj_num, con_obj_type;
+			uint8_t con_obj_id, con_obj_num;
 
 			con_obj_id =
 			    (le16_to_cpu(path->usConnObjectId) & OBJECT_ID_MASK)
@@ -578,9 +578,6 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 			con_obj_num =
 			    (le16_to_cpu(path->usConnObjectId) & ENUM_ID_MASK)
 			    >> ENUM_ID_SHIFT;
-			con_obj_type =
-			    (le16_to_cpu(path->usConnObjectId) &
-			     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 
 			/* TODO CV support */
 			if (le16_to_cpu(path->usDeviceTag) ==
@@ -648,15 +645,7 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 			router.ddc_valid = false;
 			router.cd_valid = false;
 			for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
-				uint8_t grph_obj_id, grph_obj_num, grph_obj_type;
-
-				grph_obj_id =
-				    (le16_to_cpu(path->usGraphicObjIds[j]) &
-				     OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
-				grph_obj_num =
-				    (le16_to_cpu(path->usGraphicObjIds[j]) &
-				     ENUM_ID_MASK) >> ENUM_ID_SHIFT;
-				grph_obj_type =
+				uint8_t grph_obj_type =
 				    (le16_to_cpu(path->usGraphicObjIds[j]) &
 				     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 
-- 
2.17.2

