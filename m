Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC921D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfKDNUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:20:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729047AbfKDNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:20:16 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA8CC467E437E7B21A1D;
        Mon,  4 Nov 2019 21:20:14 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 21:20:04 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Jammy.Zhou@amd.com>, <tianci.yin@amd.com>, <sam@ravnborg.org>,
        <luben.tuikov@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 4/7] drm/amdgpu: remove set but not used variable 'dig_connector'
Date:   Mon, 4 Nov 2019 21:27:23 +0800
Message-ID: <1572874046-30996-5-git-send-email-yukuai3@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
References: <1572874046-30996-1-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/atombios_dp.c: In function
‘amdgpu_atombios_dp_get_panel_mode’:
drivers/gpu/drm/amd/amdgpu/atombios_dp.c:364:36: warning: variable
‘dig_connector’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/atombios_dp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
index 6858cde..9426530 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
@@ -361,7 +361,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 			       struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
-	struct amdgpu_connector_atom_dig *dig_connector;
 	int panel_mode = DP_PANEL_MODE_EXTERNAL_DP_MODE;
 	u16 dp_bridge = amdgpu_connector_encoder_get_dp_bridge_encoder_id(connector);
 	u8 tmp;
@@ -369,8 +368,6 @@ int amdgpu_atombios_dp_get_panel_mode(struct drm_encoder *encoder,
 	if (!amdgpu_connector->con_priv)
 		return panel_mode;
 
-	dig_connector = amdgpu_connector->con_priv;
-
 	if (dp_bridge != ENCODER_OBJECT_ID_NONE) {
 		/* DP bridge chips */
 		if (drm_dp_dpcd_readb(&amdgpu_connector->ddc_bus->aux,
-- 
2.7.4

