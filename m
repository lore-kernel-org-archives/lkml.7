Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6015C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8732457F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186124;
	bh=64YVpBKbQ6cl3JEdzie9z2NZtDnvSDmVNbTanJeWREI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2Yd+xo4P9cpWjPNq8c4rIFfRqPh9Yo88maa1KLugdKJCDEoeZKzLfeJRAfBkBaUv
	 VbfYa14JFRHviblYvvvjjE93Swr+93bvinazoGQvl61ovm6eOckpdWolDGCxccKKrx
	 BeRBdS6xFq3cwsqw6Oo77gqQ9tu6XUwHri/u+wFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfE3DPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbfE3DMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:47 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CBE21BE2;
        Thu, 30 May 2019 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185967;
        bh=64YVpBKbQ6cl3JEdzie9z2NZtDnvSDmVNbTanJeWREI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zvj2VTacL34Xst7InSkxE/21qHNRSXh82Nk9yDMmMwIU+PHJrNw/OKKT3uRoH5yMA
         yJXYEPuSiYp8w8bHsZgcQdJv8h94HRYFQNXm2cWjaCiEmeVRfbCDSVbP7T1XJTG42J
         ycIH12ygEpQKd/CNrJ48LR9EN1O4aGiXe8TfxXjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 396/405] drm/amd/display: Reset planes that were disabled in init_pipes
Date:   Wed, 29 May 2019 20:06:34 -0700
Message-Id: <20190530030600.624638663@linuxfoundation.org>
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

[ Upstream commit 4bc46da4a3aeeb4d55e83dd276cf72756e908286 ]

[Why]
Seamless boot tries to reuse planes that were enabled for the first
commit applied.

In the case where Raven is booting with two monitors connected and the
first commit contains two streams the screen corruption would occur
because the second stream was trying to re-use a tg and plane that
weren't previously enabled.

The state on the first commit looks something like the following:

TG0: enabled=1
TG1: enabled=0
TG2: enabled=0
TG3: enabled=0

New state: pipe=0, stream=0,    plane=0,       new_tg=0
New state: pipe=1, stream=1,    plane=1,       new_tg=1
New state: pipe=2, stream=NULL, plane=NULL,    new_tg=NULL
New state: pipe=3, stream=NULL, plane=NULL,    new_tg=NULL

Only one plane/tg is setup before we enter accelerated mode so
we really want to disabling everything but that first plane.

[How]

Check if the stream is not NULL and if the tg is enabled before
deciding whether to skip the plane disable.

Also ensure we're also disabling on the current state's pipe_ctx so
we don't overwrite the fields in the new pending state.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 401ea9561618e..5b551a544e82d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1008,9 +1008,14 @@ static void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 		 * to non-preferred front end. If pipe_ctx->stream is not NULL,
 		 * we will use the pipe, so don't disable
 		 */
-		if (pipe_ctx->stream != NULL)
+		if (pipe_ctx->stream != NULL &&
+		    pipe_ctx->stream_res.tg->funcs->is_tg_enabled(
+			    pipe_ctx->stream_res.tg))
 			continue;
 
+		/* Disable on the current state so the new one isn't cleared. */
+		pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
 		dpp->funcs->dpp_reset(dpp);
 
 		pipe_ctx->stream_res.tg = tg;
-- 
2.20.1



