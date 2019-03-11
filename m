Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA72C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850EE20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfCKJ1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:27:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKJ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:27:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DB6CB9D857254BE3108;
        Mon, 11 Mar 2019 17:27:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 11 Mar 2019 17:27:24 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <vz@mleia.com>,
        <dan.carpenter@oracle.com>
Subject: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()
Date:   Mon, 11 Mar 2019 17:39:59 +0800
Message-ID: <20190311093959.86344-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing uart_unregister_driver() and i2c_del_driver() before
return from sc16is7xx_init() in the error handling case.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
---
 v1->v2: fix compile warning if CONFIG_SERIAL_SC16IS7XX_SPI is not exist.
 v2->v3: create functions for i2c and spi to do error handling as dan carpenter
 suggestion.
 drivers/tty/serial/sc16is7xx.c | 53 ++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 268098681856..8be3adaf4782 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1436,6 +1436,19 @@ static struct spi_driver sc16is7xx_spi_uart_driver = {
 };
 
 MODULE_ALIAS("spi:sc16is7xx");
+
+static int __init register_sc16is7xx_spi(void)
+{
+	return spi_register_driver(&sc16is7xx_spi_uart_driver);
+}
+
+static void __exit unregister_sc16is7xx_spi(void)
+{
+	spi_unregister_driver(&sc16is7xx_spi_uart_driver);
+}
+#else
+static int __init register_sc16is7xx_spi(void) { return 0; }
+static void __exit unregister_sc16is7xx_spi(void) {}
 #endif
 
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
@@ -1493,6 +1506,18 @@ static struct i2c_driver sc16is7xx_i2c_uart_driver = {
 	.id_table	= sc16is7xx_i2c_id_table,
 };
 
+static int __init register_sc16is7xx_i2c(void)
+{
+	return i2c_add_driver(&sc16is7xx_i2c_uart_driver);
+}
+
+static void __exit del_sc16is7xx_i2c(void)
+{
+	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
+}
+#else
+static int __init register_sc16is7xx_i2c(void) { return 0; }
+static void __exit del_sc16is7xx_i2c(void) {}
 #endif
 
 static int __init sc16is7xx_init(void)
@@ -1505,34 +1530,32 @@ static int __init sc16is7xx_init(void)
 		return ret;
 	}
 
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	ret = i2c_add_driver(&sc16is7xx_i2c_uart_driver);
+	ret = register_sc16is7xx_i2c();
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx i2c --> %d\n", ret);
-		return ret;
+		goto err_i2c;
 	}
-#endif
 
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	ret = spi_register_driver(&sc16is7xx_spi_uart_driver);
+	ret = register_sc16is7xx_spi();
 	if (ret < 0) {
 		pr_err("failed to init sc16is7xx spi --> %d\n", ret);
-		return ret;
+		goto err_spi;
 	}
-#endif
+
+	return ret;
+
+err_spi:
+	del_sc16is7xx_i2c();
+err_i2c:
+	uart_unregister_driver(&sc16is7xx_uart);
 	return ret;
 }
 module_init(sc16is7xx_init);
 
 static void __exit sc16is7xx_exit(void)
 {
-#ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-#endif
-
-#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
-	spi_unregister_driver(&sc16is7xx_spi_uart_driver);
-#endif
+	del_sc16is7xx_i2c();
+	unregister_sc16is7xx_spi();
 	uart_unregister_driver(&sc16is7xx_uart);
 }
 module_exit(sc16is7xx_exit);
-- 
2.20.1

