Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE67C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A552075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgAHQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:16:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:28872 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgAHQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:16:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 08:16:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="254271270"
Received: from pg-nx5.altera.com ([10.142.129.193])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2020 08:16:35 -0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>, Ooi@vger.kernel.org
Subject: [PATCH] gpio: altera: change to platform_get_irq_optional to avoid false-positive error
Date:   Thu,  9 Jan 2020 00:16:20 +0800
Message-Id: <20200108161620.80105-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches to platform_get_irq_optional() from
platform_get_irq() as it causes a false-positive error such as 'IRQ
index 0 not found' when IRQ is not used. The IRQ usage is optional in
this gpio-altera driver, so the error log is undesirable.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 drivers/gpio/gpio-altera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index 9f2e6b04c361..cc4ba71e4fe3 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -266,7 +266,7 @@ static int altera_gpio_probe(struct platform_device *pdev)
 	altera_gc->mmchip.gc.owner		= THIS_MODULE;
 	altera_gc->mmchip.gc.parent		= &pdev->dev;
 
-	altera_gc->mapped_irq = platform_get_irq(pdev, 0);
+	altera_gc->mapped_irq = platform_get_irq_optional(pdev, 0);
 
 	if (altera_gc->mapped_irq < 0)
 		goto skip_irq;
-- 
2.13.0

