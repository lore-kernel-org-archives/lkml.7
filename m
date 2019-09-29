Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E6CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CCE21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765804;
	bh=/N4BNUim2ujhrBzUpyfOBCNZJx17ZezEr41HEe4TTRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6v/mD+g5awEXZHOgbhQn4kliTC+xfgrpK3sLlmBBETWmE3di4osKAzxA4Y84KIVj
	 g70TuVKoiB7gohuLhaH8OP4Z36kfTRUXZ/wPllGNSUDdtusLzxX7AFS2Cj9ND/ZnqM
	 Fe7+aUd0pMwLoJioS0wOVmaRr5scHscLajHnLRu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfI2ODX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbfI2ODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92CC021835;
        Sun, 29 Sep 2019 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765800;
        bh=/N4BNUim2ujhrBzUpyfOBCNZJx17ZezEr41HEe4TTRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wb/1j+mOpDKVy2g3+fqEzxh8CuAaw0mKQTavCxCEXPoNFQDycGEBg//V3P3SkI4Te
         BwEX3wbctnQRgWSVV5eT674I2g2vD4CKVmtkQ3gK7aiHpg9Axx1PHyh6dMvfuYGpge
         z1h1HoHXRA2gPal55WeI6/Q3PNffFYD/coTd3FfQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.3 17/25] clk: imx: imx8mm: fix audio pll setting
Date:   Sun, 29 Sep 2019 15:56:20 +0200
Message-Id: <20190929135015.896738113@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 053a4ffe298836bb973d2cba59f82fff60c7db5b upstream.

The AUDIO PLL max support 650M, so the original clk settings violate
spec. This patch makes the output 786432000 -> 393216000,
and 722534400 -> 361267200 to aligned with NXP vendor kernel without any
impact on audio functionality and go within 650MHz PLL limit.

Cc: <stable@vger.kernel.org>
Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-imx8mm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -55,8 +55,8 @@ static const struct imx_pll14xx_rate_tab
 };
 
 static const struct imx_pll14xx_rate_table imx8mm_audiopll_tbl[] = {
-	PLL_1443X_RATE(786432000U, 655, 5, 2, 23593),
-	PLL_1443X_RATE(722534400U, 301, 5, 1, 3670),
+	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
+	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
 
 static const struct imx_pll14xx_rate_table imx8mm_videopll_tbl[] = {


