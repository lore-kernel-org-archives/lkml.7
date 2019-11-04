Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70ACCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8888E217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904763;
	bh=sP7BL7tqYErBOvL8W0EM0ifrxBAL2ZwmaMUBXDKCsdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2A014y/YC6D95BwsVub6kFdUhOROqWgK9Izga7l7EG769bFPZaWY/kL5Z/KkHslCu
	 WSV58bcR2frFS+rfmzLgHFPJMslZDzr/jlPzCNPsey3G+M0rllM/3tEMK7wg+NxVz6
	 oPXvOdsDoc6hp0GgkwP4K+LDq22vCQbDp3e8fsVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbfKDV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfKDV7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:59:09 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C438520659;
        Mon,  4 Nov 2019 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904749;
        bh=sP7BL7tqYErBOvL8W0EM0ifrxBAL2ZwmaMUBXDKCsdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x8tYiGklybRxgLqrTEvTdZewwLO7TvHBKBfXAsSTmO5EOOLW2Y8iTtiPV3sHD0MWR
         RLQakrmRTFmvFWGu3i3wtTkmTHyO9qu7uJObopbnOrfty2YOE5Sg0pjF55qP9VbfV1
         /qM3ucEOsAGPCYd/jfXG9HzRpCLuz7RR+xvSU/Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/149] drm/amd/display: fix odm combine pipe reset
Date:   Mon,  4 Nov 2019 22:44:09 +0100
Message-Id: <20191104212140.255532616@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[ Upstream commit f25f06b67ba237b76092a6fc522b1a94e84bfa85 ]

We fail to reset the second odm combine pipe. This change fixes
odm pointer management.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d440b28ee43fb..6896d69b8c240 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1399,9 +1399,9 @@ bool dc_remove_plane_from_context(
 			 * For head pipe detach surfaces from pipe for tail
 			 * pipe just zero it out
 			 */
-			if (!pipe_ctx->top_pipe ||
-				(!pipe_ctx->top_pipe->top_pipe &&
+			if (!pipe_ctx->top_pipe || (!pipe_ctx->top_pipe->top_pipe &&
 					pipe_ctx->top_pipe->stream_res.opp != pipe_ctx->stream_res.opp)) {
+				pipe_ctx->top_pipe = NULL;
 				pipe_ctx->plane_state = NULL;
 				pipe_ctx->bottom_pipe = NULL;
 			} else {
@@ -1803,8 +1803,6 @@ enum dc_status dc_remove_stream_from_ctx(
 				dc->res_pool->funcs->remove_stream_from_ctx(dc, new_ctx, stream);
 
 			memset(del_pipe, 0, sizeof(*del_pipe));
-
-			break;
 		}
 	}
 
-- 
2.20.1



