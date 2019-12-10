Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66C520652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLJUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:31:13 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLJUbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:31:13 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mw8gc-1hpI030rKO-00s44T; Tue, 10 Dec 2019 21:31:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Charlene Liu <charlene.liu@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix undefined struct member reference
Date:   Tue, 10 Dec 2019 21:30:46 +0100
Message-Id: <20191210203101.2663341-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6Y2/uQlFVUAl2FLpNaMIEOkGmiPd6/841XgCPxFoFzLNddBwEXH
 Gv0mA5U4F2XyfY5t7Irv9sGvE7omtf7B7anfrVJBcEa6nJh0oGgFa3a8TjQPfIv9chsmwPT
 jvm00bAGb9IDmiVsEt/HDimufrl4EuajG0pezWC+Cd9W5Z3cXKjNuVPnbUu6xNF5mo57oYn
 vjtK9SqzVDqza+VajFYtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nvvWyV4d47I=:igjZJHss92gevPEg0s6AeJ
 irNg5oTb0g/mz1SP58BRWPJSUPXagn9fT5Q282PRr4qjKcGuqUqdPcXxozfe+lB8JSjqAtAGw
 uGrMQgtCqCSRhrmYPiIvqAvYo7eKNTHjgm5zzL+bvo9/CHEzMDRNSIV7lUKhGjbHAClQMc8c7
 GlE5a+tlT+8othshZhcQR4ci6Pr2UmYOudQalhqK0FT3R1UV5qW9PQ02gnzVmeqVwr8kIlJDv
 8hlVZ1hkWffCyUrLjn0vH+xN/T6TWgnWt+pJTNBPdIYjibiIKuItvsKNill74VNUq3R/Kgh/V
 6C6ONZlPZdxOlv3KSBoMTYET6qDuqe7QIqBbeqar9KHm+OhvaT8Oi2mBTCr9Ebb4ITtqpVHIZ
 k50AT2eOTHY5gRKN3y6dURvxJPLaNTVNVRSDQLVquHAsvnq16pI2hRHsyfUddNkOdKg8FVKGf
 BToTy7SZam/OruTSwmLzD2ZboH7k3sc+6HbQ+hBNHkDSNS/fzNmcpKJZ0pn1TdrdbIdJVqMC/
 jMwXwnoDMWLCak14H7Wgws8CcQkZCddWhNXS2qO3EOHS34zybzsKNNXd0Y8WmYupY8xDr+ec+
 sbZB7GEbT3OhMcmh9VKJsGypjTr45ZjUJjJzf4ZhnrukVS/57Y/133obTCJn3PUT9bdP6a0Gq
 CCQSrwldYAAxNi+wQCxvY7r/8JJO6YxFLt/UEeXdDcYWXY+qwESm3KQEQdgsusLFVxLYdhoHK
 83cyamaR95AcqjPE+P6lB3yo112Lk2GKxGxl4T/yNKfnnecQcJQoQ96ep8o7xWFSso8fdyte9
 xYjZnAYcSEBleU5p/+5gbGi1R2S9x1j3AMcpJo1yAJn3p4G8DD0Q8XSAHsyN9rJksdRVvZxI0
 jyJZTahwNkriE15CwfTw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An initialization was added for two optional struct members.  One of
these is always present in the dcn20_resource file, but the other one
depends on CONFIG_DRM_AMD_DC_DSC_SUPPORT and causes a build failure if
that is missing:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:926:14: error: excess elements in struct initializer [-Werror]
   .num_dsc = 5,

Add another #ifdef around the assignment.

Fixes: c3d03c5a196f ("drm/amd/display: Include num_vmid and num_dsc within NV14's resource caps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index faab89d1e694..fdf93e6edf43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -923,7 +923,9 @@ static const struct resource_caps res_cap_nv14 = {
 		.num_dwb = 1,
 		.num_ddc = 5,
 		.num_vmid = 16,
+#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 		.num_dsc = 5,
+#endif
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-- 
2.20.0

