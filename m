Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0644CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2BD20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406182AbfJWNwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:52:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404484AbfJWNwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:52:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 741B29750C5E0B14BABF;
        Wed, 23 Oct 2019 21:52:09 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 21:51:59 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ssantosh@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] memory: emif: remove set but not used variables 'cs1_used' and 'custom_configs'
Date:   Wed, 23 Oct 2019 21:51:49 +0800
Message-ID: <20191023135149.34704-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/memory/emif.c:1616:9: warning:
 variable cs1_used set but not used [-Wunused-but-set-variable]
drivers/memory/emif.c:1624:36: warning:
 variable custom_configs set but not used [-Wunused-but-set-variable]

They are never used since introduction.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/memory/emif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 402c6bc..9d9127b 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1613,7 +1613,7 @@ static void emif_shutdown(struct platform_device *pdev)
 static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 		struct emif_regs *regs)
 {
-	u32				cs1_used, ip_rev, phy_type;
+	u32				ip_rev, phy_type;
 	u32				cl, type;
 	const struct lpddr2_timings	*timings;
 	const struct lpddr2_min_tck	*min_tck;
@@ -1621,7 +1621,6 @@ static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 	const struct lpddr2_addressing	*addressing;
 	struct emif_data		*emif_for_calc;
 	struct device			*dev;
-	const struct emif_custom_configs *custom_configs;
 
 	dev = emif->dev;
 	/*
@@ -1639,12 +1638,10 @@ static int get_emif_reg_values(struct emif_data *emif, u32 freq,
 
 	device_info	= emif_for_calc->plat_data->device_info;
 	type		= device_info->type;
-	cs1_used	= device_info->cs1_used;
 	ip_rev		= emif_for_calc->plat_data->ip_rev;
 	phy_type	= emif_for_calc->plat_data->phy_type;
 
 	min_tck		= emif_for_calc->plat_data->min_tck;
-	custom_configs	= emif_for_calc->plat_data->custom_configs;
 
 	set_ddr_clk_period(freq);
 
-- 
2.7.4


