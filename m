Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D8DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699332077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfHPWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:10:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfHPWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:10:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hykQF-0001vO-C2; Fri, 16 Aug 2019 22:10:11 +0000
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
Subject: [PATCH][drm-next] drm/amd/display: fix a potential null pointer dereference
Date:   Fri, 16 Aug 2019 23:10:11 +0100
Message-Id: <20190816221011.10750-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the pointer init_data is dereferenced on the assignment
of fw_info before init_data is sanity checked to see if it is null.
Fix te potential null pointer dereference on init_data by only
performing dereference after it is null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 9adc8050bf3c ("drm/amd/display: make firmware info only load once during dc_bios create")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index bee81bf288be..926954c804a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1235,7 +1235,7 @@ static bool calc_pll_max_vco_construct(
 			struct calc_pll_clock_source_init_data *init_data)
 {
 	uint32_t i;
-	struct dc_firmware_info *fw_info = &init_data->bp->fw_info;
+	struct dc_firmware_info *fw_info;
 	if (calc_pll_cs == NULL ||
 			init_data == NULL ||
 			init_data->bp == NULL)
@@ -1244,6 +1244,7 @@ static bool calc_pll_max_vco_construct(
 	if (init_data->bp->fw_info_valid)
 		return false;
 
+	fw_info = &init_data->bp->fw_info;
 	calc_pll_cs->ctx = init_data->ctx;
 	calc_pll_cs->ref_freq_khz = fw_info->pll_info.crystal_frequency;
 	calc_pll_cs->min_vco_khz =
-- 
2.20.1

