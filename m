Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35164C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEF12073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Hxc7L4l5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfLMAKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38638 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbfLMAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:10:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id a17so389731pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W68U2ZD90t/uLperHJH6QZY5vNXoTiR73B4nzOn7+nk=;
        b=Hxc7L4l5pyeOyjRf8CwgkdyYlf3pwlr7Ql8k4shXBB0yZEIYeZ3+rOEhYGIj08jJsF
         TCTD5288VQM1xwtmLJw6cq4+bXlBlzSo37fpDjGJZuHYE5vt6ZKetIcCMUxckmFdHgLo
         QrUdpBvoIXoHxNqqGYEJfu+KK5mOju5ilYV5Lo0TdKTg5+pma2xzhk8Y87Mg9ZhmdasO
         eHjpN4u0xpihatDmccw6y3VxlNOrkdZgK+cDqDWcMLY4ldPKZWPDgT9HRu0h/tkOpKC5
         fPbyNBCKEokdMgWOG0RSb8gmQEwHE8ErAqD9mThhFXehLLr4VG9/mKyOWD9GOYChXI3y
         abkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W68U2ZD90t/uLperHJH6QZY5vNXoTiR73B4nzOn7+nk=;
        b=EUXvgYNyC4m4h+qhfBKiJcEpeqdexXHoYNqggZRZ7GODlGoOKNmwBDVNrgwK50pqh8
         hvU5dbeCm/x6iNAPQK7W7AYdz833ypTQnqQowONAg9/6bQkXPk+w6QxEB2lKpdEorjBZ
         AaNffe7RbJDmBzHBi5b8UK4G6/8MwP0of25y6HHf20i2ypRa3cYmkzKheQazTBabOJDI
         yLY/wUIX3o+br7ORuaCHAADXRrT/Pj4i0WdzG1Qac1TqvvAf3oRDf51WWQmpkv/fKt77
         BZnhHz2tHutaCdfEcTfPz8DrTTmCt6HlRVTpWNWB5VUKse+lOUpjaLT0cTCOy8EVrZtF
         lpzg==
X-Gm-Message-State: APjAAAV7g2H+go1bLNPpX12NlQASRAvHa84w8vnWpqdLIl1/xGb904u0
        QJ6BDYNKVtpFHS6pkFr6s3stqWnaPW8=
X-Google-Smtp-Source: APXvYqzYt9Y5QatWs+SWB6tlIvCM66OwX3SIh613h/TCNSrxEHKLvAeXzkRU9TMTB5+R8DVOcLa5jA==
X-Received: by 2002:a17:90a:a004:: with SMTP id q4mr13053802pjp.106.1576195800650;
        Thu, 12 Dec 2019 16:10:00 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:59 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 56/58] serial_core: Move sysrq functions from header file
Date:   Fri, 13 Dec 2019 00:06:55 +0000
Message-Id: <20191213000657.931618-57-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not worth to have them in every serial driver and I'm about to add
another one.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 83 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h      | 84 ++------------------------------
 2 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b0a6eb106edb..ef43c168e848 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3080,6 +3080,89 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		handle_sysrq(ch);
+		port->sysrq = 0;
+		return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_handle_sysrq_char);
+
+int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq || !port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		port->sysrq_ch = ch;
+		port->sysrq = 0;
+		return 1;
+	}
+	port->sysrq = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
+
+void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	int sysrq_ch;
+
+	if (!port->has_sysrq) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
+	}
+
+	sysrq_ch = port->sysrq_ch;
+	port->sysrq_ch = 0;
+
+	spin_unlock_irqrestore(&port->lock, irqflags);
+
+	if (sysrq_ch)
+		handle_sysrq(sysrq_ch);
+}
+EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
+
+/*
+ * We do the SysRQ and SAK checking like this...
+ */
+int uart_handle_break(struct uart_port *port)
+{
+	struct uart_state *state = port->state;
+
+	if (port->handle_break)
+		port->handle_break(port);
+
+	if (port->has_sysrq) {
+		if (port->cons && port->cons->index == port->line) {
+			if (!port->sysrq) {
+				port->sysrq = jiffies + HZ*5;
+				return 1;
+			}
+			port->sysrq = 0;
+		}
+	}
+
+	if (port->flags & UPF_SAK)
+		do_SAK(state->port.tty);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uart_handle_break);
+
 EXPORT_SYMBOL(uart_write_wakeup);
 EXPORT_SYMBOL(uart_register_driver);
 EXPORT_SYMBOL(uart_unregister_driver);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 9cf1682dc580..255e86a474e9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -460,85 +460,11 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-static inline int
-uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-static inline int
-uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
-{
-	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
-		return 0;
-
-	if (!port->has_sysrq || !port->sysrq)
-		return 0;
-
-	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
-	}
-	port->sysrq = 0;
-
-	return 0;
-}
-static inline void
-uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
-{
-	int sysrq_ch;
-
-	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, irqflags);
-		return;
-	}
-
-	sysrq_ch = port->sysrq_ch;
-	port->sysrq_ch = 0;
-
-	spin_unlock_irqrestore(&port->lock, irqflags);
-
-	if (sysrq_ch)
-		handle_sysrq(sysrq_ch);
-}
-
-/*
- * We do the SysRQ and SAK checking like this...
- */
-static inline int uart_handle_break(struct uart_port *port)
-{
-	struct uart_state *state = port->state;
-
-	if (port->handle_break)
-		port->handle_break(port);
-
-	if (port->has_sysrq) {
-		if (port->cons && port->cons->index == port->line) {
-			if (!port->sysrq) {
-				port->sysrq = jiffies + HZ*5;
-				return 1;
-			}
-			port->sysrq = 0;
-		}
-	}
-
-	if (port->flags & UPF_SAK)
-		do_SAK(state->port.tty);
-	return 0;
-}
+extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
+extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
+extern void uart_unlock_and_check_sysrq(struct uart_port *port,
+					unsigned long irqflags);
+extern int uart_handle_break(struct uart_port *port);
 
 /*
  *	UART_ENABLE_MS - determine if port should enable modem status irqs
-- 
2.24.0

