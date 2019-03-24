Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0105C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8D32082F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hJ3agEnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfCXTWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:22:17 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:55040 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXTWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:22:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4409ABC9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 19:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gw6fvoRRmS7n for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 14:22:15 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1B998B97
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:22:15 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id r186so1562762ita.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dzx5QAwS7gezE84Y65aYERItKnoCKTiqtmbFTImRu5g=;
        b=hJ3agEnZd3BCyGpTk6XTX99IdiG5G2/Xil/xERxyKFXRBiRTFt2AlaUu1+wt1ikeaz
         NuLRweZteMwhICPAJmvqXOSgkHpb3vrNjtSEd6pmU0tltChrV3qKLPLA5D6J8ob3MD+M
         cotHBoX3y6zrywiUhpo6ZNWBZci74qgSaiBIaHTJhToEXrrxcSDOVPs9g34LRzzWMHnV
         4hhJQabQt/Pii6ED9vPb8EHJajaYwnlXSaoI/Td+MWdlR7Tv0Sv6XTR8AmX+1Rcbt/Q+
         IwHOTkW12wmqc9RnolyM0hIlAy4Iwbfqcxk/5CD/Yqugq0yG5ITiKAmtbDlO9Lm9LiqQ
         Mimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dzx5QAwS7gezE84Y65aYERItKnoCKTiqtmbFTImRu5g=;
        b=tzPFpSu2232yRPH/CdKcnxlqosDJB2l7BljfWyqY1oTuHDQPiiiKDg67ulEu494uwd
         lnAlhSdlFIlmh+48aNOPJSCzwbfqjEajux1xYk227N3JGtUsvIuINcegJsEPAJaXsB73
         NnTpiC/b/9cjtWSqv9ZEq52ejch0Fvapm8HHQ7VeY5NDSYAZgeAJN7Uy4H3/Q50+APOL
         OIsQlWMwVvk9MJh95XBJIb/hFyRJJKBbeCqmNpQLIFfGAJyc+cM50jxHhoolnam11G1i
         6+AeVlH9lTffmx6gpmdVhUh7ZdNLzIhi5KI+aK/f8YJJbBJMgCyp7IyJRxGMdrZyrDt1
         lIlQ==
X-Gm-Message-State: APjAAAWwM4sHP9E5YykvOnrjMzD3wD/WVVE1KG5NjKChxs9Nz8IBgAS9
        73FXkRdKgH+Oco/YyoY+QZopwkQP1fEVBIzcBtLtk2KUISWHIa6KSqj2vXQKPCkH00lXb6ZUHL7
        B75GIJa1/hnszxjR3OcxMM+rQjZ1T
X-Received: by 2002:a6b:7601:: with SMTP id g1mr14985156iom.108.1553455333561;
        Sun, 24 Mar 2019 12:22:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymz0i8w3n2uRjgmo7D5HZdDq2wSKMdeWqYKxllHiNBDKfXKiDSmdQHfwM4l7kVgL6mWyuJvQ==
X-Received: by 2002:a6b:7601:: with SMTP id g1mr14985100iom.108.1553455331932;
        Sun, 24 Mar 2019 12:22:11 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id j10sm4967861itj.32.2019.03.24.12.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 12:22:11 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Sun, 24 Mar 2019 14:22:08 -0500
Message-Id: <20190324192209.27202-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The patch returns in case of failure to
acquire IOMEM. It also releases the acquired resource in the exit path.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v4: Missed resource release in dma_probe failure.
v3: Change the order of pci_iounmap and dw_dma_remove
v2: Failed to release resource in exit path and incorrect code in non
DMA case, suggested by Andy Shevchenko
v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
Jiri Slaby
---
 drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..a098902221df 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -170,14 +170,18 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
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
-	if (ret)
+	if (ret) {
+		pci_iounmap(pdev, chip->regs);
 		return;
+	}
 
 	pci_try_set_mwi(pdev);
 
@@ -199,7 +203,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 
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

