Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A990EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504B121874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfCNWfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:55 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfCNWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:37 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6c0W-1gyKKL0286-018294; Thu, 14 Mar 2019 23:35:15 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 45/45] drivers: tty: serial: mux: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:15 +0100
Message-Id: <1552602855-26086-46-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:z+/rx4MhVeeVcG08TBj8jDGh8jFYW4zOBRqesRKWryiDcRo/5/R
 leJZXEwA5A8UHumYCGBKoEZd/n6lwwxGYVqhYppL++hnQWZn4i/9gvdyfWaGun1q+60/N+h
 4z5cuuKGwvNPqZvAl+9UM3D2gQWTn1V1WdXgynLWTTiAImQFWYw+bzULiWFqNFoMAcBU45M
 KH5Wa0+N6J6kBEfXsWzLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AyTX8fP0X0o=:cKX2hr9y6IZHZi8s1kQfKv
 YXVZQKL9F1saxga1oKyjnVJwUddGMktkTYIG1E0A0lNoSj/uQoxBWo07CUMYsnFOVfQlzGtns
 edauhP1WyGdeLfzIdx/NBM0a7C+s+cz5HOuMsTe1pJpr46iuNnbGCayMLYYi/BEy8csxJafrV
 J0GAroT/TI6X8N1h34ozppCWgHl9XlzDaxH8iRqNrNyDqqh0H7TUHbghCCFXwKq1Rvpq1HoJR
 Lid8ph/pkx+/H+uXeYOSML/n1ahtcBgVR5ut7JYearlzmwLi8EgIcohsBZSIlqkdNetadISaX
 ja8zO1g7LZIPnt9vNwqGdCHtwiC408lDFYpRSvwJT9DLiNf7+0yZzVkHx6RlkDytPK5tzM+aw
 w8f6pXrbyVM2EvoLtb0F3qZZnlwqfQJ9DL7KdKOqIjRU+RekXvv/MjjtYip23UkU2IacGoVRk
 hQ1zQgSqQXH1fjoUR7EKb8DHujWhjn8yirf4PqrM97MpWLeY20ZqNJIAuRYhdBaSXXMXKxF+S
 Es+m/XbfZYeg9dykyvJX4VskAo1tOGL9tHEXmtyLTPdrPm3WeSTeVy1NfTSlXtuSHe97vyDRd
 8DIUvVl/g5ACLyoxdr1qherCK5OOGgYivJdAwLvo+qerTWfFt9HHj6BDAzhLVCyJGjqdhRBQ+
 BgETsbUB6s0YBR/QR7HXDaT3Z/oaM2wjxThS4clRDddOIq2LgXI9MmUzX0+PzM8eqFrva3G4v
 jyXQeuooIFmmZNokTNg0U+gu6k7QQiDTdRCb2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/mux.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e..cd08f0f 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -456,8 +456,9 @@ static int __init mux_probe(struct parisc_device *dev)
 	printk(KERN_INFO "Serial mux driver (%d ports) Revision: 0.6\n", port_count);
 
 	dev_set_drvdata(&dev->dev, (void *)(long)port_count);
-	request_mem_region(dev->hpa.start + MUX_OFFSET,
-                           port_count * MUX_LINE_OFFSET, "Mux");
+	devm_request_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET, "Mux");
 
 	if(!port_cnt) {
 		mux_driver.cons = MUX_CONSOLE;
@@ -474,7 +475,9 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->iobase	= 0;
 		port->mapbase	= dev->hpa.start + MUX_OFFSET +
 						(i * MUX_LINE_OFFSET);
-		port->membase	= ioremap_nocache(port->mapbase, MUX_LINE_OFFSET);
+		port->membase	= devm_ioremap_nocache(port->dev,
+						       port->mapbase,
+						       MUX_LINE_OFFSET);
 		port->iotype	= UPIO_MEM;
 		port->type	= PORT_MUX;
 		port->irq	= 0;
@@ -517,10 +520,12 @@ static int __exit mux_remove(struct parisc_device *dev)
 
 		uart_remove_one_port(&mux_driver, port);
 		if(port->membase)
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 	}
 
-	release_mem_region(dev->hpa.start + MUX_OFFSET, port_count * MUX_LINE_OFFSET);
+	devm_release_mem_region(&dev->dev,
+				dev->hpa.start + MUX_OFFSET,
+				port_count * MUX_LINE_OFFSET);
 	return 0;
 }
 
-- 
1.9.1

