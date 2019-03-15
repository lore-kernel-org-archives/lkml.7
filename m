Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A5221872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 04:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Pz3tTBZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfCOE42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:56:28 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55446 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfCOE41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 00:56:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 5C795D44
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 04:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XWGsiv5OoKBc for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 23:56:26 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3542ACFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:56:26 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id i1so6179876ioq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u2gwbnbzIDO4/Mhaw6yBDXOhq6ZssVWg8uPknOAfdGg=;
        b=Pz3tTBZdvKJTqJX8emjQ7DSdkSVc3UVy0k7OeIVNwagwDGo8m8U+RMNzWNGWijQgLY
         nQeSHDdvta3LME8pUOx+HxsuG6+c+IGXeFV5bnD1SH+nUJJGkQ2jhE8fzNAFwu61fHza
         SyyHLBred9jpj54QRDwGNqYaSvzt9uiBEDvPGY/C4LoXTatdXHAFwHE0nkzAO3JBOwzB
         3BO6PKH2Prlf1y1MR4caFUEehc482NSK7jBJ/W0TU15CzKIFb+gZ77fgGF7DTRFvHnvm
         exsy/kVpC5hrH93+KTaTzggr6TB31Q9MXoALdpJkuQfIQL408WVZQIZ2po19maMF94zI
         eEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u2gwbnbzIDO4/Mhaw6yBDXOhq6ZssVWg8uPknOAfdGg=;
        b=U/ciZ86v18787cWIjidFFGLKKbop5XYTMQFbl4OOOCeg2FhWxphRQfiNHzmwZRt3XZ
         5uG0vOCmRSc6QcZlvhBi2gFQqZS91SW51A+aa24iSTldZB2kGQmwLnTHfaPMHgAcMtSV
         A/6rkl5KlAsjWntrZcAezP9fZBhqqj+TV/RV/gG789l1bIyzeMv6YfnwfGdETo4fFEww
         TlqDpRJwgh3d0V8YU2fmdu2YRqynn4gG8agYEpza3X0i+zv00qMTG2cRfHEEYmw2jqo+
         MpcvhU/hmu60QBo5O95MdxxtxMlGbZb6GpChc9Xdk2vqXs5cVZLFEDi5YvzQvxt4M6Ru
         2FqQ==
X-Gm-Message-State: APjAAAWLx7hbJfSE8hVxn6cUAEkkMyFdmDxE068/MQEZwAc8onaLd3Kf
        8HH29ABXFT2IZeJOjxnYQH4dAEdiph5G70F2WH5MLcUBlafsHhhYCoAI7xUVkuPtVXRPrumgGLi
        s4uvPnKoKAwKFsOuMxw2OAApVNH65
X-Received: by 2002:a02:94a1:: with SMTP id x30mr1218875jah.82.1552625784975;
        Thu, 14 Mar 2019 21:56:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcChBtGfAgnOgmaALv4bJXuSjSntQvbcyQZ40WX7RMxYEKbXe7wpCzV7rzLxfy7ThjBptfiA==
X-Received: by 2002:a02:94a1:: with SMTP id x30mr1218864jah.82.1552625784645;
        Thu, 14 Mar 2019 21:56:24 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id i5sm568131itb.3.2019.03.14.21.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 21:56:23 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Thu, 14 Mar 2019 23:56:16 -0500
Message-Id: <20190315045617.7616-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The fix captures the failure and
pass an error code upstream. This can avoid potential NULL
pointer dereferences in the future.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/8250/8250_lpss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 98dbc796353f..e95332d8b35e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -162,7 +162,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.multi_block = {0},
 };
 
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->dma;
 	struct dw_dma_chip *chip = &lpss->dma_chip;
@@ -173,12 +173,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
+	if (!chip->regs)
+		return -EIO;
 	chip->pdata = &qrk_serial_dma_pdata;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
 	if (ret)
-		return;
+		return ret;
 
 	pci_try_set_mwi(pdev);
 
@@ -192,6 +194,8 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	param->hs_polarity = true;
 
 	lpss->dma_maxburst = 8;
+
+	return 0;
 }
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
@@ -203,7 +207,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 	dw_dma_remove(&lpss->dma_chip);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
 static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
 #endif	/* !CONFIG_SERIAL_8250_DMA */
 
@@ -220,8 +224,7 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 	port->irq = pci_irq_vector(pdev, 0);
 
-	qrk_serial_setup_dma(lpss, port);
-	return 0;
+	return qrk_serial_setup_dma(lpss, port);
 }
 
 static void qrk_serial_exit(struct lpss8250 *lpss)
-- 
2.17.1

