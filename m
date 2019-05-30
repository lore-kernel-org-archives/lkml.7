Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39218C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED40252CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189946;
	bh=E/EYYlcgbQtQS2gTJGEww6lOw4QQeGZBhvt4msuHt0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqTiBDXlw+hGZoXzG0iV/9HPDUkZGu/EoF/JS9SDpNQxbzPmrel2dr36EJt9+QG6P
	 7Y65Bn9F7+o9AFGlzAr5W2+Op01SWwyjk4yPw571sCMZY1EN/ZXbHADCp3MUfKUVol
	 Vj9KB9Q6eEH0qcMcjRY9pdE71aBDoF7ainb2cX4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfE3ETE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:19:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbfE3DP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:28 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA10224557;
        Thu, 30 May 2019 03:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186127;
        bh=E/EYYlcgbQtQS2gTJGEww6lOw4QQeGZBhvt4msuHt0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9e5X6ny16Tlosap+d2Braqi8Hji8HthIDKTRfKT3S9F+3Cbg8gDhMxKl/RNtNsil
         wFwv0+sZ+kieNBMzGFagWeOs6bi9Zg2Q9lNbaeeWbBGFzer9/t/0AHjQjSYdlyEbNL
         MURIpq6awKEPh6na2AMVDxBRuPBpUnIlxQQzqlLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 288/346] drm/amd/display: fix releasing planes when exiting odm
Date:   Wed, 29 May 2019 20:06:01 -0700
Message-Id: <20190530030555.482788966@linuxfoundation.org>
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

[ Upstream commit bc2193992b00488f5734613ac95b78ef2d2803ab ]

Releasing planes should not release the 2nd odm pipe right away,
this change leaves us with 2 pipes with null planes and same stream
when planes are released during odm.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 76137df74a535..c6aa80d7e639b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1266,10 +1266,12 @@ bool dc_remove_plane_from_context(
 			 * For head pipe detach surfaces from pipe for tail
 			 * pipe just zero it out
 			 */
-			if (!pipe_ctx->top_pipe) {
+			if (!pipe_ctx->top_pipe ||
+				(!pipe_ctx->top_pipe->top_pipe &&
+					pipe_ctx->top_pipe->stream_res.opp != pipe_ctx->stream_res.opp)) {
 				pipe_ctx->plane_state = NULL;
 				pipe_ctx->bottom_pipe = NULL;
-			} else  {
+			} else {
 				memset(pipe_ctx, 0, sizeof(*pipe_ctx));
 			}
 		}
-- 
2.20.1



