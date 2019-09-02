Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03F8C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C7A2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="L9WqNTw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIBO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:28:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbfIBO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:28:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so14228481wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=kBVMTQuhk+T7Ukw/iH6Fv/Si0UxRiFoyQ0dMHE7QvtM=;
        b=L9WqNTw+lDeQxnmb4IBnSlhQIEjQQEHc41KpOvIKTg6KVy2yoNjjF0Nnh3im22NzGk
         B1poC8Zm7MmUme/s/QoCtqp0DafVLacWOZEh5oskcW/M7zO5kFYB6UxIHq70UbftB7Cc
         TEph3W3dL/+LRVqc2I8bppCzfEKyrw508B/tK1tYfnj9x2njqYPQgcc+pBV9dYyKbmc8
         OHjH6PIRyCmCv0FlRzLxz9mzECWspMpHzmY+XPxFfpyULlu5qe/H+oh3WzaOE+4XATKq
         t2x36xBsjphwNv1CWin4JiOBDvPgqEE/uB89obbyhs3POIn212EVTMEbej0ZRBfw4STQ
         Pj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=kBVMTQuhk+T7Ukw/iH6Fv/Si0UxRiFoyQ0dMHE7QvtM=;
        b=JaXu1K2TfjdxvMBHAnSQQ15KxrmktRbNKtLVH0zs9YCFpF/mkznRxy8g3op80eYKo9
         bazEiX3JbfYtXBql9dOdH6APx/RKJnoFD44GQ7pM4JHII7JI3uzzFgL19NHIVtX7UTlU
         vNmOQaNon4jHJduEVATaxiuZLuPHzxSGkXH7ImzsWe2hWQX5Sx8eiZ7WKej0DGiOY1nt
         uUfs7lJhvWydoWuR2UJPsAiqJvkWoBdyt0/5+VFEzHL+psn3crDpE5gKHD2/xhj2puLc
         a+8bDORi8Iyws2R0xs6QSiKFaPqftTCbGWpBnlGzhQJtx+rpV95A+JYngdfJpwD1b52A
         02vQ==
X-Gm-Message-State: APjAAAU5hvMs6HBGpK0uNjqIGg0sCYMVw+iAi2Xc51LhjkyJmKT2f93E
        rVqneZXxtc9f6/NiX5v1QwwLUugKB/OXRLbM
X-Google-Smtp-Source: APXvYqyO397vHhfCskHh8cwMyoUd3jnZFHXaYs4K0biXoMFfjgiE/4hfNFZBtUyw7CEUYPc6j/Am4g==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr38731050wru.27.1567434481989;
        Mon, 02 Sep 2019 07:28:01 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f18sm16202373wrx.85.2019.09.02.07.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 07:28:01 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] serial: core: Use cons->index for preferred console registration
Date:   Mon,  2 Sep 2019 16:27:59 +0200
Message-Id: <4a877f1c7189a7c45b59a6ebfc3de607e8758949.1567434470.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for this patch is xilinx_uartps driver which create one dynamic
instance per IP with unique major and minor combinations. drv->nr is in
this case all the time setup to 1. That means that uport->line is all the
time setup to 0 and drv->tty_driver->name_base is doing shift in name to
for example ttyPS3.

register_console() is looping over console_cmdline array and looking for
proper name/index combination which is in our case ttyPS/3.
That's why every instance of driver needs to be registered with proper
combination of name/number (ttyPS/3). Using uport->line is doing
registration with ttyPS/0 which is wrong that's why proper console index
should be used which is in cons->index field.

Also it is visible that recording console should be done based on
information about console not about the port but in most cases numbers are
the same and xilinx_uartps is only one exception now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..5ec447a4c5c3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2825,7 +2825,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
 	if (uport->cons && uport->dev)
-		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
+		of_console_check(uport->dev->of_node, uport->cons->name,
+				 uport->cons->index);
 
 	uart_configure_port(drv, state, uport);
 
-- 
2.17.1

