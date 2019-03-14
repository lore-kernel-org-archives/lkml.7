Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49885C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF012184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfCNWhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfCNWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:07 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZeX-1gkHxf0is7-00txnj; Thu, 14 Mar 2019 23:34:52 +0100
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
Subject: [PATCH v2 21/45] drivers: tty: serial: altera_jtaguart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:51 +0100
Message-Id: <1552602855-26086-22-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/7N3Y15yubt1Hp/mjw3zs7TBCGDbpCWoamybrySXM7TWT1iiZ5r
 2R8qGWtT++LJJEcxQpELQ8gkj3HbqZ0eXBmEHjMtZDtMbIQlKSH4mB2MapOJmflPOvkQlJH
 NKjJApxMquO+xfL6lXyipXMxU89N9c6JrlVMWKHy2OyBKhNKp3c99Rkevx9rKdNWXzDu9gW
 fZGjlLuF87u52WfoatMxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOxp4iW/df8=:suctqOpq3a/nVrfdf/e1hw
 MNoCU4SRZ7HWSprUjLQV7I3v2UgGm+YHZbGfV/V7DGZPk4exNA7H4Ei+tLgG6ZposG0O2RWam
 cYOsNjUoZI3yuwm8shOQjmuBJAZmNqA4/Yeor7sMVJvA1OnfZqurxmfHlcc814DxLrqN6XCi9
 x0pO3bw30vLUDh0jCjvRFCMr3IOf2/x8wpcn7P4kwPAMTMa2XJj7/azpzikkrVPMqYZlquyBu
 +deD1Lii4JlDPATXMSHb+TP0GWBbKHF3IvnOrIyqXG2M/59fPgJcoaraM8OqEz4ZB93WC1v4d
 zmO+g103p+K848F4RiqTbKYbKJfd3YHoyYd7YC9KI6wjAh4U64kPjDSIz77cL/RpqXH7G3UGo
 leuLZFF4Z7PaAhQu2VipOsGfxdPVQi4z90j1cUPzHiahjRZ15Wwtq359R2uNyzLWZo/sPQYgN
 SaPjsot9Z1lK6NZF5nLV39mmBOeDmPsuyRmFd0IpH0bgWDfoRQy6Z1BDpOa1qLJ3USOuRqH41
 1QlXnWFrMfaCa1pjU6MX9Ov+DuE1Ez4o530TumHkNxa/0IAwj2tKf6HrS+D9XsDDsFwRlrnSa
 Yni/M4O+NGtSg4gQ/2aj+mVJWUI6z3Vfdk/lRrk+/gRVAHjw77VQMjjJxpTefXqB4KVqBvyx+
 ajrOBFamJ9xRSN0qEICe4myxxQs1wbP6O0XgjPHHpiRE5urnj2GS6wj+1pAJVioPA5MO1kS1Q
 LKfM83cdawIT1kmG8V4p3VA4GYckcO8YKaTCUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/altera_jtaguart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c90e503..13cab5d 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -448,7 +448,9 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	else
 		return -ENODEV;
 
-	port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     ALTERA_JTAGUART_SIZE);
 	if (!port->membase)
 		return -ENOMEM;
 
@@ -474,7 +476,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 
 	port = &altera_jtaguart_ports[i].port;
 	uart_remove_one_port(&altera_jtaguart_driver, port);
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 
 	return 0;
 }
-- 
1.9.1

