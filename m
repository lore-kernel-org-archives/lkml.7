Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4055C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B263C21670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfGHOL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:11:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39239 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfGHOL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:11:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mx0VH-1ih8Qe1h99-00ySN3; Mon, 08 Jul 2019 16:11:19 +0200
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
        Kenneth Feng <kenneth.feng@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: fix warning about misplaced initializers
Date:   Mon,  8 Jul 2019 16:11:06 +0200
Message-Id: <20190708141117.1466888-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Riw7pyi5fcHlFYgLggi5fT891CARP6ay/3Mzo3v4QtTa3qKzhQL
 AQJ5rjrUB+ksQGEJNzGPSGY7yey1IZtuSLtkqHiHYkZZHHBjhihEsGvdLsAuTFIdsn/oxzu
 nq4sGwyPUsnY4YgfBmWzhwKz+kmnJCA+z8nBP0iM5TttL8c2eVGLIaz+ghEYdtZlgSO8U+o
 E06XZtUGrB9dO+gikaOTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbwEaYXrfiE=:z53MLd0Y/hSMEKZsD0Sie0
 sRZ863E1F83owcszbx/t58wXHyeQ6pp5Tlg2GQII6QloINaPdTd0oaEbdF8lUbhIEA9rCI8sx
 lnDbMzc8cl7jz8aAFbx8t7dznlvqsaABgwe/pOcqFsRJu3PmHNudN54+HrmnFI1XfFB/r4uVI
 LtOoKxm6aEMdIrtAL8xCgXg42LmsiFZ4SvL0KxcCZrKQl96EotWj4LmiN0cevwUSSUylS4hb2
 yQQaeYKMi1RJcKWGeQYpPORmgX/CIeMwbUExQMeCsEpeb5yzKUx50boK3bSqTNNZ1E3PgduYL
 lVE1jAFMh2M/RDAOrDclN07mjq3Ui3F5FYCITaiKFk9ioKso03vvNtCsPC448ruep2SwwzBWS
 5FOtJhfXxHljhx3hTD4JgX0ScPUSAzjRk/Iloymuz2gpHOp1kW1wOP0YTRrN1D2mUEhj1tcpE
 xbAYfXORYm0EgoKTwFQxYWox/YmAAFDym8GE0IFuq4REEqFPEIfSaykWyuu0S9zcvWj9f2NE+
 kyryAoGZRaswOEtF0yu3igVAaasJHnSN2DHeopqwDTBoPoDJQQ36acpV9iW29cdDzHOmET7Y9
 tUEHHWa4yNVcH51K4IAL5hndtUReNt/Rii5CG19WTu1QPNLcuZ1BW1oY2XYb1jGQaUWMs78wN
 ZGHnXeoSmwOyOJOGtFx7bUAlwlBgeDqh0J1UxViQPxxaI+a6AuzOsEYzZxlIQX9I/IYNR8FkC
 amQgy5tB2Rs7+Rkvq8MViI6LV5JEXrM9i4+7xA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The navi10_ppt code contains two instances of an incorrect struct initializer:

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:601:33: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
        static SmuMetrics_t metrics = {0};
                                       ^
                                       {}
drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:905:26: error: suggest braces around initialization of subobject
      [-Werror,-Wmissing-braces]
        SmuMetrics_t metrics = {0};
                                ^

Setting it to {} instead of {0} is correct and more portable here.

Fixes: ab43c4bf1cc8 ("drm/amd/powerplay: fix fan speed show error (for hwmon pwm)")
Fixes: 98e1a543c7b1 ("drm/amd/powerplay: add function get current clock freq interface for navi10")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index fdcea2b944ab..ce1da9e6e1bf 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -606,7 +606,7 @@ static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
 {
-	static SmuMetrics_t metrics = {0};
+	static SmuMetrics_t metrics = {};
 	int ret = 0, clk_id = 0;
 
 	if (!value)
@@ -957,7 +957,7 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 
 static int navi10_get_fan_speed(struct smu_context *smu, uint16_t *value)
 {
-	SmuMetrics_t metrics = {0};
+	SmuMetrics_t metrics = {};
 	int ret = 0;
 
 	if (!value)
-- 
2.20.0

