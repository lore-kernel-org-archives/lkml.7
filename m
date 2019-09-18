Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5796C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CD620640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A46fF7k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfIRIQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:16:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43640 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfIRIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:16:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so3548530pgb.10;
        Wed, 18 Sep 2019 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yiaoTcLMObHEuVBOS7Z0L3j322h3GH76oh+bOCjNQ+M=;
        b=A46fF7k2WxMdNCCWecjkXhZ8lroe2Oul1bU8/jtD2Ry1mNLUae7EhNpBtrSLcUuGJU
         ULXbo1gf0R0B5jNH7oe6PZtaZibGEbWgGP/i6LAzuGlEzjFgNFX4WUWGYoQ1UqCk9Da3
         1mbUZD0bKlIzyfONcK7Q9ZHi6rkuEMNpdJ1pqh8FPelRiGhqNnqtK+K3Y0d+ZXkiapjP
         6BWDVOYDBuzAFeDj8YegzM3zMPZ+0Xp7xU7vlowrqWOU3LR0MNNB8fPJGvoAiL9S9OZO
         IJYwWX4QEJkVeDQfwNXBhU67DZNpxWsoHJNGJprkilpQtac371ot2EutK9xswnmwP6Mi
         duPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yiaoTcLMObHEuVBOS7Z0L3j322h3GH76oh+bOCjNQ+M=;
        b=UnvY2nUYjkkhyY+1vymkcUwDB6AUGcODnx2OSjp3WrozpHNna7JkgX6B9gLuFo3Yb6
         b2FRVivwnqNZDrHDOxossNAgtYCEllUQ0fi440tJEamSk7qneUvZ6rZMn7AE/xMFZCc5
         FcsJC1LU8OExsOPUCs0opiCvvFdD7YiHQlQnspqYInX+6X+6tt76FWX8eM7FbfZgGwW9
         IlC9IHvaG2dnANslwyAQ40N6ce/O8NJZR7tatpfYwex91KG0/ixUwsAZvqFSU2F9gA8w
         sLBvDzvt+98vGc1Xf8lU/EW7cuk4M1rfmAuWwuFYfRjBwL5DofC74WjMRmg17Qt1qH3w
         SuhA==
X-Gm-Message-State: APjAAAX0z1wKzUxDhYZzhb4MXAJhLu0oTSYbJfYOl/qhyg5ED14kfGb1
        UNIStt8NJHKYiBoYJqJ8Tr0=
X-Google-Smtp-Source: APXvYqwT2yFup1iBoL0hIKm06zOvImy36xDiCylfzNCC8lzNkpRwTjkvOm5BJFerxiQ99gU7eyO7+Q==
X-Received: by 2002:a63:2744:: with SMTP id n65mr2762512pgn.277.1568794576552;
        Wed, 18 Sep 2019 01:16:16 -0700 (PDT)
Received: from sh04182tmp293.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y4sm5731309pga.60.2019.09.18.01.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 01:16:16 -0700 (PDT)
From:   Lanqing Liu <liuhhome@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     baolin.wang@linaro.org, lanqing.liu@unisoc.com, liuhhome@gmail.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH] serial: sprd: Add polling IO support
Date:   Wed, 18 Sep 2019 16:15:05 +0800
Message-Id: <a634860d9194cc235298d6d8bbd2282bf6f853c4.1568793195.git.liuhhome@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to access the UART without the interrupts, the kernel uses
the basic polling methods for IO with the device. With these methods
implemented, it is now possible to enable kgdb during early boot over serial.

Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4..579ab41 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -911,6 +911,24 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int sprd_poll_get_char(struct uart_port *port)
+{
+	while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
+		cpu_relax();
+
+	return serial_in(port, SPRD_RXD);
+}
+
+static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
+		cpu_relax();
+
+	serial_out(port, SPRD_TXD, ch);
+}
+#endif
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -928,6 +946,10 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
 	.pm = sprd_pm,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= sprd_poll_get_char,
+	.poll_put_char	= sprd_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
-- 
1.9.1

