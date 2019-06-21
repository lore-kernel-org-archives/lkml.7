Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078F4C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0E215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn4Tk5lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFULQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:16:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33335 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfFULQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:16:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so2854956plo.0;
        Fri, 21 Jun 2019 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VTdFcOm7CRlTRM81w2wtydH4RXmRokL4phZ/JGHnN6s=;
        b=Jn4Tk5lGNQj1IWGHAbsqZk1saP02PZQK0W27XBlH7+C+MA+xacGU1p9LiEyzqji5iU
         VxWJIUs9bcWrspUtuQFBnGhPFW6dX6g34TENxF263nZKSubHseIXKkRiViZG3lyu9onw
         h+8XADj/kTLDd+LDqtwC8Os7YwfgoG+A6dsUD7wWsKnPNntiMzgJ4ayl9NB8RLZS1uJu
         cUiTJ4esjnkQVt1G+LeNB6NeMjoAuisJxRxGlXmm8m3On5DsNDBIboVDq5/Uk17Q50U7
         S6O2JHFzAKANr6HADyr683BLgFpWaxp9yN4GFcNUNQbQD/FoBjxR72oLn7/8AuZCGH3N
         BIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VTdFcOm7CRlTRM81w2wtydH4RXmRokL4phZ/JGHnN6s=;
        b=povRhkguKgi4OonZyV/evZxtdQIQMPH+hMzRGiSoo52qVHt6TnDY68NYMD3DLNDni7
         IAMQUntJ0tr5aLhIZAoaET1tcXxRVRfm5zThk3/5IKW5hIqLPMpHxlcJbCIodHTE+9+E
         vTQh5RjaoGZGWpF38z2T5y9HwBQPLWmgYFpbzOUnWpoVcKOR7ChV11HV8uePgzrl6XuM
         xSIeI2opK58h4stL8lliz5SJay20q1XVeovo23V9v0M49rKtum7wMkNn3RMwE8gDwS1z
         x/+hyMKBnkKQcHYXRI9I4WPBUFp/PbhgthMl40n2cFA3uuEd7kRC3QBWlpLja0HQDEog
         86iw==
X-Gm-Message-State: APjAAAVNp5EJ46NSA7GK/9K2u+qV6D0rGBFsIiWpMKULmG3+ebbtqyNF
        5WZZ2bkwd37CzWsn9VtU3fk=
X-Google-Smtp-Source: APXvYqx3Ym+DsSadzqC71uLQatiJFRtm6FLzNbco5rONESCMD0bzwqP6ShU8n5RtmTuvQPnjXSIsxQ==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr61025775ply.11.1561115768738;
        Fri, 21 Jun 2019 04:16:08 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id w4sm2405737pfw.97.2019.06.21.04.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 04:16:08 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 2/5] build configuration for AST2500 DMA UART driver
Date:   Fri, 21 Jun 2019 16:47:32 +0530
Message-Id: <1561115855-4186-3-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 drivers/tty/serial/8250/Kconfig  | 35 +++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/Makefile |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..c793466a1c47 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -45,7 +45,7 @@ config SERIAL_8250_DEPRECATED_OPTIONS
 	  keep the 8250_core.* options around until they revert the changes
 	  they already did.
 
-	  If 8250 is built as a module, this adds 8250_core alias instead. 
+	  If 8250 is built as a module, this adds 8250_core alias instead.
 
 	  If you did not notice yet and/or you have userspace from pre-3.7, it
 	  is safe (and recommended) to say N here.
@@ -189,6 +189,39 @@ config SERIAL_8250_RUNTIME_UARTS
 	  with the module parameter "nr_uarts", or boot-time parameter
 	  8250.nr_uarts
 
+config  AST_SERIAL_DMA_UART
+        tristate "AST UART driver with DMA"
+        select SERIAL_CORE
+        help
+          UART driver with DMA support for Aspeed BMC AST25XX.
+          this driver supports UARTs in AST2500,AST2600. It uses
+          DMA channel of DMA engines present in these chips.
+          since this dma engine is used only by UARTs it is not
+          added as a separate DMA driver instead added as a layer
+          within UART driver.
+
+
+config AST_NR_DMA_UARTS
+        int "Maximum number of uart dma serial ports"
+        depends on AST_SERIAL_DMA_UART
+        default "4"
+        help
+          Set this to the number of serial ports you want the driver
+          to support.  This includes any ports discovered via ACPI or
+          PCI enumeration and any ports that may be added at run-time
+          via hot-plug, or any ISA multi-port serial cards.
+
+config AST_RUNTIME_DMA_UARTS
+        int "Number of uart dma serial ports to register at runtime"
+        depends on AST_SERIAL_DMA_UART
+        range 0 AST_NR_DMA_UARTS
+        default "4"
+        help
+          Set this to the maximum number of serial ports you want
+          the kernel to register at boot time.  This can be overridden
+          with the module parameter "nr_uarts", or boot-time parameter
+          8250.nr_uarts
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..54d40e5c6e2a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_MOXA)		+= 8250_moxa.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_AST_SERIAL_DMA_UART)	+= 8250_ast2500_uart_dma.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.17.1

