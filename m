Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0072467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLTG7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:59:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbfLTG7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:59:24 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD535BB4347BE60FDE57;
        Fri, 20 Dec 2019 14:59:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 14:59:13 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH next] drm/amd/display: make some symbols static
Date:   Fri, 20 Dec 2019 14:55:57 +0800
Message-ID: <20191220065557.151393-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some structs and functions static to fix build warnings, parts of
warnings are as follows:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:744:21:
	warning: symbol 'dce110_clock_source_create' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:768:6:
	warning: symbol 'dce110_clock_source_destroy' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index bf14e9a..87227db 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -741,7 +741,7 @@ struct dce_i2c_hw *dce110_i2c_hw_create(
 
 	return dce_i2c_hw;
 }
-struct clock_source *dce110_clock_source_create(
+static struct clock_source *dce110_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -765,7 +765,7 @@ struct clock_source *dce110_clock_source_create(
 	return NULL;
 }
 
-void dce110_clock_source_destroy(struct clock_source **clk_src)
+static void dce110_clock_source_destroy(struct clock_source **clk_src)
 {
 	struct dce110_clk_src *dce110_clk_src;
 
@@ -1007,7 +1007,7 @@ static bool dce110_validate_bandwidth(
 	return result;
 }
 
-enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
+static enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_state,
 				     struct dc_caps *caps)
 {
 	if (((plane_state->dst_rect.width * 2) < plane_state->src_rect.width) ||
@@ -1062,7 +1062,7 @@ static bool dce110_validate_surface_sets(
 	return true;
 }
 
-enum dc_status dce110_validate_global(
+static enum dc_status dce110_validate_global(
 		struct dc *dc,
 		struct dc_state *context)
 {
@@ -1305,7 +1305,7 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 		1000);
 }
 
-const struct resource_caps *dce110_resource_cap(
+static const struct resource_caps *dce110_resource_cap(
 	struct hw_asic_id *asic_id)
 {
 	if (ASIC_REV_IS_STONEY(asic_id->hw_internal_rev))
-- 
2.7.4

