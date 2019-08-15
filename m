Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974102064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 05:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbfHOFLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:11:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33112 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbfHOFLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:11:35 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hy82j-0008U4-GS; Thu, 15 Aug 2019 05:11:22 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com
Cc:     ray.huang@amd.com, anthony.wong@canonical.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/amdgpu: Apply flags after amdgpu_device_ip_init()
Date:   Thu, 15 Aug 2019 13:11:17 +0800
Message-Id: <20190815051117.24003-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven
series (v2)"), some Raven Ridge systems start to have rendering
corruption in browser [1].

Chip specific flags like cg_flags and pg_flags are applied in
amdgpu_device_ip_early_init(). For Raven Ridge, the flags may depend on
pp_feature's PP_GFXOFF_MASK bit, which can be negated in
amdgpu_device_ip_init() based on firmware information. At that time it's
already too late, since cg_flags and pg_flags are already set.

Apply flags after amdgpu_device_ip_init() and consolidate all flags to
one place, to solve the issue.

[1] https://lore.kernel.org/lkml/3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com/

Fixes: 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series (v2)")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 589 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/cik.c           |  87 ---
 drivers/gpu/drm/amd/amdgpu/nv.c            |  50 --
 drivers/gpu/drm/amd/amdgpu/si.c            |  83 ---
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 140 -----
 drivers/gpu/drm/amd/amdgpu/vi.c            | 162 ------
 6 files changed, 589 insertions(+), 522 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 275277364a8a..10ea4899c338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1852,6 +1852,591 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	return r;
 }
 
