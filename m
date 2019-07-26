Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF6AC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE8022BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABSnbEq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGZNZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:25:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44115 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfGZNZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so24798377pgl.11;
        Fri, 26 Jul 2019 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y/+vYtsCysqhzTsUB/MaZnRyWhMQc4pCqw65yISuFeg=;
        b=ABSnbEq7gwAOQcJS4x5BPjR9TjiZ/KtpISxsQmuCXZ9MoBHN4Pk/qbasRPH/bovbz7
         /gabE+SpXbFSM52BcfmH6FOW+cYZpUHrFAGFVh8fizPuqOvg6gscdBzzH4zV6Ra9gFUx
         FS3FcUiD56vmqIGZNdiS1sn2xqSalRXnaG1bbbcMUXctzETi9DMsSuwH8Wp0C5rR5amq
         8fvgvrVz8RmAJN+u3RtWSyqXPljlYlQt/kUcqWvyz48WGOiFZX/2A+4OmZzahiasGzN5
         S7WQQZgSnCHcIMakYAnWg8SjXgfdHZrXYLKUvxDMyhX9MIM4rmqzX4STqIu3Tn1DX5kX
         yhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y/+vYtsCysqhzTsUB/MaZnRyWhMQc4pCqw65yISuFeg=;
        b=s4gvvgKULkccWdS8pCfVJWhFwoaZbrYEXtP9iXW4gjPEyZUUu/TWljY6rLfQKgWDrN
         adzXK44+GQ/0N9bw87ZTTJHeqOICJZVpNy+obVlvLF0r8JtsK/nW/zyk2LrOZm3nCUb3
         VKBIqtsr95QlUVpiAykukc5FQLL12+KI9sMTZJTuQJoJVrJkb+zQIWzLx4G93oa45yQ0
         1LK0evg7ELtvlkVofZSkiMoXCB0JGSoxJVufFU/YDE7ZovFdHH69R2pYxI9huKOP3VAT
         XlraHPeCfSzVCTaO5uso/ihCGb4uO4p/5ZlVAb3QiYqF9+ePLoryy7aBWuDxJ8TIID/z
         Xz9w==
X-Gm-Message-State: APjAAAW2mXPJqv1tRgcEd3Gcwgc00wcxSN1YW1V/AzHGwmKRGrXmh5WL
        uYe0Aizupm4FsRn+11TumSk=
X-Google-Smtp-Source: APXvYqyZxkac6LiJUmd4XgiaCjs6pQWpAXR97GUjfDJ6ofnoz0LFeonQ/46Uw+0sk31ucCSvExwYQw==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr56974280pgb.307.1564147532616;
        Fri, 26 Jul 2019 06:25:32 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id k36sm54544603pgl.42.2019.07.26.06.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 06:25:32 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v4 2/5] build configuration for AST2500 DMA UART driver
Date:   Fri, 26 Jul 2019 18:57:17 +0530
Message-Id: <1564147640-30753-3-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

build config for DMA based UART driver in AST2500.
Total Available  UARTs in AST2500 are 4

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes from v3->v4:
- config name changed to SERIAL_AST_DMA_UART  
- new config AST_UART_DMA_RX_INTERRUPT  introduced 
  for selectin between  DMA interrupt based RX vs timer based uart RX

Changes in v2->v3:
- change logs added

drivers/tty/serial/8250/Kconfig  | 43 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Makefile |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..7052ab0f4894 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -189,6 +189,49 @@ config SERIAL_8250_RUNTIME_UARTS
 	  with the module parameter "nr_uarts", or boot-time parameter
 	  8250.nr_uarts
 
+config  SERIAL_AST_DMA_UART
+        tristate "AST UART driver with DMA"
+        select SERIAL_CORE
+        help
+          UART driver with DMA support for Aspeed BMC AST25XX.
+          this driver supports UARTs in AST2500. It uses
+          DMA channel of DMA engines present in these chips.
+          since this dma engine is used only by UARTs it is not
+          added as a separate DMA driver instead added as a layer
+          within UART driver.
+
+config AST_UART_DMA_RX_INTERRUPT
+	bool "DMA interrupt of UART RX"
+	depends on SERIAL_AST_DMA_UART
+	default y
+	help
+	  This config  is Enabled by default,which means Rx part
+	  of UART is handled by DMA interrupt.
+	  if the version of chip AST2500 doesn't support
+	  DMA interrupt based RX,then Disable this option.Refer
+	  driver code to see how Rx is handled by timer,if Rx
+	  interrupt  is not available.
+
+
+config AST_NR_DMA_UARTS
+        int "Maximum number of uart dma serial ports"
+        depends on SERIAL_AST_DMA_UART
+        default "4"
+        help
+          Set this to the number of serial ports you want the driver
+          to support.  This includes any ports discovered via ACPI or
+          PCI enumeration and any ports that may be added at run-time
+          via hot-plug, or any ISA multi-port serial cards.
+
+config AST_RUNTIME_DMA_UARTS
+        int "Number of uart dma serial ports to register at runtime"
+        depends on SERIAL_AST_DMA_UART
+        range 0 AST_NR_DMA_UARTS
+        default "4"
+        help
+          Set this to the maximum number of serial ports you want
+          the kernel to register at boot time.
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 18751bc63a84..251f2e85efa1 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
 obj-$(CONFIG_SERIAL_8250_MOXA)		+= 8250_moxa.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_SERIAL_AST_DMA_UART)	+= 8250_ast2500_uart_dma.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.17.1

