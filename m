Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2321976
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XtvRF2Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfFDJMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:12:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12896 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfFDJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:12:41 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5498qNp019707;
        Tue, 4 Jun 2019 11:12:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=PlxzoaxTpT7xfTSaFEe7rJyo9NUlAGqUd0kCqJ49OI4=;
 b=XtvRF2JeKJZfffjpzMNle1ULSUh/rkODDI4QXRECKKUHrDNwTzdSSsQFalGKpEzaX7c3
 zbdFycHJK0pK41AqKzt8HzxEPeS/R+NpLHPnwFNRl+7fEQVvJqCiJsIrVkqlJfVWsnw1
 s5bpON+O+iCT3GTVpXsG7jkXTbOmwlAUSL/01gpJykwL6Wtd4/6Csdo3M31y9DgD7eKy
 AH6xJxvjR27XMZDahEE5uOf/NctnBrvnWp3k38bh1ahoRPF5DZImMR1hba6fMdZRVj75
 ESMRxem/Yf4Nl6StAyVjtmij9zLMHceFLYD4i6RGUtKC/rJVtwgTyKLX4G4QEwZ26t7R NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sunmefkt6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 11:12:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F70A17E;
        Tue,  4 Jun 2019 08:55:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B858250C;
        Tue,  4 Jun 2019 08:55:41 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 10:55:41 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019 10:55:39
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
Subject: [PATCH 06/10] serial: stm32: add support for no_console_suspend
Date:   Tue, 4 Jun 2019 10:55:15 +0200
Message-ID: <1559638519-6128-7-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
References: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
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
index aa3da1c..573eae1 100644
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
@@ -802,6 +804,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 {
 	struct uart_port *port = &stm32port->port;
 	struct resource *res;
+	struct pinctrl *uart_pinctrl;
 	int ret;
 
 	port->iotype	= UPIO_MEM;
@@ -816,6 +819,24 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	stm32port->wakeirq = platform_get_irq(pdev, 1);
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
@@ -1228,6 +1249,7 @@ static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
 static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct stm32_port *stm32_port = to_stm32_port(port);
 
 	uart_suspend_port(&stm32_usart_driver, port);
 
@@ -1236,7 +1258,19 @@ static int __maybe_unused stm32_serial_suspend(struct device *dev)
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
index 6f294e2..6957d50 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -261,6 +261,7 @@ struct stm32_port {
 	bool hw_flow_control;
 	bool fifoen;
 	int wakeirq;
+	struct pinctrl_state *console_pins;
 };
 
 static struct stm32_port stm32_ports[STM32_MAX_PORTS];
-- 
1.9.1

