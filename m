Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4803C10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9152080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383647;
	bh=R/jTEcosIgI42IvSWc1LupVsH5P7htvyBIlQkVgNgvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YU3HDGSXc2g8Ae+tfDzxh7ckMoY0c+lV5i7aLIahRWhawqKptTS3udKcqYdGTj8/j
	 CIrFJgFrvmxmwzRsisl+CkfPBMri0Q09QoeKMKwTnKOYyr0p14Ou9bCzfg6dQBGp7D
	 Y1Vr7yp/+VIwEgLznvarUWsPZNMMB1BTP/3iQGNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfJFRkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbfJFRkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:40:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5685A20700;
        Sun,  6 Oct 2019 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383641;
        bh=R/jTEcosIgI42IvSWc1LupVsH5P7htvyBIlQkVgNgvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB0OdHzRIEXQL81pFtsx5vCMgoun4xf+eMYIRfqaN5Ha4a1INwNFNTHlvFHiSX7jh
         JWW/ycF9MgPqeOPplZ8PYFgLdDp8v9/lOjKL2nUzy04P1tBsLYmKSHVEmvjdzhzDqC
         KssJWHdKxAXu6Ob9/Y5v0EVxRgUGr5TXZU4307W8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Sung Chung <Su.Chung@amd.com>,
        Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 008/166] drm/amd/display: fix not calling ppsmu to trigger PME
Date:   Sun,  6 Oct 2019 19:19:34 +0200
Message-Id: <20191006171213.380091770@linuxfoundation.org>
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

From: Su Sung Chung <Su.Chung@amd.com>

[ Upstream commit 18b401874aee10c80b5745c9b93280dae5a59809 ]

[why]
dcn20_clk_mgr_construct was not initializing pp_smu, and PME call gets
filtered out by the null check

[how]
initialize pp_smu dcn20_clk_mgr_construct

Signed-off-by: Su Sung Chung <Su.Chung@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 50bfb5921de07..2ab0f97719b5a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -348,6 +348,8 @@ void dcn20_clk_mgr_construct(
 
 	clk_mgr->base.dprefclk_khz = 700000; // 700 MHz planned if VCO is 3.85 GHz, will be retrieved
 
+	clk_mgr->pp_smu = pp_smu;
+
 	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
 		dcn2_funcs.update_clocks = dcn2_update_clocks_fpga;
 		clk_mgr->dentist_vco_freq_khz = 3850000;
-- 
2.20.1



