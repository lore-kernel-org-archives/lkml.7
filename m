Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8333DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584BA24672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430602;
	bh=NCtaa7kgR2xrGcKG+Q0wYaoTdA2BTNNwnmJcvzCZ/1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=StJMP8erFgryViicKWzvq3S4a2/6Eajb9f8hhXmI5/DSnWTFdlfl+Qh2aD4bn5A16
	 VMwsHCICVMU+pgdqYv50n2x74nHViFX9oT33N2DN3mtFqj9ZyQ+4syS5MKwzKBGCMG
	 Kr57FpQaQUS6jZh78X/pU/OGI6P66gNvQ8zm8dm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgAGU4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbgAGU4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:56:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DC72081E;
        Tue,  7 Jan 2020 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430594;
        bh=NCtaa7kgR2xrGcKG+Q0wYaoTdA2BTNNwnmJcvzCZ/1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kl/0hfFkGqycFS/gZne6vgtV0SSNy74aAPpZqwTwSZSUGh/P0rg4K7aoXjK6tTsf
         HdmFHoMEjCtNPrxNL1mrta3QvIVl9tC5huQO5i9mokSepwglsRONI+7BQIuSnsoENT
         eShtaN30oPYWmDOVHmgXSCVq3GzOu3NDxJeicZeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikola Cornij <nikola.cornij@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/191] drm/amd/display: Map DSC resources 1-to-1 if numbers of OPPs and DSCs are equal
Date:   Tue,  7 Jan 2020 21:52:07 +0100
Message-Id: <20200107205333.399399339@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikola Cornij <nikola.cornij@amd.com>

[ Upstream commit a1fc44b609b4e9c0941f0e4a1fc69d367af5ab69 ]

[why]
On ASICs where number of DSCs is the same as OPPs there's no need
for DSC resource management. Mappping 1-to-1 fixes mode-set- or S3-
-related issues for such platforms.

[how]
Map DSC resources 1-to-1 to pipes only if number of OPPs is the same
as number of DSCs. This will still keep other ASICs working.
A follow-up patch to fix mode-set issues on those ASICs will be
required if testing shows issues with mode set.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 78b2cc2e122f..3b7769a3e67e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1419,13 +1419,20 @@ enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state
 
 static void acquire_dsc(struct resource_context *res_ctx,
 			const struct resource_pool *pool,
-			struct display_stream_compressor **dsc)
+			struct display_stream_compressor **dsc,
+			int pipe_idx)
 {
 	int i;
 
 	ASSERT(*dsc == NULL);
 	*dsc = NULL;
 
+	if (pool->res_cap->num_dsc == pool->res_cap->num_opp) {
+		*dsc = pool->dscs[pipe_idx];
+		res_ctx->is_dsc_acquired[pipe_idx] = true;
+		return;
+	}
+
 	/* Find first free DSC */
 	for (i = 0; i < pool->res_cap->num_dsc; i++)
 		if (!res_ctx->is_dsc_acquired[i]) {
@@ -1468,7 +1475,7 @@ static enum dc_status add_dsc_to_stream_resource(struct dc *dc,
 		if (pipe_ctx->stream != dc_stream)
 			continue;
 
-		acquire_dsc(&dc_ctx->res_ctx, pool, &pipe_ctx->stream_res.dsc);
+		acquire_dsc(&dc_ctx->res_ctx, pool, &pipe_ctx->stream_res.dsc, i);
 
 		/* The number of DSCs can be less than the number of pipes */
 		if (!pipe_ctx->stream_res.dsc) {
@@ -1669,7 +1676,7 @@ static bool dcn20_split_stream_for_odm(
 	next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
 #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 	if (next_odm_pipe->stream->timing.flags.DSC == 1) {
-		acquire_dsc(res_ctx, pool, &next_odm_pipe->stream_res.dsc);
+		acquire_dsc(res_ctx, pool, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
 		ASSERT(next_odm_pipe->stream_res.dsc);
 		if (next_odm_pipe->stream_res.dsc == NULL)
 			return false;
-- 
2.20.1



