Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D60C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD58E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfCNWgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:36:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfCNWfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:24 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUXd0-1hUvWx0plo-00QRnQ; Thu, 14 Mar 2019 23:35:11 +0100
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
Subject: [PATCH v2 41/45] drivers: tty: serial: timuart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:11 +0100
Message-Id: <1552602855-26086-42-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VMveoKcaSSHQL6RZwKQTc3/i2g9aJhrz4ZUp5udhZJLzknlw8eb
 mO3m1FgaSydJp0i9ppsuqSSADF2wx7oy/tJetuQM2OdQdiIv1Uw9QCGJGrlDrG51wwmyQKS
 QtRqDuKYQgw1G+dZVKHDrsT7U6XfbH2WyDjSmPJht5pNnysAvx5jQQBxa9943RVv/UlP6zA
 B0m1yhUE3SDYjr3U6EIeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OVTdimSIwhw=:0fjq4dK3oWnY0464Powhnc
 7rfmkvH81P1wU0CND4zuwoPagTtHtqBN6RBtLWYBigT2UOKTQtwVZNSsVvLGqWQmz4onKmnZ2
 4pMzlHSswZYra1RLTK8eP1WK3m384fkMpBkeRFy1AcF1IGxpK6ZHLc1wjYzUncL+oTXbQ3rm/
 d0xBccrOSXvlaomZ9tzl95r/IUCl2RisWjmjNrvl3R0m14Swwai5O6FDctWHa5zbckPjEVvKh
 qktIWEz4hwHK4Zf2wP9I1CA7nRGX5dEkSmX+lKRWfj0Flo2vIMgB7fN3h4ddyCC25f6Eh7U9E
 2V+frhMA5H8SwWvxhBRMggmJFkL5qYNBR+pQVDK0QU9ci6jd8UxNRCVfztOtfm8rPU4J5oluG
 X3vn8mtV+fRkA0DLS0iJ6ctX1MdRPxU/HPySBOsjkGI6tgmF9spwTHfTk0i9x+WokfhU9Admx
 4M8xuzbzzBUUuv/1cF2vQaC21Hyoty3Bj7GKyVfF5rdPyeZj8PGzvsqFeUOxycClk0nBqBm6p
 HiSrEosu076k2HbNGMA626JgE8oTpZ0tc4Sw4ejFjLotzV+HJ3645YK1E4c7X/+fbF00vaBLE
 YUebghMxpUN77i4Rk3eTK7wHl7os7haMqy3xkzxCKxAU/unrnyjPK8hooVGGw4+zMmm2maKnD
 MA8G9Vy68tRUR39weO0Neo+nUrUsBkEie3R36idAfQ5HMoxURLYRMFWRUruZ+1dDOqvOEpIOU
 8Xt0H+prJzQQRtmUg/unRJ0cFFSESt8VG2ulDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/men_z135_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index ef89534..349f70e 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -732,7 +732,7 @@ static void men_z135_release_port(struct uart_port *port)
 {
 	struct men_z135_port *uart = to_men_z135(port);
 
-	iounmap(port->membase);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 
 	mcb_release_mem(uart->mem);
@@ -751,7 +751,7 @@ static int men_z135_request_port(struct uart_port *port)
 	port->mapbase = mem->start;
 	uart->mem = mem;
 
-	port->membase = ioremap(mem->start, resource_size(mem));
+	port->membase = devm_ioremap_resource(port->dev, mem);
 	if (port->membase == NULL) {
 		mcb_release_mem(mem);
 		return -ENOMEM;
-- 
1.9.1

