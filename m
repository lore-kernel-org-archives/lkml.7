Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B550C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4174C21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsp1jc77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfLLNQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:16:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40119 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfLLNQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:16:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2685109wrn.7;
        Thu, 12 Dec 2019 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xC1V1OXM7iQO6hr2sfVaq+K9PrfoaGHt4GtTPGZeDwk=;
        b=Lsp1jc77LRacRdX0U6+mRFDG8frM2mpWQwMeSGuqFjiGFjC5r7wOvdPOe/fNlNFfsN
         ESuMHIe+ETmK/3pZ56Owi8ztDLBa/yhCFidSyTshVlX5IPvE3bojObJcd+Wv8cgzyyR+
         ZgLLQ7JT71qDlwVJkC74I6PBISvHN16pFaGaX2SXocgyAj18ZzsrJDsubkcba51po/sD
         GdvtKrqewCYiZQsviaL9gjREZISvaLnzXEPEbvyIt8d/oywicDvGNcFUjFiPo5KeDIcy
         q9OG9rLryRCfW0kWNYqtfvMtmdpG2J9vdQ5MeCefi2Sg6wBJ+EPSVeA2cXW4i6pkn5hL
         ebJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xC1V1OXM7iQO6hr2sfVaq+K9PrfoaGHt4GtTPGZeDwk=;
        b=CQgQHpBZzj8XRal8+VOcJCCRM4mdzkxV/YjLUSJwc849mAumUMRBfnDEE6RnS7gL4f
         9QmoUCiMxZKGBS1NWDVuaS3AkM6uxh20m0oEuEe77qyUbIL9vTOJiGPHpaiz5hlH+Zt1
         xEJalKv51v3PrnMmmYfxt13GGJFG0R6T7MLkOfFP7MQA8BrA9pK5Hhpdn8DMeXa+malp
         3DlsIKOMArr288d1LH7UzTlQlW6Fo9RVYII6skyjE0x+8CC7nZVjRDTQkiFrJkoKYMaz
         LtHRvCIF+7UD3+I0TkpYFb1e3kfQ87rRneJKzqOF4mWKc/+kRsYBOyyAWivOHu507ZNr
         U99g==
X-Gm-Message-State: APjAAAXm1ctqKYgqMqqWQAaKKFfr+NZl97EDhlCiFgw0Lf0b/7zpgS8+
        XIB0RZ9Y837G/KqB01gLPqQ=
X-Google-Smtp-Source: APXvYqy68o0ch6tMvKbbixnsXmQ1TzXWiQrN6b9xHSlwFMCN4fCWbAyBAzJC69h+tbVHBzGeMOSJyA==
X-Received: by 2002:a5d:61cf:: with SMTP id q15mr6416821wrv.231.1576156565036;
        Thu, 12 Dec 2019 05:16:05 -0800 (PST)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id e12sm6027849wrn.56.2019.12.12.05.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 05:16:04 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: link tty and port before configuring it as console
Date:   Thu, 12 Dec 2019 13:16:02 +0000
Message-Id: <20191212131602.29504-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a race condition in tty drivers and I could see on
many boot cycles a NULL pointer dereference as tty_init_dev() tries to
do 'tty->port->itty = tty' even though tty->port is NULL.
'tty->port' will be set by the driver and if the driver has not yet done
it before we open the tty device we can get to this situation. By adding
some extra debug prints, I noticed that:

6.650130: uart_add_one_port
6.663849: register_console
6.664846: tty_open
6.674391: tty_init_dev
6.675456: tty_port_link_device

uart_add_one_port() registers the console, as soon as it registers, the
userspace tries to use it and that leads to tty_open() but
uart_add_one_port() has not yet done tty_port_link_device() and so
tty->port is not yet configured when control reaches tty_init_dev().

Further look into the code and tty_port_link_device() is done by
uart_add_one_port(). After registering the console uart_add_one_port()
will call tty_port_register_device_attr_serdev() and
tty_port_link_device() is called from this.

Call add tty_port_link_device() before uart_configure_port() is done and
add a check in tty_port_link_device() so that it only links the port if
it has not been done yet.

Suggested-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

This actually should be v3. The previous discussions are at:
https://lore.kernel.org/lkml/20191120151709.14148-2-sudipm.mukherjee@gmail.com/
https://lore.kernel.org/lkml/20191121152239.28405-1-sudipm.mukherjee@gmail.com/

 drivers/tty/serial/serial_core.c | 1 +
 drivers/tty/tty_port.c           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b0a6eb106edb..7c2782785736 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2834,6 +2834,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
+	tty_port_link_device(port, drv->tty_driver, uport->line);
 	uart_configure_port(drv, state, uport);
 
 	port->console = uart_console(uport);
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 044c3cbdcfa4..5023c85ebc6e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -89,7 +89,8 @@ void tty_port_link_device(struct tty_port *port,
 {
 	if (WARN_ON(index >= driver->num))
 		return;
-	driver->ports[index] = port;
+	if (!driver->ports[index])
+		driver->ports[index] = port;
 }
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 
-- 
2.11.0

