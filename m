Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF8C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72238215E5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 01:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3BuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:50:15 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727171AbfK3BuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 20:50:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 756CDFABC129D1FBD040;
        Sat, 30 Nov 2019 09:50:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 09:50:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <broonie@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] gpiolib: of: Make of_gpio_spi_cs_get_count static
Date:   Sat, 30 Nov 2019 09:28:28 +0800
Message-ID: <20191130012828.14504-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
References: <CACRpkdbeKdEAEtoPZH8+fWcZEOqJ6cdGTRSkrKx8L9avxnPQQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpio/gpiolib-of.c:35:5: warning:
 symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: This is caused by commit 71b8f600b034 ("gpio: Handle counting of Freescale chipselects"),
	should be applied to spi tree.
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 610c6622f62d..b696e4598a24 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -32,7 +32,7 @@
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 {
 	struct device_node *np = dev->of_node;
 
-- 
2.20.1


