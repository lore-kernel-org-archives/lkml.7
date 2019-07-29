Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E198AC41514
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F53205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429292;
	bh=ZBJ79+KNPR3qfgggcd1jIRFTHX+Nclci3drFihOHSog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BdPMcaVK4fxKcY9XB2JJXEtp9u894u0d+dIf3GVUjzqdVAdzWNgavDFN0kFZDz6F1
	 BiJVwxZPxtyMImvsM1heGOSpEv4AMOMgTeNVgfz35+3iNWVZ4Kv9fDUayhEbCCJVuc
	 cXfidqwm6tG91KAN5U0AmhgUYhYS0XHAMK4vBApI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbfG2Tlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389329AbfG2Tl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:41:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF2D205F4;
        Mon, 29 Jul 2019 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429287;
        bh=ZBJ79+KNPR3qfgggcd1jIRFTHX+Nclci3drFihOHSog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy+LOLsMpmLsZYF3BT9MsaJJ4wafl33Sm+hjsLEzJtbEOiX22Ac0Dm0AjCSvL0ccP
         bWq13itetPDqfp9Auo6SIo3dtD+laxkSSf1+2AHFj1ipcpdu/KUSyiXjNwBbblgh6v
         hi6ppYgHRNZ5Ec0I7UoSr8zC/yIkho646L6KtmK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/113] tty: serial_core: Set port active bit in uart_port_activate
Date:   Mon, 29 Jul 2019 21:22:00 +0200
Message-Id: <20190729190703.738844723@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 8dbeb14a1e3a..fe9261ffe3db 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1738,6 +1738,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
+	int ret;
 
 	uport = uart_port_check(state);
 	if (!uport || uport->flags & UPF_DEAD)
@@ -1748,7 +1749,11 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
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



