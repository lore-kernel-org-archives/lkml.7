Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE8CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721922080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfJ3M5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:57:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfJ3M5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:57:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D58B047779B32F6F8190;
        Wed, 30 Oct 2019 20:57:12 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 20:57:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <digetx@gmail.com>
CC:     <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] clk: tegra: Fix build error without CONFIG_PM_SLEEP
Date:   Wed, 30 Oct 2019 20:56:50 +0800
Message-ID: <20191030125650.36776-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM_SLEEP is n, build fails:

drivers/clk/tegra/clk-tegra210.c:3426:13: error:
 tegra210_clk_suspend undeclared here (not in a function); did you mean tegra_clk_ndspeed?
  .suspend = tegra210_clk_suspend,
             ^~~~~~~~~~~~~~~~~~~~
             tegra_clk_ndspeed
drivers/clk/tegra/clk-tegra210.c:3427:12: error:
 tegra210_clk_resume undeclared here (not in a function); did you mean tegra210_clk_suspend?
  .resume = tegra210_clk_resume,

Use ifdef to guard this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 27d10d548c04 ("clk: tegra: Add suspend and resume support on Tegra210")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/tegra/clk-tegra210.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index d038fed..762cd18 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3423,8 +3423,10 @@ static void tegra210_cpu_clock_resume(void)
 #endif
 
 static struct syscore_ops tegra_clk_syscore_ops = {
+#ifdef CONFIG_PM_SLEEP
 	.suspend = tegra210_clk_suspend,
 	.resume = tegra210_clk_resume,
+#endif
 };
 
 static struct tegra_cpu_car_ops tegra210_cpu_car_ops = {
-- 
2.7.4


