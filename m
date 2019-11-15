Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B91C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C78620733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfKOIti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:49:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:59180 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfKOItf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:49:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 00:49:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="208370306"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2019 00:49:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4E0B12A; Fri, 15 Nov 2019 10:49:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] mfd: syscon: Re-use resource_size() to count max_register
Date:   Fri, 15 Nov 2019 10:49:30 +0200
Message-Id: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coded variant use resource_size() and replace
weird '- 3' to more understandable '- 4'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index e22197c832e8..13626bb2d432 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -245,7 +245,7 @@ static int syscon_probe(struct platform_device *pdev)
 	if (!base)
 		return -ENOMEM;
 
-	syscon_config.max_register = res->end - res->start - 3;
+	syscon_config.max_register = resource_size(res) - 4;
 	if (pdata)
 		syscon_config.name = pdata->label;
 	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);
-- 
2.24.0

