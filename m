Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC38C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88B420861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfGHNwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:52:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:52:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MTAJl-1hvicR406R-00UWYx; Mon, 08 Jul 2019 15:52:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Park <Chris.Park@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        David Francis <David.Francis@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: avoid 64-bit division
Date:   Mon,  8 Jul 2019 15:52:08 +0200
Message-Id: <20190708135238.651483-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:52AGef0Lq+dkr8kwjZNMwANHvgY3NRXyfVsWmIJgsnAVhNNRfc6
 +DvJqiMs58ht8342jZhhnhohh35rAb8AknH5DtGDOAN2AdFoXCfAFhd66huKJ7KP7xjFEOl
 1kTxt89yac00Xl8XVX6DHMdODQQoJ3QXl2KnJ+nrhTWnmYS5yWJD5d1DKT84ZJmlLvczuip
 7ZBsA0mrNEjAw8ono+ZwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LM2YkTiy6w0=:Urgvr2KhXrQJHmnNUZ3Aay
 HFfPj1p4DzZqha1rGAJgrxsvl9i8srVeglCgb73+oum6M1wTdy8DYfYrTpaFTlP7cev+MOAos
 kyeL6Eq13c7PwtKIpYMvsJYlLZYlh8gu2FUWblDQa3Ng1tNbBh0jSZZQGnBdzegEvULxEcq7u
 c0la0Zph5YDkQMp/0h0NCc+2rN7rBiMFvYCcw5WwcIb3KegNA3Upn0RYUxCJ/zwbcWup7PHxE
 xIOB3orusnst6VaI+JFBAsA3Ks7kljv0AXSpRWYyJ6JUKE9jMXIyr/o5QCDN7MDLN3KQkwSQa
 6EF2OKILbWXOGfxMgiYdbQefheqOutolj0llTvM7r6pqMHHmOI7DTKvdSRcuoE8CR04K7knZP
 XdfDWv8uuYM0ZAmAR4kg5jOez0yZ00rwbL7QEeMyVQBnQAZpfOMlzgXKNSWusQO4/QpKcvEmn
 5dRCBC4s+r3HluLBSBrvRCR4Hbp9JAX68dim4X+6XlwZTPv95qtUe7yRhl5wLi32pyKwQroQX
 QoJDTBHHe/XBKcv7z7pajYSK2k9b6VwYvRV9efBlEPZDVmik3ZInGRj5IA1M1JRxVyANblVZU
 whrhtyHeR68dVy7SfImFQF4WsLWiahcsOCCbt3jlXsAkb+qbKb72HBUalG8TZNiVbHJjKGvC0
 kyZ2JWup0wlDDaCg6Gtg0BkHw3LAxzl05Bx0JK3pj2GEz4sSPk4X3jqV1gl9EhI8RUie7/7ak
 LSU+6aP8VHZ+Up6UUb4n9RG4490JV7q7/gvsVw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, dividing a 64-bit integer in the kernel
leads to a link error:

ERROR: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: "__divdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Change the two recently introduced instances to a multiply+shift
operation that is also much cheaper on 32-bit architectures.
We can do that here, since both of them are really 32-bit numbers
that change a few percent.

Fixes: bedbbe6af4be ("drm/amd/display: Move link functions from dc to dc_link")
Fixes: f18bc4e53ad6 ("drm/amd/display: update calculated bounding box logic for NV")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c         | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c17db5c144aa..8dbf759eba45 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3072,8 +3072,8 @@ uint32_t dc_link_bandwidth_kbps(
 		 * but the difference is minimal and is in a safe direction,
 		 * which all works well around potential ambiguity of DP 1.4a spec.
 		 */
-		long long fec_link_bw_kbps = link_bw_kbps * 970LL;
-		link_bw_kbps = (uint32_t)(fec_link_bw_kbps / 1000LL);
+		link_bw_kbps = mul_u64_u32_shr(BIT_ULL(32) * 970LL / 1000,
+					       link_bw_kbps, 32);
 	}
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b35327bafbc5..70ac8a95d2db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2657,7 +2657,7 @@ static void update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_
 		calculated_states[i].dram_speed_mts = uclk_states[i] * 16 / 1000;
 
 		// FCLK:UCLK ratio is 1.08
-		min_fclk_required_by_uclk = ((unsigned long long)uclk_states[i]) * 1080 / 1000000;
+		min_fclk_required_by_uclk = mul_u64_u32_shr(BIT_ULL(32) * 1080 / 1000000, uclk_states[i], 32);
 
 		calculated_states[i].fabricclk_mhz = (min_fclk_required_by_uclk < min_dcfclk) ?
 				min_dcfclk : min_fclk_required_by_uclk;
-- 
2.20.0

