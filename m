Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE8DC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620332070B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyZwnWZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfFPO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:57:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:57:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so7169008wrl.9;
        Sun, 16 Jun 2019 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EohE1hArQHwKn6jzGJF5c0OKmDVC8mwcJ3LIed3WVcI=;
        b=nyZwnWZaNpCC2pexx/gFVBxgIGATsb9VbOYWhg2mNFp1efqOmmSVCpwk/ngFTmznjy
         QVFnpapAOZ8zbrxl3MF7qsEWTFWu3iDsxksgxgWW33YuQ4FMVWEPySM41tN/cQmRIKEc
         INVaDeZUXsBy5xaEnYaeL9V/wZhJLE1w7xcXgX1BDGkMPVCFcF3cemgrideSs+BSHdxw
         E3ZXo6vb5mXYmIdGatMZhHnIOR2Kw3Vj+9kpjyYcbJcl28c0pItuXYAjXuTFy81bxQma
         6Bp1Wwobxu3J5p9+knANrmBez8BBvihYHovpBqsyNw1frUmE1Bwq3FXagjnUTbm4WrXw
         a+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EohE1hArQHwKn6jzGJF5c0OKmDVC8mwcJ3LIed3WVcI=;
        b=QkV7S7WxKse++wH4Y397tBfWql0mbArTnUhK8Zs6/7u2w04jStCVgYsusChXMQ7M93
         FYjcg1j/qyVr0g+JnqggvVpqSTJAwMJcOJ09fh9CoY7OaX4RzGxbolOKM9UUga7iiSES
         FxoGGMLiVLbMqK9Pyvizyo+/p9Zlgks8JRcivcECc3lZNNFHduHuFTXTLlOPohANw2uM
         d5/xGTL2S4+QDiMeRW6ATzHS7LK3HBgrUwMxeaO91niQM/8MPUJGC+7zS99MXVMzBosG
         761t9rShXMmZiJVe1K2a1TXKwR/E6HQ9W/5dFsose834Ho2NsUb4eIu4Irhc4GwcpnBi
         r3hA==
X-Gm-Message-State: APjAAAUH6jZyrz7TEYUwUUGQ2fya8Z6+YA6pFGTV8dUmI5B21C7a/9y1
        6DvwsOy9wbV+Jjvk6y3SrFa0N76H
X-Google-Smtp-Source: APXvYqxHAiO15++mRi+sScOtC6aCoSxoZ7DA9BTOQwHimatfszDLMcPugFD+aXscZG8uws49cmzTiA==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr14709466wrs.320.1560697045512;
        Sun, 16 Jun 2019 07:57:25 -0700 (PDT)
Received: from sahara-mac.darkmatter.uae ([92.96.147.131])
        by smtp.gmail.com with ESMTPSA id l19sm6203302wmj.33.2019.06.16.07.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Jun 2019 07:57:25 -0700 (PDT)
From:   kpark3469@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, keun-o.park@darkmatter.ae
Subject: [PATCH] tty: serial_core: recover uport->cons->cflag on uart_close
Date:   Sun, 16 Jun 2019 18:57:14 +0400
Message-Id: <1560697034-4807-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahara <keun-o.park@darkmatter.ae>

Since uart_close was converted to use tty_port_close, uart_shutdown
also moved to uart_tty_port_shutdown, which means it does not backup
tty's termios to uart_port.console.cflag when console is closed and
uart_console is true.
By losing this value, serial console was not set correctly especially
after suspend/resume when there is no consumer of console device.
This problem resets console driver's configuration to an unwanted value
and may give a performance regression in the system eventually.
This patch fixes the bug introduced from v4.9 kernel.

Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: Jouni Linnamaa <Jouni.Linnamaa@darkmatter.ae>
Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 83f4dd0bfd74..a52afceb2f4e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1533,6 +1533,7 @@ static void uart_set_termios(struct tty_struct *tty,
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport = uart_port_check(state);
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
@@ -1548,6 +1549,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	pr_debug("uart_close(%d) called\n", tty->index);
 
+	if (uport && uart_console(uport))
+		uport->cons->cflag = tty->termios.c_cflag;
 	tty_port_close(tty->port, tty, filp);
 }
 
-- 
2.17.1

