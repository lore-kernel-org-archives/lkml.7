Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4157C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF74206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDCJmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:42:43 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:38366 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:42:39 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.130])
        by regular1.263xmail.com (Postfix) with ESMTP id EA11528C;
        Wed,  3 Apr 2019 17:42:30 +0800 (CST)
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
        Wed, 03 Apr 2019 17:42:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7d694868107abc9780ad842a7eb9bee8>
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
Subject: [PATCH v1 2/6] clk: rockchip: fix up the frac clk get rate error
Date:   Wed,  3 Apr 2019 17:42:25 +0800
Message-Id: <1554284549-24916-3-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support fractional divider with only one level parent clock

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index e04bf300ea0a..0256a99f06f3 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -195,16 +195,21 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 	if (((rate * 20 > p_rate) && (p_rate % rate != 0)) ||
 	    (fd->max_prate && fd->max_prate < p_rate)) {
 		p_parent = clk_hw_get_parent(clk_hw_get_parent(hw));
-		p_parent_rate = clk_hw_get_rate(p_parent);
-		*parent_rate = p_parent_rate;
-		if (fd->max_prate && p_parent_rate > fd->max_prate) {
-			div = DIV_ROUND_UP(p_parent_rate, fd->max_prate);
-			*parent_rate = p_parent_rate / div;
+		if (!p_parent) {
+			*parent_rate = p_rate;
+		} else {
+			p_parent_rate = clk_hw_get_rate(p_parent);
+			*parent_rate = p_parent_rate;
+			if (fd->max_prate && p_parent_rate > fd->max_prate) {
+				div = DIV_ROUND_UP(p_parent_rate,
+						   fd->max_prate);
+				*parent_rate = p_parent_rate / div;
+			}
 		}
 
 		if (*parent_rate < rate * 20) {
-			pr_err("%s parent_rate(%ld) is low than rate(%ld)*20, fractional div is not allowed\n",
-			       clk_hw_get_name(hw), *parent_rate, rate);
+			pr_warn("%s p_rate(%ld) is low than rate(%ld)*20, use integer or half-div\n",
+				clk_hw_get_name(hw), *parent_rate, rate);
 			*m = 0;
 			*n = 1;
 			return;
-- 
1.9.1



