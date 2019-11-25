Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77BDC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDDE2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="eXZ2QhdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfKYN0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:26:21 -0500
Received: from aliyun-cloud.icoremail.net ([47.90.73.12]:18180 "HELO
        aliyun-sdnproxy-4.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1727393AbfKYN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:26:21 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 08:26:19 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=UP7iGuZyWy
        7rUnb0BqANyOczNI15OI3BvmT6wTeNlTs=; b=eXZ2QhdAr0Eyh94pU+Rqp9+x7t
        2zeecmS/wKv+KbWTbb8a6UEeVVp4jNp9wE8FTl18CWzy8edd0vItJ3seI6IeoUhO
        MN1Fklnl1NIFUTPZGekVfxgQsWOdRnLnpwos6+z8CecGCwKsKRRq+nbdQK+Thai5
        hZCVHNE/da2va4hEI=
Received: from localhost.localdomain (unknown [10.136.208.163])
        by coremail-app1 (Coremail) with SMTP id RYCowACXebb6z9tdwLfmAQ--.36688S2;
        Mon, 25 Nov 2019 20:58:37 +0800 (CST)
From:   Yunhao Tian <18373444@buaa.edu.cn>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Yunhao Tian <18373444@buaa.edu.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.
Date:   Mon, 25 Nov 2019 20:58:32 +0800
Message-Id: <20191125125833.8023-1-18373444@buaa.edu.cn>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: RYCowACXebb6z9tdwLfmAQ--.36688S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZr1xZFy7Ar4fKFWxWr43Awb_yoW8Jr47pF
        W7J34FqF1rJ3Wagay3Ar1xCFy5ua4Y9FyUCrWUA3y5Zrn7JF1rt3Wjy34DAFykCrWfZr1Y
        yrnrZry8CF4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylx4CE04Ijxs4lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCg4fUUUUU
X-CM-SenderInfo: yrytljauuuquxxddhvlgxou0/
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hws field of sun8i_v3s_hw_clks has only 74
members. However, the number specified by CLK_NUMBER
is 77 (= CLK_I2S0 + 1). This leads to runtime segmentation
fault that is not always reproducible.

This patch fixes the problem by specifying correct clock number.

Signed-off-by: Yunhao Tian <18373444@buaa.edu.cn>
---
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 5c779eec454b..0e36ca3bf3d5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -618,7 +618,7 @@ static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
 		[CLK_MBUS]		= &mbus_clk.common.hw,
 		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
 	},
-	.num	= CLK_NUMBER,
+	.num	= CLK_PLL_DDR1 + 1,
 };
 
 static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
@@ -700,7 +700,7 @@ static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
 		[CLK_MBUS]		= &mbus_clk.common.hw,
 		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
 	},
-	.num	= CLK_NUMBER,
+	.num	= CLK_I2S0 + 1,
 };
 
 static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
-- 
2.24.0

