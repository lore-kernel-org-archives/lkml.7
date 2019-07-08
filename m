Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD6C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751B2216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfGHOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:42:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfGHOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:42:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLz3X-1i1kiV3kq9-00HvJD; Mon, 08 Jul 2019 16:42:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Amber Lin <Amber.Lin@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Shaoyun Liu <Shaoyun.Liu@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
        Yong Zhao <Yong.Zhao@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>, Emily Deng <Emily.Deng@amd.com>,
        xinhui pan <xinhui.pan@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] amdgpu: make SOC15/navi support conditional
Date:   Mon,  8 Jul 2019 16:41:44 +0200
Message-Id: <20190708144205.2770771-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190708144205.2770771-1-arnd@arndb.de>
References: <20190708144205.2770771-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/qqa7xAUEYcyvnYV1MGx8PARrNuy+ZJAsk4UGuBiFcxWXLI+pc2
 Ha+zmE2ZtaxCj70hCUcR8y1t3xac09TTPTReN4vPu5hurpTGSWfaYsyw8YrAOdkesYhpv4T
 CzrtsVY/egDEoJaz8Z8/v0j9lvrIfq1PHf39yQeL5KRj8+K7ayKCG7YlcWbMqulFYUousQx
 2HxZwCJjhkthSEC6y/Q7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p9TalNiSPJQ=:JBe2OadY2KhV1ciUCC9+mL
 Kij/NSnJxMJVvJ8KWSD0Zh0IwQmw/RpUoCPgZPKVoNW9Ze6sxXEY8tWd7uh9OrpcCErP5KbEr
 5EGLySNZ+3WvLY9sVNQKWUcxNgZUGJmKjudOcfwjP8LzWa7CF6X1WsT7gyi3udC73fgG5ki5R
 Xdz46PzGykNMXP5hNFnca08mUD0IERRKdQLe5xUjAbeehuHfJxwUc61KC4eOh+t4GXaliye+N
 BzbHg4IlPuMpCKMhhos+O9VCa/3WnCfQo0HHygHdm0TOxYPqSTM1oxgogleO0ikXU/PUMON0X
 jj2RaDmIwt5H9qZUXzBVuVCNjDTM/7ycVqyWgSarBkvbG9kukFKm8eA+1Jg9arMLfSW791/uU
 E/IBdZYKNGsPoPo1hk+13mlXrVD7WmsHdQUkKzaz2Xf9XTOlCD23pbLkYgRLEaEO/PtMjGn7m
 NxqV+P2QpFqNhJXke0H7OWzaJfgYMKlWxPvCcRwchZRFmpZY4ylFeEt7jPZzFNa1+b50pctef
 vIsOi+Un1nQVVGyFCANfQKG29oCUaVsl9KgdCqG5GqJO30szQ3B9aFZJcs72kdO1p2xHVFV4C
 GfdfIxJY1LQSs+lZ+3PmB9KfqgmzRoRosaFIwRY7Qw0Z6jUtn1aX5JPWhFAm8nQWsjhc1MOq1
 gw4fLrQuvZccmg08i/BzU7Nml/7GQPF1vYRHWlPcl9ILRl+w4VXLiu7LpjgVCni8zCy7A7f2B
 viJCn0j4RPcjFxrs5rGUrwnsrchAyM+MQ/N8oA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling amdgpu but not CONFIG_DRM_AMD_DC leads to a warning:

drivers/gpu/drm/amd/amdgpu/nv.c: In function 'nv_set_ip_blocks':
drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on navi." [-Werror=cpp]
 # warning "Enable CONFIG_DRM_AMD_DC for display support on navi."
   ^~~~~~~
drivers/gpu/drm/amd/amdgpu/soc15.c: In function 'soc15_set_ip_blocks':
drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: #warning "Enable CONFIG_DRM_AMD_DC for display support on SOC15." [-Werror=cpp]

However, CONFIG_DRM_AMD_DC can only be enabled on x86, so we
cannot do that when building for other architectures.

