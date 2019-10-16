Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4309FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C432E2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbfJPLXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:23:33 -0400
Received: from mx1.unisoc.com ([222.66.158.135]:23338 "EHLO SHSQR01.unisoc.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403823AbfJPLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:23:33 -0400
X-Greylist: delayed 2254 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Oct 2019 07:23:30 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id x9GAjkpG035605;
        Wed, 16 Oct 2019 18:45:46 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id x9GAi8PG033493
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 16 Oct 2019 18:44:09 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 16 Oct 2019 18:44:17
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Xiaolong Zhang <xiaolong.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] clk: sprd: change to implement .prepare instead of .enable
Date:   Wed, 16 Oct 2019 18:44:14 +0800
Message-ID: <1571222654-12315-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com x9GAi8PG033493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Xiaolong Zhang <xiaolong.zhang@unisoc.com>

Some pll_sc_gate clocks need to wait a certain long time for being stable
after enabled, for this reason enabling this kind of clocks shouldn't be
done in clk_ops.enable() which would be called at interrupt context. So
we move the operation to .prepare(), and also hooks to .unprepare() with
disabling pll_sc_gate clocks.

Signed-off-by: Xiaolong Zhang <xiaolong.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/clk/sprd/gate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
index 1491c00575fa..d8b480f852f3 100644
--- a/drivers/clk/sprd/gate.c
+++ b/drivers/clk/sprd/gate.c
@@ -80,7 +80,7 @@ static int sprd_sc_gate_enable(struct clk_hw *hw)
 	return 0;
 }
 
-static int sprd_pll_sc_gate_enable(struct clk_hw *hw)
+static int sprd_pll_sc_gate_prepare(struct clk_hw *hw)
 {
 	struct sprd_gate *sg = hw_to_sprd_gate(hw);
 
@@ -120,9 +120,11 @@ const struct clk_ops sprd_sc_gate_ops = {
 };
 EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
 
+#define sprd_pll_sc_gate_unprepare sprd_sc_gate_disable
+
 const struct clk_ops sprd_pll_sc_gate_ops = {
-	.disable	= sprd_sc_gate_disable,
-	.enable		= sprd_pll_sc_gate_enable,
+	.unprepare	= sprd_pll_sc_gate_unprepare,
+	.prepare	= sprd_pll_sc_gate_prepare,
 	.is_enabled	= sprd_gate_is_enabled,
 };
 EXPORT_SYMBOL_GPL(sprd_pll_sc_gate_ops);
-- 
2.20.1


