Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B119C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349582186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfH3KHn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:07:43 -0400
Received: from is-comm2.is-ol.de ([159.69.231.212]:59782 "EHLO
        is-comm2.is-ol.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfH3KHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:07:43 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 06:07:42 EDT
Received: from localhost (unknown [127.0.0.1])
        by is-comm2.is-ol.de (Postfix) with ESMTP id 72259161753;
        Fri, 30 Aug 2019 09:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at is-comm2.is-ol.de
Received: from SSSDEEX.i.sigma-surface-science.com (p50937f79.dip0.t-ipconnect.de [80.147.127.121])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by is-comm2.is-ol.de (Postfix) with ESMTPS;
        Fri, 30 Aug 2019 11:58:53 +0200 (CEST)
Received: from SSSDEEX.i.sigma-surface-science.com (172.27.0.81) by
 SSSDEEX.i.sigma-surface-science.com (172.27.0.81) with Microsoft SMTP Server
 (TLS) id 15.0.913.22; Fri, 30 Aug 2019 11:58:35 +0200
Received: from SSSDEEX.i.sigma-surface-science.com ([::1]) by
 SSSDEEX.i.sigma-surface-science.com ([::1]) with mapi id 15.00.0913.011; Fri,
 30 Aug 2019 11:58:35 +0200
From:   =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christoph_Vogtl=E4nder?= 
        <Christoph.Vogtlaender@sigma-surface-science.com>
Subject: [PATCH] serial: max310x: Properly set flags in AutoCTS mode
Thread-Topic: [PATCH] serial: max310x: Properly set flags in AutoCTS mode
Thread-Index: AdVfGD0lgVnKR7hkSuu7VvwpZc9RMQ==
Date:   Fri, 30 Aug 2019 09:58:34 +0000
Message-ID: <47a1918df72a4b28b124a53e055e045a@SSSDEEX.i.sigma-surface-science.com>
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

Commit 391f93f2ec9f ("serial: core: Rework hw-assisted flow control
support") has changed the way the AutoCTS mode is handled.

According to that change, serial drivers which enable H/W AutoCTS mode must
set UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF to prevent the
serial core from inadvertently disabling RX or TX. This patch adds proper
handling of UPSTAT_AUTORTS, UPSTAT_AUTOCTS and UPSTAT_AUTOXOFF flags.

Signed-off-by: Christoph Vogtländer <c.vogtlaender@sigma-surface-science.com>
---
 drivers/tty/serial/max310x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0e24235..fb5a7e0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -859,15 +859,23 @@ static void max310x_set_termios(struct uart_port *port,
 /* Configure flow control */
 max310x_port_write(port, MAX310X_XON1_REG, termios->c_cc[VSTART]);
 max310x_port_write(port, MAX310X_XOFF1_REG, termios->c_cc[VSTOP]);
-if (termios->c_cflag & CRTSCTS)
+
+port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
+
+if (termios->c_cflag & CRTSCTS) {
+/* Enable AUTORTS and AUTOCTS */
+port->status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 flow |= MAX310X_FLOWCTRL_AUTOCTS_BIT |
 MAX310X_FLOWCTRL_AUTORTS_BIT;
+}
 if (termios->c_iflag & IXON)
 flow |= MAX310X_FLOWCTRL_SWFLOW3_BIT |
 MAX310X_FLOWCTRL_SWFLOWEN_BIT;
-if (termios->c_iflag & IXOFF)
+if (termios->c_iflag & IXOFF) {
+port->status |= UPSTAT_AUTOXOFF;
 flow |= MAX310X_FLOWCTRL_SWFLOW1_BIT |
 MAX310X_FLOWCTRL_SWFLOWEN_BIT;
+}
 max310x_port_write(port, MAX310X_FLOWCTRL_REG, flow);

 /* Get baud rate generator configuration */
--
2.7.4


Sigma Surface Science GmbH, Idsteiner Str. 78, 65232 Taunusstein. Amtsgericht Wiesbaden, HRB 27422. Geschäftsführer: Norbert Nold
