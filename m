Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA030C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFAD206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="opcG6ew6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfLMAHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33215 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfLMAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13so400250pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfdmzXy/tr/5l8uacjPRcN2UZbf1ukI0DlMsU/05qw8=;
        b=opcG6ew61EJlu0r95XGFc0PBlPnVEbSyEkZ/PnI0ZvDTlp8HFvlbBEpZ9Gmby6WJ0o
         x8dQuRBaYdcXvyeYkznLCRWgFHDGqR1VbOOMOGTvCjB5DlZjpFQtxm4YeMy4IkPYUs7z
         yZHrw0L5pC6ttRfVAYC+2s644nfuroRAZF9+/tTrtwJPka0wffAN7KgsM3kqP0uoMB3/
         4+FWHzUY2je/bHI/bUhTicfSETJmPN3Bsp4uocM8WmmJu93OHA60j+Z9ozh13FmFzye1
         mHNxKrvWgHUaUw2N20lHh80X1chtCvQwlCSTqjjLbG3i0kbgPq2y7ddSNEvW86fOwASf
         ppcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfdmzXy/tr/5l8uacjPRcN2UZbf1ukI0DlMsU/05qw8=;
        b=akKPS2oHafBs47Tb7Z5zF9aybhD7Okikr/exeLyxviFM47+7aG81hNswFaCmG2moIP
         HeG3KzrR655FpGj0cgUkOasJB7TkBdj/UyRvTyNvXgm4cg3gLISm9MiD/NnvtURl5l+Q
         qUutvMJ9oidGN6K9xGAF/y4+QbfMEw89zsbTmXb72ebaC9mNqsNbnwiLiFGiHW0lpAwt
         QRBZRix1DCxm5Oo6qr3O59z3dqssSDKMvf9dAp9EZJwjckZZPSS4G06H3Hy/RQbZc797
         57qBCrfEG1o8qaAUzVZND7Ay+3ATk6rVtyI0B+Fe2lkf2zXMHwYD74tsh3dVpbIaZPoJ
         ZJQg==
X-Gm-Message-State: APjAAAUg/wCoU9OjipGV/n4KoB9DC+GkyhSWWeZktdxX6+BJ4/3wtBKC
        udgR6ijaf17qicAabXMVKh/mSt3l+Hs=
X-Google-Smtp-Source: APXvYqxw5XZn4UQX0vr1Ac16jLp4hYP0SiJLcSrh0Xn/J4KufxFS6+XB4I5Rh8TAOkkESDtUbglbyg==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr12974695pjs.51.1576195666067;
        Thu, 12 Dec 2019 16:07:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:45 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 11/58] tty/serial: Migrate arc_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:10 +0000
Message-Id: <20191213000657.931618-12-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/arc_uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index d904a3a345e7..17c3fc398fc6 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -21,10 +21,6 @@
  *  -check if sysreq works
  */
 
-#if defined(CONFIG_SERIAL_ARC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/serial.h>
 #include <linux/console.h>
@@ -625,6 +621,7 @@ static int arc_serial_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->line = dev_id;
 	port->ops = &arc_serial_pops;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ARC_CONSOLE);
 
 	port->fifosize = ARC_UART_TX_FIFO_SIZE;
 
-- 
2.24.0

