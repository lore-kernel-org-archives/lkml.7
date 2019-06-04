Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41552C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8624C4B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="zcB+NMK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfFDI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:56:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726988AbfFDI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:56:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x548tKw0021226;
        Tue, 4 Jun 2019 10:55:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=2t7Oh2wFwFzhKSRexvanrt3z18l9MjaRhX9ZcdCIqoQ=;
 b=zcB+NMK4ZEKRouNwjVExKEnwxrgxeu2Fil4w6ZZvxebJzxMN5BKsKqqErUlE6i7b3zTa
 yVTjw4DDtR54Sr+8YnvD3WVjGymrHCuIFR2vsKjBwLjkXJaHwaPnlB+7saNTKdVtA+gq
 8PtnXy/xQCwVidJTjNXokBNS5/0BGwceMsdl6GRGtiMSE53dfneX7txHvdry4vvOePsd
 zVO4S8jU2FkvhrA35rE80HH7oMGW9kBfBz5JE5Q9wb1YlIMMPxD/ATEEhY9YWrOPoNH2
 ZV4YHgC7HmgikiFjuPMI/x5odw52oMN8LP1dfOcBLJJ6QMGj7FBHsLcj98p9Gym2xnxi Ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sundrynjk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 04 Jun 2019 10:55:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D9E016A;
        Tue,  4 Jun 2019 08:55:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 730242508;
        Tue,  4 Jun 2019 08:55:38 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019
 10:55:38 +0200
Received: from localhost (10.201.23.31) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 4 Jun 2019 10:55:36
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
        "Fabrice Gasnier" <fabrice.gasnier@st.com>
Subject: [PATCH 05/10] serial: stm32: Use __maybe_unused instead of #if CONFIG_PM_SLEEP
Date:   Tue, 4 Jun 2019 10:55:14 +0200
Message-ID: <1559638519-6128-6-git-send-email-erwan.leray@st.com>
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

Use __maybe_unused for power management related functionsinstead of
#if CONFIG_PM_SLEEP to simply the code.

fixes: 270e5a74fe4c ("serial: stm32: add wakeup mechanism")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 05d2ef6..aa3da1c 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1200,8 +1200,8 @@ static int stm32_console_setup(struct console *co, char *options)
 	.cons		= STM32_SERIAL_CONSOLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
-static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
+static void __maybe_unused stm32_serial_enable_wakeup(struct uart_port *port,
+						      bool enable)
 {
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
@@ -1225,7 +1225,7 @@ static void stm32_serial_enable_wakeup(struct uart_port *port, bool enable)
 	}
 }
 
-static int stm32_serial_suspend(struct device *dev)
+static int __maybe_unused stm32_serial_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1241,7 +1241,7 @@ static int stm32_serial_suspend(struct device *dev)
 	return 0;
 }
 
-static int stm32_serial_resume(struct device *dev)
+static int __maybe_unused stm32_serial_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 
@@ -1252,7 +1252,6 @@ static int stm32_serial_resume(struct device *dev)
 
 	return uart_resume_port(&stm32_usart_driver, port);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int __maybe_unused stm32_serial_runtime_suspend(struct device *dev)
 {
-- 
1.9.1

