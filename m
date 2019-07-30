Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09BD2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f3jwSZ3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfG3SQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34461 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbfG3SQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so24256650pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X8hLkpiNTOcIMGNmROyV+w/FtAgznL0afZf+kaW+1c=;
        b=f3jwSZ3EQ9GvK4fVs1HrYT6eWXNJzLuiBDiXgH+a9XTQUwb1eOy93OUYR3vkqieVSE
         tC4YOGiz0tPLhXddU9RH/QlGNaPEFCtPk0EG2IwVgSsDCHjFJ0922PL1Cvun02i1xlzc
         Ur2mbzEv7HSZDz12ksiL9gIopzeB/87yCns5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X8hLkpiNTOcIMGNmROyV+w/FtAgznL0afZf+kaW+1c=;
        b=hAxdrFTOD2YGdh9nQ7PMr9j7QpWtYx87jbnvffXBx52N/C5xVc2QEh1YhXGt/3waUx
         6RHU5xAwVGu9CMEcymFT4uSDjHVwfkmnmrQT1j6rW9moFrz70VDmyehNp1s3Tk0uzhgx
         UGS+XJixioCHbzsuBxg7M+0+8nHe1JVo8sChr2Z7c6NThyP2iqGsO2+4k2Wx8QPpsMD7
         dqIGL5DLcFsvNxRp/K6uR2OfKX8atjI711m0Ln9XF0gyL2X8gSrajxplWyETABCdtD3v
         itgnfLT92QREPtLAHYO3WkghguyKO0qwXUnB4YbtT15HrsfnTeYQ0IIurr4+MQyY7TvN
         tLnQ==
X-Gm-Message-State: APjAAAXGdo8KhqOa+cmpLWYt7OFFg1WUYYUlc6KzOxVTAPjHl/B7QYMZ
        pKT5HuUf/2TBa21NxlKSjwWJDG410kjtow==
X-Google-Smtp-Source: APXvYqxxoz2inFV06sgWI8/GJPaap+cnYFKP3l0gEbP2XOuYCnhK/v3QWrXBbYo5msllu20SzT+1OQ==
X-Received: by 2002:aa7:989a:: with SMTP id r26mr30667497pfl.232.1564510594816;
        Tue, 30 Jul 2019 11:16:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v6 44/57] tty: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:44 -0700
Message-Id: <20190730181557.90391-45-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/tty/serial/8250/8250_bcm2835aux.c |  4 +---
 drivers/tty/serial/8250/8250_lpc18xx.c    |  4 +---
 drivers/tty/serial/8250/8250_uniphier.c   |  4 +---
 drivers/tty/serial/amba-pl011.c           |  5 +----
 drivers/tty/serial/fsl_lpuart.c           |  4 +---
 drivers/tty/serial/lpc32xx_hs.c           |  5 +----
 drivers/tty/serial/mvebu-uart.c           | 12 +++---------
 drivers/tty/serial/owl-uart.c             |  4 +---
 drivers/tty/serial/qcom_geni_serial.c     |  4 +---
 drivers/tty/serial/rda-uart.c             |  4 +---
 drivers/tty/serial/sccnxp.c               |  1 -
 drivers/tty/serial/serial-tegra.c         |  4 +---
 drivers/tty/serial/sifive.c               |  4 +---
 drivers/tty/serial/sprd_serial.c          |  4 +---
 drivers/tty/serial/stm32-usart.c          | 17 ++++-------------
 15 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index bd53661103eb..8ce700c1a7fc 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -56,10 +56,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "irq not found - %i", ret);
+	if (ret < 0)
 		return ret;
-	}
 	data->uart.port.irq = ret;
 
 	/* map the main registers */
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119374e1..570e25d6f37e 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -106,10 +106,8 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "irq not found");
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba133437a..e0b73a5402db 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -176,10 +176,8 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..3a7d1a66f79c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2718,11 +2718,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot obtain irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	uap->port.irq	= ret;
 
 #ifdef CONFIG_ACPI_SPCR_TABLE
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b4ec36..1b790cc1c0cf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2346,10 +2346,8 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot obtain irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	sport->port.irq = ret;
 	sport->port.iotype = sdata->iotype;
 	if (lpuart_is_32(sport))
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0ad947..7c67e3afbac7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -687,11 +687,8 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 	p->port.membase = NULL;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error getting irq for HS UART port %d\n",
-			uarts_registered);
+	if (ret < 0)
 		return ret;
-	}
 	p->port.irq = ret;
 
 	p->port.iotype = UPIO_MEM32;
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7e7b1559fa36..c12a12556339 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -884,10 +884,8 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	if (platform_irq_count(pdev) == 1) {
 		/* Old bindings: no name on the single unamed UART0 IRQ */
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get UART IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_IRQ_SUM] = irq;
 	} else {
@@ -897,18 +895,14 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		 * uart-sum of UART0 port.
 		 */
 		irq = platform_get_irq_byname(pdev, "uart-rx");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-rx' IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_RX_IRQ] = irq;
 
 		irq = platform_get_irq_byname(pdev, "uart-tx");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-tx' IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_TX_IRQ] = irq;
 	}
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..03963af77b15 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -662,10 +662,8 @@ static int owl_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (owl_uart_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 35e5f9c5d5be..f879710e23f1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1291,10 +1291,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	uport->irq = irq;
 
 	uport->private_data = drv;
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 284623eefaeb..c1b0d7662ef9 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -735,10 +735,8 @@ static int rda_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (rda_uart_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 68a24a14f6b7..d2b77aae42ae 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -961,7 +961,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 	if (!s->poll) {
 		s->irq = platform_get_irq(pdev, 0);
 		if (s->irq < 0) {
-			dev_err(&pdev->dev, "Missing irq resource data\n");
 			ret = -ENXIO;
 			goto err_out;
 		}
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d5269aaaf9b2..76ffbc7826ae 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1307,10 +1307,8 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
 	u->iotype = UPIO_MEM32;
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 	u->irq = ret;
 	u->regshift = 2;
 	ret = uart_add_one_port(&tegra_uart_driver, u);
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index be4687814353..d5f81b98e4d7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -896,10 +896,8 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	int irq, id, r;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not acquire interrupt\n");
+	if (irq < 0)
 		return -EPROBE_DEFER;
-	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4e6c0c..284709f61831 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1173,10 +1173,8 @@ static int sprd_probe(struct platform_device *pdev)
 	up->mapbase = res->start;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	up->irq = irq;
 
 	/*
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 24a2261f879a..222694352a17 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -927,11 +927,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->fifosize	= stm32port->info->cfg.fifosize;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get event IRQ: %d\n", ret);
-		return ret ? ret : -ENODEV;
-	}
+	if (ret <= 0)
+		return ret ? : -ENODEV;
 	port->irq = ret;
 
 	port->rs485_config = stm32_config_rs485;
@@ -940,14 +937,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	if (stm32port->info->cfg.has_wakeup) {
 		stm32port->wakeirq = platform_get_irq(pdev, 1);
-		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO) {
-			if (stm32port->wakeirq != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Can't get event wake IRQ: %d\n",
-					stm32port->wakeirq);
-			return stm32port->wakeirq ? stm32port->wakeirq :
-				-ENODEV;
-		}
+		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO)
+			return stm32port->wakeirq ? : -ENODEV;
 	}
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
-- 
Sent by a computer through tubes

