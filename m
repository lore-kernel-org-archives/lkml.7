Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A0BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA8D2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383180;
	bh=pUQzzgviHZAl9J4RPTZPd1/kHJ8JsYvcDV5EOmgKvJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCggvLIgTW63hyVBOrec1DdqG/wBuvTkaDdPZRPEAu7jsXjaeJ/IblclY3R85BXd/
	 FzWW0mDFpTX/XHG4sD1SBFkqFS3tKTbZsqq3/VdEk8dSsfrwMJiOkzlx1+rZ5JMxPq
	 0SD04ISb+b79OTq7ijLlPmEyzFGJ7Sd+6ZzdF4bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJFRc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbfJFRc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:32:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80FE92087E;
        Sun,  6 Oct 2019 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383176;
        bh=pUQzzgviHZAl9J4RPTZPd1/kHJ8JsYvcDV5EOmgKvJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMCK4o6kVrxEVt4u2OG6/9ZrRRbV2Iuu2l4xJY2ANvlE8uQ7CS4AA4rdhl/+5wYlW
         x2WUhCMcB0Plg0gAcRND0Jrrmvk3naBblWmRBTduZi6HSiRCd3biLBU1Z4ar59zhcU
         VnhQpb6wUxNQsx6biEwLu4RILzYY3l23D+Pgoe6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 082/106] hso: fix NULL-deref on tty open
Date:   Sun,  6 Oct 2019 19:21:28 +0200
Message-Id: <20191006171157.664209125@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8353da9fa69722b54cba82b2ec740afd3d438748 ]

Fix NULL-pointer dereference on tty open due to a failure to handle a
missing interrupt-in endpoint when probing modem ports:

	BUG: kernel NULL pointer dereference, address: 0000000000000006
	...
	RIP: 0010:tiocmget_submit_urb+0x1c/0xe0 [hso]
	...
	Call Trace:
	hso_start_serial_device+0xdc/0x140 [hso]
	hso_serial_open+0x118/0x1b0 [hso]
	tty_open+0xf1/0x490

Fixes: 542f54823614 ("tty: Modem functions for the HSO driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/hso.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -2634,14 +2634,18 @@ static struct hso_device *hso_create_bul
 		 */
 		if (serial->tiocmget) {
 			tiocmget = serial->tiocmget;
+			tiocmget->endp = hso_get_ep(interface,
+						    USB_ENDPOINT_XFER_INT,
+						    USB_DIR_IN);
+			if (!tiocmget->endp) {
+				dev_err(&interface->dev, "Failed to find INT IN ep\n");
+				goto exit;
+			}
+
 			tiocmget->urb = usb_alloc_urb(0, GFP_KERNEL);
 			if (tiocmget->urb) {
 				mutex_init(&tiocmget->mutex);
 				init_waitqueue_head(&tiocmget->waitq);
-				tiocmget->endp = hso_get_ep(
-					interface,
-					USB_ENDPOINT_XFER_INT,
-					USB_DIR_IN);
 			} else
 				hso_free_tiomget(serial);
 		}


