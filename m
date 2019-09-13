Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94201C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8D0214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 07:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="iBcZbYKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfIMH2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 03:28:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46406 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfIMH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:28:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17so18204366wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HBeSnnaknF8l50flmejOlPoMNRFfD6iWBsjsOqPj+d0=;
        b=iBcZbYKS9kEIsmLFLKGgi8dVQynqqARBR3pZUlHdw07+qkP+mM4JaljCPnbXn29WcU
         Wh8LDkQnK2mCu9b3RDxj0kWUysIuRRgYoEDDOLPO3FT4NiWRNj5JpNcZ9W/k8me1dS+o
         y9WEV5ebefC0wyCmSEA2QymG5/UX5qoliD8t6bQ5XVFMgMVuj1h1r49nDIY41AOoFGSb
         g803a8MH9wPQdfuzIfHdYv4N7Xci2NoqYxcdxITcXmjjgB8FEHGqM/o8vRY6ZH8nV9Bj
         1a+T/u268RHPM1a+6HmbgOR5iycHdMktQUA+0JVDx0e+M8khwS+Zk1/Bsk5V6eR9YLcZ
         iYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HBeSnnaknF8l50flmejOlPoMNRFfD6iWBsjsOqPj+d0=;
        b=oYcQlalQWCqJcF5vEEfoBMJ1CVsUWcVezyujMFvAoDLdviY8+mvuV1oTsNtoyrJ2zo
         7cBD6JgAWUSWsEWFOEyZSjwx4aZNKHTVrvMgEellkvsXVymdJO9cMFl/XWhV2JTHHDQl
         zl31V0N42tE+V4dkNfdYczzaPw7ZHs1dH06hVKYF37KHoVSlYMoooSu8cCg4LUg9Mbqg
         /O80FM/SnkigZh9RqqD10aZ2Mw8F7wsrjg5tXCcET8BpCOq0orkECORE44BoeBCWkEHn
         pBif43noC7IGrxAr3tAHmKlqfePl8GorkZTgnyDIRH6XWQ5/mC+ZG3pfXOQbxtHjfQx4
         v/Ag==
X-Gm-Message-State: APjAAAW44OgCDMX8fZ3b1vrfY8WfM97KTBqum9YDuO8JCwC7s0thfBEz
        q0EHW2Zu/HpboB9s6PJl7KvwdBRL8PG73A==
X-Google-Smtp-Source: APXvYqxHBtSh+/6IJVUafbfXSPoUImAQ5IbkQ1l66MjQy8e3RUYc28sXyCP+8jS6lFV9j9YqfpKiRA==
X-Received: by 2002:adf:ce04:: with SMTP id p4mr3773130wrn.130.1568359711768;
        Fri, 13 Sep 2019 00:28:31 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w8sm1798031wmc.1.2019.09.13.00.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 00:28:31 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Paul Thomas <pthomas8589@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] serial: uartps: Fix uartps_major handling
Date:   Fri, 13 Sep 2019 09:28:29 +0200
Message-Id: <00a269bc15c4f8c0a73c14958c5d7a5d37ff70ce.1568359707.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two parts which should be fixed. The first one is to assigned
uartps_major at the end of probe() to avoid complicated logic when
something fails.
The second part is initialized uartps_major number to 0 when last device is
removed. This will ensure that on next probe driver will ask for new
dynamic major number.

Fixes: c9712e333809 ("serial: uartps: Use the same dynamic major number for all ports")
Reported-by: Paul Thomas <pthomas8589@gmail.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f145946f659b..92df0c4f1c7a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1550,7 +1550,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
-	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
@@ -1680,6 +1679,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
 	return 0;
@@ -1741,6 +1741,12 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	/* If this is last instance major number should be initialized */
+	mutex_lock(&bitmap_lock);
+	if (bitmap_empty(bitmap, MAX_UART_INSTANCES))
+		uartps_major = 0;
+	mutex_unlock(&bitmap_lock);
+
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
-- 
2.17.1

