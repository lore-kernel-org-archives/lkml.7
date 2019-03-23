Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04813C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39492183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OvnvXRGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfCWWxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:53:19 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33682 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfCWWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:53:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id C9E09C81
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w_09x8QrHkZa for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:53:17 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A1242C64
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:53:17 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id c17so4845281iom.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lkwf77gcvxRd7F9DgtgZhnQjP4tOsJVDrnF8H560fsY=;
        b=OvnvXRGW6n0vnPqbtLzW6cwpSx7ICUIoUvC2OhbncD7q6+p82IYJZkiJ9g+GPjzZtj
         +ohf/fI3hvEwQJrg1R3rgnFdYpnl30yvKNDaaFOJyrSnaC32p1s7WZxJ/Ubw7NCTQZvb
         lkGMGHPpXpw7QafWlnBIqfCD31tFWo0BGrSoeBKO03q3OE72RtebdpWxovwIhMVzWhnm
         8/uu/fsD2Qax1uvOoFF1dq8nM0o1jiWB3HwVYFmYkRjB3A+RxbS92CYEGyeJqv83c8ZL
         IhNb/qP8ODMwHb7YzjifL83R2Vvp3w+3SdrhyLIGaj7atBh8MWXcSOfvXndz5ZAwUvBX
         hp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lkwf77gcvxRd7F9DgtgZhnQjP4tOsJVDrnF8H560fsY=;
        b=Ft/vtMszPp6cCPhCe4xo0vYpZh1eBbi6IrYJjloRiMefgWDIeb4cCCufBmaTj3nhzL
         CZm86OVTxfRwYXNl0NcQtIdbwnZTw5Ol0OGJf5WQpfIljU0KjmWh6PxhJ8WsKshrZFe4
         RLupdtGVSESm4JS/5gDvc3Fu4j5q6PY6wJBC4e3y87A0jCmuqNcXsAkj4zVtWwtergqr
         kQgDcZG2lE5USZEC3Rs/e5rxMDVYvArqxT6XNOU4GXW1ceqYS+xryG6Zf75Hh1fMvDFv
         hvw+5vIB/eUZj+8J0IXGIWiyp6PeW2UFEKchmPPMV5PW3Oxdqr3tCb1MZxc7VSH1HyPX
         fEZQ==
X-Gm-Message-State: APjAAAUUVV+w/XBflFEMGWbfr4G/jXBhGI84FVLoODVfCnGwX9Cx+N09
        tqIdwk0ROHyrG5qNQE3pU9cynIM5jurE7edqqUEtPp0e8GJd6owE68m8NyIwQLogqID9lLZ6ylN
        NX4Vn3HxXu+IJUytUSjMPbFpKLzZP
X-Received: by 2002:a24:3281:: with SMTP id j123mr5905456ita.166.1553381597177;
        Sat, 23 Mar 2019 15:53:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7FTlQpT3xo4RwrHWRPt/uAde2iCPIj2pb2Of7Mwxw5Ueq9UQr4UQkjm3GY/TSTfMJ0VMMwA==
X-Received: by 2002:a24:3281:: with SMTP id j123mr5905443ita.166.1553381596925;
        Sat, 23 Mar 2019 15:53:16 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id n4sm3330753ioh.52.2019.03.23.15.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:53:16 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Sat, 23 Mar 2019 17:53:12 -0500
Message-Id: <20190323225313.12325-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The fix captures the failure and
pass an error code upstream. This can avoid potential NULL
pointer dereferences in the future.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
Jiri Slaby
---
 drivers/tty/serial/8250/8250_lpss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..1dc67897dcf8 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -161,7 +161,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.multi_block = {0},
 };
 
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->dma;
 	struct dw_dma_chip *chip = &lpss->dma_chip;
@@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
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
 
@@ -191,6 +193,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	param->hs_polarity = true;
 
 	lpss->dma_maxburst = 8;
+	return 0;
 }
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
@@ -202,7 +205,11 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 	dw_dma_remove(&lpss->dma_chip);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
+{
+	return 0;
+}
+
 static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
 #endif	/* !CONFIG_SERIAL_8250_DMA */
 
@@ -219,8 +226,7 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 	port->irq = pci_irq_vector(pdev, 0);
 
-	qrk_serial_setup_dma(lpss, port);
-	return 0;
+	return qrk_serial_setup_dma(lpss, port);
 }
 
 static void qrk_serial_exit(struct lpss8250 *lpss)
-- 
2.17.1

