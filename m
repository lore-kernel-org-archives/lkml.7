Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67027C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D652184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfCNWfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfCNWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:21 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnZwp-1gfQnb1weL-00jcjx; Thu, 14 Mar 2019 23:34:46 +0100
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
Subject: [PATCH v2 15/45] drivers: tty: serial: uartlite: use dev_err() instead of printk()
Date:   Thu, 14 Mar 2019 23:33:45 +0100
Message-Id: <1552602855-26086-16-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RSoecuiUMCZFKu5zI3Fmkey2Q65perOqK2cY4diVUxs0pMNgGPN
 PalJtmCPaFOSbfC4yBadqBKEZNlvOncF3ajHkufnu5rz1QboqDrdwUmUfiRhC+TgF+g0cbS
 JAE7DLET49TPjeUt1osFGFk20Kwdvucf6IpD2gjUvnVwceSTJfeslXtvexXj65EC854gWo3
 6okcQAIGUF2YtkvTtnAyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FWwdgWppYgs=:W94AFim0QvzBf6t3n2dCL5
 hPsR5ArPLhY9IWEl2ixGTD7ritzbAyx9G/JmIBeUYdk7vlwwOW53nxltuxwi+VIcXY2f8MY7z
 eisYgmkKv3XlU8q5ufnExo46SHv/xNjEZLfFNFJ2Fs4YFznEWgHl2hkiGpsiqBK8q352SvtcD
 hc6CULneGrDS1TKXOZUMx5PVj1mDPOBDvTFeO6KBMwMaDZiYA5PcMQw9xxgHT3Q3oRNuy8t9H
 Q1Tc5aWf9WZmn6J5UuNHMc4+lwaZnbfcIwjKP5/GI6T32PiWjk+R83MCK9LjC1gERWpny9Pd8
 GpfMAheYjUrjW3tZME1pLEd+Og2uw9CgWs5PaY+RPDXRflofmt4+hMmAzPU1rsGZJGPEWU9sg
 z+4mo6FDO+cQXTGA7KVW48RzatuHWiCssx41GtL9vX+T7PC7LX8Whx7tfyx9gCKnXvBHeKn62
 MdqHRHA0XqaxKtXNZXg2mJmZnwqLoYyJP9q0dcbOa+bz/gDZ0bN1Mu0rFmw8p4BP7kE1wN3n3
 D9tY3z/cKKslWoNmVDVYDJ8ulHx/PChE/Eyjn1dz7GVWXjm9D5B28WQw90ALAiZK4x0O2Tt+0
 WbG34ohEc0bLmNEZ9C5LrqvZagjpRmJebG5njAl9z2Y40hRSUUzBuyIfd78hssq9zDYCe3lB6
 x1sZIw5nvHq0TKWRffsANWkbflirk5N6pOHgWYVglAaPi3xSFh+9CcEztzXLcqMeFdHBOOO+D
 c9k2Q/KKmdHMGejs/D7YXJYsTt2ZOJU0S0lPGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b..aa461b8 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -352,7 +352,7 @@ static int ulite_request_port(struct uart_port *port)
 	struct uartlite_data *pdata = port->private_data;
 	int ret;
 
-	pr_debug("ulite console: port=%p; port->mapbase=%llx\n",
+	dev_dbg(port->dev, "ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
 	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
@@ -519,7 +519,7 @@ static int ulite_console_setup(struct console *co, char *options)
 
 	/* Has the device been initialized yet? */
 	if (!port->mapbase) {
-		pr_debug("console on ttyUL%i not present\n", co->index);
+		dev_dbg(port->dev, "console on ttyUL%i not present\n", co->index);
 		return -ENODEV;
 	}
 
-- 
1.9.1

