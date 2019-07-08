Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD1C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3E021670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfGHOIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:08:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54365 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:08:36 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M89P3-1ho4wp0FFr-005MGd; Mon, 08 Jul 2019 16:08:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Chengming Gui <Jack.Gui@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/powerplay: vega20: fix uninitialized variable use
Date:   Mon,  8 Jul 2019 16:07:59 +0200
Message-Id: <20190708140816.1334640-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190708140816.1334640-1-arnd@arndb.de>
References: <20190708140816.1334640-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NyfhK5Y4jz7Zauo0keyLsO1GaKfDaYS9PZtk4wBhZX4qB8ZPG7o
 XAcUVBB10BKXLj+ZVSeTI0D/l0efVGJTE5jS5oIEgaFpES91kHGCZp7xFl+VVFnyf2qjvYb
 2fB+TOUjE1u/eR4fhGyZ2JdQcYLO2UnbqY0jmhrnxJuGyQOSHKgFFx/hNbUk/9FeK4dtLtA
 Oxe6uhkvKx0J1PnP+d+xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ricJjI9sTU0=:jjXRZ80JOXKSZPGfAGrxJK
 5MnloyJFczjlnFDwjZoAv0fwMyEViU4SCNoRSWVfTEh0vtq9rHrXy8+CvjNqjl+T61doObwix
 m3B5FUdbFLzwvqBot8udnBzZkUd7bTCsEPcWYm4kyB5GZCG9FMddxefo+Be04RtMXrb/Ym2Y+
 PKpfcLUjN85jnj5vmcw0EJZ7GHa44LWiwS3HJFinSQZDng4N9nH10YapicmaHhS62nJy+s+R8
 bL33CgjW9z0+yon2t3LZe9udh3ZRcKpjSKYOUY55qU8wDLQcW8dK4rqdbwqJ2r2/g6HtEoY/v
 RuIHTcSjnKd+YeMHG2h2DC/OvaABlVnlTBWcyT3p2vfs+Ow+cEZFJUXVg603RYF4EJ5e/dNeu
 c71aMaqg57jo/MLiiygnDKvAMvOHL2rEnX9nlZFTc22jLWmgaB52K5De7HPIL8evckboAMlec
 xMRIyvSKQvWuxoRpvFUzRrcNKdl6qwqnG/O7R1Ul+0sAKP+HKT4mfU5HIisPTI69bLKUUWV2K
 rd7gHOFQSW0dNEOw/wY4Rq/HDso6zIOiQsKwCDWehWy91e1zYwgmdbsDswzQllLmh9xNuDZ38
 uwKA6AIUJQs1k1botxu8ysfXcNj3p9ZyAkUMfBjrPTx05zryPWmzNg/x2c4AcK7T1SIfWj9P9
 JO9rk5eSeyYbi5CApjYKkYGASvXiEYCdPTRCIGr8wbUgOFSJTSlqaUqAftcbnNAyP+Zx8cf0w
 5bTezfc2UNfDfzWUxTUVcMij5exbEFDN9pIcAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If smu_get_current_rpm() fails, we can't use the output,
as that may be uninitialized:

drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: error: variable 'current_rpm' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
        ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3024:12: note: uninitialized use occurs here
        percent = current_rpm * 100 / pptable->FanMaximumRpm;
                  ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: note: remove the '?:' if its condition is always true
        ret = smu_get_current_rpm(smu, &current_rpm);
              ^
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
        ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
         ^
drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3020:22: note: initialize the variable 'current_rpm' to silence this warning
        uint32_t current_rpm;

Propagate the error code in that case.

Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 9ce3f1c8ae0f..20d477f8dc84 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3021,10 +3021,13 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
 	ret = smu_get_current_rpm(smu, &current_rpm);
+	if (ret)
+		return ret;
+
 	percent = current_rpm * 100 / pptable->FanMaximumRpm;
 	*speed = percent > 100 ? 100 : percent;
 
-	return ret;
+	return 0;
 }
 
 static int vega20_get_gpu_power(struct smu_context *smu, uint32_t *value)
-- 
2.20.0

