Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286BAC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4192147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBVLanAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfENKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:14:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40222 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENKOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:14:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so11401003lfc.7;
        Tue, 14 May 2019 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okS49diCXOt/N6onPXAaFdBtr26ozsI1KBRps9sVl9k=;
        b=QBVLanAC8X4PfqWN+vkEBhK74Z1n2uRHXeLsV1vyzeBpNcYOth5WlMl+EO+cNXf6tZ
         oMWfa00cce6J5irVMfoTUejDiUVBb86wwMb0CChEkTXen1sHd+JrKN9HmwBGODVZEmhk
         DKr9z4Y/RmIGM7SMZRtXHsnUhFtiaHegCUoLhZaH30bbJms/IF70C20qxO02hKdLW1r7
         tMClpRiUOxs/i13XhtnHm++/Pvpt48giCjux7fvE9s5hr+44wt1srHOr8CAtwm50csb3
         rKDm1ChkLo/xCI9vWsx9Bw7+ttj0cC06eQoObfmM+BHgG3G228Pxj7aJjW5LBDKDv5OG
         HsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okS49diCXOt/N6onPXAaFdBtr26ozsI1KBRps9sVl9k=;
        b=os0+F7j1FS39KtHiOhWxysGp6biLPUMHsrli9deBICgwz/fr/nini9i4+aXn0fztQK
         ttLqjiAcHOjtEUzpBDIU0t00CiS0mxQnL0yTR3l0AiEMO6VH6iHPHbj/Pkxz+py5HMGx
         Tk4TJAvaBzAPYQYDpPDqaR6Mcr4L2VfvTZQ3zIte0iVLF2ZF1qR1uPRqPue9GFJVBAsB
         +oR/WjPy0rI3oh1FGRkmjKti3ckfldtO4DdWJVI3YLm3lXhTkFyIPHL7HGd2ELtv5Yyd
         aeluKd9tU6a8kk7k2yJT3VrVWBJ8CODqIKx+LWiEXIOhnhclLN+p0hT3rGo9ALYgxBQ0
         whoA==
X-Gm-Message-State: APjAAAUj+HKgtKSexeNXlMEM83BFOhluwA9Zh1Z9CvA8kZLsVrDTeiB5
        NfUEyMBHhmBattOCrsh72lY=
X-Google-Smtp-Source: APXvYqwwkk7wgiSlVz6gmp/q3A5Etk8WWEEDBkCx/M7x0DGmDBh0jbiaZBizqLd6hPlrkwr+cm4oSQ==
X-Received: by 2002:ac2:4213:: with SMTP id y19mr7285683lfh.66.1557828876865;
        Tue, 14 May 2019 03:14:36 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id v2sm3126359ljg.6.2019.05.14.03.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 03:14:36 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] tty: max310x: Optionally enable rs485 on startup
Date:   Tue, 14 May 2019 13:14:14 +0300
Message-Id: <20190514101415.26754-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART port might be pre-configured with rs485 enabled flag at the
time of the port starting up process. In this case we need to
have the hardware rs485-related registers initialized in accordance
with the rs485 flags and settings provided by the configs descriptor.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2255300404bd..36943f6c198c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1030,6 +1030,22 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
+	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
+	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
+		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT);
+
+		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+			max310x_port_update(port, MAX310X_MODE2_REG,
+					    MAX310X_MODE2_ECHOSUPR_BIT,
+					    MAX310X_MODE2_ECHOSUPR_BIT);
+	}
+
 	/* Configure flow control levels */
 	/* Flow control halt level 96, resume level 48 */
 	max310x_port_write(port, MAX310X_FLOWLVL_REG,
-- 
2.21.0

