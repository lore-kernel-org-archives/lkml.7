Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D920863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDH+kg9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCDI7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:59:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44209 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:59:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so2523977pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OH4/R/+Sw0xSAT1PY7Jcu+TD5xcCuEZT5i9WHOVRd/E=;
        b=FDH+kg9UlgZpIFtvEodb8mfZQhQOH8YRfJPwwzImeazPa5C5/NKN3xyUNQ4rqN43q5
         R9AB+rMf8FM8Niht2E1eS/Lb3mrPXyusbytrhShjHP3Eks18Os9iewfx1QbnOU0olPeJ
         GJ3iuGTBFaY3MT93Y/mv1dmBy09HFoui6EhFS4CY0UEjOIv8gyOePLscoAcGgokUoWhJ
         Slw8R80+y9W3tS493V3ipvX7guXngBmkQx9ep16nHEG6Gr4mSXtBOC92kKVFEmRNMh5s
         or3RlyudWjQF2MXphUqcLiOwT8ftsj0wjSiWpNP77ZvCyveznMRQa+CjFmISBMD8rvIk
         3rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OH4/R/+Sw0xSAT1PY7Jcu+TD5xcCuEZT5i9WHOVRd/E=;
        b=nTdqp1W7mPuOtkSkly1/aPlgZm/2begjn+6YL8vx9otOpRkfVv/gOLcSByZJxVERmO
         zO6lXz2K3AdZsYpfgLbR+ESmA1WEbMRahwEVDo7XnPlV53GqlnBeGN4dM9jkZxKJSndq
         K3ylGR0V4l1dNEfBmOomdsEAM3k/iMjxaRtKcNOa2qVL9o0bvSqgHe7ryNpv9Bfb8trW
         9YMSRF+mz5kVr+0+epEtNwJWOcxJS7ntf5Ctj1iYlF9JOloqan/yg0sGFRCK3xsNS4fh
         et6/gd3fkN5Ia3bdjjf7CyGiGIQ0FvT4tbfsHjfs5lIC4C2LJQLLO4/qTUiN7E5eL0ga
         UXQw==
X-Gm-Message-State: APjAAAWU6xK5wbgUC5qd4DCi5S6T3QjoR7jCyz3QaldeOW2mGef3Ojty
        f/5IBz9NPBorxjtYq9dWJC+Jcg==
X-Google-Smtp-Source: APXvYqzej7+O6H4GMiw0VMsp3w16KI/ZZVuWuMquOThvKLIvZd4AyrVjwnAR9RuwKzS35CZZ+ZsP0w==
X-Received: by 2002:a63:104e:: with SMTP id 14mr17440216pgq.185.1551689959930;
        Mon, 04 Mar 2019 00:59:19 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k8sm7395523pgg.75.2019.03.04.00.59.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 00:59:19 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        mark.rutland@arm.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] serial: sprd: Add power management for the Spreadtrum serial controller
Date:   Mon,  4 Mar 2019 16:58:22 +0800
Message-Id: <904abaadecc22f8cbcfe0370ca30dc5c9ac52c11.1551689518.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1551689518.git.baolin.wang@linaro.org>
References: <cover.1551689518.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

This patch adds power management for the Spreadtrum serial controller.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |   61 +++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1891a45..8f45b66 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -100,10 +100,12 @@
 #define SPRD_IMSR_TX_FIFO_EMPTY	BIT(1)
 #define SPRD_IMSR_BREAK_DETECT	BIT(7)
 #define SPRD_IMSR_TIMEOUT	BIT(13)
+#define SPRD_DEFAULT_SOURCE_CLK	26000000
 
 struct sprd_uart_port {
 	struct uart_port port;
 	char name[16];
+	struct clk *clk;
 };
 
 static struct sprd_uart_port *sprd_port[UART_NR_MAX];
@@ -491,6 +493,22 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
+static void sprd_pm(struct uart_port *port, unsigned int state,
+		unsigned int oldstate)
+{
+	struct sprd_uart_port *sup =
+		container_of(port, struct sprd_uart_port, port);
+
+	switch (state) {
+	case UART_PM_STATE_ON:
+		clk_prepare_enable(sup->clk);
+		break;
+	case UART_PM_STATE_OFF:
+		clk_disable_unprepare(sup->clk);
+		break;
+	}
+}
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -507,6 +525,7 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	.request_port = sprd_request_port,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
+	.pm = sprd_pm,
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
@@ -671,11 +690,45 @@ static int sprd_remove(struct platform_device *dev)
 	return 0;
 }
 
+static int sprd_clk_init(struct uart_port *uport)
+{
+	struct clk *clk_uart, *clk_parent;
+	struct sprd_uart_port *u = sprd_port[uport->line];
+
+	clk_uart = devm_clk_get(uport->dev, "uart");
+	if (IS_ERR(clk_uart)) {
+		dev_warn(uport->dev, "uart%d can't get uart clock\n",
+			 uport->line);
+		clk_uart = NULL;
+	}
+
+	clk_parent = devm_clk_get(uport->dev, "source");
+	if (IS_ERR(clk_parent)) {
+		dev_warn(uport->dev, "uart%d can't get source clock\n",
+			 uport->line);
+		clk_parent = NULL;
+	}
+
+	if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
+		uport->uartclk = SPRD_DEFAULT_SOURCE_CLK;
+	else
+		uport->uartclk = clk_get_rate(clk_uart);
+
+	u->clk = devm_clk_get(uport->dev, "enable");
+	if (IS_ERR(u->clk)) {
+		if (PTR_ERR(u->clk) != -EPROBE_DEFER)
+			dev_err(uport->dev, "uart%d can't get enable clock\n",
+				uport->line);
+		return PTR_ERR(u->clk);
+	}
+
+	return 0;
+}
+
 static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
-	struct clk *clk;
 	int irq;
 	int index;
 	int ret;
@@ -704,9 +757,9 @@ static int sprd_probe(struct platform_device *pdev)
 	up->ops = &serial_sprd_ops;
 	up->flags = UPF_BOOT_AUTOCONF;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR_OR_NULL(clk))
-		up->uartclk = clk_get_rate(clk);
+	ret = sprd_clk_init(up);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
1.7.9.5

