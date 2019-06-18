Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD6C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC309213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QLNmM8Ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFRKDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:03:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25738 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbfFRKDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:03:01 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I9ug4W007561;
        Tue, 18 Jun 2019 12:02:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=h01JWVwcjqILFh4YSO7W65sajs6sEQaVQ79mN3RX8qQ=;
 b=QLNmM8Ym6XwFgwWEWHrCnihEcWc1VtywI4qxDJ1y07gq6pLzS6LqMBnyj+bx4Bz4vXzd
 /TauvCyjVPOhiJO1QvGhcOV9gNzPdMDgl/GxNPp4z5LOLi4df/L7Z1FttIduxDTgwc/5
 +rvAI7NUxvqoGC+yZ9akFbW1Mqqn3IAsKFMW42TK/ijPpv/W9zYZW5UtN1QbZr82blPr
 ecRstm6j6+unZ/8cvQeAe/NkKYJVT5fy9fmxLvP5GitcPz3ZfWMEkMcjagxZRRWcyzpD
 xQop4ni9R2rTwxlJiJRvhUxq6sRrqRYCZYrkiR7qtt/S4V3reILsXQ6wTStX/5lhAhy1 8Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t4nt883jd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 18 Jun 2019 12:02:37 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A74438;
        Tue, 18 Jun 2019 10:02:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59DB025D7;
        Tue, 18 Jun 2019 10:02:36 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 12:02:36 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun 2019 12:02:35
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
Subject: [PATCH 2/5] serial: stm32: update PIO transmission
Date:   Tue, 18 Jun 2019 12:02:23 +0200
Message-ID: <1560852146-3393-3-git-send-email-erwan.leray@st.com>
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

Improves PIO transmission:
- Replaces the FIFO filling per character by a filling per blocks of
  characters, which provides better performances
- Replaces the active waiting loop by TX empty interrupt dynamic handling.
  TXE interrupt is now enabled when data has to be sent (ie when
  uart_circ is not empty), and inhibited when there is no more data to
  send (ie when uart_circ is empty).

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e1cfb1e..8316e19 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -303,27 +303,26 @@ static void stm32_transmit_chars_pio(struct uart_port *port)
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int isr;
-	int ret;
 
 	if (stm32_port->tx_dma_busy) {
 		stm32_clr_bits(port, ofs->cr3, USART_CR3_DMAT);
 		stm32_port->tx_dma_busy = false;
 	}
 
-	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
-						isr,
-						(isr & USART_SR_TXE),
-						10, 100000);
-
-	if (ret)
-		dev_err(port->dev, "tx empty not set\n");
-
-	stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
+	while (!uart_circ_empty(xmit)) {
+		/* Check that TDR is empty before filling FIFO */
+		if (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
+			break;
+		writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		port->icount.tx++;
+	}
 
-	writel_relaxed(xmit->buf[xmit->tail], port->membase + ofs->tdr);
-	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	port->icount.tx++;
+	/* rely on TXE irq (mask or unmask) for sending remaining data */
+	if (uart_circ_empty(xmit))
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
+	else
+		stm32_set_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
 static void stm32_transmit_chars_dma(struct uart_port *port)
-- 
1.9.1

