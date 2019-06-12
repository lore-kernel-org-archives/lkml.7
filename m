Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35EC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A3B208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="vJ8MWs3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438298AbfFLLOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:14:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438270AbfFLLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so16481600wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NnFm9RoxHS8m0lojdUsIdKlkIcGlKRsn/Qls2kl7Du4=;
        b=vJ8MWs3xCAP10O+/tw+ajXf/Z9z0zjuN6S/iODK4BARmr0JqC7ItWkKbW+uJ99UCvA
         YeOQ5IezMKgR3fuYHyKHzHAUyDZ8HrCWG3+xIgNk/7FYSdLJoxPhJ7a0m9j5pTqD27gH
         nkNVzQVSGJ0vdDrjuSEgM7HrFL8BnqGggijp3gJkg3s372J38utK69Oeiu+1DllfJLYJ
         npIAWwBXk4lCJ5w+q779GctHtwfgbB2t/J3Nkugp3d4XClKjZZsVQ1lEhQe5PTWs1vL6
         iCjoBvtzcD9ZV9EBGi4SyeTOFWqf+++Ixxi8tv7xdA671+urlkeYGAwbMxru+s26Vgoi
         OACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=NnFm9RoxHS8m0lojdUsIdKlkIcGlKRsn/Qls2kl7Du4=;
        b=C4kgsnq8kTGIsTsDnnHYiMdiPRZLGMXVkv4M2+XFAWcX01RznZB91aHgusq8dN7au/
         xe+/ErHHSMbBDQdO3oV5UTVs0/HQysfOuw60AzCgJ8RqAqQM/b8DIo+qltdpzELZApwh
         o81Idtl+Uj/ccpwaVDj5qC92k3uevjI5suh3LXOUU6OQfMclurm8cdqdi4OE89nLO2Xq
         7AvEL642tzDSTsglxCdT3M77wcY8We5DHBPKKAuEvvNulRBV+bAmUwUgjoUjOSehO+RC
         i+LHW4JY61inAeVkoQ2VZxiXwoMO14Mtz30cpB4epKsKhIe/w2NyB/2hZXnEOS5cTmlr
         nOMg==
X-Gm-Message-State: APjAAAU4syEnAz1BouKz1gpyUiOiWxn9nsbw5ehSq4LRG9xWgHKctd0l
        8ilHV4wCXT5UNTGAIETqER3teg1aDUzCbA==
X-Google-Smtp-Source: APXvYqwbi8W/UYkCzMJLaCklKQBfeHAQMEcDaMqD7GdpzWuZQ8QpJkYincPYnwzm8UpBd5aiyruS6A==
X-Received: by 2002:adf:fb8a:: with SMTP id a10mr18835589wrr.235.1560338089973;
        Wed, 12 Jun 2019 04:14:49 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r6sm10675891wrp.85.2019.06.12.04.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:49 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] serial: uartps: Use the same dynamic major number for all ports
Date:   Wed, 12 Jun 2019 13:14:38 +0200
Message-Id: <6bacab58ca88dd08c766b571f19d0b26378099fb.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Let kernel to find out major number dynamically for the first device and
then reuse it for other instances.
This fixes the issue that each uart is registered with a
different major number.

After the patch:
crw-------    1 root     root      253,   0 Jun 10 08:31 /dev/ttyPS0
crw--w----    1 root     root      253,   1 Jan  1  1970 /dev/ttyPS1

Fixes: 024ca329bfb9 ("serial: uartps: Register own uart console and driver structures")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix typo in subject line
- Swap patches compare to previous series
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 605354fd60b1..9dcc4d855ddd 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -29,12 +29,12 @@
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
-#define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
+static int uartps_major;
 module_param(rx_trigger_level, uint, S_IRUGO);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
@@ -1517,7 +1517,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
-	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
+	cdns_uart_uart_driver->major = uartps_major;
 	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
@@ -1546,6 +1546,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
-- 
2.17.1