Add another Kconfig symbol to handle the SOC15 and navi, making
sure that we implicitly enable DC.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig         |  7 +++++
 drivers/gpu/drm/amd/amdgpu/Makefile        | 32 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index a04f2fc7bf37..d7186dd88dbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -24,6 +24,13 @@ config DRM_AMDGPU_CIK
 
 	  radeon.cik_support=0 amdgpu.cik_support=1
 
+config DRM_AMDGPU_SOC15
+	bool "Enable amdgpu support for SOC15 parts"
+	depends on DRM_AMDGPU
+	select DRM_AMD_DC
+	help
+	  Choose this option if you want to enable support for SOC15 asics.
+
 config DRM_AMDGPU_USERPTR
 	bool "Always enable userptr write support"
 	depends on DRM_AMDGPU
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3f5329906fce..e95ae468eaa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -64,9 +64,10 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
 
 amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o si_dpm.o si_smc.o
 
-amdgpu-y += \
-	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
-	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o
+amdgpu-y += vi.o mxgpu_vi.o emu_soc.o nbio_v7_4.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += gmc_v9_0.o nbio_v6_1.o soc15.o mxgpu_ai.o nbio_v7_0.o \
+	vega10_reg_init.o vega20_reg_init.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o
 
 # add DF block
 amdgpu-y += \
@@ -77,7 +78,10 @@ amdgpu-y += \
 amdgpu-y += \
 	gmc_v7_0.o \
 	gmc_v8_0.o \
-	gfxhub_v1_0.o mmhub_v1_0.o gmc_v9_0.o gfxhub_v1_1.o \
+	gfxhub_v1_0.o mmhub_v1_0.o gfxhub_v1_1.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
+	gmc_v9_0.o \
 	gfxhub_v2_0.o mmhub_v2_0.o gmc_v10_0.o
 
 # add IH block
@@ -86,7 +90,9 @@ amdgpu-y += \
 	amdgpu_ih.o \
 	iceland_ih.o \
 	tonga_ih.o \
-	cz_ih.o \
+	cz_ih.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
 	vega10_ih.o \
 	navi10_ih.o
 
@@ -111,7 +117,9 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_gfx.o \
 	amdgpu_rlc.o \
-	gfx_v8_0.o \
+	gfx_v8_0.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
 	gfx_v9_0.o \
 	gfx_v10_0.o
 
@@ -119,12 +127,14 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_sdma.o \
 	sdma_v2_4.o \
-	sdma_v3_0.o \
+	sdma_v3_0.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
 	sdma_v4_0.o \
 	sdma_v5_0.o
 
 # add MES block
-amdgpu-y += \
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
 	mes_v10_1.o
 
 # add UVD block
@@ -161,8 +171,10 @@ amdgpu-y += \
 	 amdgpu_amdkfd_fence.o \
 	 amdgpu_amdkfd_gpuvm.o \
 	 amdgpu_amdkfd_gfx_v8.o \
-	 amdgpu_amdkfd_gfx_v9.o \
-	 amdgpu_amdkfd_gfx_v10.o
+
+amdgpu-$(CONFIG_DRM_AMDGPU_SOC15) += \
+	amdgpu_amdkfd_gfx_v9.o \
+	amdgpu_amdkfd_gfx_v10.o
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y += amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 9fa4f25a3745..101d806ff996 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -81,6 +81,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 	case CHIP_VEGAM:
 		kfd2kgd = amdgpu_amdkfd_gfx_8_0_get_functions();
 		break;
+#ifdef CONFIG_DRM_AMDGPU_SOC15
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
@@ -90,6 +91,7 @@ void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 		kfd2kgd = amdgpu_amdkfd_gfx_10_0_get_functions();
 		break;
+#endif
 	default:
 		dev_info(adev->dev, "kfd not supported on this ASIC\n");
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a02ccce7bf53..2a6447febcb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1530,6 +1530,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			return r;
 		break;
 #endif
+#ifdef CONFIG_DRM_AMDGPU_SOC15
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
@@ -1551,6 +1552,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
+#endif
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.20.0

