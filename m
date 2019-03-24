Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105D3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336520823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="h2l66GGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfCXQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:41:56 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57618 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:41:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49F4CBC0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M_mf9LE6QEY5 for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 11:41:54 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 220E091F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 11:41:54 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z6so5987333ioh.16
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M08smIfHJAEEw5STDve0az8jRhJ94IrOSIYUTYTGmTU=;
        b=h2l66GGG62aBS01xnl5p4wqsSv2S2sM26fp8Yhgjq7BqVDkXTLDQiec34o2DG3Jxw0
         /RkePrpb3pWPMTqEp0aUG0a2ELnOm9SPEF3KkE7IVNS6WsJ3FmAJP7olBPGzlgtg7EXJ
         y8UrLVb48BV4RONDXrR0SFeCTC0KhOBo+uSeWhb2mgMFNktPaAOsYzmiFOJLGuDQvfDm
         cQz38HLo/xEqYGhTvM3Rx2MT4fdibFAKyHRGV71aiekAYz83y+vDK76r9ZeLoW828E4Y
         6f9finQr1KiiqDsTNtCLRFy4Y+NNPIaFWLGVKZ+94j7Ayjzjmyjk6F62jGT0jUy67q9A
         vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M08smIfHJAEEw5STDve0az8jRhJ94IrOSIYUTYTGmTU=;
        b=GjHi5JmVBoLTrxKu6z2qgM87lIduPxa/7q24xSchS/5W0hlf63YPnawgmHdwIyt09g
         5TTEV5DLeUPih5p6QrPFckLupDk8fiqScG2RkzjthfM3TseW3I3+qKx7R+jl0Oq40pS8
         ZQ6PcWgeG90E23U+XcU8v4a68t7Z1UFxiAc2DDZVd5GuCYWW+vDg/oFdsDcB6BT5C/Wa
         YEYS/LQqGQ/WTsnBBSl4lbVBzDrVwuE82i4YL9FqPzSFm6lVaP/T306uikQrW/H/U55w
         bbYfkEKJ6AOdOVyDxeaDmNihLY9FzU9Kx4mmFwZblC1IKA7xfsSogtZc4iX4PhdgCVB3
         EOLA==
X-Gm-Message-State: APjAAAUwR0k0ofqlIoYYwJUEBo+rADVVYvraKX8J5dKSEyDDnJTshAhm
        kb0hIamYNeGPEzwTDaaaAUlHscL343Bh1wLOCszPjaIW9lh5Bl7rilyjYJTJQAgsyZeXgyJPIvb
        AeE2hJda9h2pl8a//T9BbTGNWrw6O
X-Received: by 2002:a6b:e009:: with SMTP id z9mr13262539iog.127.1553445713516;
        Sun, 24 Mar 2019 09:41:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwuYMe19IToriQ1j3VaOzwtG2KSvRbWBNJ/fMUPwyQndLn3SE47ee5Q9oOFSIamulx0UTVEAQ==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr13262515iog.127.1553445712998;
        Sun, 24 Mar 2019 09:41:52 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z22sm5454436ioc.68.2019.03.24.09.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:41:52 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Sun, 24 Mar 2019 11:41:38 -0500
Message-Id: <20190324164139.23899-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The patch returns in case of failure to
acquire IOMEM. It also releases the acquired resource in the exit path.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v3: Change the order of pci_iounmap and dw_dma_remove
v2: Failed to release resource in exit path and incorrect code in non
DMA case, suggested by Andy Shevchenko
v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
Jiri Slaby
---
 drivers/tty/serial/8250/8250_lpss.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..69d6e32da713 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	int ret;
 
 	chip->dev = &pdev->dev;
+	chip->pdata = &qrk_serial_dma_pdata;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
-	chip->pdata = &qrk_serial_dma_pdata;
+	if (!chip->regs)
+		return;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
@@ -199,7 +201,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 
 	if (!param->dma_dev)
 		return;
+
 	dw_dma_remove(&lpss->dma_chip);
+
+	pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
-- 
2.17.1

