Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AFD24F9B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559188893;
	bh=6er5g/8CYKetSS9XvwMOYRCiloLvfcJOKlkvmk3cSYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Asvj9V5CDrYNdiiqXinqPO82Z6PsHsLqZ8zbGOxzAHKkBoE1Jfcjzsor7gJpWnqui
	 bID79IPb8ToXBjr+5O+zqgjXQzOLaCTeTPndyz14Krr7liQJENTCntJnJK9/ft8Otn
	 eQscChvMJu8DSkMDN1MozAUgysvNh8GNWWMsy9yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfE3EBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731433AbfE3DSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:18:09 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4C324771;
        Thu, 30 May 2019 03:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186288;
        bh=6er5g/8CYKetSS9XvwMOYRCiloLvfcJOKlkvmk3cSYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FAXThNxsTkrVUSUsVais8Tk2gIXlbmzduap+rvqMWbGfJIDlSyvl69Zqk9/XXzpSG
         OSorOOzjyxHB0euanVPYkrQJCZ+vFmyTtuvTxoJ1fLEFnXpKi6r+jghFgplZBd+EKF
         GjtFhNmtEZK5NBLSPDuDDythuP5pRF8g7LlGDwOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 244/276] drm/amd/display: fix releasing planes when exiting odm
Date:   Wed, 29 May 2019 20:06:42 -0700
Message-Id: <20190530030540.397421697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
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
index 87bf422f16be7..e0a96abb3c46c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1401,10 +1401,12 @@ bool dc_remove_plane_from_context(
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



