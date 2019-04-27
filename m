Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8102087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfD0MzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:25 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfD0MxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:17 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPooN-1h7uVt3Uzj-00MrCK; Sat, 27 Apr 2019 14:52:51 +0200
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
Subject: [PATCH 20/41] drivers: tty: serial: cpm_uart: use dev_err()/dev_warn() instead of printk()
Date:   Sat, 27 Apr 2019 14:52:01 +0200
Message-Id: <1556369542-13247-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:gPxg0pvaNEeq5x+UwAsDbHdgypnsGOsK9o3j3foMhaID5KFRvEv
 8AvtdT3OHQsnwoPSUVUVgaG7uGVOSNulOF2BUp5euWPO4xOffryfhmOQh75bfkqTrattPsp
 QFI8+vQMDSRQJ10o81AgQsbvofwXHCA01N/KdcAMGoHFdvQFXnI8JYKNCiQeBe0EpQIxX+K
 rRBN+WvzZqwD0ZWGZ/IRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ju8YRhuhXY=:onNlvZ0aDrqH1/5VH3xxRk
 97sCatc+DPnq24Zb7ZJM6qAh6b3iT6iWeaqZSLN5g857Y4q/gZkpStxTSY0y7/0vVZ2W2K8eN
 hrg8KTsBqdMCfc4qz0COMhhaiMomIx6Ezqf1jP899W3P6VFeOiJceFdEaDUqJ2x0mkdvjcSjR
 P3IZevKXifgjbgM0+HGLwqyrJOuozz0fGHG6voJYrbtD0tdC2lAYE9WFwuLR1ujJzxSkwStdT
 lkylIMBo9lhsNzylPGYzyv4UI8ZZMZrpvojOg3lgZ0vpcI+NQUoteI0P+Wz5lfIyPfcI+6QP5
 bcBDKc9LVTJUAbZrZZUPykDkm6du6zW2r19As2FmM093PScDZCbPR2np4C9780LIVQFScmK7B
 cS6pvNLxOjZG7VrdBAeBHYqG35dNFeg7Y4G/O2pavGZMM/m9VfYlslnOpQpaOA7biLCwDiZ3g
 ORABcZsNz/R1affuaIPOyjUXod5AymqWkBo/t+ZeZW+oS7GqagtrFM+tD6HiEmEJQjSZyfhnf
 bbhVVvk5eNalCXzlFJXa8G2brsHEUR05O/eTzVUCsjKTbU69zjG5Y9jitLl1WIhvZoR1wWDxa
 R6dA3fagJAV0pXITce+DpVexGE7gqSXQvcl0BHe49TekWK+zRLUg8fQRepiwCRKCXuJeJeQ5m
 uDJWEO3RV24ra1DasOhJ8L4Y3zxtMI650z5aczoHnbcvIKn7BzWRl4VXH6ecpN1d35iAhdifu
 qDIdgE2pptfSyvUIDQnzvzrSEC1fksYnQ5U6ig==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err()/dev_warn() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 6 +++---
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index b929c7a..374b8bb 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -265,7 +265,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		 * later, which will be the next rx-interrupt or a timeout
 		 */
 		if (tty_buffer_request_room(tport, i) < i) {
-			printk(KERN_WARNING "No room in flip buffer\n");
+			dev_warn(port->dev, "No room in flip buffer\n");
 			return;
 		}
 
@@ -1155,7 +1155,7 @@ static int cpm_uart_init_port(struct device_node *np,
 	if (!pinfo->clk) {
 		data = of_get_property(np, "fsl,cpm-brg", &len);
 		if (!data || len != 4) {
-			printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+			dev_err(port->dev, "CPM UART %pOFn has no/invalid "
 			                "fsl,cpm-brg property.\n", np);
 			return -EINVAL;
 		}
@@ -1164,7 +1164,7 @@ static int cpm_uart_init_port(struct device_node *np,
 
 	data = of_get_property(np, "fsl,cpm-command", &len);
 	if (!data || len != 4) {
-		printk(KERN_ERR "CPM UART %pOFn has no/invalid "
+		dev_err(port->dev, "CPM UART %pOFn has no/invalid "
 		                "fsl,cpm-command property.\n", np);
 		return -EINVAL;
 	}
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 6a1cd03..ef1ae08 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -67,7 +67,7 @@ void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 		return pram;
 
 	if (len != 2) {
-		printk(KERN_WARNING "cpm_uart[%d]: device tree references "
+		dev_warn(port->dev, "cpm_uart[%d]: device tree references "
 			"SMC pram, using boot loader/wrapper pram mapping. "
 			"Please fix your device tree to reference the pram "
 			"base register instead.\n",
-- 
1.9.1

