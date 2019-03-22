Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42471C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1248321916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254644;
	bh=VCjzVkkQedvvF9a9APv5XXf/VthrJiMGGFcPf1lMLQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJPVCXZwbWsB/+6gAM+HugeTLEPRqWho6rQLdDRRhliiKL9pd69TIRnfl/m4QYdk1
	 M0XN3WKpFjm+UkChxFfmUIFDndeVJjzmi0aBUjXO4scfpgM7/troDrJGEvet9vEgpc
	 gSXbmOl39LuZchoHdsRcIy81tlqHlvNKyL4cp1Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfCVLhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbfCVLhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:37:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013572082C;
        Fri, 22 Mar 2019 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254638;
        bh=VCjzVkkQedvvF9a9APv5XXf/VthrJiMGGFcPf1lMLQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJMR4Awq3Gch+G5ClPcFz/v9jrg7RkY/XixEM52HdCsL+1fhe4xV6ik5mgyljPIXx
         d8zT8FH6zkDzaAYzVmdLeZOamvJMiFrlnKasC2MHkhs2rNEN0Hy4NDNmygvvYosdxg
         hQGG+Pu8jUfs0wbZZ0/TbtzF4iLnpKJzfMtyTEuc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.4 197/230] clk: ingenic: Fix round_rate misbehaving with non-integer dividers
Date:   Fri, 22 Mar 2019 12:15:35 +0100
Message-Id: <20190322111250.653480077@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Cercueil <paul@crapouillou.net>

commit bc5d922c93491878c44c9216e9d227c7eeb81d7f upstream.

Take a parent rate of 180 MHz, and a requested rate of 4.285715 MHz.
This results in a theorical divider of 41.999993 which is then rounded
up to 42. The .round_rate function would then return (180 MHz / 42) as
the clock, rounded down, so 4.285714 MHz.

Calling clk_set_rate on 4.285714 MHz would round the rate again, and
give a theorical divider of 42,0000028, now rounded up to 43, and the
rate returned would be (180 MHz / 43) which is 4.186046 MHz, aka. not
what we requested.

Fix this by rounding up the divisions.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Maarten ter Huurne <maarten@treewalker.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ingenic/cgu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -355,16 +355,16 @@ ingenic_clk_round_rate(struct clk_hw *hw
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info;
-	long rate = *parent_rate;
+	unsigned int div = 1;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 
 	if (clk_info->type & CGU_CLK_DIV)
-		rate /= ingenic_clk_calc_div(clk_info, *parent_rate, req_rate);
+		div = ingenic_clk_calc_div(clk_info, *parent_rate, req_rate);
 	else if (clk_info->type & CGU_CLK_FIXDIV)
-		rate /= clk_info->fixdiv.div;
+		div = clk_info->fixdiv.div;
 
-	return rate;
+	return DIV_ROUND_UP(*parent_rate, div);
 }
 
 static int
@@ -384,7 +384,7 @@ ingenic_clk_set_rate(struct clk_hw *hw,
 
 	if (clk_info->type & CGU_CLK_DIV) {
 		div = ingenic_clk_calc_div(clk_info, parent_rate, req_rate);
-		rate = parent_rate / div;
+		rate = DIV_ROUND_UP(parent_rate, div);
 
 		if (rate != req_rate)
 			return -EINVAL;


