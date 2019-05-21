Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DABC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDC021743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uPzJ62Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfEUPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:47:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728905AbfEUPrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:47:02 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LFjvSE004967;
        Tue, 21 May 2019 17:46:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=/OcbG7X/4P3w326sEJsRi0F6w6c2W3c9KT64wC0AeuY=;
 b=uPzJ62FcrBpb0lxQBdoL3q7yqp9WRb1GSrBJ0BDvUo3FxxqLGodXE8vj6AEZ+IpskDpI
 jQsR2hgkTlil5kIFWQpEz6oCb0NjhjzWCdPUtaWqHasJynFZvxflh2bm+An27/7C/DPG
 stnoWV8uE9urEZADUnLOqS27XL8F2IvOoHzqV+tIDgkRs2BtAS2ePXsuH2N+h9UWcEz+
 uzXTjGSY93Sv56v/klN+ube0g7/bceUM8tBJCwCt+NgUaxq0TAaLQeyqj167Mg235Qx9
 xvUQ9WkDeAtQ5kZB9DqKCqGh5nim/Aom2gfRjL5yHTVyXmti+pvBmiSyn1a8xtIs4A+A Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sj7tu2h78-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 17:46:43 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 213A038;
        Tue, 21 May 2019 15:46:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09B712CEA;
        Tue, 21 May 2019 15:46:43 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May
 2019 17:46:42 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May 2019 17:46:42
 +0200
From:   Erwan Le Ray <erwan.leray@st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Erwan Le Ray" <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 6/7] serial: stm32: fix wakeup source initialization
Date:   Tue, 21 May 2019 17:45:46 +0200
Message-ID: <1558453547-22866-7-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
References: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dedicated_irq_wakeup issue and deactivated uart as wakeup source by
default.

Fixes: 270e5a74fe4c ("serial: stm32: add wakeup mechanism")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index d603be9..1334e42 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -557,7 +557,6 @@ static int stm32_startup(struct uart_port *port)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	const char *name = to_platform_device(port->dev)->name;
 	u32 val;
 	int ret;
@@ -568,15 +567,6 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	if (cfg->has_wakeup && stm32_port->wakeirq >= 0) {
-		ret = dev_pm_set_dedicated_wake_irq(port->dev,
-						    stm32_port->wakeirq);
-		if (ret) {
-			free_irq(port->irq, port);
-			return ret;
-		}
-	}
-
 	val = USART_CR1_RXNEIE | USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		val |= USART_CR1_FIFOEN;
@@ -607,7 +597,6 @@ static void stm32_shutdown(struct uart_port *port)
 
 	stm32_clr_bits(port, ofs->cr1, val);
 
-	dev_pm_clear_wake_irq(port->dev);
 	free_irq(port->irq, port);
 }
 
@@ -1079,11 +1068,18 @@ static int stm32_serial_probe(struct platform_device *pdev)
 		ret = device_init_wakeup(&pdev->dev, true);
 		if (ret)
 			goto err_uninit;
+
+		ret = dev_pm_set_dedicated_wake_irq(&pdev->dev,
+						    stm32port->wakeirq);
+		if (ret)
+			goto err_nowup;
+
+		device_set_wakeup_enable(&pdev->dev, false);
 	}
 
 	ret = uart_add_one_port(&stm32_usart_driver, &stm32port->port);
 	if (ret)
-		goto err_nowup;
+		goto err_wirq;
 
 	ret = stm32_of_dma_rx_probe(stm32port, pdev);
 	if (ret)
@@ -1097,6 +1093,10 @@ static int stm32_serial_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_wirq:
+	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
+		dev_pm_clear_wake_irq(&pdev->dev);
+
 err_nowup:
 	if (stm32port->info->cfg.has_wakeup && stm32port->wakeirq >= 0)
 		device_init_wakeup(&pdev->dev, false);
@@ -1134,8 +1134,10 @@ static int stm32_serial_remove(struct platform_device *pdev)
 				  TX_BUF_L, stm32_port->tx_buf,
 				  stm32_port->tx_dma_buf);
 
-	if (cfg->has_wakeup && stm32_port->wakeirq >= 0)
+	if (cfg->has_wakeup && stm32_port->wakeirq >= 0) {
+		dev_pm_clear_wake_irq(&pdev->dev);
 		device_init_wakeup(&pdev->dev, false);
+	}
 
 	clk_disable_unprepare(stm32_port->clk);
 
-- 
1.9.1

