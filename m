Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E755CC742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9632064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGLJkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:40:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfGLJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:40:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MwQCb-1ie6cI24qj-00sKbe; Fri, 12 Jul 2019 11:40:11 +0200
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
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Charlene Liu <charlene.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] drm/amd/display: return 'NULL' instead of 'false' from dcn20_acquire_idle_pipe_for_layer
Date:   Fri, 12 Jul 2019 11:39:52 +0200
Message-Id: <20190712094009.1535662-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3cpkDgxIhIsadjRAYBvtn1DUyn+BUx4TJsnFE7RqYAa5qmUsTy6
 ZFEWWtos2jSr8XJqGbISEDbpNjknjjyG9gOydIRFynjICGXMb1KjAkon8PG4aAb1JAjEzma
 AHDoJXR1FwIQHXXfZ6oorG8LKXZJrnCGniYroO08K5/hrWuUrJyWyfGGD6IbPMMiazMUfKK
 ewxOssRMv/wrh7Cmz9ZMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oRQbMjjvoFQ=:No9erCSCNWW+VJd/nxNhyr
 6OIu1qjtUork6mvRXgF9CoyGhOzQGkOATDOd+8MhfahUOLpWn+L8svIDug83SSQ/7iAxMuSmx
 UrNw0VrqwduicMcLa+nRC8oH5lpP8V9RuBpXbsDJNeUIXyD8lhYApZQr7TCs4q5dn6C76CpC5
 Gwyg4aMd/cRD2vQ40hhDjZicgD8qQZN++JKALp1vl0SDa2GqIOfJuyoLM/AxVaB9BsLdRxNaK
 CJdKCFxr2akRoHyPTMTqFffdefAE/NxJOwyLUjcplYD3jclo9o9pNZPorygWG8DnAfIwWcDXG
 J9R9bPanREK3s4gsxF4LYCrS6CLqyCF71J+3mG11TKA8oRJQXt/cFkUYW9KmDZap0y/dwgy9t
 T4NQSvQI9ZIYH8HAim4kYVHrDxeQVQrR0Bh64IWpOJLDJclJ5+nQAiAQPRiHr/lbxtuHAH2lh
 s5xpzuWjhVdhXQRzveJoMYS171SlizoNBgxs01FJSzvR5UWcaASBlmgkPYmTYRPmx1wUYamzE
 cKu++M6LrFPoQOxxLNx/bTbgdQB1WnxFM1IyEfqcYrloSdTtoIhNTCGaIZcsspJBuLclBNJvI
 m4DF+ruvt1dNq/hJa1h2QHFX3ww0+kI2F6mWmMR0YP+UHoUMbXCK37CLEFgwuNCmuU+1wZBbB
 ZuJhpWGiZ20xa0VH1MXAJ2eIfALilxi2CpFAYKbYq9HeYwWNoPg5VCDsJI9Ayyb3HX/+JaWuq
 skFB7ZWyVD61qKRx4CE6mJxDQGNEBrS8y3JB/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang complains that 'false' is a not a pointer:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c:2428:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
                return false;

Changing it to 'NULL' looks like the right thing that will shut up
the warning and make it easier to read, while not changing behavior.

Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 70ac8a95d2db..66aa414ad38f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2425,7 +2425,7 @@ struct pipe_ctx *dcn20_acquire_idle_pipe_for_layer(
 		ASSERT(0);
 
 	if (!idle_pipe)
-		return false;
+		return NULL;
 
 	idle_pipe->stream = head_pipe->stream;
 	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
-- 
2.20.0

