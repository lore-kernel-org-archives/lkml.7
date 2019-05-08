Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9737C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfEHMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:55:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfEHMz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:55:59 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4678F3A9E7B50225F17D;
        Wed,  8 May 2019 20:55:43 +0800 (CST)
Received: from huawei.com (10.184.227.228) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 May 2019
 20:55:33 +0800
From:   Wang Hai <wanghai26@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Bhawanpreet.Lakha@amd.com>, <Tony.Cheng@amd.com>,
        <Dmytro.Laktyushkin@amd.com>, <hersenxs.wu@amd.com>,
        <David.Francis@amd.com>, <Jun.Lei@amd.com>, <Jerry.Zuo@amd.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <wanghai26@huawei.com>
Subject: [PATCH] drm/amd/display: Make some functions static
Date:   Wed, 8 May 2019 20:55:16 +0800
Message-ID: <20190508125516.16732-1-wanghai26@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.227.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:483:21: warning: symbol 'dce120_clock_source_create' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:506:6: warning: symbol 'dce120_clock_source_destroy' was not declared. Should it be static?
drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:513:6: warning: symbol 'dce120_hw_sequencer_create' was not declared. Should it be static?

Fixes: b8fdfcc6a92c ("drm/amd/display: Add DCE12 core support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai26@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 312a0aebf91f..0948421219ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -458,7 +458,7 @@ static const struct dc_debug_options debug_defaults = {
 		.disable_clock_gate = true,
 };
 
-struct clock_source *dce120_clock_source_create(
+static struct clock_source *dce120_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
@@ -481,14 +481,14 @@ struct clock_source *dce120_clock_source_create(
 	return NULL;
 }
 
-void dce120_clock_source_destroy(struct clock_source **clk_src)
+static void dce120_clock_source_destroy(struct clock_source **clk_src)
 {
 	kfree(TO_DCE110_CLK_SRC(*clk_src));
 	*clk_src = NULL;
 }
 
 
-bool dce120_hw_sequencer_create(struct dc *dc)
+static bool dce120_hw_sequencer_create(struct dc *dc)
 {
 	/* All registers used by dce11.2 match those in dce11 in offset and
 	 * structure
-- 
2.17.1


