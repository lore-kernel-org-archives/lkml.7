Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC4C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E202064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfDPO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:56:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfDPO4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:56:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCF06B77F0C37EFF6098;
        Tue, 16 Apr 2019 22:56:47 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:56:39 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <robert.jarzmik@free.fr>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] gpio: pxa: Make two symbols static
Date:   Tue, 16 Apr 2019 22:56:12 +0800
Message-ID: <20190416145612.30364-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/gpio/gpio-pxa.c:580:29: warning:
 symbol 'pxa_irq_domain_ops' was not declared. Should it be static?
drivers/gpio/gpio-pxa.c:819:20: warning:
 symbol 'pxa_gpio_syscore_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpio/gpio-pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index dd47960..26f77fd 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -577,7 +577,7 @@ static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-const struct irq_domain_ops pxa_irq_domain_ops = {
+static const struct irq_domain_ops pxa_irq_domain_ops = {
 	.map	= pxa_irq_domain_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
@@ -812,7 +812,7 @@ static void pxa_gpio_resume(void)
 #define pxa_gpio_resume		NULL
 #endif
 
-struct syscore_ops pxa_gpio_syscore_ops = {
+static struct syscore_ops pxa_gpio_syscore_ops = {
 	.suspend	= pxa_gpio_suspend,
 	.resume		= pxa_gpio_resume,
 };
-- 
2.7.4


