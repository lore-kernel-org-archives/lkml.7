Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB790C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCFC21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfGHOI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:08:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:08:26 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMoXC-1i375x3FCu-00Ik9A; Mon, 08 Jul 2019 16:08:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Wang <kevin1.wang@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/powerplay: smu_v11_0: fix uninitialized variable use
Date:   Mon,  8 Jul 2019 16:07:58 +0200
Message-Id: <20190708140816.1334640-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X3J4e80NQyAuaqivhrauUEXEWU7jDdUAqZMBR/kGPcQ7CYCTHSi
 CIzF/Hx8mmfKT7DQSNax0/KaUiiTQnuK2hIJxk0dtFaoEHsVLxWeR+yR3fnKIhqt3Dfg4iP
 PIwtg8WqdZuu0vvm6p03mU3SVAQ/SbVVPQmeuP08r/dD1WfosPTHh5iYGmMh5e0Nlbbcmuq
 /M8IBS2hCeB21b3CZkm/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:14Ii1zw6QsU=:dUxvAlUg7CH/JD12q86ZkC
 NPa53AjNYyMTTFb6PHM3SufF/j4+MnmcH24nLk8u0Hgn3Zjyt5+jIgUAsdj/FId5IDMeL/Liv
 nFyB93a5FGykJUhWnsd4/N7+WiKiZeSeKFiN0Wkl7LFFMw8iFr3+IjVvXXAbkP91ATFF0Ky57
 Sjv+FZ05WJjs5A2oHVCsGp27DI94HU4OVvvM06CjWz+uVWaEXCeM6EYs+NNqDfLi75VqEWFdc
 xJltWBfGrxJgLug9v+coRVT7Min4kP/f1NnvKAuT0TL84cK3VbOCK/N9rwlVCBkSmdQljhiNd
 nzzBabj5pKnYUSWSsjizgTnUGaI7k8AWxy4JePuE0YNpj0iuFkvGMX/A2alZ/pnDBa36RMNp6
 KLTjObokalL6XkDdWgC3m1QyHYwwH/nJke3R/tdvxXI9MeyFxQDjo5Gn/JGtW1TD/3BGVd7Ii
 p+eI9SipxqKZeL8C23nGph/LlsHXy/jHq+HQ8dwOAwjeVJ3IiDQFvGnkib+FZPah4RGd4gHS6
 KetPom7A/2J3Z5F5XDDGeijFvIAYkQYOIBe5/ccHW7XwjieBCWCn0gSq0v8NkVz428AYUCWOP
 f/IYNPZfMsGCYPZHXFMb2OK+ig0J9/NSkIpixzmkcQY/IB/hpqCDMb2NGE/bJGZyPsIzvHsq2
 DwE37KZqnY9akc5gRm42udStAewy3dM3SVFb+Q6RYG6YeSCx/E/OylqA1frsCZe/E1QbFUXJE
 hMQvYzIH57lCSq586//fOLaruyhv252i6sZ/3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A mistake in the error handling caused an uninitialized
variable to be used:

drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: error: variable 'freq' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
        ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1114:2: note: uninitialized use occurs here
        freq *= 100;
        ^~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1102:10: note: remove the '?:' if its condition is always true
                ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
                       ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:880:3: note: expanded from macro 'smu_get_current_clk_freq_by_table'
        ((smu)->ppt_funcs->get_current_clk_freq_by_table ? (smu)->ppt_funcs->get_current_clk_freq_by_table((smu), (clk_type), (value)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:1095:15: note: initialize the variable 'freq' to silence this warning
        uint32_t freq;
                     ^
                      = 0

Bail out of smu_v11_0_get_current_clk_freq() before we get there.

Fixes: e36182490dec ("drm/amd/powerplay: fix dpm freq unit error (10KHz -> Mhz)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index c3f9714e9047..bd89a13b6679 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1099,9 +1099,11 @@ static int smu_v11_0_get_current_clk_freq(struct smu_context *smu,
 		return -EINVAL;
 
 	/* if don't has GetDpmClockFreq Message, try get current clock by SmuMetrics_t */
-	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0)
+	if (smu_msg_get_index(smu, SMU_MSG_GetDpmClockFreq) == 0) {
 		ret =  smu_get_current_clk_freq_by_table(smu, clk_id, &freq);
-	else {
+		if (ret)
+			return ret;
+	} else {
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_GetDpmClockFreq,
 						  (smu_clk_get_index(smu, clk_id) << 16));
 		if (ret)
-- 
2.20.0

