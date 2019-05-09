Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025B72053B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csVtQtV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEIFms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:42:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46440 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfEIFms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:42:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi2so544400plb.13;
        Wed, 08 May 2019 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s2x7LoSc32lEvDkAoL480aj+nvBiwY0CVx5bvNfBU9w=;
        b=csVtQtV2inpBwOs4SzreziyFUbTddSpdZwh3TtZNEKES3WBzVVfQo22rH99jXdchRj
         wdTcbhtY/wbeexkXvyEZzixQCc8C0AKTeMmAOamYGlEG75/OYQA9qAV07CeFlu3YwBzW
         1+WXafAjmM7iDnCRsG8iyWsG+fj5pYAzcXU5ockry1mnvf+h/Y9ZcI3wuugepWGOnket
         SEzYoDv4J8t1L9ePPQNDqYHSxss1AsK2/pgcPCMPQFEY4fvDt5uHzV7vVge7ubb0ivOG
         mfSSfq11dvQ/FuF2egKLlrMcG0GEsffVGzknWnLT+e76XEqo3xOigAr5+TgxcZ7LKBeW
         IxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s2x7LoSc32lEvDkAoL480aj+nvBiwY0CVx5bvNfBU9w=;
        b=nEskWZB5ZTZiVNyOXq6UNlpHRYqSR6lHwuZ7dFCVKhx1lWVUvJOiG3cm0fDhVEv5Hr
         q9acJQ/P0cRrn4v4fo69WzpsPz6YCQdFAwAIdFDGom9HBHCxgbsHnv9gX17MJXCY065r
         bsjdJwXxUvjD6GPvaP7VHaCsX3EVTWxjQ9OtHVYDYxzfa1n/0gWX4RWgLOFQLuqB7Gsj
         aLRt1h6DRPVQGlcoiy9a3rADcDaVhjNQ+DB32xQrDup3dVZJFsT93R74CrkhMG7WQZ+n
         LlTfrFT05Ofq4G6XICgR0RhePnVDStIeZlr5X4dDKlwnH3s6UWyB/Vfwn1q3EbV8E39q
         vOvQ==
X-Gm-Message-State: APjAAAU2dba/KEbTuQhHcVPaykky+5Vuc60Ry6MouPBZ3RbNYCW0GDgl
        uaqSdUOPn3awHEBpfoz6x6eNZ8OH
X-Google-Smtp-Source: APXvYqze8v6crZWAl58N5X/Scx9NrUlvHZ/iyQMejrI8ikqUnJl0inftxptETIK8zBoZb48dU+v3Jw==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr2749122pla.48.1557380567984;
        Wed, 08 May 2019 22:42:47 -0700 (PDT)
Received: from sh04182tmp293.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 2sm1881814pgc.49.2019.05.08.22.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 22:42:47 -0700 (PDT)
From:   Lanqing Liu <liuhhome@gmail.com>
To:     baolin.wang@unisoc.com, baolin.wang@linaro.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     lanqing.liu@unisoc.com, liuhhome@gmail.com, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        chunyan.zhang@unisoc.com, orson.zhai@unisoc.com,
        zhang.lyra@gmail.com
Subject: [PATCH] tty: serial_core: Fix the incorrect configuration of baud rate and data length at the console serial port resume
Date:   Thu,  9 May 2019 13:42:39 +0800
Message-Id: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace opens a serial port for console, uart_port_startup()
is called. This function assigns the uport->cons->cflag value to
TTY->termios.c_cflag, then it is cleared to 0. When the user space
closes this serial port, the TTY structure will be released, and at
this time uport->cons->cflag has also been cleared.

On the Spreadtrum platform, in some special scenarios, like charging mode,
userspace needs to close the console, which means the uport->cons->cflag
has also been cleared. But printing logs is still needed in the kernel. So
when system enters suspend and resume, the console needs to be configure
the baud rate and data length of the serial port according to its own cflag
when resuming the console port. At this time, the cflag is 0, which will
cause serial port to produce configuration errors that do not meet user
expectations.

To fix this, assigning the TTY->termios.c_cflag value to uport->cons->cflag
before the userspace closes this console serial port. It will ensure that
the correct cflag value can be gotten when the console serial port was
resumed.

Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
 drivers/tty/serial/serial_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f..f233cf8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1539,6 +1539,7 @@ static void uart_set_termios(struct tty_struct *tty,
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_port *uport;
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
@@ -1553,6 +1554,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	}
 
 	pr_debug("uart_close(%d) called\n", tty->index);
+	uport = uart_port_check(state);
+	if (uport && uart_console(uport))
+		uport->cons->cflag = tty->termios.c_cflag;
 
 	tty_port_close(tty->port, tty, filp);
 }
-- 
1.9.1

