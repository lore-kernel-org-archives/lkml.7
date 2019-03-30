Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA9FC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AC02184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfC3C2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:28:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730213AbfC3C2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:28:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4B3D4DE79F4DFFA0C29;
        Sat, 30 Mar 2019 10:28:38 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 30 Mar 2019 10:28:29 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jbrunet@baylibre.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <soren.brinkmann@xilinx.com>,
        <nixiaoming@huawei.com>, <mojha@codeaurora.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] clk:Fix divide-by-zero in divider_ro_round_rate_parent
Date:   Sat, 30 Mar 2019 10:31:25 +0800
Message-ID: <1553913085-51237-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function divider_recalc_rate() The judgment of the return value of
_get_div() indicates that the return value of _get_div() may be 0.
In order to avoid the divide-by-zero error, add check the return value
of _get_div() in the divider_ro_round_rate_parent()

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 drivers/clk/clk-divider.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e5a1726..f4bf7a4 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -347,6 +347,9 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 	int div;
 
 	div = _get_div(table, val, flags, width);
+	/* avoid divide-by-zero */
+	if (!div)
+		return -EINVAL;
 
 	/* Even a read-only clock can propagate a rate change */
 	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-- 
1.8.5.6

