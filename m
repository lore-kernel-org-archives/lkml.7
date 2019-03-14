Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207EB21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfCNWhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45381 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfCNWfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:09 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Evp-1h9lL217Kh-006Q6t; Thu, 14 Mar 2019 23:34:51 +0100
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
Subject: [PATCH v2 20/45] drivers: tty: serial: msm_serial: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:50 +0100
Message-Id: <1552602855-26086-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:diJhcXtKr0D9/1hkZLjn+AYb9Hm7J40LLWi5x1os7vmD7rQjq8n
 3bxGMqvIElvCGM73BifRMbUwOFvxrGZEifs0Z3hFJKocT1wm1CRFsh3vC0w7MgHsbmqeLn1
 l5L4Nn633+AouAwf6GZGNXuKFqbJNOmzN6VqXSDgBASKzGng88Sndkk4Wn/BUROPz9gt8QY
 9eAP7TVtiyekp/lSOR46g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qWdwZrcrphM=:Vr4g6+GcLb2UrH5sHtuy7G
 j6THHVI47163HDaXyn/+41uCVvxMTdb8Vccwz3gazk3aCqu+gVphY4WiZeMTV4rIY2Er1gVDj
 An3FU7LhKef8cKXhjnpEgecEw4jF6tE/tdOiz7+jgNyLkoRLakMYz4WqzeM3kOGbrdkVH7bCa
 Jwo78HU4gB6em7EqQzT83KADUbfKNjCxrjHk7+ldawsluv8ETpSr63V8BWGC+8c+5prhaq5KK
 l114KsrEdNsOHxiXD+j54QivTlEF1hK2k/Nz9mtQzgj+6XwZq+EX9AomI6SG8HVYrBcBQFDvC
 SEYIvqTCpQIX8rM30Y5C7115rhYsD8ij9d/GkHkoiA9L4TWC02vFDR/7bmY5I9RA4wslMv1mq
 ohVRNvWfEDBOUzKage64NoPr/yrRPSXNMQPtu3ML56MpHT1SC+AzCFnAQLpT1oDOTh08TDWPP
 1zW/1hLpbV/n7DtRMy3k1Y43XNlTMi3rKUT0oE40aHlVlX+unHI/FymKD8xaT+wrovVlKZ80i
 7tpYOmVeukpTQaDRUBhfVe/D51lKnFJe2bGRJsh/TbZyNkhgoQT/3wHELxbHQagjMfFlcxdar
 vJfjwf75X5t+pDHOoaMLZtt8g/At7ZC17krKlWXDwBHB1JVb4qiI8dGpPzqqSaY1meLQXdp7P
 2rVEOGChkDikRzIeKlJ7zBqkRBP1pcMwZ5/qW2Rit37Geaxk20vgVbY6zq5uKO0qSS5ePf1m3
 Knw6YvC3SksmRcQ34BvMll/UO7d3fqWe7lnl1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/msm_serial.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 1090960..e8e0c87 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1324,8 +1324,8 @@ static void msm_release_port(struct uart_port *port)
 		return;
 	size = resource_size(uart_resource);
 
-	release_mem_region(port->mapbase, size);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev, port->mapbase, size);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
@@ -1342,10 +1342,13 @@ static int msm_request_port(struct uart_port *port)
 
 	size = resource_size(uart_resource);
 
-	if (!request_mem_region(port->mapbase, size, "msm_serial"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "msm_serial"))
 		return -EBUSY;
 
-	port->membase = ioremap(port->mapbase, size);
+	port->membase = ioremap(port->dev, port->mapbase, size);
 	if (!port->membase) {
 		ret = -EBUSY;
 		goto fail_release_port;
@@ -1354,7 +1357,7 @@ static int msm_request_port(struct uart_port *port)
 	return 0;
 
 fail_release_port:
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 	return ret;
 }
 
-- 
1.9.1

