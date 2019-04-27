Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE31C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977CE2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfD0MxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfD0MxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:16 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ5nE-1h759i2pEm-00M2Ff; Sat, 27 Apr 2019 14:52:38 +0200
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
Subject: [PATCH 06/41] drivers: tty: serial: sb1250-duart: use dev_err() instead of printk()
Date:   Sat, 27 Apr 2019 14:51:47 +0200
Message-Id: <1556369542-13247-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:virapGaLe72N04lun9WdAKkbszb/ggQMqOiOUSHBcLWgpMmeSap
 mBYtyGLtkO8bfsb4eQ43Ka/Pvv/b4cCI/WGEqijtDJEFEcNTc93ifR7R/FI82p+Et0Hzuoy
 6Mqe+toYlTBM2KOFgvujwEBfyVHzntqNkA4zWfZ1M4ILi8IQFR+Hd6QOrw7CXV2bkioPk2/
 824zpPHm55RHdm67u7Kxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJOyTKZqpIg=:tp2oVLfWX5tgJwhU7rJw/s
 5xC3YkCNU9Clc7T8duZDvMjLNAqv/hMeDkuQQSl0VFwB/77Xz/6uLhmENAywHnQ/tv5KQ7k+P
 X9UWHtEtD0eICFfIuNQEVk8Q1vsrEuNpiCnIVQ6AMEHCRTcnAaveMmnXgfeMDyhFJuwk0nf9L
 DQALyFq0RsHbgzwO4tPR+AHmL8LxevQNFrS6XnH3aHQhZHr2GCgH6P4TJOTYEtv/LqtPy4mVx
 ZCTsD5oD1hBA+QVf0Pd0xggJm7VCPpuIHTXK3+8waBmtVcTiONHpiiLJ8LfXX5ZlVudpg3fJs
 7Km2WOt6iHbRSSP2BK9YWglzHwTAjjGfFFXZX5yZB2VBzzFOHrx8eh/DApk430FdXIzKK+KXW
 CsVOucv0ERWvtQeWpdeOgZArjzFR+5/OAcw1rQ0/vzqSfqwgmxfG68VyYt/9gWidW+AZLD4IL
 VuuJLLLY+/ieyyWwCeF54XzbHWRkg65H4yD9Gib1If0oHkvzZ5bsH78my7Ab2SNUDFkxkalbY
 xRmVs2FRPXJhn3TaJlzs61kfXrxC4ykInMr4wqMqSVZwyFWNiCF9CyaKAQIV8R9zy8hHjFMKv
 MtfTaICEo7G2x/KLhs20qcpKTe2pGkj5pAmeRCK2KtaY+K3mfJcJW4Cchqv6Cc3SbiOKg5Cyj
 WIzWAlTpHhNJJdD/7UdFKP76U5ka0AcjgmnSylZj6f6d9Z3HzklBnnFCCZ0CvEuEzTICYXIxC
 r7oQERNUs9tETo/js3nNih5wcVWQ8qeBOPu63Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced..655961c 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -663,7 +663,6 @@ static void sbd_release_port(struct uart_port *uport)
 
 static int sbd_map_port(struct uart_port *uport)
 {
-	const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
@@ -671,7 +670,7 @@ static int sbd_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 DUART_CHANREG_SPACING);
 	if (!uport->membase) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
@@ -679,7 +678,7 @@ static int sbd_map_port(struct uart_port *uport)
 		sport->memctrl = ioremap_nocache(duart->mapctrl,
 						 DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
 		iounmap(uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
-- 
1.9.1

