Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2BC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906D8218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509620;
	bh=p6UHpgjwO37at5y0gpM2mNj68J9UQcIXBrNvevoVx4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKTvYCVVRAb27U7SmXUdAS3nBVNeTOR2w+NAnAGLGb1QYDubPZRdsqpLS+HBCKF4/
	 F6jYsmL9zAo2TxVRCoHH2bbSkXrGXApaQ4yVT16zlE3yz/t1IF+hQJqWpIxzqJYbVY
	 1dP0oCQODzRZquwehXoXAwKlZbogKVQEoiCTW4D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733061AbfGSENj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389233AbfGSENa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:13:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A012D21850;
        Fri, 19 Jul 2019 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509609;
        bh=p6UHpgjwO37at5y0gpM2mNj68J9UQcIXBrNvevoVx4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXrUnPkGXt2uYNhUrUoLzhZebZE9kYX8My2tKHBcCjCS7COFoLHiD1AzkGZpVzTUt
         YYhUkF18lER2kuSN39LLMWVmkw+e6D8aSt+UkBjF2nRzvpaYGKWvkJDyKaXIaPkMc6
         6xLpooJn+SjxKnLNXuZSYIIdexQESj2tYh6Wownk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 16/45] tty: serial_core: Set port active bit in uart_port_activate
Date:   Fri, 19 Jul 2019 00:12:35 -0400
Message-Id: <20190719041304.18849-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 13b18d35909707571af9539f7731389fbf0feb31 ]

A bug was introduced by commit b3b576461864 ("tty: serial_core: convert
uart_open to use tty_port_open"). It caused a constant warning printed
into the system log regarding the tty and port counter mismatch:

[   21.644197] ttyS ttySx: tty_port_close_start: tty->count = 1 port count = 2

in case if session hangup was detected so the warning is printed starting
from the second open-close iteration.

Particularly the problem was discovered in situation when there is a
serial tty device without hardware back-end being setup. It is considered
by the tty-serial subsystems as a hardware problem with session hang up.
In this case uart_startup() will return a positive value with TTY_IO_ERROR
flag set in corresponding tty_struct instance. The same value will get
passed to be returned from the activate() callback and then being returned
from tty_port_open(). But since in this case tty_port_block_til_ready()
isn't called the TTY_PORT_ACTIVE flag isn't set (while the method had been
called before tty_port_open conversion was introduced and the rest of the
subsystem code expected the bit being set in this case), which prevents the
uart_hangup() method to perform any cleanups including the tty port
counter setting to zero. So the next attempt to open/close the tty device
will discover the counters mismatch.

In order to fix the problem we need to manually set the TTY_PORT_ACTIVE
flag in case if uart_startup() returned a positive value. In this case
the hang up procedure will perform a full set of cleanup actions including
the port ref-counter resetting.

Fixes: b3b576461864 "tty: serial_core: convert uart_open to use tty_port_open"
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 680fb3f9be2d..04c023f7f633 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1725,6 +1725,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
+	int ret;
 
 	uport = uart_port_check(state);
 	if (!uport || uport->flags & UPF_DEAD)
@@ -1735,7 +1736,11 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * Start up the serial port.
 	 */
-	return uart_startup(tty, state, 0);
+	ret = uart_startup(tty, state, 0);
+	if (ret > 0)
+		tty_port_set_active(port, 1);
+
+	return ret;
 }
 
 static const char *uart_type(struct uart_port *port)
-- 
2.20.1

