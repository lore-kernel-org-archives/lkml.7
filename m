Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB7C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D122166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuPHlOKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfENKOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37636 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfENKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id h19so7339917ljj.4;
        Tue, 14 May 2019 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPn8FPvs2SjLEj/IT8pEZw6LNgmcxaZw6OHHve5bSvE=;
        b=BuPHlOKhuHA86vpCSCE2Khe2qcQ53z+yUJ0J6wRlq87EXVDsc++DdiW7fBe3ovXTVA
         Y3izPN5hENRt/2ttq0Ea+lJG8g0x8qpX5jHoifk+DoKV80NFXtac4jmhdfC6I+JyMe8j
         STPvN1y6+xAtDe2L+pjI6NDQqHtPS5JSpsNXwckulTkWx3DUnRhvGzB/R2ksEmydgAlP
         Iv0wikz0gbUI9dOT0fRfudxvhQiFCoNZuzM3uziUOprlPIjRQxEDG/fku2cosvti50Dk
         xxZvEQeywmtlcsWKlNFWtsrGehfmWlix/ZrLfm1zSoQVOwFp8gJvHPpRQUyEBCV5PcCz
         Nexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPn8FPvs2SjLEj/IT8pEZw6LNgmcxaZw6OHHve5bSvE=;
        b=rXVwfJVQU+J73NmWtmL+FiZKuGzkEmwSyLDmdtVwAXBfGfhzidS96ngaFPP3eZxdCg
         USRJ7/7WV/u+tJ5qqSjXWl61ua0iljxW3r8qiY9A7KrFBbd+5juiu1C6wr2p0110Cpxu
         Pxc9IZvP40v2PvVTQyKNITeEnmOhrrAD/kcUr2IRF6kNvzBKPclBzgGJ/P08GZbhidyp
         sMFVavNqKTq1IVnG7lWUlvt2a/1gyNa/mW287x5dzk6gOCQ8xAEuSbDeh7EapeD432c/
         zIK0ASgMWDBjDSzLYLK65DNjTKp+UW27lM3qBkpQ+xTQ7UN5wIfpcGRW8BJMYJIMs9qU
         k3uA==
X-Gm-Message-State: APjAAAUTnUUjQThHAENOC22m3725BQpDp060wO58w2cUx3qJUekmt8yD
        TkEw52MHG+ay4gZfKGLsqE8=
X-Google-Smtp-Source: APXvYqxKhs2VHDhW/KEDGjyMv++36P8nn6OVWjhyVQa/SWIVgYYAgf9/dEhHVseBpuQvVpjIoLqWSQ==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr15359706ljj.146.1557828875653;
        Tue, 14 May 2019 03:14:35 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:35 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] tty: max310x: Add rx-during-tx rs485 flag support
Date:   Tue, 14 May 2019 13:14:13 +0300
Message-Id: <20190514101415.26754-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently sets the echo suppression bit by default when rs485
is enabled. Naturally it disables any data retrieval in rs485 mode while
RTSn is pushed up. The receiver gate (RX_) can be enabled just by clearing
(or not setting) the EchoSuprs bit of mode2 register. So by setting or
clearing the bit we implement the SER_RS485_RX_DURING_TX rs485 flag
support.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ca044f96c5cc..2255300404bd 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -975,25 +975,23 @@ static void max310x_set_termios(struct uart_port *port,
 static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
-	unsigned int val;
+	unsigned int delay, mode1 = 0, mode2 = 0;
 
-	val = (one->port.rs485.delay_rts_before_send << 4) |
+	delay = (one->port.rs485.delay_rts_before_send << 4) |
 		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, val);
+	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
 
 	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(&one->port, MAX310X_MODE1_REG,
-				MAX310X_MODE1_TRNSCVCTRL_BIT,
-				MAX310X_MODE1_TRNSCVCTRL_BIT);
-		max310x_port_update(&one->port, MAX310X_MODE2_REG,
-				MAX310X_MODE2_ECHOSUPR_BIT,
-				MAX310X_MODE2_ECHOSUPR_BIT);
-	} else {
-		max310x_port_update(&one->port, MAX310X_MODE1_REG,
-				MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
-		max310x_port_update(&one->port, MAX310X_MODE2_REG,
-				MAX310X_MODE2_ECHOSUPR_BIT, 0);
+		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+
+		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 	}
+
+	max310x_port_update(&one->port, MAX310X_MODE1_REG,
+			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(&one->port, MAX310X_MODE2_REG,
+			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
 static int max310x_rs485_config(struct uart_port *port,
@@ -1005,7 +1003,8 @@ static int max310x_rs485_config(struct uart_port *port,
 	    (rs485->delay_rts_after_send > 0x0f))
 		return -ERANGE;
 
-	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_ENABLED;
+	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX |
+			SER_RS485_ENABLED;
 	memset(rs485->padding, 0, sizeof(rs485->padding));
 	port->rs485 = *rs485;
 
-- 
2.21.0

