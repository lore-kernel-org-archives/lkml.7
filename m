Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB80C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951921479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfGHN5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:57:37 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbfGHN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:57:37 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N63JO-1iZC2B3Bai-016SJP; Mon, 08 Jul 2019 15:57:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Likun Gao <Likun.Gao@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Gui Chengming <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] drm/amd/powerplay: work around enum conversion warnings
Date:   Mon,  8 Jul 2019 15:57:06 +0200
Message-Id: <20190708135725.844960-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HFJkRL/u3m2h7/kWPZ2uweQQNsKNk+l+VGn5825pAbgysbgYwaT
 s3QkxM4NKWF+vHWVUAOEs/maQ8DqGz7XjO8XGncS/eCce3++nGb4cf2kdDLLJtnJTwBHax7
 LYcBNwvdhdbuYu9JXkgQg6JgBVBuSYUzObUfv8XhNL2XYcu4un+h3iikS2W68ur9ppkwoTd
 A+FiuYeCaHA/M2b49R9vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmEqUqwMfX0=:G9E21xJMV/y1DCq1lu03hI
 lRFdCR79iFIrvVOJxLPANX3KpKHjZV0JXcPUVkAysCfC8XuS7Kl5jiUexkqtG3pIXfoqvEVU5
 8ftcewsSQ7pPM4qF/gluJgtlZYDGLYZu/9uFuk1zMnnSYYIR1zy0c+6ZpZ3VVqilhZ4CS50Vs
 WSBSl2Y/evTMvg+F1ogc2h3aUr+xYFufDiJnqNUaEA7tY3KKUvovtGYcpw2o/o+SaZi3MU54v
 tBJ1ghxC0RRAZW7Nrr08IO/MmjS0Zl9Xn+9GXlWV3qQ9fq+3kGEDlLg2DkNKq3IEGsNFQHprN
 XhkWVF3L+LpEMK7755WegE85UHj449PeDcKHHSYft7GHZJp1VtfJDh/xprn1+d0HIcae6QBa2
 j6f2nQA2Axhlbmk0J2xOiqK1zrEJZtzhy/Kvr2MSmSRqfZyf9VOWinabm5KN48Kq6JKIFr9br
 YeMySEGjKn4CFd1Ll97o8UWm4Muq+wuIHJFWYLVNJkapyHzHSr92EsD7kAgXk0UTd+tfSKeav
 lMk+tjBdhY5uR/22xnNDVRBfNQSqjHKXGBjIKPfDYuDEXWlBy9gG6MQzlnuuYNDL8/0kl3lQi
 cIOFcjtiDsxjefksgiyS3G5+CQTMeBNFCfXtvLsSi8HxpShotLtVx3KtlNCYbdAfGZRSMTPwC
 49h+V3kq3ggh8tXxaQJm4Skqpnr1V0OXBwqmeCTkZBkMWJfDfH8nRL94l+3r1Jv7aOFUXWQhI
 SjZzBNqMGYAL8RNbBc/bj+NiSoQrg2ifKa9CIg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
pass constants of the wrong type, leading to warnings with clang-8:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
                ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
        ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)

I could not figure out what the purpose is of mixing the types
like this and if it is written like this intentionally.
Assuming this is all correct, adding an explict case is an
easy way to shut up the warnings.

Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Please check carefully if the warning is just a false positive
or we need a different patch.
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ++--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 755c6c79f724..93732623b507 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1386,8 +1386,8 @@ int smu_adjust_power_state_dynamic(struct smu_context *smu,
 							 &soc_mask);
 			if (ret)
 				return ret;
-			smu_force_clk_levels(smu, PP_SCLK, 1 << sclk_mask);
-			smu_force_clk_levels(smu, PP_MCLK, 1 << mclk_mask);
+			smu_force_clk_levels(smu, (enum smu_clk_type)PP_SCLK, 1 << sclk_mask);
+			smu_force_clk_levels(smu, (enum smu_clk_type)PP_MCLK, 1 << mclk_mask);
 			break;
 
 		case AMD_DPM_FORCED_LEVEL_MANUAL:
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index dba02fa0de01..20d477f8dc84 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_SOCCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current socclk Failed!");
 			return ret;
@@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_FCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_FCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current fclk Failed!");
 			return ret;
@@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
+		ret = smu_get_current_clk_freq(smu, (enum smu_clk_type)PPCLK_DCEFCLK, &now);
 		if (ret) {
 			pr_err("Attempt to get current dcefclk Failed!");
 			return ret;
-- 
2.20.0

