Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBA9C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B919222C3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfJBMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:02:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M26iv-1iI7En17CD-002Te9; Wed, 02 Oct 2019 14:02:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Luben Tuikov <Luben.Tuikov@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: make pmu support optional, again
Date:   Wed,  2 Oct 2019 14:01:22 +0200
Message-Id: <20191002120136.1777161-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a5b90JQEWWEeBtwVRSZFjdGm9b3I8/kdLc+6ckDpRAohLoCOLNA
 Zt4AJ464Pz/isbP+TP5Kwc89OJD3wbonPMlq/qENKAvYZB1vR8s2mS577y7JdJA+FtGwNAm
 wv5IefPzHdJPWeBjXQg9O5pmwYi/FuswYNw0pL0xXRdmWyFBmcYgbalu8WPFx9G3U3VFOwc
 JV8P3sVH+zYNVEG8X0rNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gCX3Pclsid0=:2lnBRc1wB+VF4RSpdJj4pZ
 fUwT10GYvO0RsxFhbCUbiaYIcMydMqqMM56ICOu4Ar1iEzLA4bLtuE2kjxLk3E61oljDTaPkf
 wXWUN+FYoFQZQWg014b8ji+w/TzQmvBIydjneTRzjw9psnZOH3q5kd80JSSlTOnA5Jt67faFG
 SYCwOoaeaeEtyr/LzIBPSSiHFfWrZbolvAJf+P+OHRNrDttMBmClrSGBtWEHMIDhcCTWZCmH+
 KUwJthhWAqgwIsI8zMc3w6APokxYyO2Kk6mtyu6dbUxL+aI5wbfuFvVdargQIKy18Xl8AXRJQ
 Ar5fBn73URH/PbHM3bXFfH5owy4aqZQH1Wlmo2KX+5RuhkTt39ba/QWvPM/XvPqs2DrU1baxQ
 nb2CwF7ucyLT0T5sXzHUyHVxRXX6BEolSLzfLJVqgvIJJ2oL4l09qlg5XssKdoTaQ1vRXznKo
 F4yZjZir9RbLuE9lmQY0Vtq8aK0/4cjErS/JUIjIkIrKWtXg/TrklmkwdSW6uhZht8QP79+rR
 YiTKNAZNKZgZm67NQjHOA7Q0e11HtM8B/ofPgXvvw7jQ+x/zfD9oZHQ7vqOttg1o+lGBRbzck
 5zjXRHACBqPhJHjHWh5Vt3nfHftZs5meLjT4MX3KhCD0cl0b+/DYY38aaNnE/h9wkkK7tIm2N
 RFcnie4SKAfRNC+zeaTqhxo8Ev5EiDVg5ux1iynqkEof4uorAWjyW4tptFFCCdtP61kGptB8U
 uNvPiWYiK8Aimjr+Yvc8D8lnxzzHqeDhSu5CjfukuG/ZSylarKgsyDwQthMBs/jFRpZLNFlt5
 WJyAJYvPyrCxWFwePNBukYvFe8lg9gXEZagcgcVxUYOK2kUvaVa7GMOKNylTYpmjw6txrjPoa
 BhFwQrKLI3BWRiiXf1UQ==
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

The same bug was already fixed by commit d155bef0636e ("amdgpu: make pmu
support optional") but broken again by what looks like an incorrectly
rebased patch.

Fixes: 64f55e629237 ("drm/amdgpu: Add RAS EEPROM table.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 42e2c1f57152..00962a659009 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -54,7 +54,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o amdgpu_atomfirmware.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
-	amdgpu_vm_sdma.o amdgpu_pmu.o amdgpu_discovery.o amdgpu_ras_eeprom.o smu_v11_0_i2c.o
+	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o smu_v11_0_i2c.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
-- 
2.20.0

