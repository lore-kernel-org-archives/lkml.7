Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0695C216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfGHOmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:42:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfGHOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:42:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MWiYo-1hzqv148xk-00X1Le; Mon, 08 Jul 2019 16:42:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Kim <Jonathan.Kim@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Rex Zhu <Rex.Zhu@amd.com>, Emily Deng <Emily.Deng@amd.com>,
        xinhui pan <xinhui.pan@amd.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] amdgpu: make pmu support optional
Date:   Mon,  8 Jul 2019 16:41:43 +0200
Message-Id: <20190708144205.2770771-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TL1q7iyD5PpIZrvVCvrRvHAEqENf6QOhISgByGYYJX9jV/rf/xg
 M406DVe1lGcgSljrSAf61pEusIKkC3qSIQ+fLZSMbU3brdrpcG2nHgEwYkia6rDBUCq2ZdZ
 Ag8tQzIQs5OwrZE2DI7ZuF7dvJosR20rVcUecDsFwHtc/2KjOzZCJ7I9hVY7OkhpKGBqGat
 A1j3Rt2ErvZmbhjIQ4x+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lnFTjrpE41c=:9mQYtLxFcpzQV2qFm/8yIE
 SoJ/ip22hyZDDdbyqQRhP1ar5J85GrRy0ziq8mkxbDL6ImsU+PRvY7t2xMVKx/rwh1XyU94de
 jbLARyZH1ZtsMfRLZkRR5soBdlxdutLlFwwOGzoz4+dTivWjZinLfkdzHHht3wBtlG9UTL9fx
 R+lDMHwCBjULSVCwQA8ok0YBWjywIs9uJDnrcu9k7+7JKXNWqbiTDOFgDiUYOVZ9dy8PjkVnT
 lquSTfbKQOf4desKeysg/LijtPf6zgJgGFAj20D3FUGSKMrEt79X7YbQeYHKALF0S7i7pyMGG
 Azboq2UifUADzZOy/SqwCm5gAZ6OnsSNxDvYvNLB9EXNH2X5TR7rHq47HecfTvRh+02LOBoaA
 Ns6LI8KM7pnmYn2nMCATam+RFzvUbkh5VpOc874UZEvvmJ7mY/y1Yco9ZfZ4K33wIYpYdMU2Z
 M54SC6ZNmKKtY6i6ARl1I1ahJl4jq9NoGiC9uCAN+gQK/QRvDakzR/kK/Xw2rGXOueiT3ME1H
 maqnFEa4jdvcSoU5Ql83Y9R/HCkrRQInX2yjnb3NDPKg7yLdMCZDOuPikOO7+lJzc77BgR9/X
 8FFwGxKCtdu6wMVEFKVnpGq5c9/Ddi152/IFttm742ujmFIRR7sFzDTCUIvIVEaTbP/mHjpIu
 N1BT3MKSASMJiYypWubm5ww5IKJj7yu6E6eoK4NgYLsrXiFoblrf+v2a6ToGTFzvNK/spe5hR
 IN2J/smOH2L/OpQ/5IZ2wa98hRbURz8AeGrGpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PERF_EVENTS is disabled, we cannot compile the pmu
portion of the amdgpu driver:

drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:48:38: error: no member named 'hw' in 'struct perf_event'
        struct hw_perf_event *hwc = &event->hw;
                                     ~~~~~  ^
drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:51:13: error: no member named 'attr' in 'struct perf_event'
        if (event->attr.type != event->pmu->type)
            ~~~~~  ^
...

Use conditional compilation for this file.

Fixes: 9c7c85f7ea1f ("drm/amdgpu: add pmu counters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3a15a46b4ecb..3f5329906fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,9 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o amdgpu_atomfirmware.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
-	amdgpu_vm_sdma.o amdgpu_pmu.o amdgpu_discovery.o
+	amdgpu_vm_sdma.o amdgpu_discovery.o
+
+amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
 # add asic specific block
 amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 30989b455047..a02ccce7bf53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2816,7 +2816,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_pmu_init(adev);
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		r = amdgpu_pmu_init(adev);
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
@@ -2888,7 +2889,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	amdgpu_debugfs_regs_cleanup(adev);
 	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	amdgpu_ucode_sysfs_fini(adev);
-	amdgpu_pmu_fini(adev);
+	if (IS_ENABLED(CONFIG_PERF_EVENTS))
+		amdgpu_pmu_fini(adev);
 	amdgpu_debugfs_preempt_cleanup(adev);
 	if (amdgpu_discovery)
 		amdgpu_discovery_fini(adev);
-- 
2.20.0

