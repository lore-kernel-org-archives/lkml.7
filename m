Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4149AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96520700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383691;
	bh=102bwutzRxcs2V9RTN9Y+pSZKhS2+svPGHXK6ShtJ24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6omIW8WsmBvGIAmYPQSjsttFXI6+2RTc27QCIa0VW57YS7AIEkj9idno6fLepWyI
	 PbHLulBcOdfo9eRQoT2bS349/jAwofv/NOQqxCMYbohvCkY+zP8zgFa4zeoMgZj9b1
	 OJF1F05SZaQFwzq9A5w+fqtDz6zNs4q74VISPoMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfJFRla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbfJFRlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:41:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EB320700;
        Sun,  6 Oct 2019 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383684;
        bh=102bwutzRxcs2V9RTN9Y+pSZKhS2+svPGHXK6ShtJ24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UoHGKG0Gzb2ity1HtzC20if8rtvs+mpyw/WNgLQvHriRxjLJBYAe2MV6Sr/bpv4gg
         TcFyoOd/uJ5jIqaUbu1iComSPOon8pf2SniYu6qAVWsU5TPThemy0MPoNEaF9Dg0sr
         9hZA0p9uH2wMvse/YQTtKDL/BLYvgCbxpTCkpwVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zi Yu Liao <ziyu.liao@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 057/166] drm/amd/display: fix MPO HUBP underflow with Scatter Gather
Date:   Sun,  6 Oct 2019 19:20:23 +0200
Message-Id: <20191006171217.910059397@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yu Liao <ziyu.liao@amd.com>

[ Upstream commit 89cb5614736b9b5d3b833ca2237d10da6b4b0395 ]

[why]
With Scatter Gather enabled, HUBP underflows during MPO enabled video
playback. hubp_init has a register write that fixes this problem, but
the register is cleared when HUBP gets power gated.

[how]
Make a call to hubp_init during enable_plane, so that the fix can
be applied after HUBP powers back on again.

Signed-off-by: Zi Yu Liao <ziyu.liao@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f8abe98a576be..8fdb53a44bfb3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1110,6 +1110,9 @@ void dcn20_enable_plane(
 	/* enable DCFCLK current DCHUB */
 	pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl(pipe_ctx->plane_res.hubp, true);
 
+	/* initialize HUBP on power up */
+	pipe_ctx->plane_res.hubp->funcs->hubp_init(pipe_ctx->plane_res.hubp);
+
 	/* make sure OPP_PIPE_CLOCK_EN = 1 */
 	pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control(
 			pipe_ctx->stream_res.opp,
-- 
2.20.1



