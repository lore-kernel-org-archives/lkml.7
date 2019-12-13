Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8FCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9682173E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LukXmycd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfLMAIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37548 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfLMAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so390026plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+sV5GoSJEiRZfmjrW1+1MwtZsdkaDLVuk2NRqNrH9Y=;
        b=LukXmycdan+JrEsleQGB4m5qUwPFAgpUEG4ulZ/iKQnBL9RStn7Cp6kjSV+4MQl1dl
         oE1jEaS75KVIjf4z+fWgjvfIzQd8TAVO3wv14/gI10gbHxdCXZbhlzyuNfDOSaM28uz1
         4MczGTd3U5cbFMNQ3qRKf+iKJtfcOt5rBr7I5BmCUkgKCsAVdkyAvpG3G69fO/wt0y0I
         2fcLvrn2wwPSqkHp5CaVVbRH7DgdkImmcUBrJUqn+i4Vdyr5+xb5VEyGMDuNxyDC0kxO
         blZg4LtcnOFKuNXL1/sCwrSUuEo3Inlo9OHn34GAPMCYZ+uTABe9MRJagmu3KIQhPMmK
         kvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+sV5GoSJEiRZfmjrW1+1MwtZsdkaDLVuk2NRqNrH9Y=;
        b=WTDVl5LEwp7irFqMer1a/ctJ1yWNCFRrGJeMJ+0YOr1dCRWggqhwyKF9wo3QaiJ+fL
         dtvcwh6SEfrQgcdcHGw8YgtVgf9YecxeFghEYcBWN/xDp++lspuXqi/KyecV32Oxcq3h
         qn3nsZeSeTVK4BJSODlCKwjOZo6qkXAQXwXQosKQDdR2LAP+lO9apGu/jcP+D3aq4LJa
         Suv+096n80nNc1D4Nyivn+UlUOvH8DUy2bCMI73Nh6HZ+oX8z/kmTbtl36dBnaQCUCs+
         31USaAm3VCGQRd8rQPx8DEu7/YXiXY8UfZC3LxGRAPfmA39dhvXZNDMBeqtXKHFdyOyS
         YtlQ==
X-Gm-Message-State: APjAAAWtHFh9KX8nqebl+byQdhXtQNAiwxJcoZJfLi45R+qAa4s0UBnc
        tLXGD6FsRSHj7tvuRGohVojXfD46Qas=
X-Google-Smtp-Source: APXvYqw/W5ycRttQjCqpid9Ha6262vYFX2I8+5hsdzSjxZT4ZtOSRnkmyoJSW7ZXIymmA8NjgLKpTw==
X-Received: by 2002:a17:902:bf47:: with SMTP id u7mr13112236pls.259.1576195674977;
        Thu, 12 Dec 2019 16:07:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:54 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 14/58] tty/serial: Migrate cpm_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:13 +0000
Message-Id: <20191213000657.931618-15-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index de6d02f7abe2..19d5a4cf29a6 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -40,10 +40,6 @@
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
-#if defined(CONFIG_SERIAL_CPM_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
 
@@ -347,9 +343,7 @@ static void cpm_uart_int_rx(struct uart_port *port)
 		/* ASSUMPTION: it contains nothing valid */
 		i = 0;
 	}
-#ifdef SUPPORT_SYSRQ
 	port->sysrq = 0;
-#endif
 	goto error_return;
 }
 
@@ -1204,7 +1198,8 @@ static int cpm_uart_init_port(struct device_node *np,
 	pinfo->port.uartclk = ppc_proc_freq;
 	pinfo->port.mapbase = (unsigned long)mem;
 	pinfo->port.type = PORT_CPM;
-	pinfo->port.ops = &cpm_uart_pops,
+	pinfo->port.ops = &cpm_uart_pops;
+	pinfo->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_CPM_CONSOLE);
 	pinfo->port.iotype = UPIO_MEM;
 	pinfo->port.fifosize = pinfo->tx_nrfifos * pinfo->tx_fifosize;
 	spin_lock_init(&pinfo->port.lock);
-- 
2.24.0

