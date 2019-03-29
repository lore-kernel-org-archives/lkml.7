Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD8CC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CA72184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfC2JCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:02:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfC2JCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:02:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 610B6EAD8CBD5CF508DB;
        Fri, 29 Mar 2019 17:02:42 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 29 Mar 2019 17:02:32 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jbrunet@baylibre.com>, <rnayak@ti.com>,
        <soren.brinkmann@xilinx.com>, <sboyd@codeaurora.org>,
        <nixiaoming@huawei.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk:Fix divide by 0 error in divider_ro_round_rate_parent
Date:   Fri, 29 Mar 2019 17:05:24 +0800
Message-ID: <1553850324-25625-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function divider_recalc_rate The judgment of the return value of
_get_div indicates that the return value of _get_div may be 0.
In order to avoid the divide-by-zero error, add check the return value
of _get_div in the divider_ro_round_rate_parent

Signed-off-by: nixiaoming <nixiaoming@huawei.com>
---
 drivers/clk/clk-divider.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index e5a1726..0854e3e 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -347,6 +347,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 	int div;
 
 	div = _get_div(table, val, flags, width);
+	if (!div) /* avoid divide-by-zero */
+		return -EINVAL;
 
 	/* Even a read-only clock can propagate a rate change */
 	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-- 
1.8.5.6

