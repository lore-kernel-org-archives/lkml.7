Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DFC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED619206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfHPOA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:00:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbfHPOA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:00:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4C51C4BC3A2E475478C;
        Fri, 16 Aug 2019 22:00:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 16 Aug 2019
 22:00:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: qcom: clk-rpm: remove unused code
Date:   Fri, 16 Aug 2019 21:59:44 +0800
Message-ID: <20190816135944.54232-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/qcom/clk-rpm.c:453:29: warning:
 clk_rpm_branch_ops defined but not used [-Wunused-const-variable=]

It is never used, also the macros 'DEFINE_CLK_RPM_CXO_BRANCH'
and 'DEFINE_CLK_RPM_CXO_BRANCH' are unused, so remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/qcom/clk-rpm.c | 63 ----------------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index 9e3110a..c3430e2 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -73,62 +73,6 @@
 		},							      \
 	}
 
-#define DEFINE_CLK_RPM_PXO_BRANCH(_platform, _name, _active, r_id, r)	      \
-	static struct clk_rpm _platform##_##_active;			      \
-	static struct clk_rpm _platform##_##_name = {			      \
-		.rpm_clk_id = (r_id),					      \
-		.active_only = true,					      \
-		.peer = &_platform##_##_active,				      \
-		.rate = (r),						      \
-		.branch = true,						      \
-		.hw.init = &(struct clk_init_data){			      \
-			.ops = &clk_rpm_branch_ops,			      \
-			.name = #_name,					      \
-			.parent_names = (const char *[]){ "pxo_board" },      \
-			.num_parents = 1,				      \
-		},							      \
-	};								      \
-	static struct clk_rpm _platform##_##_active = {			      \
-		.rpm_clk_id = (r_id),					      \
-		.peer = &_platform##_##_name,				      \
-		.rate = (r),						      \
-		.branch = true,						      \
-		.hw.init = &(struct clk_init_data){			      \
-			.ops = &clk_rpm_branch_ops,			      \
-			.name = #_active,				      \
-			.parent_names = (const char *[]){ "pxo_board" },      \
-			.num_parents = 1,				      \
-		},							      \
-	}
-
-#define DEFINE_CLK_RPM_CXO_BRANCH(_platform, _name, _active, r_id, r)	      \
-	static struct clk_rpm _platform##_##_active;			      \
-	static struct clk_rpm _platform##_##_name = {			      \
-		.rpm_clk_id = (r_id),					      \
-		.peer = &_platform##_##_active,				      \
-		.rate = (r),						      \
-		.branch = true,						      \
-		.hw.init = &(struct clk_init_data){			      \
-			.ops = &clk_rpm_branch_ops,			      \
-			.name = #_name,					      \
-			.parent_names = (const char *[]){ "cxo_board" },      \
-			.num_parents = 1,				      \
-		},							      \
-	};								      \
-	static struct clk_rpm _platform##_##_active = {			      \
-		.rpm_clk_id = (r_id),					      \
-		.active_only = true,					      \
-		.peer = &_platform##_##_name,				      \
-		.rate = (r),						      \
-		.branch = true,						      \
-		.hw.init = &(struct clk_init_data){			      \
-			.ops = &clk_rpm_branch_ops,			      \
-			.name = #_active,				      \
-			.parent_names = (const char *[]){ "cxo_board" },      \
-			.num_parents = 1,				      \
-		},							      \
-	}
-
 #define to_clk_rpm(_hw) container_of(_hw, struct clk_rpm, hw)
 
 struct rpm_cc;
@@ -450,13 +394,6 @@ static const struct clk_ops clk_rpm_ops = {
 	.recalc_rate	= clk_rpm_recalc_rate,
 };
 
-static const struct clk_ops clk_rpm_branch_ops = {
-	.prepare	= clk_rpm_prepare,
-	.unprepare	= clk_rpm_unprepare,
-	.round_rate	= clk_rpm_round_rate,
-	.recalc_rate	= clk_rpm_recalc_rate,
-};
-
 /* MSM8660/APQ8060 */
 DEFINE_CLK_RPM(msm8660, afab_clk, afab_a_clk, QCOM_RPM_APPS_FABRIC_CLK);
 DEFINE_CLK_RPM(msm8660, sfab_clk, sfab_a_clk, QCOM_RPM_SYS_FABRIC_CLK);
-- 
2.7.4


