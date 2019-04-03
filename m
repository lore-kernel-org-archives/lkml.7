Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6106C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10DC2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDCJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:42:38 -0400
Received: from regular1.263xmail.com ([211.150.70.201]:52044 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDCJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:42:38 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.130])
        by regular1.263xmail.com (Postfix) with ESMTP id 891D630D;
        Wed,  3 Apr 2019 17:42:35 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18217T139987412580096S1554284546411238_;
        Wed, 03 Apr 2019 17:42:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8bf4afa24df6c8ebd83ad45a928975ab>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 4/6] clk: rockchip: add a clock-type for muxes based in the pmugrf
Date:   Wed,  3 Apr 2019 17:42:27 +0800
Message-Id: <1554284549-24916-5-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip socs often have some tiny number of muxes not controlled from
the core clock controller but through bits set in the pmugrf.
Use MUXPMUGRF() to cover this special clock-type.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.c |  9 +++++++++
 drivers/clk/rockchip/clk.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 0a8a694a41ab..875412043dd7 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -415,6 +415,8 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
 
 	ctx->grf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
 						   "rockchip,grf");
+	ctx->pmugrf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
+						   "rockchip,pmugrf");
 
 	return ctx;
 
@@ -490,6 +492,13 @@ void __init rockchip_clk_register_branches(
 				list->mux_shift, list->mux_width,
 				list->mux_flags);
 			break;
+		case branch_muxpmugrf:
+			clk = rockchip_clk_register_muxgrf(list->name,
+				list->parent_names, list->num_parents,
+				flags, ctx->pmugrf, list->muxdiv_offset,
+				list->mux_shift, list->mux_width,
+				list->mux_flags);
+			break;
 		case branch_divider:
 			if (list->div_table)
 				clk = clk_register_divider_table(NULL,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 20200a707611..1b30346f11e1 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -234,6 +234,7 @@ struct rockchip_clk_provider {
 	struct clk_onecell_data clk_data;
 	struct device_node *cru_node;
 	struct regmap *grf;
+	struct regmap *pmugrf;
 	spinlock_t lock;
 };
 
@@ -386,6 +387,7 @@ enum rockchip_clk_branch_type {
 	branch_composite,
 	branch_mux,
 	branch_muxgrf,
+	branch_muxpmugrf,
 	branch_divider,
 	branch_fraction_divider,
 	branch_gate,
@@ -658,6 +660,21 @@ struct rockchip_clk_branch {
 		.gate_offset	= -1,				\
 	}
 
+#define MUXPMUGRF(_id, cname, pnames, f, o, s, w, mf)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_muxpmugrf,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.mux_shift	= s,				\
+		.mux_width	= w,				\
+		.mux_flags	= mf,				\
+		.gate_offset	= -1,				\
+	}
+
 #define DIV(_id, cname, pname, f, o, s, w, df)			\
 	{							\
 		.id		= _id,				\
-- 
1.9.1



