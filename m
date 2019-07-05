Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB149C4649C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A73A21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfGEMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:34:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbfGEMem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:34:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3A8D35FA08B773A96C8F;
        Fri,  5 Jul 2019 20:34:38 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 20:34:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] gpio: tegra: Fix build error without CONFIG_DEBUG_FS
Date:   Fri, 5 Jul 2019 20:32:20 +0800
Message-ID: <20190705123220.54008-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_FS is not set, building fails:

drivers/gpio/gpio-tegra.c: In function tegra_gpio_probe:
drivers/gpio/gpio-tegra.c:665:2: error: implicit declaration of function debugfs_create_file;
 did you mean bus_create_file? [-Werror=implicit-function-declaration]
  debugfs_create_file("tegra_gpio", 0444, NULL, tgi,
  ^~~~~~~~~~~~~~~~~~~
  bus_create_file
drivers/gpio/gpio-tegra.c:666:9: error: tegra_dbg_gpio_fops undeclared (first use in this function);
 did you mean tegra_gpio_pm_ops?
        &tegra_dbg_gpio_fops);
         ^~~~~~~~~~~~~~~~~~~
         tegra_gpio_pm_ops

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: a4de43049a1d ("gpio: tegra: Clean-up debugfs initialisation")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpio/gpio-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 59b99d8..40fd6bd 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -662,8 +662,10 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_DEBUG_FS
 	debugfs_create_file("tegra_gpio", 0444, NULL, tgi,
 			    &tegra_dbg_gpio_fops);
+#endif
 
 	return 0;
 }
-- 
2.7.4


