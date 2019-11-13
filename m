Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C5BC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05433222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfKMKyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:54:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38800 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfKMKyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:54:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25B3A627E2CF131B800A;
        Wed, 13 Nov 2019 18:54:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 13 Nov 2019
 18:54:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <qperret@google.com>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] thermal: power_allocator: Fix Kconfig warning
Date:   Wed, 13 Nov 2019 18:53:13 +0800
Message-ID: <20191113105313.41616-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191112152801.GA247051@google.com>
References: <20191112152801.GA247051@google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When do randbuiding, we got this:

WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
  Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
  Selected by [y]:
  - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>

Make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR depend on
THERMAL_DEFAULT_GOV_POWER_ALLOCATOR to fix this warning.

Suggested-by: Quentin Perret <qperret@google.com>
Fixes: a4e893e802e6 ("thermal: cpu_cooling: Migrate to using the EM framework")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 59b79fc..79b2786 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -108,7 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 
 config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
 	bool "power_allocator"
-	select THERMAL_GOV_POWER_ALLOCATOR
+	depends on THERMAL_GOV_POWER_ALLOCATOR
 	help
 	  Select this if you want to control temperature based on
 	  system and device power allocation. This governor can only
-- 
2.7.4


