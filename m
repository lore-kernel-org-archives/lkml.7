Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4142054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF2Nzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:55:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35093 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfF2Nzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:55:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hhDpG-0006Uw-Gt; Sat, 29 Jun 2019 13:55:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pp: fix a dereference of a pointer before it is null checked
Date:   Sat, 29 Jun 2019 14:55:34 +0100
Message-Id: <20190629135534.15116-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer hwmgr is dereferenced when initializing pointer adev however
it is a little later hwmgr is null checked, implying it could potentially
be null hence the assignment of adev may cause a null pointer dereference.
Fix this by moving the assignment after the null check. Note that I did
think of removing adev as it is only used once, however, hwmgr->adev is
a void * pointer, so using adev avoids some ugly casting so it makes sense
to still use it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 59156faf810e ("drm/amd/pp: Remove the cgs wrapper for notify smu version on APU")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 8189fe402c6d..12815b3830e4 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -722,13 +722,11 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 
 static int smu8_start_smu(struct pp_hwmgr *hwmgr)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
-
+	struct amdgpu_device *adev;
 	uint32_t index = SMN_MP1_SRAM_START_ADDR +
 			 SMU8_FIRMWARE_HEADER_LOCATION +
 			 offsetof(struct SMU8_Firmware_Header, Version);
 
-
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
 
@@ -738,6 +736,7 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)
 		((hwmgr->smu_version >> 16) & 0xFF),
 		((hwmgr->smu_version >> 8) & 0xFF),
 		(hwmgr->smu_version & 0xFF));
+	adev = hwmgr->adev;
 	adev->pm.fw_version = hwmgr->smu_version >> 8;
 
 	return smu8_request_smu_load_fw(hwmgr);
-- 
2.20.1