+#define CZ_REV_BRISTOL(rev)	 \
+	((rev >= 0xC8 && rev <= 0xCE) || (rev >= 0xE1 && rev <= 0xE6))
+
+static int amdgpu_device_apply_flags(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_TAHITI:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_PITCAIRN:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_VERDE:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		//???
+		break;
+	case CHIP_OLAND:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_HAINAN:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_BONAIRE:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_HAWAII:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_KAVERI:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags =
+			/*AMD_PG_SUPPORT_GFX_PG |
+			  AMD_PG_SUPPORT_GFX_SMG |
+			  AMD_PG_SUPPORT_GFX_DMG |*/
+			AMD_PG_SUPPORT_UVD |
+			AMD_PG_SUPPORT_VCE |
+			/*  AMD_PG_SUPPORT_CP |
+			  AMD_PG_SUPPORT_GDS |
+			  AMD_PG_SUPPORT_RLC_SMU_HS |
+			  AMD_PG_SUPPORT_ACP |
+			  AMD_PG_SUPPORT_SAMU |*/
+			0;
+		break;
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			/*AMD_CG_SUPPORT_GFX_CGCG |*/
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG;
+		adev->pg_flags =
+			/*AMD_PG_SUPPORT_GFX_PG |
+			  AMD_PG_SUPPORT_GFX_SMG | */
+			AMD_PG_SUPPORT_UVD |
+			/*AMD_PG_SUPPORT_VCE |
+			  AMD_PG_SUPPORT_CP |
+			  AMD_PG_SUPPORT_GDS |
+			  AMD_PG_SUPPORT_RLC_SMU_HS |
+			  AMD_PG_SUPPORT_SAMU |*/
+			0;
+		break;
+	case CHIP_TOPAZ:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_FIJI:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_UVD_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_TONGA:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_UVD_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_POLARIS11:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_POLARIS10:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_POLARIS12:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_VEGAM:
+		adev->cg_flags = 0;
+			/*AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG;*/
+		adev->pg_flags = 0;
+		break;
+	case CHIP_CARRIZO:
+		adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_VCE_MGCG;
+		/* rev0 hardware requires workarounds to support PG */
+		adev->pg_flags = 0;
+		if (adev->rev_id != 0x00 || CZ_REV_BRISTOL(adev->pdev->revision)) {
+			adev->pg_flags |= AMD_PG_SUPPORT_GFX_SMG |
+				AMD_PG_SUPPORT_GFX_PIPELINE |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_UVD |
+				AMD_PG_SUPPORT_VCE;
+		}
+		break;
+	case CHIP_STONEY:
+		adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_CGTS |
+			AMD_CG_SUPPORT_GFX_CGTS_LS |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_VCE_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_GFX_SMG |
+			AMD_PG_SUPPORT_GFX_PIPELINE |
+			AMD_PG_SUPPORT_CP |
+			AMD_PG_SUPPORT_UVD |
+			AMD_PG_SUPPORT_VCE;
+		break;
+	case CHIP_VEGA10:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_DRM_MGCG |
+			AMD_CG_SUPPORT_DRM_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_DF_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_VEGA12:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_VEGA20:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_ROM_MGCG |
+			AMD_CG_SUPPORT_VCE_MGCG |
+			AMD_CG_SUPPORT_UVD_MGCG;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_RAVEN:
+		if (adev->rev_id >= 0x8) {
+			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+				AMD_CG_SUPPORT_GFX_MGLS |
+				AMD_CG_SUPPORT_GFX_CP_LS |
+				AMD_CG_SUPPORT_GFX_3D_CGCG |
+				AMD_CG_SUPPORT_GFX_3D_CGLS |
+				AMD_CG_SUPPORT_GFX_CGCG |
+				AMD_CG_SUPPORT_GFX_CGLS |
+				AMD_CG_SUPPORT_BIF_LS |
+				AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_ROM_MGCG |
+				AMD_CG_SUPPORT_MC_MGCG |
+				AMD_CG_SUPPORT_MC_LS |
+				AMD_CG_SUPPORT_SDMA_MGCG |
+				AMD_CG_SUPPORT_SDMA_LS |
+				AMD_CG_SUPPORT_VCN_MGCG;
+
+			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
+		} else if (adev->pdev->device == 0x15d8) {
+			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+				AMD_CG_SUPPORT_GFX_MGLS |
+				AMD_CG_SUPPORT_GFX_CP_LS |
+				AMD_CG_SUPPORT_GFX_3D_CGCG |
+				AMD_CG_SUPPORT_GFX_3D_CGLS |
+				AMD_CG_SUPPORT_GFX_CGCG |
+				AMD_CG_SUPPORT_GFX_CGLS |
+				AMD_CG_SUPPORT_BIF_LS |
+				AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_ROM_MGCG |
+				AMD_CG_SUPPORT_MC_MGCG |
+				AMD_CG_SUPPORT_MC_LS |
+				AMD_CG_SUPPORT_SDMA_MGCG |
+				AMD_CG_SUPPORT_SDMA_LS;
+
+			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
+				AMD_PG_SUPPORT_MMHUB |
+				AMD_PG_SUPPORT_VCN |
+				AMD_PG_SUPPORT_VCN_DPG;
+		} else {
+			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+				AMD_CG_SUPPORT_GFX_MGLS |
+				AMD_CG_SUPPORT_GFX_RLC_LS |
+				AMD_CG_SUPPORT_GFX_CP_LS |
+				AMD_CG_SUPPORT_GFX_3D_CGCG |
+				AMD_CG_SUPPORT_GFX_3D_CGLS |
+				AMD_CG_SUPPORT_GFX_CGCG |
+				AMD_CG_SUPPORT_GFX_CGLS |
+				AMD_CG_SUPPORT_BIF_MGCG |
+				AMD_CG_SUPPORT_BIF_LS |
+				AMD_CG_SUPPORT_HDP_MGCG |
+				AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_DRM_MGCG |
+				AMD_CG_SUPPORT_DRM_LS |
+				AMD_CG_SUPPORT_ROM_MGCG |
+				AMD_CG_SUPPORT_MC_MGCG |
+				AMD_CG_SUPPORT_MC_LS |
+				AMD_CG_SUPPORT_SDMA_MGCG |
+				AMD_CG_SUPPORT_SDMA_LS |
+				AMD_CG_SUPPORT_VCN_MGCG;
+
+			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
+		}
+
+		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
+			adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
+				AMD_PG_SUPPORT_CP |
+				AMD_PG_SUPPORT_RLC_SMU_HS;
+		break;
+	case CHIP_ARCTURUS:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_RENOIR:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		break;
+	case CHIP_NAVI10:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_MMHUB |
+			AMD_PG_SUPPORT_ATHUB;
+		break;
+	case CHIP_NAVI14:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG;
+		break;
+	case CHIP_NAVI12:
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_SDMA_MGCG |
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_VCN_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
+		break;
+	default:
+		/* FIXME: not supported yet */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_fill_reset_magic - writes reset magic to gart pointer
  *
@@ -2827,6 +3412,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
+	r = amdgpu_device_apply_flags(adev);
+	if (r)
+		goto failed;
+
 	adev->accel_working = true;
 
 	amdgpu_vm_check_compute_bug(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 7b63d7a8298a..01e2211e251d 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1862,74 +1862,12 @@ static int cik_common_early_init(void *handle)
 	adev->external_rev_id = 0xFF;
 	switch (adev->asic_type) {
 	case CHIP_BONAIRE:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x14;
 		break;
 	case CHIP_HAWAII:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = 0x28;
 		break;
 	case CHIP_KAVERI:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags =
-			/*AMD_PG_SUPPORT_GFX_PG |
-			  AMD_PG_SUPPORT_GFX_SMG |
-			  AMD_PG_SUPPORT_GFX_DMG |*/
-			AMD_PG_SUPPORT_UVD |
-			AMD_PG_SUPPORT_VCE |
-			/*  AMD_PG_SUPPORT_CP |
-			  AMD_PG_SUPPORT_GDS |
-			  AMD_PG_SUPPORT_RLC_SMU_HS |
-			  AMD_PG_SUPPORT_ACP |
-			  AMD_PG_SUPPORT_SAMU |*/
-			0;
 		if (adev->pdev->device == 0x1312 ||
 			adev->pdev->device == 0x1316 ||
 			adev->pdev->device == 0x1317)
@@ -1939,31 +1877,6 @@ static int cik_common_early_init(void *handle)
 		break;
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags =
-			/*AMD_PG_SUPPORT_GFX_PG |
-			  AMD_PG_SUPPORT_GFX_SMG | */
-			AMD_PG_SUPPORT_UVD |
-			/*AMD_PG_SUPPORT_VCE |
-			  AMD_PG_SUPPORT_CP |
-			  AMD_PG_SUPPORT_GDS |
-			  AMD_PG_SUPPORT_RLC_SMU_HS |
-			  AMD_PG_SUPPORT_SAMU |*/
-			0;
 		if (adev->asic_type == CHIP_KABINI) {
 			if (adev->rev_id == 0)
 				adev->external_rev_id = 0x81;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d4a2012b4832..30d100dc7b29 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -600,62 +600,12 @@ static int nv_common_early_init(void *handle)
 	adev->external_rev_id = 0xff;
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_IH_CG |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_MMHUB |
-			AMD_PG_SUPPORT_ATHUB;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	case CHIP_NAVI14:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_IH_CG |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN |
-			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 20;
 		break;
 	case CHIP_NAVI12:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_IH_CG |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_VCN_MGCG;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0xa;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 904361451650..22ba2d7e797f 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1442,104 +1442,21 @@ static int si_common_early_init(void *handle)
 	adev->external_rev_id = 0xFF;
 	switch (adev->asic_type) {
 	case CHIP_TAHITI:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = (adev->rev_id == 0) ? 1 :
 					(adev->rev_id == 1) ? 5 : 6;
 		break;
 	case CHIP_PITCAIRN:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 20;
 		break;
-
 	case CHIP_VERDE:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
-		//???
 		adev->external_rev_id = adev->rev_id + 40;
 		break;
 	case CHIP_OLAND:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = 60;
 		break;
 	case CHIP_HAINAN:
-		adev->cg_flags =
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			/*AMD_CG_SUPPORT_GFX_CGCG |*/
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = 70;
 		break;
-
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c2d324d8da75..f2849fc463b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -983,72 +983,14 @@ static int soc15_common_early_init(void *handle)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 		adev->asic_funcs = &soc15_asic_funcs;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_DRM_MGCG |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_DF_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
-		adev->pg_flags = 0;
 		adev->external_rev_id = 0x1;
 		break;
 	case CHIP_VEGA12:
 		adev->asic_funcs = &soc15_asic_funcs;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x14;
 		break;
 	case CHIP_VEGA20:
 		adev->asic_funcs = &vega20_asic_funcs;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG |
-			AMD_CG_SUPPORT_UVD_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x28;
 		break;
 	case CHIP_RAVEN:
@@ -1061,95 +1003,13 @@ static int soc15_common_early_init(void *handle)
 			adev->external_rev_id = adev->rev_id + 0x20;
 		else
 			adev->external_rev_id = adev->rev_id + 0x01;
-
-		if (adev->rev_id >= 0x8) {
-			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-				AMD_CG_SUPPORT_GFX_MGLS |
-				AMD_CG_SUPPORT_GFX_CP_LS |
-				AMD_CG_SUPPORT_GFX_3D_CGCG |
-				AMD_CG_SUPPORT_GFX_3D_CGLS |
-				AMD_CG_SUPPORT_GFX_CGCG |
-				AMD_CG_SUPPORT_GFX_CGLS |
-				AMD_CG_SUPPORT_BIF_LS |
-				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
-				AMD_CG_SUPPORT_MC_MGCG |
-				AMD_CG_SUPPORT_MC_LS |
-				AMD_CG_SUPPORT_SDMA_MGCG |
-				AMD_CG_SUPPORT_SDMA_LS |
-				AMD_CG_SUPPORT_VCN_MGCG;
-
-			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
-		} else if (adev->pdev->device == 0x15d8) {
-			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-				AMD_CG_SUPPORT_GFX_MGLS |
-				AMD_CG_SUPPORT_GFX_CP_LS |
-				AMD_CG_SUPPORT_GFX_3D_CGCG |
-				AMD_CG_SUPPORT_GFX_3D_CGLS |
-				AMD_CG_SUPPORT_GFX_CGCG |
-				AMD_CG_SUPPORT_GFX_CGLS |
-				AMD_CG_SUPPORT_BIF_LS |
-				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
-				AMD_CG_SUPPORT_MC_MGCG |
-				AMD_CG_SUPPORT_MC_LS |
-				AMD_CG_SUPPORT_SDMA_MGCG |
-				AMD_CG_SUPPORT_SDMA_LS;
-
-			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				AMD_PG_SUPPORT_MMHUB |
-				AMD_PG_SUPPORT_VCN |
-				AMD_PG_SUPPORT_VCN_DPG;
-		} else {
-			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-				AMD_CG_SUPPORT_GFX_MGLS |
-				AMD_CG_SUPPORT_GFX_RLC_LS |
-				AMD_CG_SUPPORT_GFX_CP_LS |
-				AMD_CG_SUPPORT_GFX_3D_CGCG |
-				AMD_CG_SUPPORT_GFX_3D_CGLS |
-				AMD_CG_SUPPORT_GFX_CGCG |
-				AMD_CG_SUPPORT_GFX_CGLS |
-				AMD_CG_SUPPORT_BIF_MGCG |
-				AMD_CG_SUPPORT_BIF_LS |
-				AMD_CG_SUPPORT_HDP_MGCG |
-				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_DRM_MGCG |
-				AMD_CG_SUPPORT_DRM_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
-				AMD_CG_SUPPORT_MC_MGCG |
-				AMD_CG_SUPPORT_MC_LS |
-				AMD_CG_SUPPORT_SDMA_MGCG |
-				AMD_CG_SUPPORT_SDMA_LS |
-				AMD_CG_SUPPORT_VCN_MGCG;
-
-			adev->pg_flags = AMD_PG_SUPPORT_SDMA | AMD_PG_SUPPORT_VCN;
-		}
-
-		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
-			adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
-				AMD_PG_SUPPORT_CP |
-				AMD_PG_SUPPORT_RLC_SMU_HS;
 		break;
 	case CHIP_ARCTURUS:
 		adev->asic_funcs = &vega20_asic_funcs;
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 	case CHIP_RENOIR:
 		adev->asic_funcs = &soc15_asic_funcs;
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x91;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 56c882b3ea3c..6a94c72e86f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1042,9 +1042,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 };
 
-#define CZ_REV_BRISTOL(rev)	 \
-	((rev >= 0xC8 && rev <= 0xCE) || (rev >= 0xE1 && rev <= 0xE6))
-
 static int vi_common_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1071,189 +1068,30 @@ static int vi_common_early_init(void *handle)
 	adev->external_rev_id = 0xFF;
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
-		adev->cg_flags = 0;
-		adev->pg_flags = 0;
 		adev->external_rev_id = 0x1;
 		break;
 	case CHIP_FIJI:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_UVD_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	case CHIP_TONGA:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_UVD_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x14;
 		break;
 	case CHIP_POLARIS11:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x5A;
 		break;
 	case CHIP_POLARIS10:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	case CHIP_POLARIS12:
-		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG;
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x64;
 		break;
 	case CHIP_VEGAM:
-		adev->cg_flags = 0;
-			/*AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_GFX_3D_CGCG |
-			AMD_CG_SUPPORT_GFX_3D_CGLS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_BIF_MGCG |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_ROM_MGCG |
-			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_DRM_LS |
-			AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_VCE_MGCG;*/
-		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x6E;
 		break;
 	case CHIP_CARRIZO:
-		adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_VCE_MGCG;
-		/* rev0 hardware requires workarounds to support PG */
-		adev->pg_flags = 0;
-		if (adev->rev_id != 0x00 || CZ_REV_BRISTOL(adev->pdev->revision)) {
-			adev->pg_flags |= AMD_PG_SUPPORT_GFX_SMG |
-				AMD_PG_SUPPORT_GFX_PIPELINE |
-				AMD_PG_SUPPORT_CP |
-				AMD_PG_SUPPORT_UVD |
-				AMD_PG_SUPPORT_VCE;
-		}
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
 	case CHIP_STONEY:
-		adev->cg_flags = AMD_CG_SUPPORT_UVD_MGCG |
-			AMD_CG_SUPPORT_GFX_MGCG |
-			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_RLC_LS |
-			AMD_CG_SUPPORT_GFX_CP_LS |
-			AMD_CG_SUPPORT_GFX_CGTS |
-			AMD_CG_SUPPORT_GFX_CGTS_LS |
-			AMD_CG_SUPPORT_GFX_CGLS |
-			AMD_CG_SUPPORT_BIF_LS |
-			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS |
-			AMD_CG_SUPPORT_SDMA_MGCG |
-			AMD_CG_SUPPORT_SDMA_LS |
-			AMD_CG_SUPPORT_VCE_MGCG;
-		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
-			AMD_PG_SUPPORT_GFX_SMG |
-			AMD_PG_SUPPORT_GFX_PIPELINE |
-			AMD_PG_SUPPORT_CP |
-			AMD_PG_SUPPORT_UVD |
-			AMD_PG_SUPPORT_VCE;
 		adev->external_rev_id = adev->rev_id + 0x61;
 		break;
 	default:
-- 
2.17.1

