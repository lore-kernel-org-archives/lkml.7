Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E16C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BD6218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfGDOXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:23:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44345 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfGDOXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:23:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hj2e1-0004gL-NU; Thu, 04 Jul 2019 14:23:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu/psp: fix incorrect logic when checking asic_type
Date:   Thu,  4 Jul 2019 15:23:29 +0100
Message-Id: <20190704142329.22983-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check of the asic_type is always returning true because
of the use of ||.  Fix this by using && instead.  Also break overly
wide line.

Addresses-Coverity: ("Constant expression result")
Fixes: dab70ff24db6 ("drm/amdgpu/psp: add psp support for navi14")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 527dc371598d..e4afd34e3034 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -540,7 +540,8 @@ psp_v11_0_sram_map(struct amdgpu_device *adev,
 
 	case AMDGPU_UCODE_ID_RLC_G:
 		*sram_offset = 0x2000;
-		if (adev->asic_type != CHIP_NAVI10 || adev->asic_type != CHIP_NAVI14) {
+		if (adev->asic_type != CHIP_NAVI10 &&
+		    adev->asic_type != CHIP_NAVI14) {
 			*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
 			*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
 		} else {
@@ -551,7 +552,8 @@ psp_v11_0_sram_map(struct amdgpu_device *adev,
 
 	case AMDGPU_UCODE_ID_SDMA0:
 		*sram_offset = 0x0;
-		if (adev->asic_type != CHIP_NAVI10 || adev->asic_type != CHIP_NAVI14) {
+		if (adev->asic_type != CHIP_NAVI10 &&
+		    adev->asic_type != CHIP_NAVI14) {
 			*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
 			*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
 		} else {
-- 
2.20.1

