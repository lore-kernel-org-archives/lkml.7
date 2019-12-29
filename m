Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97C0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA97206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642924;
	bh=ehvcL/pHOM57FNFV9+Gcyx74XBJhRnSsmFb4AJnjk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zv0uuBTjUDK1xe2/5QhM5UzSbyDmbekbtdVJ4B00Po/PlIwPBS5/uG+Z0Qb5KeZir
	 w9D0Ruf07p2AMZx2zsus9+ptp5nG34TXr9CI9+OV93BebrnnQdbtqG4BC3okDDU5vq
	 5XvoJWAeJ4CAdtvOqjlAmlXA9S31P3wMkBwILK5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbfL2SIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:08:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbfL2RrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:47:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C8C206DB;
        Sun, 29 Dec 2019 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641619;
        bh=ehvcL/pHOM57FNFV9+Gcyx74XBJhRnSsmFb4AJnjk3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xAFzqrmlmKYKORirjgQoycx86BU4LE8LFFq0PpCwCNDAsKdJg1dcAw/QTTJp6GvZu
         gRNbBtCXR1ceuRLsqJBa6fWtjvFfglV9s46GbQRdSNi2bJXMGb+on7OhqHgmk1lKcS
         PKdWsb3odFmURtgnUqPct2OVdxTQfqfgaLskjfKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Parkin <julian.parkin@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 140/434] drm/amd/display: Program DWB watermarks from correct state
Date:   Sun, 29 Dec 2019 18:23:13 +0100
Message-Id: <20191229172711.028798845@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Parkin <julian.parkin@amd.com>

[ Upstream commit edb922b022c0c94805c4ffad202b3edff83d76f0 ]

[Why]
When diags adds a DWB via a stream update, we calculate MMHUBBUB
paramaters, but dc->current_state has not yet been updated
when the DWB programming happens. This leads to overflow on
high bandwidth tests since the incorrect MMHUBBUB arbitration
parameters are programmed.

[How]
Pass the updated context down to the (enable|update)_writeback functions
so that they can use the correct watermarks when programming MMHUBBUB.

Signed-off-by: Julian Parkin <julian.parkin@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 5 +++--
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  | 6 ++++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index bf1d7bb90e0f..bb09243758fe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -423,10 +423,10 @@ bool dc_stream_add_writeback(struct dc *dc,
 
 		if (dwb->funcs->is_enabled(dwb)) {
 			/* writeback pipe already enabled, only need to update */
-			dc->hwss.update_writeback(dc, stream_status, wb_info);
+			dc->hwss.update_writeback(dc, stream_status, wb_info, dc->current_state);
 		} else {
 			/* Enable writeback pipe from scratch*/
-			dc->hwss.enable_writeback(dc, stream_status, wb_info);
+			dc->hwss.enable_writeback(dc, stream_status, wb_info, dc->current_state);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b3ae1c41fc69..937a8ba81160 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1356,7 +1356,8 @@ bool dcn20_update_bandwidth(
 static void dcn20_enable_writeback(
 		struct dc *dc,
 		const struct dc_stream_status *stream_status,
-		struct dc_writeback_info *wb_info)
+		struct dc_writeback_info *wb_info,
+		struct dc_state *context)
 {
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
@@ -1373,7 +1374,7 @@ static void dcn20_enable_writeback(
 	optc->funcs->set_dwb_source(optc, wb_info->dwb_pipe_inst);
 	/* set MCIF_WB buffer and arbitration configuration */
 	mcif_wb->funcs->config_mcif_buf(mcif_wb, &wb_info->mcif_buf_params, wb_info->dwb_params.dest_height);
-	mcif_wb->funcs->config_mcif_arb(mcif_wb, &dc->current_state->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[wb_info->dwb_pipe_inst]);
+	mcif_wb->funcs->config_mcif_arb(mcif_wb, &context->bw_ctx.bw.dcn.bw_writeback.mcif_wb_arb[wb_info->dwb_pipe_inst]);
 	/* Enable MCIF_WB */
 	mcif_wb->funcs->enable_mcif(mcif_wb);
 	/* Enable DWB */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 3a938cd414ea..f6cc2d6f576d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -321,10 +321,12 @@ struct hw_sequencer_funcs {
 			struct dc_state *context);
 	void (*update_writeback)(struct dc *dc,
 			const struct dc_stream_status *stream_status,
-			struct dc_writeback_info *wb_info);
+			struct dc_writeback_info *wb_info,
+			struct dc_state *context);
 	void (*enable_writeback)(struct dc *dc,
 			const struct dc_stream_status *stream_status,
-			struct dc_writeback_info *wb_info);
+			struct dc_writeback_info *wb_info,
+			struct dc_state *context);
 	void (*disable_writeback)(struct dc *dc,
 			unsigned int dwb_pipe_inst);
 #endif
-- 
2.20.1



