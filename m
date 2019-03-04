Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49617C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47E21741
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688093;
	bh=n6PtKROm5WM8bxvM3VD98jbyhx87dhXle5jBhUnu5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLmLuZF5cPzXFdsONmIs1SsRTXDAOUTVfwJ3L96CCvIuC2ohT4XvJdc0PItLS+FxJ
	 7fTYSMytKXQxqDIcgGoMelf9lGHNFiehfMR13VuvSgWmUu5Fxo8uWO3ZYC38JZWuVq
	 yklaA2iEJJr6N+V68wHSpnx6P/31aHAQ+Fr2zSK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCDI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:28:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfCDI2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:28:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23723208E4;
        Mon,  4 Mar 2019 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688082;
        bh=n6PtKROm5WM8bxvM3VD98jbyhx87dhXle5jBhUnu5RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCpFsQMRL/3axYj9iD20IClaLuTuYCJbShppL3ab4+yuDI6UswAkDrv8gTxNhxY9c
         JRbEX8TklEHvmOqqlDeeynl4vfhTvJJ1m9hbbc3ihAhYYs5byYfq6suXnY6xyg0XUz
         wNje1dszT0napYnR3ZzYfAk8nDU95tOU0/8fGxR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Alexey Firago <alexey_firago@mentor.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 12/78] clk: vc5: Abort clock configuration without upstream clock
Date:   Mon,  4 Mar 2019 09:21:55 +0100
Message-Id: <20190304081626.050114036@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2137a109a5e39c2bdccfffe65230ed3fadbaac0e ]

In case the upstream clock are not set, which can happen in case the
VC5 has no valid upstream clock, the $src variable is used uninited
by regmap_update_bits(). Check for this condition and return -EINVAL
in such case.

Note that in case the VC5 has no valid upstream clock, the VC5 can
not operate correctly. That is a hardware property of the VC5. The
internal oscilator present in some VC5 models is also considered
upstream clock.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Alexey Firago <alexey_firago@mentor.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org
[sboyd@kernel.org: Added comment about probe preventing this from
happening in the first place]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-versaclock5.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index decffb3826ece..a738af893532f 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -262,8 +262,10 @@ static int vc5_mux_set_parent(struct clk_hw *hw, u8 index)
 
 		if (vc5->clk_mux_ins == VC5_MUX_IN_XIN)
 			src = VC5_PRIM_SRC_SHDN_EN_XTAL;
-		if (vc5->clk_mux_ins == VC5_MUX_IN_CLKIN)
+		else if (vc5->clk_mux_ins == VC5_MUX_IN_CLKIN)
 			src = VC5_PRIM_SRC_SHDN_EN_CLKIN;
+		else /* Invalid; should have been caught by vc5_probe() */
+			return -EINVAL;
 	}
 
 	return regmap_update_bits(vc5->regmap, VC5_PRIM_SRC_SHDN, mask, src);
-- 
2.19.1



