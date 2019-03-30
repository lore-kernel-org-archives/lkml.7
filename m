Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7B2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfC3Cad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:30:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730104AbfC3Cad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:30:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C26B3DAA1DB5CBC2F028;
        Sat, 30 Mar 2019 10:30:30 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Sat, 30 Mar 2019 10:30:22 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jbrunet@baylibre.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <soren.brinkmann@xilinx.com>,
        <nixiaoming@huawei.com>, <mojha@codeaurora.org>,
        <chao.xie@marvell.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] clk:mmp: clk-mix.c fix divide-by-zero
Date:   Sat, 30 Mar 2019 10:33:17 +0800
Message-ID: <1553913197-51325-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _get_div() function has a branch with a return value of 0
Add a check on the return value of _get_div() to avoid divide-by-zero

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/clk/mmp/clk-mix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index 90814b2..6ed5ad7 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -245,6 +245,9 @@ static int mmp_clk_mix_determine_rate(struct clk_hw *hw,
 			div_val_max = _get_maxdiv(mix);
 			for (j = 0; j < div_val_max; j++) {
 				div = _get_div(mix, j);
+				/* avoid divide-by-zero */
+				if (!div)
+					continue;
 				mix_rate = parent_rate / div;
 				gap = abs(mix_rate - req->rate);
 				if (!parent_best || gap < gap_best) {
@@ -341,6 +344,9 @@ static unsigned long mmp_clk_mix_recalc_rate(struct clk_hw *hw,
 	shift = mix->reg_info.shift_div;
 
 	div = _get_div(mix, MMP_CLK_BITS_GET_VAL(mux_div, width, shift));
+	/* avoid divide-by-zero */
+	if (!div)
+		return -EINVAL;
 
 	return parent_rate / div;
 }
-- 
1.8.5.6

