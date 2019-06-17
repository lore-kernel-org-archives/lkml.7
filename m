Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C560C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF172086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfFQMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:52:29 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:52:29 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGQax-1hquxU2lVF-00GtQn; Mon, 17 Jun 2019 14:52:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Kim <jonathan.kim@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix error handling in df_v3_6_pmc_start
Date:   Mon, 17 Jun 2019 14:51:45 +0200
Message-Id: <20190617125216.1439481-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4mjJ8DAUrqD7K3ik9JFh1A+imhzojGmM2U9nkMvmJroglwtNgbR
 uxEfBJoTHVzu13ZhwrwgrM6e38j8pBnDFOSIiI6NVnDb1AKXjj0XsHb5SZ/o7weXZmpJGRK
 b4RW1+baqU8jtxvfNE0f+7TvDXfTL6sFCl743HK4GE7P7xPMc6wEvBvoJ20HXf3fpOmJcaw
 UGpQSQaK/Das93ZAx0ETg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+5vhAAztk0=:EqgY/a1W3We1mNJ7HsNbw7
 ObwMB7mvH6RsXLFuDzawvG5JZi5AuU8NuAGK3Rmil62H4EsECaCGif/ICTp8MJYRqw03PMyAX
 eKWNsYhlxh7HfrVJV4cClKv6IVzcA/0iE2mo+JgJjgq9ZOjgV9MK9gTePjqAYCO9YR1nZAnSE
 PGi8y+fXyWCenl9YdNfXOVgxTHAbXFdzO+gWUCPm3QH3BBbRNFQleu/WSG7CNluU9KCx7ibZB
 flECQ/y2I8ioCuuHYPfDQ63nxmfhGvvAekoKwr/6+olGsovn5UMZ0ijWaDBvU3eZxLpSrZTIf
 6N7mXV0y0Qm5vF8ACYmtrpJMyhzT5AyvAdYUucZXieLw9rnQn+vADSFx885qw+FN6AJ4mkV5e
 yGbjugRKQlXtmwUbMbvsHTmSv6bzzMlGL0ty9HKbDONkK4x847fJJm4O7lP/N1JhR7Ct0453C
 5+5rRtXF3qIHvKAxuWrVQ7A77PrvPnz0VG6It8yrffditgUtIx+/If124thp1KV3eZwr9ditm
 JmPnIZRkdpvbeiKKdMbkTeAHc96tYpoxsiqlSh446keWSRoLzxQPsIBRALFOq4C23Un/5xJTV
 3LpsuwiXZ9DHGPF2WOV1DKudFv0onLyeGNBzKXdBAq0w5V8JBH9waUT/uB87VyfduhPTcq66E
 EQNimNTjDgI2cNVqUEPzY3xCrU1jDIYf5o/wSgFysfFX66C+dYhcmTYi5QnQzcOSAIrKt8T0F
 AKbeOt4MzlIvqi+oTmuAa1BkeKAwpYTo3CgRlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When df_v3_6_pmc_get_ctrl_settings() fails for some reason, we
store uninitialized data in a register, as gcc points out:

drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function 'df_v3_6_pmc_start':
drivers/gpu/drm/amd/amdgpu/amdgpu.h:1012:29: error: 'lo_val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
                             ^~~~
drivers/gpu/drm/amd/amdgpu/df_v3_6.c:334:39: note: 'lo_val' was declared here
  uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
                                       ^~~~~~

Make it return a proper error code that we can catch in the caller.

Fixes: 992af942a6cf ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 8c09bf994acd..e079ee066d87 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -177,7 +177,7 @@ static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
 }
 
 /* get control counter settings i.e. address and values to set */
-static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
+static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 					  uint64_t config,
 					  uint32_t *lo_base_addr,
 					  uint32_t *hi_base_addr,
@@ -191,12 +191,12 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr, hi_base_addr);
 
 	if (lo_val == NULL || hi_val == NULL)
-		return;
+		return -EINVAL;
 
 	if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
 		DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
 				*lo_base_addr, *hi_base_addr);
-		return;
+		return -ENXIO;
 	}
 
 	eventsel = GET_EVENT(config);
@@ -211,6 +211,8 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
 	es_7_0 = es_13_0 & 0x0FFUL;
 	*lo_val = (es_7_0 & 0xFFUL) | ((unitmask & 0x0FUL) << 8);
 	*hi_val = (es_11_8 | ((es_13_12)<<(29)));
+
+	return 0;
 }
 
 /* assign df performance counters for read */
@@ -345,13 +347,16 @@ static int df_v3_6_add_xgmi_link_cntr(struct amdgpu_device *adev,
 	if (ret || is_assigned)
 		return ret;
 
-	df_v3_6_pmc_get_ctrl_settings(adev,
+	ret = df_v3_6_pmc_get_ctrl_settings(adev,
 			config,
 			&lo_base_addr,
 			&hi_base_addr,
 			&lo_val,
 			&hi_val);
 
+	if (ret)
+		return ret;
+
 	WREG32_PCIE(lo_base_addr, lo_val);
 	WREG32_PCIE(hi_base_addr, hi_val);
 
-- 
2.20.0

