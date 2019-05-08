Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08845C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE3A20656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksWsDbG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEHKo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:44:57 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42668 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfEHKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:44:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id y10so10520511lji.9;
        Wed, 08 May 2019 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uo6IowrDKy5xO74vMPNp+4alps7YeBhIIa0E2z+OC4I=;
        b=ksWsDbG033ZNAM/bhOkqJv7bItU8lGJLybn6jQjQ0FJCjLlKLUmUMYW+g+dH8syvr7
         SRGckmSOrT+RwIZdM9Oq4jMwufhX7fWyPb+gzLRg+92UaZjvFbZROf9MfwGNs4sRS9b6
         J9hloBDnwBwCg9eb0PpLz76GGThiYP0h+dMzi9hnUg3hYgiH/FfVepP0JOLJCVXSvYqC
         Wp8IYf1VrWc9WbR7B7frq+VUUNat5Ya1qh9pOFQE2uz4V3H52HHBU+9oTkFhKwnG0VOL
         WSJQv0lckvTBXG3iMKB51dkAbMMfCQyFfm2hzgISbcasBiApgAaIXMWt5NO0dkQHXldT
         hWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uo6IowrDKy5xO74vMPNp+4alps7YeBhIIa0E2z+OC4I=;
        b=U8Va7KL3lcKsqt8rZ8KcM962SqMdTQdUcNzqpaVxWnhgEt6maF7uzGIBHHPzsbUuZ+
         7mU+8mORrmc9q/ORnH+x2vDefb1LtVV6iTGbgiNEBfpoHUwph+CphQslVXBQHtwJQzYg
         mB77kYNWm9mdKUH8larOHEe+e/Z1eS6xQxIREduY4QsbHbeGNUrKFjK5QyNS4NzKI7wT
         iCOpI9YGw10bqJtpJmj97JAWmn4WF66HWm3ktah/C5NSNzmRYURQdbovlgUwytq2QCQG
         f4DFsp7XvJALWqyKG74YYX4+5BKW8iM8z4B+PCzlfJ+F4XPed7WGvZwLkDIe10+6wnOK
         JKUw==
X-Gm-Message-State: APjAAAVKpsskHF19Ry6pHpP3CI3nXJZH2HRe/Xl8F9acY0gnfpGpqksL
        8BJvooFQGBtbZb5UIr/Hc80=
X-Google-Smtp-Source: APXvYqz1yV3Og4tgavJ7jYF8TahNSxe9f0BkuWTgO7caJeJH4zHFwUizxFbRctkv5B94vfYcHinruQ==
X-Received: by 2002:a2e:1b8a:: with SMTP id c10mr14788678ljf.139.1557312293344;
        Wed, 08 May 2019 03:44:53 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id 17sm2081193lju.3.2019.05.08.03.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 03:44:52 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial_core: Set port active bit in uart_port_activate
Date:   Wed,  8 May 2019 13:44:41 +0300
Message-Id: <20190508104441.16842-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/tty/serial/serial_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f847c0..9113e07952d1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1776,6 +1776,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
+	int ret;
 
 	uport = uart_port_check(state);
 	if (!uport || uport->flags & UPF_DEAD)
@@ -1786,7 +1787,11 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
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
2.21.0

