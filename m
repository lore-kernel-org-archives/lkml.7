Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79855C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4000F2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079434;
	bh=vOkcwzGxcrqH8Avf80bvLOHtmYPdbSJE+fQOgD6vOyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYa1LT46tZhzOTNuMCs609CQMJiYlIHkLOOw20c19a3iIJZVlUDAbFqroYuV7sLe6
	 cYNbaELJ0QTWsA/rnYELPlcjgiC6HbXYwW2RkeE1hrxq6+U4SWu5yadZoW51b7pua/
	 QmBeuH/8PDVD4wwwMCVE6nmtmV3FHsWSQpfQOc70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfLKPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732184AbfLKPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:23:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF7F2073D;
        Wed, 11 Dec 2019 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077789;
        bh=vOkcwzGxcrqH8Avf80bvLOHtmYPdbSJE+fQOgD6vOyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvBbD6ILA8UyClExdGpBy6Adzx7lhPIHAits3hBpmUfsFBYsh0sc1VgvvJvRhr/f8
         vj9QzqEqVfzVtQxWDj+Ca20oyuKoW6DCI9pD8GHNvFcDw/RGb7cVtKw9AG/vEk29H3
         Z0FzHS4HmsBzlVLdat73cgALGaZoyQ5zLsrYr0SA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 171/243] clk: renesas: r8a77990: Correct parent clock of DU
Date:   Wed, 11 Dec 2019 16:05:33 +0100
Message-Id: <20191211150350.722636762@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

[ Upstream commit 7cf3a216a2b3a672cad3e498c186c9333bdff90a ]

According to the R-Car Gen3 Hardware Manual Rev 1.00, the parent clock
of the DU module clocks on R-Car E3 is S1D1.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: 3570a2af473789c5 ("clk: renesas: cpg-mssr: Add support for R-Car E3")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index 9e14f1486fbb9..81569767025cc 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -175,8 +175,8 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("ehci0",		 703,	R8A77990_CLK_S3D4),
 	DEF_MOD("hsusb",		 704,	R8A77990_CLK_S3D4),
 	DEF_MOD("csi40",		 716,	R8A77990_CLK_CSI0),
-	DEF_MOD("du1",			 723,	R8A77990_CLK_S2D1),
-	DEF_MOD("du0",			 724,	R8A77990_CLK_S2D1),
+	DEF_MOD("du1",			 723,	R8A77990_CLK_S1D1),
+	DEF_MOD("du0",			 724,	R8A77990_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A77990_CLK_S2D1),
 
 	DEF_MOD("vin5",			 806,	R8A77990_CLK_S1D2),
-- 
2.20.1



