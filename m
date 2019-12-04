Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C20C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8894D20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfLDMw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:52:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7633 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfLDMw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:52:58 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1DE918E8D495979774EA;
        Wed,  4 Dec 2019 20:52:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 20:52:46 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH] clk: remove set but not used variable 'fref'
Date:   Wed, 4 Dec 2019 21:14:03 +0800
Message-ID: <20191204131403.11526-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/clk-bm1880.c: In function ‘bm1880_pll_rate_calc’:
drivers/clk/clk-bm1880.c:477:13: warning: variable ‘fref’ set but not
used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/clk/clk-bm1880.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index 4cd175afce9b..e6d6599d310a 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -474,11 +474,10 @@ static struct bm1880_composite_clock bm1880_composite_clks[] = {
 static unsigned long bm1880_pll_rate_calc(u32 regval, unsigned long parent_rate)
 {
 	u64 numerator;
-	u32 fbdiv, fref, refdiv;
+	u32 fbdiv, refdiv;
 	u32 postdiv1, postdiv2, denominator;
 
 	fbdiv = (regval >> 16) & 0xfff;
-	fref = parent_rate;
 	refdiv = regval & 0x1f;
 	postdiv1 = (regval >> 8) & 0x7;
 	postdiv2 = (regval >> 12) & 0x7;
-- 
2.17.2

