Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF137C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9835F2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfEKMcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 08:32:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35097 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEKMb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 08:31:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hPRAR-0007va-5C; Sat, 11 May 2019 12:31:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove redundant assignment to variable actual_clock
Date:   Sat, 11 May 2019 13:31:54 +0100
Message-Id: <20190511123154.2708-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable actual_clock is being initialized however this is never
read and later it is being reassigned to a new value. The initialization
is redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
index 6b2e207777f0..fdd973c03dca 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
@@ -344,7 +344,7 @@ int dce112_set_dispclk(struct clk_mgr *clk_mgr, int requested_clk_khz)
 	struct dc_bios *bp = clk_mgr->ctx->dc_bios;
 	struct dc *core_dc = clk_mgr->ctx->dc;
 	struct dmcu *dmcu = core_dc->res_pool->dmcu;
-	int actual_clock = requested_clk_khz;
+	int actual_clock;
 	/* Prepare to program display clock*/
 	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
 
-- 
2.20.1

