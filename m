Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA476C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A7205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518979;
	bh=sSQGXtUBwq1HgWZiNGj8oNP9wbdZB0MTUIajG+SdqIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfiyviUauZIkM8GZb9Vdb+5Rc2nWPXiRd3knAiaNaI/nrKKXthEiOfpNY2tlb68NX
	 GIiXe27fkiV8rp8Nn3FJTRluBka6u53fNOxgq4+yGibOSMCEh83KaAXARVx2a6ZsIU
	 X8Zx0UEyBIA8M7rQCi8YD0F8fYEdaJhX+NOehfXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfLPR4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbfLPR4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583F0205ED;
        Mon, 16 Dec 2019 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518973;
        bh=sSQGXtUBwq1HgWZiNGj8oNP9wbdZB0MTUIajG+SdqIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOBAAE7cZjZLpDcffcP3vB3w5DG4RAy7ZhZmUb/CGest0gZhDMPD8fIPTZQkSPATq
         iV/x0WEN09LdwHe1Ar4z/mKLsdQmeAa/FR9WnZNsHoTBiLqhGv+yXpddcNSenUCOCQ
         rOiwS0TE4FCOKWTJKCcK7HznCFyCFuULYtGLwDCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 105/267] clk: renesas: r8a77995: Correct parent clock of DU
Date:   Mon, 16 Dec 2019 18:47:11 +0100
Message-Id: <20191216174902.474889166@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 515b2915ee08060ad4f6a3b3de38c5c2c5258e8b ]

According to the R-Car Gen3 Hardware Manual Rev 1.00, the parent clock
of the DU module clocks on R-Car D3 is S1D1.

Fixes: d71e851d82c6cfe5 ("clk: renesas: cpg-mssr: Add R8A77995 support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index e594cf8ee63b6..8434d5530fb15 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -141,8 +141,8 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("vspbs",		 627,	R8A77995_CLK_S0D1),
 	DEF_MOD("ehci0",		 703,	R8A77995_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A77995_CLK_S3D2),
-	DEF_MOD("du1",			 723,	R8A77995_CLK_S2D1),
-	DEF_MOD("du0",			 724,	R8A77995_CLK_S2D1),
+	DEF_MOD("du1",			 723,	R8A77995_CLK_S1D1),
+	DEF_MOD("du0",			 724,	R8A77995_CLK_S1D1),
 	DEF_MOD("lvds",			 727,	R8A77995_CLK_S2D1),
 	DEF_MOD("vin7",			 804,	R8A77995_CLK_S1D2),
 	DEF_MOD("vin6",			 805,	R8A77995_CLK_S1D2),
-- 
2.20.1



