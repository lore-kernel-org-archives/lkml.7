Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40992C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227E520838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfHASpg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:45:36 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:40398 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHASpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:45:35 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 089816274C3;
        Thu,  1 Aug 2019 20:45:33 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 1 Aug 2019
 20:45:32 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 1 Aug 2019 20:45:32 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] serial: 8250: Remove check for specific
 mctrl_gpio_init() return value
Thread-Topic: [PATCH v2 3/3] serial: 8250: Remove check for specific
 mctrl_gpio_init() return value
Thread-Index: AQHVSJlMYOgwSyf98EmjTVkXuG4aig==
Date:   Thu, 1 Aug 2019 18:45:32 +0000
Message-ID: <20190801184505.17239-3-frieder.schrempf@kontron.de>
References: <20190801184505.17239-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190801184505.17239-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 089816274C3.AFA37
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
in cases when CONFIG_GPIOLIB is disabled, we can safely remove this
check.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/tty/serial/8250/8250_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index df3bcc0b2d74..e682390ce0de 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1026,10 +1026,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (!has_acpi_companion(uart->port.dev)) {
 			gpios = mctrl_gpio_init(&uart->port, 0);
 			if (IS_ERR(gpios)) {
-				if (PTR_ERR(gpios) != -ENOSYS) {
-					ret = PTR_ERR(gpios);
-					goto out_unlock;
-				}
+				ret = PTR_ERR(gpios);
+				goto out_unlock;
 			} else {
 				uart->gpios = gpios;
 			}
-- 
2.17.1
