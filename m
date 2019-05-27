Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E38D2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfE0QJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:09:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0QJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:09:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9CCBA0048445AF8D72D;
        Mon, 27 May 2019 23:49:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 23:49:19 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ssantosh@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] memory: emif: Remove set but not used variables 'custom_configs' and 'cs1_used'
Date:   Mon, 27 May 2019 23:45:25 +0800
Message-ID: <20190527154525.19516-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/memory/emif.c: In function get_emif_reg_values:
drivers/memory/emif.c:1626:36: warning: variable custom_configs set but not used [-Wunused-but-set-variable]
drivers/memory/emif.c: In function get_emif_reg_values:
drivers/memory/emif.c:1618:9: warning: variable cs1_used set but not used [-Wunused-but-set-variable]

They are not used since introduction in commit
a93de288aad3 ("memory: emif: handle frequency and voltage change events")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/memory/emif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 2f214440008c..1b262bbd1d65 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1615,7 +1615,7 @@ static void emif_shutdown(struct platform_device *pdev)
 static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 		struct emif_regs *regs)
 {
-	u32				cs1_used, ip_rev, phy_type;
+	u32				ip_rev, phy_type;
 	u32				cl, type;
 	const struct lpddr2_timings	*timings;
 	const struct lpddr2_min_tck	*min_tck;
@@ -1623,7 +1623,6 @@ static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 	const struct lpddr2_addressing	*addressing;
 	struct emif_data		*emif_for_calc;
 	struct device			*dev;
-	const struct emif_custom_configs *custom_configs;
 
 	dev = emif->dev;
 	/*
@@ -1641,12 +1640,10 @@ static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 
 	device_info	= emif_for_calc->plat_data->device_info;
 	type		= device_info->type;
-	cs1_used	= device_info->cs1_used;
 	ip_rev		= emif_for_calc->plat_data->ip_rev;
 	phy_type	= emif_for_calc->plat_data->phy_type;
 
 	min_tck		= emif_for_calc->plat_data->min_tck;
-	custom_configs	= emif_for_calc->plat_data->custom_configs;
 
 	set_ddr_clk_period(freq);
 
-- 
2.17.1


