Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70698C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518875;
	bh=ocD4bQVfU34clq9XV0vAaLnR4EBaOvgJRFKXhOMifqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcHle2qKtWmVdW1UOyLOiTLK8BOxKKg+rmnQDQHLrZyhN9pPnnjcKsPELHGtW3mvh
	 58XpPlMgeH/hZLZ7dnIupNZL0siY+XnDdSBlCyNlqGNCUHshOi5oUra1e365DkuE42
	 EhGkEU590yq3CfHzSlhf929RiQCgMaH6GfVTIxCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfLPRye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfLPRy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3F9C20733;
        Mon, 16 Dec 2019 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518869;
        bh=ocD4bQVfU34clq9XV0vAaLnR4EBaOvgJRFKXhOMifqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7eFqJf2U2wI1KeFPu4q/TsiMG3igwNGhpQ793FdxpQYwUPovyGsvEFdI54V8wU9l
         yyhK6goairFrIPv5I0ivzUFbe5DA+EEIRnlpDAfSOlnI7Jz6A2P+SGHQMklTh0qIJF
         ujzpwLkTMUi7Q5yvB2C0l9bo0fs7eudMnSK7kt+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/267] clk: sunxi-ng: h3/h5: Fix CSI_MCLK parent
Date:   Mon, 16 Dec 2019 18:47:05 +0100
Message-Id: <20191216174902.141828142@linuxfoundation.org>
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

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 7bb7d29cffdd24bf419516d14b6768591e74069e ]

The third parent of CSI_MCLK is PLL_PERIPH1, not PLL_PERIPH0.
Fix it.

Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 1729ff6a5aaed..b09acda71abe9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -460,7 +460,7 @@ static const char * const csi_sclk_parents[] = { "pll-periph0", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk", csi_sclk_parents,
 				 0x134, 16, 4, 24, 3, BIT(31), 0);
 
-static const char * const csi_mclk_parents[] = { "osc24M", "pll-video", "pll-periph0" };
+static const char * const csi_mclk_parents[] = { "osc24M", "pll-video", "pll-periph1" };
 static SUNXI_CCU_M_WITH_MUX_GATE(csi_mclk_clk, "csi-mclk", csi_mclk_parents,
 				 0x134, 0, 5, 8, 3, BIT(15), 0);
 
-- 
2.20.1



