Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16FC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31E206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LVR+txnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfLMAHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbfLMAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so546224pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4b6/yjzi5Wqvr2AKScUxOfFqYlv/RC0JhB1xD4j/o58=;
        b=LVR+txnMVMqv2G6nuSfSSpznJ/8g8tRKsMrLWyfEjOUEgh2zQn/WymLY7ZIG16I0nx
         31x97ux2TYsjCrPxzvw+Qpg+q3Oht//rBVQth8qaBr/sv8SgJUQs9Mj5a44x+Q9qzvWt
         vI6dkGHe1rVh7OkNunVSxGSCMWWVKsp1yqxM0cvXq+6ucVlFfkbfuNoTMVG2dEUVkcE+
         B8q8nbYihcxOK2qaXzbBKBMwSb4AGF3q+ogZSJ+ikYjxDRlYO4/WD3eJWJbGf94D3WW3
         nYmPi2ItEs0B46dlVbGGVsHcPXGfyNMR3VYTZZlQugFCq5L5ARJuU/d9F0HeJiqVpbJR
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4b6/yjzi5Wqvr2AKScUxOfFqYlv/RC0JhB1xD4j/o58=;
        b=lugvySThemain13Hotf9gzQ1DbnHBQxP5EHaxPPa8jbo5mAOEbURxY5tmPDRqbqH+Z
         MLZu0X8Bzoh0U3TELKRj3cXvporg7+Stg13R6suIIOR1VwUUhHVBrOylTPkUC2QMcUyR
         QQE2jwPX1ZxhQ4GxdosFSxjL5ahxEpC5cKYyg2JXKDds6fYd4DmKf0JI1VOCxx8F+n9W
         eUfTEE4474ZIBEU3yvf65I1+OhfT/Fs06PLWALPkYQodnchz4C6xrlpdvLpYPi94JOrP
         AbY6Q/G6tDgyIsu7dNqfvh/ll1Uw5xCEHie4DqDsk74o+qR5AQF4Jiwuf8A8jn/0pcQR
         XkJg==
X-Gm-Message-State: APjAAAVRLY/DC0xwaZU+6kgbQTIIB9ZEfmHrfvAwMglIjts7inHfZ21p
        AMSdq6Pou4ENmOqUyAbBDGDMEvcleZw=
X-Google-Smtp-Source: APXvYqxFYCiciNaM1IW9YxK6CCYex9S4oZ0u9ws733zfIsf+2UJFfvlc3t5MmD9AJ/w/SaTjIi0LwQ==
X-Received: by 2002:a63:696:: with SMTP id 144mr14269710pgg.260.1576195642697;
        Thu, 12 Dec 2019 16:07:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:21 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 03/58] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
Date:   Fri, 13 Dec 2019 00:06:02 +0000
Message-Id: <20191213000657.931618-4-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ is messy: every .c source should define it before
including "serial_core.h" if sysrq is supported or struct uart_port will
differ in sizes. Also this prevents moving to serial_core.c functions:
uart_handle_sysrq_char(), uart_prepare_sysrq_char(),
uart_unlock_and_check_sysrq().

It doesn't save many bytes in the structure, and a better way to reduce
it's size would be making rs485 and iso7816 pointers.

Introduce `has_sysrq` member to be used by serial line drivers further.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/serial_core.h | 77 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bbbe57bf5163..5f761c399282 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -240,14 +240,13 @@ struct uart_port {
 	resource_size_t		mapsize;
 	struct device		*dev;			/* parent device */
 
-#if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
-#endif
+	unsigned char		has_sysrq;
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-	unsigned char		unused[2];
+	unsigned char		unused;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
@@ -461,31 +460,46 @@ extern void uart_handle_cts_change(struct uart_port *uport,
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
 
-#if defined(SUPPORT_SYSRQ) && defined(CONFIG_MAGIC_SYSRQ_SERIAL)
 static inline int
 uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (port->sysrq) {
-		if (ch && time_before(jiffies, port->sysrq)) {
-			handle_sysrq(ch);
-			port->sysrq = 0;
-			return 1;
-		}
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
+		return 0;
+
+	if (!port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		handle_sysrq(ch);
 		port->sysrq = 0;
+		return 1;
 	}
+	port->sysrq = 0;
+
 	return 0;
 }
 static inline int
 uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 {
-	if (port->sysrq) {
-		if (ch && time_before(jiffies, port->sysrq)) {
-			port->sysrq_ch = ch;
-			port->sysrq = 0;
-			return 1;
-		}
+	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
+		return 0;
+
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ))
+		return 0;
+
+	if (!port->sysrq)
+		return 0;
+
+	if (ch && time_before(jiffies, port->sysrq)) {
+		port->sysrq_ch = ch;
 		port->sysrq = 0;
+		return 1;
 	}
+	port->sysrq = 0;
+
 	return 0;
 }
 static inline void
@@ -493,6 +507,11 @@ uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 {
 	int sysrq_ch;
 
+	if (!port->has_sysrq && !IS_ENABLED(SUPPORT_SYSRQ)) {
+		spin_unlock_irqrestore(&port->lock, irqflags);
+		return;
+	}
+
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
@@ -501,17 +520,6 @@ uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
 }
-#else
-static inline int
-uart_handle_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
-static inline int
-uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
-static inline void
-uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
-{
-	spin_unlock_irqrestore(&port->lock, irqflags);
-}
-#endif
 
 /*
  * We do the SysRQ and SAK checking like this...
@@ -523,15 +531,16 @@ static inline int uart_handle_break(struct uart_port *port)
 	if (port->handle_break)
 		port->handle_break(port);
 
-#ifdef SUPPORT_SYSRQ
-	if (port->cons && port->cons->index == port->line) {
-		if (!port->sysrq) {
-			port->sysrq = jiffies + HZ*5;
-			return 1;
+	if (port->has_sysrq || IS_ENABLED(SUPPORT_SYSRQ)) {
+		if (port->cons && port->cons->index == port->line) {
+			if (!port->sysrq) {
+				port->sysrq = jiffies + HZ*5;
+				return 1;
+			}
+			port->sysrq = 0;
 		}
-		port->sysrq = 0;
 	}
-#endif
+
 	if (port->flags & UPF_SAK)
 		do_SAK(state->port.tty);
 	return 0;
-- 
2.24.0

