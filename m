Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F526C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E27620717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 05:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfIMFBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 01:01:32 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55246 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfIMFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 01:01:31 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46V3Q019Ztz1rK4R;
        Fri, 13 Sep 2019 07:01:28 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46V3Q0126Nz1qqkv;
        Fri, 13 Sep 2019 07:01:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Qp0MvBqXUJc7; Fri, 13 Sep 2019 07:01:27 +0200 (CEST)
X-Auth-Info: lis+tYBhtem9nY2Dg2rwsSxWw1dsvqvbP8FR6yrGmhI=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 13 Sep 2019 07:01:27 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 3656F183626;
        Fri, 13 Sep 2019 07:01:08 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 169B31A8B94; Fri, 13 Sep 2019 07:01:08 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        John Garry <john.garry@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: 8250_of: Use software emulated RS485 direction control
Date:   Fri, 13 Sep 2019 07:01:05 +0200
Message-Id: <20190913050105.1132080-1-hs@denx.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use software emulated RS485 direction control to provide RS485 API

Currently it is not possible to use rs485 as pointer to
rs485_config struct in struct uart_port is NULL in case we
configure the port through device tree.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
Patch is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
commit:
505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"

checkpatch output:
$ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
total: 0 errors, 0 warnings, 43 lines checked

0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.

 drivers/tty/serial/8250/8250_of.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0826cfdbd4063..92fbf46ce3bd9 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -48,6 +48,36 @@ static inline void tegra_serial_handle_break(struct uart_port *port)
 }
 #endif
 
+static int of_8250_rs485_config(struct uart_port *port,
+				  struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	/* Clamp the delays to [0, 100ms] */
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
+
+	port->rs485 = *rs485;
+
+	/*
+	 * Both serial8250_em485_init and serial8250_em485_destroy
+	 * are idempotent
+	 */
+	if (rs485->flags & SER_RS485_ENABLED) {
+		int ret = serial8250_em485_init(up);
+
+		if (ret) {
+			rs485->flags &= ~SER_RS485_ENABLED;
+			port->rs485.flags &= ~SER_RS485_ENABLED;
+		}
+		return ret;
+	}
+
+	serial8250_em485_destroy(up);
+
+	return 0;
+}
+
 /*
  * Fill a struct uart_port for a given device node
  */
@@ -178,6 +208,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->flags |= UPF_SKIP_TEST;
 
 	port->dev = &ofdev->dev;
+	port->rs485_config = of_8250_rs485_config;
 
 	switch (type) {
 	case PORT_TEGRA:
-- 
2.21.0

