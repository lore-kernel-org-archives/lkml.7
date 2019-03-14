Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD109C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9342A21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfCNWhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:19 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfCNWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:15 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MauFB-1gSl5B1D5f-00cQwx; Thu, 14 Mar 2019 23:35:02 +0100
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
Subject: [PATCH v2 32/45] drivers: tty: serial: atmel_serial: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:02 +0100
Message-Id: <1552602855-26086-33-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mbSZOFPTtDMVcBC7couioKu8NlV3HZl6EoZ0F7G18McCNoJhxGX
 pqzW5OiO90J9dTDV5nrvniiLum8BCoZKvDJUHTol/JUxZwmIv7lhZw3IGZmWEDtlkJ8VW/U
 cL7GQbqC0wJHsMQugo3uMmRYVBohKsRqBgEHQYtbqQfSm6cwF+hd2hXDon9oH7A1QAjy4w2
 5fBf7VG25bC8rl9662a8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rZUMY8XIoQc=:nIPvllVU+DypLrf4YQp87L
 s8lYrvlmeRpFULxKmKan1NXbwero1GUL5DO+fQ3TEIp+linqlrH917ghWa06KwW63Fk5Mf2AR
 0M+WgxLXKukMeb6HvHstMIjqOm9KDeFkfhhXHCoWiznLw+n+M7VeBGUnJy6I0n9C2+9n3Nc+m
 05dIEONUjUuWsXxF5PchH9o1PVSAZxGKYL5DRP2sEvz0a9EtzHYIhWp4y1IvTsiBEb/gIb2a0
 hgDLbJEFErQX4PQriplYneQbyV6blWPRRmDVa7ZeTnSp2VCnM9r6qVg/ExOJ2iK5HLYnD6d71
 bVpFNGTLK8YtdrhYhjeS0Ri7YFqxNCfBYCmrHpzrfzSLtAKRVTSKkCPqhfE7KIBgi4zlpqiBV
 l9kLGrHJt4AbRfQDzidptYFzLXBX4ALw59heyT18nvmH83JPIYpEM7kded42wA2P9yLsNEF11
 jfpwjOrDhniXXeeiQt8s5KVMygH4SypMqBVxpmbPMr8KJvt2trPAs5jVaQpUyaLf4V8c30DzU
 +S5Ah0upRpU4l1AgtC/Mkoqzi0XU7LZ9Y9bxBoUTyLxYguIsOL4/01fojymS/LTg/RBPwV4Ge
 Kft+x9wuwiAFycSalbdbu8okB/c3m6mqGTQRyoqHVRnNsk2aRKmJpX9v+SUfJa7uhaKtMWoo8
 s7VNJuN+EPAoJJtWdhvlBHgfPIj3EmY42pWqooKo34zRd2rlVldNXN8uKXg6ZYZCKO49soNib
 3vfgu7ybzdXogmZjtPpwLKAjID6wsyn4dEpMXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/atmel_serial.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 05147fe..084f106 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2389,10 +2389,10 @@ static void atmel_release_port(struct uart_port *port)
 	struct platform_device *mpdev = to_platform_device(port->dev->parent);
 	int size = resource_size(mpdev->resource);
 
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 }
@@ -2405,13 +2405,16 @@ static int atmel_request_port(struct uart_port *port)
 	struct platform_device *mpdev = to_platform_device(port->dev->parent);
 	int size = resource_size(mpdev->resource);
 
-	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "atmel_serial"))
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
-		port->membase = ioremap(port->mapbase, size);
+		port->membase = devm_ioremap(port->dev, port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			devm_release_mem_region(port->dev, port->mapbase, size);
 			return -ENOMEM;
 		}
 	}
-- 
1.9.1

