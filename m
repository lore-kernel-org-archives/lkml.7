Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32923C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75A620663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge7t9hsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfFYKm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:42:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42129 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfFYKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:42:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9269876pff.9;
        Tue, 25 Jun 2019 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUD+tMWxUyNEXoNHahn2osy5MI7+tyXyOvNepSOjh4w=;
        b=ge7t9hsTcR3LGUDrqBXwqjw49qWv5Rgz8ax8DE3Lhk9C7pu/rAMcy30j3l700kzrj8
         hpQYL56bSvcKS1EV653K41JdPatGWmuZswrHQatZ3e23vqdJ7+nUHn85TR9Fl4DBIcc+
         9uru009+hAUId0uuoocpjlA+Q6q08QwkAZEPBxj+0ydwx509ZaPSl5lpR4tFaXNlGRpk
         tEh2PxrTBleyWL6NjZ0Z3DJmBKlvlUkQZKwIkqrue2i/ZDng204h4ZQqa8T9NWadZr/W
         XcK9bNgmpqas07XiNCB/bb7NBUXX1JHq1hfZ/OSnL18pi4TnVL/Z0MgSHVCIajsJSkA8
         6Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUD+tMWxUyNEXoNHahn2osy5MI7+tyXyOvNepSOjh4w=;
        b=fR4wqAdfYS1SqIdjydll2p7oeQfDbTYQQmy8KlWp/+9ZVZ3gB0+7cu9o89Uh48ae1B
         xr9OpOzeHavOnN7FqUL9Ln4raZooRECucpHqk7t6klXqfn1Eb8MWDLG2fqbixqPiem0K
         DPjHa3NvHdflgcEpon9lPNy083Xx+BtUADm8WY+W/KRoFGP9Pa2CMHbduZT2umiu5fdB
         Wm9zeDFxPlpVcXWNjfbo0xSKpXumWY4BVrDJ46PphFbxCfq53VsS+VcqPtZa62dDGcin
         2jgN3xqoAx2tm4fqIhX1nlSntnl0ErwhEdEms+sjuC3Zc9EQjWcTfjpA3zLcmXlW8EJh
         thLQ==
X-Gm-Message-State: APjAAAWIeysYLa9V9iE3BXFBg3Zdtimn0OgLO9k5KdMNHA2OAtd5MSf8
        QXEPeEdvVuiY+nQaWPNO2bg=
X-Google-Smtp-Source: APXvYqzh7NNRNJB8tQmwbR5EkFdlyRXZlj6SBZqrFHYnlDl7bGB+kVQrfGiKCORsewrjPZYMxaDcwQ==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr38746435pgj.305.1561459377044;
        Tue, 25 Jun 2019 03:42:57 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id 14sm22026759pfj.36.2019.06.25.03.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 03:42:56 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v3 2/5] build configuration for AST2500 DMA UART driver
Date:   Tue, 25 Jun 2019 16:14:33 +0530
Message-Id: <1561459476-14268-3-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

build config for DMA based UART driver in AST2500.
Total Available  UARTs in AST2500 are 4

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v3:
- change logs added

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

