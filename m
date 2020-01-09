Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD7C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7CB2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NACYKqJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAIVzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:55:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53907 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgAIVzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:55:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so67905pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzduO3ezdq2YxbApEf/p7n8rWrnulpFMg5X7ZAYRvh4=;
        b=NACYKqJUKlrtSZDdGRKTweW0ZYhfwtIpUyehrAlSEABjHgI3DuvSm1Wh6eObC3hI6U
         4aarbHexpqYc3gVdpOJOyIuRhuV9FsqQgY90zrJy8nj76iIy7xi6uRRYrl6Qfs5dWzzn
         Q3R8gdNHixCz2Mf4yP3wDRJDiRB8zFiDt8Og0SVdu4KaG1mxOpTrp7w5KuwLrS8f317u
         +sOLTcUyIKBH0T9zVnALwzEjl/W4xnDAl4u3qXwzpa50ONEh3l4BUJtnVEhxc4asOSgD
         QnJzrubWX5jDv/8HVnbEyGIWG03VGzXqx5AN4qtyUEISRQFeNsJJBexhjAT2SyloQSV1
         L6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzduO3ezdq2YxbApEf/p7n8rWrnulpFMg5X7ZAYRvh4=;
        b=C7p7UaXSyUWua0ULQ2j5SVvmtLCvV60lMte4ZTy+xLeGRYYsCt88Nuh1tpS6AGlWak
         LRutU3ttOxpfL4s2A0tAoXE88X7mT8WyWeHZF0ujpjP/4Dqj69O7SHMaCBfeT8dKeGgS
         p6Fe2Tkf2pk8pXZwmJ512LcAfCqKUM2Mwd/SffEV7GkrO+r++4Y8XIuap1t+v0TCb1mc
         UxoTlY70B1lQKgr5oZuXLx6w3AXagPxeO+job8PVfgSbRa3cZmidEodEoDW4RgJK2PMy
         zirqv3s8DQPPh2DPtxcDm63bcLPdt1OmY+R0kksct5WPhA+fH/bmpWWf/uInmiBxjijU
         vIag==
X-Gm-Message-State: APjAAAWZOKrk2mdIVeUKJUqsCGM710Lfgoq82B5cQP/Qya3Oxohg2OvZ
        pOvqK/Q4iqomkNGHO9BbqbjdLSv2UpU=
X-Google-Smtp-Source: APXvYqyuhalmHNEKi9rgUlX1W2D500mU/5hrB2Skd8Ar7XDjSAlhUXV0PYnZH6LApctxTDXOELTgYA==
X-Received: by 2002:a17:90a:1b66:: with SMTP id q93mr320993pjq.102.1578606906076;
        Thu, 09 Jan 2020 13:55:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r20sm8711536pgu.89.2020.01.09.13.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:55:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH-next 1/3] serial_core: Move sysrq functions from header file
Date:   Thu,  9 Jan 2020 21:54:42 +0000
Message-Id: <20200109215444.95995-2-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109215444.95995-1-dima@arista.com>
References: <20200109215444.95995-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not worth to have them in every serial driver and I'm about to add
another helper function.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 83 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h      | 84 ++------------------------------
 2 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c2782785736..6ac9dfed3423 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3081,6 +3081,89 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
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
2.24.1

