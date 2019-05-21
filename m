Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAC0208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TgRfIKBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfEUPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:46:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2446 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbfEUPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:46:39 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4LFaPZb018181;
        Tue, 21 May 2019 17:46:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=dckJd0TpTuYSyAzItwV1CCOJi+gwS5cSNQ1t2XCMxko=;
 b=TgRfIKBE+t3bCcXLVaNETIeBSG0XdkKbtAnjgEyP62B3LfDR5m9VXVFFjo9GZXQ0dDQe
 xktcCgjoU90ckS8rhHyAIPwRStE+LGoZ3Ip//U8gzn5pQjlwd4v6+dmy7A4F8/28RxTI
 HamghdvFQO2cAvoI/DhPbX02e1vTnQNK9NXqtG0MOQuft7luStomJ0onOgTxVGp6ku95
 kzZ5EDNeQJ0TzoqIUDjapz9N7/3wzkNlvLqrKPew8/GSSd1rO9IWdtVRf99PHp4r7Zfi
 MEjaI7STsaofbQo9DidmeVnQ/g5SRA0PVx7nE0kc+dpqdFrV6K2Qvj3bCo4yByZs+0Kq 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sj7742uaa-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 May 2019 17:46:23 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48EDA38;
        Tue, 21 May 2019 15:46:22 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DA4F2CEA;
        Tue, 21 May 2019 15:46:22 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May
 2019 17:46:22 +0200
Received: from localhost (10.201.23.31) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 May 2019 17:46:21
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
Subject: [PATCH 1/7] serial: stm32: fix word length configuration
Date:   Tue, 21 May 2019 17:45:41 +0200
Message-ID: <1558453547-22866-2-git-send-email-erwan.leray@st.com>
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

STM32 supports either:
- 8 and 9 bits word length (including parity bit) for stm32f4 compatible
  devices
- 7, 8 and 9 bits word length (including parity bit) for stm32f7 and
  stm32h7 compatible devices.

As a consequence STM32 supports the following termios configurations:
- CS7 with parity bit, and CS8 (with or without parity bit) for stm32f4
  compatible devices.
- CS6 with parity bit, CS7 and CS8 (with or without parity bit) for
  stm32f7 and stm32h7 compatible devices.

This patch is fixing word length by configuring correctly the SoC with
supported configurations.

Fixes: ada8618ff3bf ("serial: stm32: adding support for stm32f7")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7b..e832185 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -599,6 +599,36 @@ static void stm32_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+unsigned int stm32_get_databits(struct ktermios *termios)
+{
+	unsigned int bits;
+
+	tcflag_t cflag = termios->c_cflag;
+
+	switch (cflag & CSIZE) {
+	/*
+	 * CSIZE settings are not necessarily supported in hardware.
+	 * CSIZE unsupported configurations are handled here to set word length
+	 * to 8 bits word as default configuration and to print debug message.
+	 */
+	case CS5:
+		bits = 5;
+		break;
+	case CS6:
+		bits = 6;
+		break;
+	case CS7:
+		bits = 7;
+		break;
+	/* default including CS8 */
+	default:
+		bits = 8;
+		break;
+	}
+
+	return bits;
+}
+
 static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
@@ -606,7 +636,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	struct serial_rs485 *rs485conf = &port->rs485;
-	unsigned int baud;
+	unsigned int baud, bits;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
 	u32 cr1, cr2, cr3;
@@ -632,16 +662,28 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
 
+	bits = stm32_get_databits(termios);
+
 	if (cflag & PARENB) {
+		bits++;
 		cr1 |= USART_CR1_PCE;
-		if ((cflag & CSIZE) == CS8) {
-			if (cfg->has_7bits_data)
-				cr1 |= USART_CR1_M0;
-			else
-				cr1 |= USART_CR1_M;
-		}
 	}
 
+	/*
+	 * Word length configuration:
+	 * CS8 + parity, 9 bits word aka [M1:M0] = 0b01
+	 * CS7 or (CS6 + parity), 7 bits word aka [M1:M0] = 0b10
+	 * CS8 or (CS7 + parity), 8 bits word aka [M1:M0] = 0b00
+	 * M0 and M1 already cleared by cr1 initialization.
+	 */
+	if (bits == 9)
+		cr1 |= USART_CR1_M0;
+	else if ((bits == 7) && cfg->has_7bits_data)
+		cr1 |= USART_CR1_M1;
+	else if (bits != 8)
+		dev_dbg(port->dev, "Unsupported data bits config: %u bits\n"
+			, bits);
+
 	if (cflag & PARODD)
 		cr1 |= USART_CR1_PS;
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 6f294e2..a70aa50 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -151,8 +151,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_PS		BIT(9)
 #define USART_CR1_PCE		BIT(10)
 #define USART_CR1_WAKE		BIT(11)
-#define USART_CR1_M		BIT(12)
-#define USART_CR1_M0		BIT(12)		/* F7 */
+#define USART_CR1_M0		BIT(12)		/* F7 (CR1_M for F4) */
 #define USART_CR1_MME		BIT(13)		/* F7 */
 #define USART_CR1_CMIE		BIT(14)		/* F7 */
 #define USART_CR1_OVER8		BIT(15)
-- 
1.9.1

