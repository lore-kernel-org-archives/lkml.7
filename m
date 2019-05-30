Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A1FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D6248C6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186382;
	bh=MlcUk6G72+uvbk4USYC2xUeg1qIwVYA88yJIJcr6nNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=prGcrTgfzENY38N/q4isvuGv1id1ARw0XK0mxHiu1EhQh0G7aKjJlyUNeO/bT5ZWx
	 XS2YeC6vpopB9vGevbW36oXZNqqFQ6dvKAK01GdDet0aKExuVM+mHKvxdRlFkJootw
	 uOofIKk2CLFZZIfLvgLlWwrhvvcF4MZc6wU3OGCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfE3DTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbfE3DPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC7F245A7;
        Thu, 30 May 2019 03:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186135;
        bh=MlcUk6G72+uvbk4USYC2xUeg1qIwVYA88yJIJcr6nNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RToj5ge8iT+Fe056ROxAUho0H/sw1jSR2bw6FEExuAPqWjZHVwYT+GKBkFh9Ijbgx
         UHuQ53wJXysBM/t6+A6xesMbcZgxQyIsqjrq0mDK7L48pkVAql5Bsp3F/pP2TLWuOb
         IWPODsiCRzcVMXtZHZFyrPWdXj+Vfqq2dVVmP/us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenjing Liu <Wenjing.Liu@amd.com>,
        Jun Lei <Jun.Lei@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 300/346] drm/amd/display: add pipe lock during stream update
Date:   Wed, 29 May 2019 20:06:13 -0700
Message-Id: <20190530030556.048112041@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
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
index 68529acba015f..c0db7788c4641 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1511,6 +1511,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				continue;
 
 			if (stream_update->dpms_off) {
+				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
 				if (*stream_update->dpms_off) {
 					core_link_disable_stream(pipe_ctx, KEEP_ACQUIRED_RESOURCE);
 					dc->hwss.optimize_bandwidth(dc, dc->current_state);
@@ -1518,6 +1519,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					dc->hwss.prepare_bandwidth(dc, dc->current_state);
 					core_link_enable_stream(dc->current_state, pipe_ctx);
 				}
+				dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
-- 
2.20.1



