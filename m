Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24421C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE056212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dn7XWWvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbfFKM0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:26:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40614 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389955AbfFKM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:26:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BCN52Z024862;
        Tue, 11 Jun 2019 14:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=c3Zd6dL5MxcQw3Ref30L3L2qWk7ypqOTnS2TbnWiQhs=;
 b=dn7XWWvDTODculAnfPxrB/I8//viPH9zF49Oi90oJikmQJNGnR1t2ehttAPqWkXW/jKn
 j0x/wKUiaB78X6bBmJuqEENfTJIwh8tzuy64EehqFjwbGs+pHydLW3bymhkvR3g3hEaK
 a6liRryndHFtdwZogYPkEMMzxUhOzAFiud8eft8qHQq66N8hGzdSV/CywU5IpJTfxHkN
 yAerKdaUVr2kqbBdSS9R2gEj+qkk5oAjItQ0Pkdb1pqoDLp7ZEjDZx35Fji8Z3w2/1BR
 1CRcD4KtvWQTuuooM789QlccXgGLLmqlVaqMbre8jzUpNjom3nWf01G4Qv4+iMm3Ithv 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t26rjsvb5-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jun 2019 14:25:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E91E138;
        Tue, 11 Jun 2019 12:25:53 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C74622A2C;
        Tue, 11 Jun 2019 12:25:53 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 14:25:53 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun 2019 14:25:52
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        "Fabrice Gasnier" <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: [PATCH v2 06/10] serial: stm32: add support for no_console_suspend
Date:   Tue, 11 Jun 2019 14:25:26 +0200
Message-ID: <1560255930-22554-7-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
References: <1560255930-22554-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to display console messages in low power mode, console pins
must be kept active after suspend call.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0d43711..00e4d7a 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -24,6 +24,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
@@ -846,6 +848,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 {
 	struct uart_port *port = &stm32port->port;
 	struct resource *res;
+	struct pinctrl *uart_pinctrl;
 	int ret;
 
 	port->iotype	= UPIO_MEM;
@@ -879,6 +882,24 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
+	uart_pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(uart_pinctrl)) {
+		ret = PTR_ERR(uart_pinctrl);
+		if (ret != -ENODEV) {
+			dev_err(&pdev->dev, "Can't get pinctrl, error %d\n",
+				ret);
+			return ret;
+		}
+		stm32port->console_pins = ERR_PTR(-ENODEV);
+	} else {
+		stm32port->console_pins = pinctrl_lookup_state
+			(uart_pinctrl, "no_console_suspend");
+	}
+
+	if (IS_ERR(stm32port->console_pins) && PTR_ERR(stm32port->console_pins)
+	    != -ENODEV)
+		return PTR_ERR(stm32port->console_pins);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(port->membase))
@@ -1303,6 +1324,7 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32_port = to_stm32_port(port);
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
@@ -1311,7 +1333,19 @@ static int __maybe_unused stm32_serial_suspend(struct device *dev)
 	else
 		stm32_serial_enable_wakeup(port, false);
 
-	pinctrl_pm_select_sleep_state(dev);
+	if (uart_console(port) && !console_suspend_enabled) {
+		if (IS_ERR(stm32_port->console_pins)) {
+			dev_err(dev, "no_console_suspend pinctrl not found\n");
+			return PTR_ERR(stm32_port->console_pins);
+		}
+
+		pinctrl_select_state(dev->pins->p, stm32_port->console_pins);
+	} else {
+		if (device_may_wakeup(dev))
+			pinctrl_pm_select_idle_state(dev);
+		else
+			pinctrl_pm_select_sleep_state(dev);
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 30d2433..050fe04 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -255,6 +255,7 @@ struct stm32_port {
 	bool fifoen;
 	int wakeirq;
 	int rdr_mask;		/* receive data register mask */
+	struct pinctrl_state *console_pins;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1

