Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535EC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA352070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfC2LnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:43:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729384AbfC2LnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:43:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8196AA317C1816A0A2CF;
        Fri, 29 Mar 2019 19:43:18 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 19:43:08 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nixiaoming@huawei.com>, <chao.xie@marvell.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk:mmp: clk-mix.c fix divide-by-zero
Date:   Fri, 29 Mar 2019 19:46:00 +0800
Message-ID: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _get_div function has a branch with a return value of 0
Add a check on the return value of _get_div to avoid divide-by-zero

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 drivers/clk/mmp/clk-mix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index 90814b2..9d152c2 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -245,6 +245,8 @@ static int mmp_clk_mix_determine_rate(struct clk_hw *hw,
 			div_val_max = _get_maxdiv(mix);
 			for (j = 0; j < div_val_max; j++) {
 				div = _get_div(mix, j);
+				if (!div) /* avoid divide-by-zero */
+					continue;
 				mix_rate = parent_rate / div;
 				gap = abs(mix_rate - req->rate);
 				if (!parent_best || gap < gap_best) {
@@ -341,6 +343,8 @@ static unsigned long mmp_clk_mix_recalc_rate(struct clk_hw *hw,
 	shift = mix->reg_info.shift_div;
 
 	div = _get_div(mix, MMP_CLK_BITS_GET_VAL(mux_div, width, shift));
+	if (!div) /* avoid divide-by-zero */
+		return -EINVAL;
 
 	return parent_rate / div;
 }
-- 
1.8.5.6

