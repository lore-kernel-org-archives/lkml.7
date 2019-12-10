Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB8DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453F207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfLJT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:59:51 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:59:50 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MjSPq-1htqK43Row-00l1Jv; Tue, 10 Dec 2019 20:59:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Roman Li <Roman.Li@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: include linux/slab.h where needed
Date:   Tue, 10 Dec 2019 20:59:24 +0100
Message-Id: <20191210195941.931745-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OrcnEQHu5wIVElyPLtj9cM/U8i3tJsEHQqMgWD9iAttxajBL+4Y
 PRozQipVEPM78uWvddh6kjFJP0m9W7Xl2iyfwMr6le8zEOqtUcR3YqBbcY0m8NmbwLj4gij
 nH91rockYuPliucDJPwxBaK0+/s8ZLF4ilxO0+TiyEzKKY8itGLkPD8DVvHiCm1DACaRXts
 wksFhEsGXgNsaguRsbwew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEiflWA01l4=:gpxzEPPROCuBYSCdglCxHL
 0FQH6OkxWAbdkjhBtOL2AOW8TAzyUHTAwzR5AHHK34sofuin6RguUUZM4C2xfxlzS6CZOZCKz
 Vo+yFJMGQ1BhPWdJG9soTTJrBPbwWOmI/bekCgki/MyU1It2Zx5Gne0YZaduSKHuAb0c+6YuY
 UpL90RraaJFqofxod1WlkAjNmht7gW1xPfTQwcufejGVJFhtrWOnrLcB5PyA76aPi9FHFVzvA
 kPjqEaWQGpM3xe9qkwf6ZjNXogUw5NkQhhqsndAXeH8kpKKt4hcLquS3mPWNqCQ6aZVcLcqbZ
 tfJHLO/WK7A4/jNQ1gNjssnSHMqomjQE73RqgmN+a9WwtA2tbrdfl5KOjDkoU8YrmhJACYK+W
 q36JztMtUCneNEZ6LNdXgahuwkkodb9RTyIIacI8L5lwUPUZRC3k33OCFOn24mdnsx5UL86tC
 PPbls88S0p6zUPMMN1zOFF3uP0TMZaNPetFeEdCwKosDt57VVWEHpFE9t/JCIFFofQjpB/BpA
 7JAubHz0yx4UUIeL6yol4IjXh1+EOCsjo+kZYaCUsVJL8zceWjEt4ZAUZjNLEW+7andvWqIyh
 w7oh5ezTHSn1BoCiCPguMWISCoPlAxEvaMCRimn3oR127JBQHa+H9DlG5f1LtOvIO9hXE2Zos
 5eSy9+iqpnSZhzGhTLuPx1nhkoO+rpRsUtZijJ8uPTvjoXouQJkXKrN9o9H5Bvx1lyPKI0mU+
 /EFS1hkKQ0TdUH7AOlhi1Ni9JD6z30oze1Ep4dCICmtrQsf4ZKsCI7vMCb9p7gawwP5k19GoT
 B8adXghoLkZL9WVo+ogipbYaq0Q5KN1jqMyHeq5myaaI/2CQF6K3IJzktAZ4hi80CVBLrDliv
 p91ZckwO07jrR8qPb+Fw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling kzalloc() and related functions requires the
linux/slab.h header to be included:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In function 'dcn21_ipp_create':
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:679:3: error: implicit declaration of function 'kzalloc'; did you mean 'd_alloc'? [-Werror=implicit-function-declaration]
   kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);

A lot of other headers also miss a direct include in this file,
but this is the only one that causes a problem for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 906c84e6b49b..af57885bbff2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -23,6 +23,8 @@
  *
  */
 
+#include <linux/slab.h>
+
 #include "dm_services.h"
 #include "dc.h"
 
-- 
2.20.0

