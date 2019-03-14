Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3626C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48AE21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfCNWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfCNWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:06 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEmpp-1hFJFm48Lb-00GLjL; Thu, 14 Mar 2019 23:34:54 +0100
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
Subject: [PATCH v2 23/45] drivers: tty: serial: amba-pl010: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:53 +0100
Message-Id: <1552602855-26086-24-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VmkbMXgZ5mJ68rFO9MD0xatMizo8sSKA6igdCG69Xczwsw11M5a
 jXG0nirTWbaUHmc0O7c5Bl5TtJOO4xYilcC1dkS/NoFePkR93NDXWPzVFcVdrpDxkvtuAhX
 AGU1PZvaWHmV3IyD7FT0tKLtIP+Anruqf81mZmBILABKNjMNkpsuWg/JAnpsRN20tYNglDC
 /tJSCgslw+xDWm7r9tTCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6pK8po7/U2M=:VaGsEUje1ohlDVmVpJUbv2
 UE3UYVn/xO+QEv9W/XxtM7miwCnXoQ9ri33k2zcCc4MRE+N81MRVaUckHvDy/CZnFWQj3Ahdk
 RErxULdXHx3rqAti74rZBn5lpq4/HIzIjSHy6ji1mjDSbNPOgIvxulRnJHe9Qy4EpjIvr5Nen
 tm1tFtfXj+N/X4GOaKHH+sEZCDbRsbrbGL7v0gS8YzrqgAX5VCU3vSlW6nropClkj4Q9+ymm5
 WdHNoOnemXierEevUvKunyhewtvFoGC2wSrZzvmny/Lom4Ft9W9ETQP8HipeRkuP9mv9FmHUh
 kOJA5kIqvNMNbI1hFgv4H8N/wkE/pRocEjpSgqoVY2ZkaGracX1UaGzvYLBjtTPla0Pq6gTX4
 QPBnEnvCXNuCCP1xJwf0p0IB+pnsqzNe/dFNFFlSej9ytJvQZoVfhp+IPV3u0vdFt4LlvZJuR
 m9PEl9ajaxDEgnFyfkGxoYCmwnG82v68EGGA95EHgV/SDQvFYvUqUPcJNwwbG7rojo3LTiFGE
 h5Sdse4CTTLacofB3gj1T6GP8l5Yo5CJHT/luXhcHaGk/0h+sBsGtR5CJHbHdRz+1G0ROV+Se
 iGCxaXf0xI39x1T6y/5XxL9fkBmARg8IRVPq9iZBsp9NvZR9EnFrmCLPhBoT4zfXomb2TO1Xn
 79g399gNsvZX1DrbLKT4Dv9BCDnqJ5aU9QYyh+0/nC28f3LRlhxgXvRGF/pHYf96eVOnzuiHu
 sRyIOrd5E8Ob0+rwRUvVEJKd9xJD8gFLNkZ/YA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/amba-pl010.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 109b8df..7abd1f8 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -503,7 +503,7 @@ static const char *pl010_type(struct uart_port *port)
  */
 static void pl010_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -511,7 +511,10 @@ static void pl010_release_port(struct uart_port *port)
  */
 static int pl010_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE, "uart-pl010")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       UART_PORT_SIZE,
+				       "uart-pl010")
 			!= NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

