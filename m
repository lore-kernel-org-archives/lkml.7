Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0162073B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DsxoXaec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfLMAKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33409 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfLMAKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:10:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so404464pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvnAD1yLF9GgQIu36T7GgNkVG8ZaovS9k11def32GLk=;
        b=DsxoXaecMZhFuQ9HHYo1wLpJR/KXsn91l8qAUKj2Fmht53+CzGnDGhqZhvRAbQIq5h
         PQwa6xxPYVH+f1/g7S1cslltMF37CjvX7pKu54tvmzII5WOa5TxdBTnqS8fBlcKIf0Ng
         uhPSZnyqbMqf2w/12jAi/3ZeK7jLc1cAwd0un7v/GKxiWt6Rw0uQ08U2gPPFVoBJl1IA
         0mSIH9FjJWY9bVGo8NQhApra+Rq/r8216n92yVw6uyt8xoeZNOZf7AFtgTLoC5/nFd1D
         vDzQl7gaKNbNDQid9bumtV8UzNIl7EMmL8TltffMwGcGnDmBKGSXhaO5TRzUnMacBk+L
         IdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvnAD1yLF9GgQIu36T7GgNkVG8ZaovS9k11def32GLk=;
        b=qy3M7p7hWU9BVoZzq3y4GOjfIMC2vQDxxmaQot4ahwBqdhiAvR8oQkOlXgYusU7wOe
         cEkYQ8WtgOSxkE0DxBhEjwLmSh6REMGmHIDMU7u4Vzve9yN6yA2IJWmxXG1LwTpf2Bwp
         /seWR4XCQ43isEPYWxhAy8sF2j79JDb1Zv2ftuCkP+nrdjcj49En94+6n1D2mOCz6v5p
         Co/WpK+7Map3613T9bQw+NXSUx17ReEAhHLUgOk4t2wcVJAAKbyDG63uPKtcYN8NTKte
         6o7p7yrkh9HDGXB8EBIkiBidaB4KLVRpcAbeXb8dfufLwcrpmmI7dRWnqeq9ztSKZl4b
         r6LA==
X-Gm-Message-State: APjAAAUtmYkdLqIId8jmpkk2+aI6lWzT4CrHuhhnVcwnwNlbjGpD8pUI
        nqZ/kYZiTlNkW/pbVm6+BOld7XOCscE=
X-Google-Smtp-Source: APXvYqzOJEsUzplWsJptPWJIAve8pBr8JefnlaBZXWg+ieCxN4q7oTVtzSo4WTQU8dsjSlhb7x2yfw==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr13292832pjb.134.1576195806784;
        Thu, 12 Dec 2019 16:10:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:10:05 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 58/58] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Fri, 13 Dec 2019 00:06:57 +0000
Message-Id: <20191213000657.931618-59-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

As a measure of balance between on and off options, add
MAGIC_SYSRQ_SERIAL_SEQUENCE which is a string sequence that can enable
sysrq if it follows BREAK on a serial line. The longer the string - the
less likely it may be in the garbage.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 52 ++++++++++++++++++++++++++++----
 include/linux/serial_core.h      |  2 +-
 lib/Kconfig.debug                |  8 +++++
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ef43c168e848..4570c99a137a 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3080,6 +3080,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
+
+static void uart_sysrq_on(struct work_struct *w)
+{
+	sysrq_toggle_support(1);
+	pr_info("SysRq is enabled by magic sequience on serial\n");
+}
+static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
+
+static int uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	if (sysrq_toggle_seq[0] == '\0')
+		return 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
+	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
+		port->sysrq_seq = 0;
+		return 0;
+	}
+
+	/* Without the last \0 */
+	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
+		port->sysrq = jiffies + HZ*5;
+		return 1;
+	}
+
+	schedule_work(&sysrq_enable_work);
+
+	port->sysrq = 0;
+	return 1;
+}
+
 int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
@@ -3089,9 +3121,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			handle_sysrq(ch);
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3108,9 +3144,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 255e86a474e9..1f4443db5474 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -243,10 +243,10 @@ struct uart_port {
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
 	unsigned char		has_sysrq;
+	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
-	unsigned char		unused;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1842fe756d5..babc464ce14a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config MAGIC_SYSRQ_SERIAL_SEQUENCE
+	string "Char sequence that enables magic SysRq over serial"
+	depends on MAGIC_SYSRQ_SERIAL
+	default ""
+	help
+	  Specifies a sequence of characters that can follow BREAK to enable
+	  SysRq on a serial console.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.24.0

