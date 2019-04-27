Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695EDC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C5A208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfD0Mz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:59 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfD0MxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:11 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3UhO-1hKv3E1nDW-000feT; Sat, 27 Apr 2019 14:52:46 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 15/41] drivers: tty: serial: uartlite: fix use fix bare 'unsigned'
Date:   Sat, 27 Apr 2019 14:51:56 +0200
Message-Id: <1556369542-13247-16-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:H9Hq+xMuwfZXnigABXZrW477+wXowxTgyBBLY0HAV0mnCDYh/e0
 TH2w4PbDOyXyM86Lq7DloZ+B8ibFAqHgCXXMWMGOq9YWJ3Y3vlKsyrAZnSi1E5Li5qxc0Ar
 AY0Hr5JlBrCnebDS4GMDfCcj7dIYVLdfUOg6Bcei5qLQJLaC/QfWMzWDYdXhqXpmqWR3y/g
 yAdYT/Wa4x9gI+B2VhpoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R72cmKom1+A=:uOo1mvuTVbiHsgBqriCUht
 6dY33ALRFs0OZberAHetXVBGAXNDyVP94BPwKbiwUt//WjlmiXpuYjDhj83S+8UluwqNM4viT
 EUygzqv1xc+QMQRr3xF+lNxXktgoicejoz188iDU6b6S4cPL882d2sf9ZdLlnzup2HcwAI7JS
 6x49799SF3XTPO+XuJ0llY00fkPDfn4uA39oeLLrbuv3geAjo9xAyCJmxDBfbAu0sxbsCH3zP
 YNow0lDzCPTXwDoEpirK5YCyPkKdesbKHHbH5k0F2gyAIqhE3ImwDRUs+f+pU5My8q2yh31GI
 76c1xKk0HKz7/oSjRMjQTgKb4j5f+Jg0YiHuRH591ObYF8o5/GcnSx9sK1sbrQ3bGRiwU/kJb
 zM4Rb2dpvvIIG5jmO7pDHpI4gtoSrFsbFUAdOkM+tlLe/t3+7X8YK2TGEB77CAte7MikaF2uS
 gX6vi6fZ3vRVEjT7A9bPa9w62Saicp1FrW829mcM16x64QqxG9d1O83+q8mdDGQRRdsksYT/K
 MuelCOp8/rAk/NmhauN9e9GIj7IDtMZONoxnPaO/FgcnC/m+/cQJnC90G6xL8KVH95EwkVKpg
 zS6EfdvWLefNplLeaVuRERQ6ZDLRf4dB2a36zkSg7R+K8VXdOIW155UoxoAEyz6BEetZx2KxO
 e2TjiagXV1RqHzcUn1fCiSg8mcHyfwlToF2LzzqlKHyMA1yBhxDcPoc54bcXj0+qVTC64YpJw
 rptbxTx0/wkORs6LFbtJRaPqlLPPbs2Kr5hC3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #562: FILE: drivers/tty/serial/uartlite.c:562:
    +	unsigned retries = 1000000;

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #574: FILE: drivers/tty/serial/uartlite.c:574:
    +				 const char *s, unsigned n)

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 4c28600..6f79353 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -559,7 +559,7 @@ static void early_uartlite_putc(struct uart_port *port, int c)
 	 * we'll never timeout on a working UART.
 	 */
 
-	unsigned retries = 1000000;
+	unsigned int retries = 1000000;
 	/* read status bit - 0x8 offset */
 	while (--retries && (readl(port->membase + 8) & (1 << 3)))
 		;
@@ -571,7 +571,7 @@ static void early_uartlite_putc(struct uart_port *port, int c)
 }
 
 static void early_uartlite_write(struct console *console,
-				 const char *s, unsigned n)
+				 const char *s, unsigned int n)
 {
 	struct earlycon_device *device = console->data;
 	uart_console_write(&device->port, s, n, early_uartlite_putc);
-- 
1.9.1

