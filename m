Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D2C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E6825A27
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191324;
	bh=CIHmdRTyjfVrqhEEIJ0lP/fh2r6sHqT6+NJh9ac4LBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4XaPN0ZZWOswbGUYx9qUlOxaELvY+L5J1iy9fXRJgoRoc2rdlrZtc0VM8Oz4ciB6
	 zZ0VnlL4ngLNJtRDSbazx4tVvmjgdtYt4+qvCpGu2JaIWfTruioyu3VLxaXBpG/lp1
	 Gzui1G9uzbfeiaLsHF0VEIWdmzo3+Vngz19EtQPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbfE3EmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbfE3DMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:21 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E052244C4;
        Thu, 30 May 2019 03:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185940;
        bh=CIHmdRTyjfVrqhEEIJ0lP/fh2r6sHqT6+NJh9ac4LBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgMBczc2pfYn0M/4mzC83L8vz1lDjLPhea32O7TFNWh94WYcgrCsY6DKAVYVmfDFN
         9mngfhl6WDrGWpZFaYxx9HI2ywvDidUJfR/zvFTrfJx+zA2R1x1EH5zJ51Ay2QpqlB
         u4bZxyDfJyOzs7tdONDsTyEUPGGYSV04Eoyldf3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenjing Liu <Wenjing.Liu@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 346/405] drm/amd/display: add pipe lock during stream update
Date:   Wed, 29 May 2019 20:05:44 -0700
Message-Id: <20190530030558.190471208@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e6bddf6c67f9a3abf6f1ef75e52bc1cd228dfe4d ]

[why]
Stream update will adjust both info packets and stream params,
need to make sure all things are applied togather.

[how]
add pipe lock during stream update

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c1a308c1dcbea..88fe4fb43bfd5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1677,6 +1677,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				continue;
 
 			if (stream_update->dpms_off) {
+				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
 				if (*stream_update->dpms_off) {
 					core_link_disable_stream(pipe_ctx, KEEP_ACQUIRED_RESOURCE);
 					dc->hwss.optimize_bandwidth(dc, dc->current_state);
@@ -1684,6 +1685,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					dc->hwss.prepare_bandwidth(dc, dc->current_state);
 					core_link_enable_stream(dc->current_state, pipe_ctx);
 				}
+				dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
-- 
2.20.1



