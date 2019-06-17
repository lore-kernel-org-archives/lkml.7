Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB31C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D92120861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfFQMvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:51:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfFQMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:51:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mae7u-1iDYhN3MgU-00cAt7; Mon, 17 Jun 2019 14:51:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/komeda: fix 32-bit komeda_crtc_update_clock_ratio
Date:   Mon, 17 Jun 2019 14:51:04 +0200
Message-Id: <20190617125121.1414507-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YNZWWtAS0xzrrfM3pjl8AX7tgKroNKj7VFYbWmDIWP/c+QDu9S7
 gDzeeip7x3tIK53FmtWpRwGHG5N939FLMnzAsoVcZaSW6/75zGoPpl5A3CoovOmO27pN0bu
 +st/zT8a1j8o/NkZMy9MfDYpsgyizzJO+Zecj5us03TSbd2deNIluDsQ0DA0iiCQE4u6SJz
 5dh87wbTaBXhC9/NXsyfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PW9GCohIInk=:aQ0AToBxA4KMITMsE6cbZd
 juUFYtzR/V0Dv2gTDcYLEKSU9/lX85CRt9wTtq9n2K0GuoDniFeKoMSv3kH9wQsYyBSl1GOT+
 Hxc2TIgRvv2yxH80NHgQ19qoblsq+tlaPGedNOsisEoFymDHTOj1qJ4ojrTJ53Ss826ZH0MRd
 sDIyFNlw8Z3P0XU0qu7hDEqdY+Nu+pcACQwG3t+ywZyEcMzUoyQ4h/6DxGXUsqafWvTQSk5Bg
 AT6JNPDPoxwlWvFbrnY9JkNyY7dg/5J5jT8i5Wu8dA8EFKBmMxoTUyG7mJZneJHTVR25U7J8r
 6NNgyAifw76O4YbYvkeMLGAV2MGjytvaKLDMI46qMwwy4wnF8ExI7ZEQoQdbnNjKIh/glQtQi
 n9E47x1U/LYi/9LLltQZ9QJjlYb90ntJVC0j7GfroYkHKG+dYuClIJm7rUswXLPV4INl9mTky
 zwMsdvJjxnkia4JBdDQjkcWNRaPXujcRI+TABRKxmt0GBRlqaKeOZ0bVC3+cUjSM0Vnpif//Z
 xj8WVCPbVZ6mzuNoIA3aTVTq/uUn1g7FIqF97AKKiH176ZBXmPm/YRhFh6N5qrY5focL6IMQH
 K8V9R7FwTpU+NQtAsoUOw0DbO4JXvdcof5aJdABDJl2e5l/Qa0DJarsKjVxmkDzKerCNBx/yo
 I8cY6vMFjuZOtV+DKIjXufoz25+pUl4RkYQWVEBrVzwx9ckEoPO7C9jjOORUJb2BX74ud2lMz
 oD0NTcn6AeHkjHNkWQEDtEUlePIiIhqs+nkvmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out a bug in the clock calculation on 32-bit, that leads
to the clock_ratio always being zero:

drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:31:36: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
        aclk = komeda_calc_aclk(kcrtc_st) << 32;

Move the shift into the division to make it apply on a 64-bit
variable. Also use the more expensive div64_u64() instead of div_u64()
to account for pxlclk being a 64-bit integer.

Fixes: a962091227ed ("drm/komeda: Add engine clock requirement check for the downscaling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index cafb4457e187..3f222f464eb2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -28,10 +28,9 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
 	}
 
 	pxlclk = kcrtc_st->base.adjusted_mode.clock * 1000;
-	aclk = komeda_calc_aclk(kcrtc_st) << 32;
+	aclk = komeda_calc_aclk(kcrtc_st);
 
-	do_div(aclk, pxlclk);
-	kcrtc_st->clock_ratio = aclk;
+	kcrtc_st->clock_ratio = div64_u64(aclk << 32, pxlclk);
 }
 
 /**
-- 
2.20.0

