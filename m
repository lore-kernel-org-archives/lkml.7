Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86284C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642A20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mjJjjvpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfCYWVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:21:54 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:41144 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbfCYWVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:21:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 2841CD13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fhgxydaP3z8B for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 17:21:52 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id F2BC1D1D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:21:51 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id e126so8615658ioa.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7uoRiAtm+W2+0gbfgPdlmupUbU4KihIr0r+iQ/F6S6s=;
        b=mjJjjvpKJFG61arLiupMl5R2pt6fKuMwsmRYnFITG4D03WCJUTRVxdkoS5/nPm72RK
         6FmqL6k9LeKpjCS0VTjexZMF6CA5Nfj/DjMaaYw/zALZZ44Tk0AEl9XpwRimvC8JALEY
         cg4XhoPwZoJE9bB/JhcdazUy5Ni5d6LpX26o2hMqH52nlE7Y3cEnmsFlviKheCoj/ubd
         ALwYcmhmwiZZ/nROPgfrjOl6/PJk4t0TLv1P80Z+hbnGENY4YItcR1wi7oT/a8mTPZFM
         xEsTAy8AnCynIhnKEUwparRXsHZGlBD+OLU2EC8z+LqI3bOHKgrwCYoUET6QLCqWSV+U
         fOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7uoRiAtm+W2+0gbfgPdlmupUbU4KihIr0r+iQ/F6S6s=;
        b=JfvlfzB2w5PPGRdqdU7c5A7LVOPPk4uhKedNSl8Yx1IoQJriM5+wAiSTG4HObSeOcI
         pKET6VNBGgvxiannqZZfnKnSHFa4vypazUiER8PUwl4WYO2AQ9eG7P147Dz9ZRra2VHl
         aKRij6XvqxnL52IfFvIh001Mg9GHfmAs/EDDLPriE3Jr6RlUiS6nch/sWQmLiZmyPkx8
         nUzx/TTj9N4SB0AL6aA8SX9QrQ/MPNYrmmX9KX5ZkoaRIhcA4WbK8wYTWOAd6ocbKxar
         lBVQ4tcXtMxzAOeRcylQcTF9Aj87QUrsDRSoqc+3rJoevTHs/FhRvSQ2KBbWMHA3eDPd
         Q0DA==
X-Gm-Message-State: APjAAAWm8qdTDDQ7J+2ifEYTOMwP9/Tc4I3cUF4O8yrPOWSx/TvQrYOA
        0aLLTnGSWvtODynvYQcTorAaah7BJmI63Zdrz6xHPhfUbP6j/1OkLh5U8OoQX7kVBS5GJdmmHCv
        bSSMqp0NOx0FtPGShtENnoS/F4+5+
X-Received: by 2002:a02:77d6:: with SMTP id g205mr14586395jac.64.1553552511406;
        Mon, 25 Mar 2019 15:21:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxo85/XTlvgvcKN/ll0Jtyi1NeI4AeaxBUuMWGdLf7yllVxTsi5+NncTDSWK+wdHWmGr4/fDA==
X-Received: by 2002:a02:77d6:: with SMTP id g205mr14586379jac.64.1553552511197;
        Mon, 25 Mar 2019 15:21:51 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z132sm6305357itb.1.2019.03.25.15.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:21:50 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] tty: 8250: fix a missing check for pci_ioremap_bar
Date:   Mon, 25 Mar 2019 17:21:46 -0500
Message-Id: <20190325222147.13342-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar could fail. The patch returns in case of failure to
acquire IOMEM. It also releases the acquired resource in the exit path.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v5: change pci_iounmap to iounmap to pass kbuild errors in other arch
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
index 53ca9ba6ab4b..c7c7bf5d7e5e 100644
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
+		iounmap(chip->regs);
 		return;
+	}
 
 	pci_try_set_mwi(pdev);
 
@@ -199,7 +203,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 
 	if (!param->dma_dev)
 		return;
+
 	dw_dma_remove(&lpss->dma_chip);
+
+	iounmap(&lpss->dma_chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
-- 
2.17.1

