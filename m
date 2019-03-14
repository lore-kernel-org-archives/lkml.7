Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61472C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B62184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfCNWfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfCNWfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:04 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bCH-1gvJWc0uCR-010bd1; Thu, 14 Mar 2019 23:34:49 +0100
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
Subject: [PATCH v2 18/45] drivers: tty: serial: sirfsoc_uart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:48 +0100
Message-Id: <1552602855-26086-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:pEqS+yFNBBWf5G6twcSYrBP6943zklyRLJUn9hzyF1TXbZEv7FE
 /fqk0BpEo7as7Vqdp/IF6N1tjm35oXPnXS7XEErlbF7pkMBQ8tMJpSUmJHeCSV2Fx58xejU
 5uavxtG1YBdvT89kw4g+iSLUNct9YGK3sJbxqFo2x1WWaGvRxd4z+6Ady+fpSqrhTB1ASNm
 LhIzW/2K+E5D5Tk//jQxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F17me8Z2WW8=:yYzCbvsrd19OMz7N2+iQAU
 bwJEXN8ODvASpvy80DH8h4z9NGaLXUwthKd4XvTPQvpC9GN50YAIv2tqCH+4UhrE4jR065gDX
 uWmDWpFWbWcH/QHBtUxc6VhtEA2vMQALjISbicSokVFE0W14pn9j8G7+SMHnh8glTI4fmdbrt
 F6GaD1gTzOo5FCx4NjAmnv1elQmgHysko+NBGvtYlIWF55FeRl4aqxYsylZA81hdNJkjrr+gR
 f16W7fL0Byk6VwpBd02S9G5MLCvzQxjMDeki02l5Z6YOhyUpUI7cT5C0unQTkgd5P1JUwFdND
 7Sw6nzFO/rpijCCZYmofi/mBFklZhwkBHqln8iukzDSkX6zsebPO6MsWjcd2JbXsPU2PjRtyt
 U58aBvlqbE+2MiW+rrtVRTqxJwhzLuzZfsQOQ5xh4AB8CQ/ME58U4dBV0y4lhyUJEPgvgwnmF
 lBG9apU5NK31KwH/j1uVRNapDSMGVdzVyirgeYVJ3szajR0J6E2X5nE01JCXUB/szcACwAN1L
 KEDNB4P3zCzbC9dTJ2Ylc4Wgp+CZvdLWD7vQ+QO7Bqw86NuYddVGS7Nwk2FryAvTnTCaBShR7
 3hJAjx8wkUHCacIlj8g26Q85HUBJlUjfD+JNc3LQHkft0cv/Pr7zNVDZUh3+V/v0JTVRh67ey
 qy4J7NZIKrCdfbmFOrsnvmauf11/0ty+ZFknDlV+Qmx/h1wk63zUjFLu2Acruq8yps+E5hmLa
 UJy3liUSH2iwCCet5MlGDntCcQuKiuUIrVLaQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sirfsoc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index db2e08d..64ea1e7 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1042,14 +1042,14 @@ static int sirfsoc_uart_request_port(struct uart_port *port)
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
 	struct sirfsoc_uart_param *uart_param = &sirfport->uart_reg->uart_param;
 	void *ret;
-	ret = request_mem_region(port->mapbase,
+	ret = devm_request_mem_region(port->dev, port->mapbase,
 		SIRFUART_MAP_SIZE, uart_param->port_name);
 	return ret ? 0 : -EBUSY;
 }
 
 static void sirfsoc_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, SIRFUART_MAP_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, SIRFUART_MAP_SIZE);
 }
 
 static void sirfsoc_uart_config_port(struct uart_port *port, int flags)
-- 
1.9.1

