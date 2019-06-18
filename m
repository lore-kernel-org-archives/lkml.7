Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B60C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022A32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pKMdFCu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfFRKDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:03:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27384 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbfFRKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:03:02 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IA1kqT030835;
        Tue, 18 Jun 2019 12:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ZNwrI9/E19QXLogxcwXLV+/wtFzsSvuPA6hnm0JPcRM=;
 b=pKMdFCu6z9l+iNvnnuFWzm/ITOJ4O7pD3VwiAG1XRPj/EB74vBLEw9mGVCi62jp2V5X5
 RjADxoXBtw/U9b/GCXEAfxfHiMYwkJXGI5Gn6qLPyYbpQc+I0Qo6stg4MqxSDer2tBN5
 L4mqGeMTarLq8Kl/+5adGTt4SDB9/1dBIKMgdYNmSS870lUw+A8L2npVXeztPIxUIRmp
 1cAEHe/3YSBft1VMmwYslw9wRl3BTvDm25TYlOGgdzrrYZGmU9CmzZs6zsFXvgM4Ec9x
 TIpUF7DcIxoi1jwFxLdZ1vc8OlxFpsDDMs5FplvHeTTLvb5lpfNAHiRdaXy4EmSC+oy3 HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t68n3nv0e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 12:02:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C84553A;
        Tue, 18 Jun 2019 10:02:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A704725DD;
        Tue, 18 Jun 2019 10:02:43 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 12:02:43 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun 2019 12:02:43
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
Subject: [PATCH 5/5] serial: stm32: add RX and TX FIFO flush
Date:   Tue, 18 Jun 2019 12:02:26 +0200
Message-ID: <1560852146-3393-6-git-send-email-erwan.leray@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
References: <1560852146-3393-1-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.31]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a flush of RX and TX FIFOs, and fixes some errors:
- adds RX FIFO flush in startup fonction
- removes the useless transmitter enabling in startup fonction
  (e.g. receiver only, see Documentation/serial/driver)
- configures FIFO threshold before enabling it, rather than after
- flushes both TX and RX in set_termios function

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 4083145..21dc380 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -602,11 +602,11 @@ static int stm32_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	val = stm32_port->cr1_irq | USART_CR1_TE | USART_CR1_RE;
-	if (stm32_port->fifoen)
-		val |= USART_CR1_FIFOEN;
-	stm32_set_bits(port, ofs->cr1, val);
+	/* RX FIFO Flush */
+	if (ofs->rqr != UNDEF_REG)
+		stm32_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
 
+	/* Tx and RX FIFO configuration */
 	if (stm32_port->fifoen) {
 		val = readl_relaxed(port->membase + ofs->cr3);
 		val &= ~(USART_CR3_TXFTCFG_MASK | USART_CR3_RXFTCFG_MASK);
@@ -615,6 +615,12 @@ static int stm32_startup(struct uart_port *port)
 		writel_relaxed(val, port->membase + ofs->cr3);
 	}
 
+	/* RX FIFO enabling */
+	val = stm32_port->cr1_irq | USART_CR1_RE;
+	if (stm32_port->fifoen)
+		val |= USART_CR1_FIFOEN;
+	stm32_set_bits(port, ofs->cr1, val);
+
 	return 0;
 }
 
@@ -697,8 +703,12 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Stop serial port and reset value */
 	writel_relaxed(0, port->membase + ofs->cr1);
 
-	cr1 = USART_CR1_TE | USART_CR1_RE;
+	/* flush RX & TX FIFO */
+	if (ofs->rqr != UNDEF_REG)
+		stm32_set_bits(port, ofs->rqr,
+			       USART_RQR_TXFRQ | USART_RQR_RXFRQ);
 
+	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
 	cr2 = 0;
-- 
1.9.1

