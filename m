Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3C5C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A640C2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 13:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfC3NwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:52:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730823AbfC3NwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 09:52:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D9C36D101AD6E7DE13A7;
        Sat, 30 Mar 2019 21:52:07 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 30 Mar 2019 21:51:57 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <jbrunet@baylibre.com>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <soren.brinkmann@xilinx.com>,
        <nixiaoming@huawei.com>, <mojha@codeaurora.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] clk:Fix divide-by-zero in divider_ro_round_rate_parent
Date:   Sat, 30 Mar 2019 21:54:50 +0800
Message-ID: <1553954090-65470-1-git-send-email-nixiaoming@huawei.com>
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
_get_div() indicates that the return value of _get_div() can be 0.
In order to avoid the divide-by-zero error, add check for return value
of _get_div() in the divider_ro_round_rate_parent()

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
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

