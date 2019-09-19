Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F76C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F9F20640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 03:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKjd4wKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfISDKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 23:10:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43521 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfISDKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:10:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so1253573pfo.10;
        Wed, 18 Sep 2019 20:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=stmOjL/c/ExaFL4SdKPgQAdlTh6GvwhfkrAMYKUCxGQ=;
        b=LKjd4wKV1Xg37mwBYmhkZq+3qE2dBemA3DYutLccscjp/M7E19G/L0otcN+62N6aYW
         z15Vkr4iZLxpLcHLobz52s+HwjxSw0BCXgJ+LJvGLFIExjN08u/mxJZVYZJzAwIXcjmg
         iN8rL7IU7fZp8yNjgGEwj6rEZPMEz8I6OVPSYlh26Vx3K1kWXCIyre1dxUxw0QHrmxjv
         EpCVrWbbNiXr4abM01WWIQ1bDBgn7geCHJcBUEz6qwb9tUe8gx/exKujMFSzCut6NNiS
         if6JGTLMoyvCXHA+8Q7DMVc1eU6zRHiJf35SAapOE5dLTPdqApcvCwfj9u/Ai654Nits
         8T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=stmOjL/c/ExaFL4SdKPgQAdlTh6GvwhfkrAMYKUCxGQ=;
        b=CIsrqCeleDqg8jD6Tzmfi7GpTI3LSNr9BRDCsvQUJR8vumgUIjL7pl8IMVTE1jC9vC
         mBZqXqgkK2KLMszAvI/PGmemaf9lNJITS7uS7DsZciARyO8/byRe1RKLUffCInNRFPUG
         6kt83MGWR05uGqUmrft/8jxS49GhPr5JC1AIkV1+RskoxN+7y3X9lUJA7Ce0ol4Iqtkr
         FI0krGoYavHvqIr+KGENzAmwkQgKGRmrZ6L5/u8D+dBZyJziGyis9BQQWWDXFsefKRgQ
         mH+QIeC6MJf+/3Mf/bjoWDnfE3P74ZDCG1xoGOnwvNl5B81Ft3v+q1RRt7ZP+5ib/v56
         uPJQ==
X-Gm-Message-State: APjAAAXxy2zIqfoqM5lcrfZpPUtEFJUeqfL1a6XT+y/fGVNyOTeXPwFK
        dMY640vtWDsPqH/9Q3JuafA=
X-Google-Smtp-Source: APXvYqyTjLTkA7SH5GnNQ4Wud8vajVQPBtuyE+Ba9ndyvrXg7XVj8VRgnW62qffqDBPJ2nHUU0hpOg==
X-Received: by 2002:aa7:851a:: with SMTP id v26mr8067420pfn.11.1568862649036;
        Wed, 18 Sep 2019 20:10:49 -0700 (PDT)
Received: from sh04182tmp293.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e127sm11182440pfe.37.2019.09.18.20.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 20:10:48 -0700 (PDT)
From:   Lanqing Liu <liuhhome@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     baolin.wang@linaro.org, lanqing.liu@unisoc.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH v2] serial: sprd: Add polling IO support
Date:   Thu, 19 Sep 2019 11:10:37 +0800
Message-Id: <f112a741c053ac5fb0637e2f058be81e17f78ccc.1568862391.git.liuhhome@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to access the UART without the interrupts, the kernel uses
the basic polling methods for IO with the device. With these methods
implemented, it is now possible to enable kgdb during early boot over serial.

Signed-off-by: Lanqing Liu <liuhhome@gmail.com>
---
Change from v1:
 - Add poll_init() support.
---
 drivers/tty/serial/sprd_serial.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4..d833160 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -911,6 +911,34 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int sprd_poll_init(struct uart_port *port)
+{
+	if (port->state->pm_state != UART_PM_STATE_ON) {
+		sprd_pm(port, UART_PM_STATE_ON, 0);
+		port->state->pm_state = UART_PM_STATE_ON;
+	}
+
+	return 0;
+}
+
+static int sprd_poll_get_char(struct uart_port *port)
+{
+	while (!(serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK))
+		cpu_relax();
+
+	return serial_in(port, SPRD_RXD);
+}
+
+static void sprd_poll_put_char(struct uart_port *port, unsigned char ch)
+{
+	while (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
+		cpu_relax();
+
+	serial_out(port, SPRD_TXD, ch);
+}
+#endif
+
 static const struct uart_ops serial_sprd_ops = {
 	.tx_empty = sprd_tx_empty,
 	.get_mctrl = sprd_get_mctrl,
@@ -928,6 +956,11 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 	.config_port = sprd_config_port,
 	.verify_port = sprd_verify_port,
 	.pm = sprd_pm,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_init	= sprd_poll_init,
+	.poll_get_char	= sprd_poll_get_char,
+	.poll_put_char	= sprd_poll_put_char,
+#endif
 };
 
 #ifdef CONFIG_SERIAL_SPRD_CONSOLE
-- 
1.9.1

