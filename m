Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB3821874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfH3KId convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:08:33 -0400
Received: from is-comm2.is-ol.de ([159.69.231.212]:59856 "EHLO
        is-comm2.is-ol.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfH3KIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:08:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by is-comm2.is-ol.de (Postfix) with ESMTP id 4935D15F57F;
        Fri, 30 Aug 2019 09:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at is-comm2.is-ol.de
Received: from SSSDEEX.i.sigma-surface-science.com (p50937f79.dip0.t-ipconnect.de [80.147.127.121])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by is-comm2.is-ol.de (Postfix) with ESMTPS;
        Fri, 30 Aug 2019 11:59:02 +0200 (CEST)
Received: from SSSDEEX.i.sigma-surface-science.com (172.27.0.81) by
 SSSDEEX.i.sigma-surface-science.com (172.27.0.81) with Microsoft SMTP Server
 (TLS) id 15.0.913.22; Fri, 30 Aug 2019 11:58:42 +0200
Received: from SSSDEEX.i.sigma-surface-science.com ([::1]) by
 SSSDEEX.i.sigma-surface-science.com ([::1]) with mapi id 15.00.0913.011; Fri,
 30 Aug 2019 11:58:42 +0200
From:   =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
Subject: [PATCH] serial: max310x: turn off transmitter before activating
 AutoCTS or auto transmitter flow control
Thread-Topic: [PATCH] serial: max310x: turn off transmitter before
 activating AutoCTS or auto transmitter flow control
Thread-Index: AdVfGB6E5SXElxQNQ2i0pQLfeo3BQw==
Date:   Fri, 30 Aug 2019 09:58:41 +0000
Message-ID: <bd9fb8e75d0e45218eb110c25bb539ef@SSSDEEX.i.sigma-surface-science.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.0.74]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As documented in the data-sheet, the transmitter must be disabled before
activating AutoCTS or auto transmitter flow control. Accordingly, the
transmitter must be enabled after AutoCTS or auto transmitter flow
control gets deactivated.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index fb5a7e0e58e9..adfef6dae4a7 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -860,6 +860,15 @@ static void max310x_set_termios(struct uart_port *port,
 max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);

+/* Disable transmitter before enabling AutoCTS or auto transmitter
+ * flow control
+ */
+if (termios->c_cflag & CRTSCTS || termios->c_iflag & IXOFF) {
+max310x_port_update(port, MAX310X_MODE1_REG,
+    MAX310X_MODE1_TXDIS_BIT,
+    MAX310X_MODE1_TXDIS_BIT);
+}
+
 port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);

 if (termios->c_cflag & CRTSCTS) {
@@ -878,6 +887,15 @@ static void max310x_set_termios(struct uart_port *port,
 }
 max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);

+/* Enable transmitter after disabling AutoCTS and auto transmitter
+ * flow control
+ */
+if (!(termios->c_cflag & CRTSCTS) && !(termios->c_iflag & IXOFF)) {
+max310x_port_update(port, MAX310X_MODE1_REG,
+    MAX310X_MODE1_TXDIS_BIT,
+    0);
+}
+
 /* Get baud rate generator configuration */
 baud = uart_get_baud_rate(port, termios, old,
   port->uartclk / 16 / 0xffff,
--
2.22.1


Sigma Surface Science GmbH, Idsteiner Str. 78, 65232 Taunusstein. Amtsgericht Wiesbaden, HRB 27422. Geschäftsführer: Norbert Nold
