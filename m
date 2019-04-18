Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEBBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9BA2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbfDRJYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:24:08 -0400
Received: from david.siemens.de ([192.35.17.14]:57695 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfDRJYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:24:06 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x3I9NoBm010411
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 11:23:51 +0200
Received: from md1f2u6c.ad001.siemens.net (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3I9NoXd030948;
        Thu, 18 Apr 2019 11:23:50 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 1/2] gpio: sch: Remove write-only core_base
Date:   Thu, 18 Apr 2019 11:23:48 +0200
Message-Id: <1d2dafa4bfcd485cf28bb8e3a6e169d220edf555.1555579429.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1555579429.git.jan.kiszka@siemens.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1555579429.git.jan.kiszka@siemens.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-sch.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index c333046d02b8..fb143f28c386 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -23,7 +23,6 @@ struct sch_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
 	unsigned short iobase;
-	unsigned short core_base;
 	unsigned short resume_base;
 };
 
@@ -166,7 +165,6 @@ static int sch_gpio_probe(struct platform_device *pdev)
 
 	switch (pdev->id) {
 	case PCI_DEVICE_ID_INTEL_SCH_LPC:
-		sch->core_base = 0;
 		sch->resume_base = 10;
 		sch->chip.ngpio = 14;
 
@@ -185,19 +183,16 @@ static int sch_gpio_probe(struct platform_device *pdev)
 		break;
 
 	case PCI_DEVICE_ID_INTEL_ITC_LPC:
-		sch->core_base = 0;
 		sch->resume_base = 5;
 		sch->chip.ngpio = 14;
 		break;
 
 	case PCI_DEVICE_ID_INTEL_CENTERTON_ILB:
-		sch->core_base = 0;
 		sch->resume_base = 21;
 		sch->chip.ngpio = 30;
 		break;
 
 	case PCI_DEVICE_ID_INTEL_QUARK_X1000_ILB:
-		sch->core_base = 0;
 		sch->resume_base = 2;
 		sch->chip.ngpio = 8;
 		break;
-- 
2.16.4

