Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E4C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A14D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWNxUzxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfGSRt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:49:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43864 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGSRtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 13:49:25 -0400
Received: by mail-io1-f67.google.com with SMTP id k20so60087920ios.10;
        Fri, 19 Jul 2019 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=baGSXwBYZTXtADqKE2KAvtjQ3yUogk839fU/9Qnnaa0=;
        b=uWNxUzxdc26FSrMI/dHfQmD/urraeYPJSBPgI7xG98vVg5wdzwRypXCXXmP/MBVUoj
         rBSIdntkqQc355oewejCvlAXff8NHR83rsu4TEz7CDNALRw2vMSV/ddS6HwTMjDmqPHr
         /esy6S+1eQ1G8uJOUGcCS5Z367dX/u5Pps9nbvfIO6LN8rGbruqMiI4kkN5aTjwF56xo
         Bjngcr0+UdrY0OS8JnFCFCjjkbc9mae9AsHuEMYgzWEYT1MIj0haLTiMoYznkMG2NXAT
         MdfvMwQeCuq5/vn2EOb58b1p/ID5l9ecIjiSWFIvb0F+Vo+hVxIOUpZBxzxlucdzz0dD
         Wecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=baGSXwBYZTXtADqKE2KAvtjQ3yUogk839fU/9Qnnaa0=;
        b=o/mk4NQ21pEnN/+pyBdk2QQIfUX5ZgyGua67TqtUgdNnaYErGRCXHHRbhTPUscFk/e
         r1RhLG8vINcW9mIO2C+KMHrYnc0cl8NDTdyFstPDIzUL72MwpAySJz+QJuRWUiaMXfIR
         ytFbOcc1GRs+W+zIOFCwfMlMlorqPZTheeedY9pkPrz5zkMHlW3tpFPSHTdcJXqdAwM6
         5bJQClmEtjp5h2Qhrn8ER1EvdXTtsezY/ZTMbW3JH3YKca8KaY/cpEAQwmfQzaAXxCZw
         3VKu8BRkQsQy/aDZm47vofoodtKc87/elFV4C3wx/hbn+9tTziE+TuU/r86GpXkpA5vt
         6/ng==
X-Gm-Message-State: APjAAAVxa99Abm7GwJ2D74wAdSEHVv0P/4QRIuE45Nn/SQlZxGxvO0d+
        nM95SsCtmE+loQXN41In8YI=
X-Google-Smtp-Source: APXvYqxim4LXHBZC7WZuwyREL+ASYVopot2Kl4subWNIHwMo/q7MFV3JD3am6uhpSpx1WSv/Gam8CA==
X-Received: by 2002:a6b:1ca:: with SMTP id 193mr52663297iob.264.1563558564836;
        Fri, 19 Jul 2019 10:49:24 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id r24sm22957223ioc.76.2019.07.19.10.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:49:23 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] 8250_lpss: check null return when calling pci_ioremap_bar
Date:   Fri, 19 Jul 2019 12:48:45 -0500
Message-Id: <20190719174848.24216-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719151519.GO9224@smile.fi.intel.com>
References: <20190719151519.GO9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar may return null. This is eventually de-referenced at 
drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check 
is needed to prevent null de-reference. I am adding the check and in case
 of failure. Thanks to Andy Shevchenko for the hint on the necessity of 
pci_iounmap when exiting.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..d07e431110d9 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -169,10 +169,12 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	struct pci_dev *pdev = to_pci_dev(port->dev);
 	int ret;
 
+	chip->pdata = &qrk_serial_dma_pdata;
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
-	chip->pdata = &qrk_serial_dma_pdata;
+	if (!chip->regs)
+		return;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
@@ -195,11 +197,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 {
+	struct dw_dma_chip *chip = &lpss->dma_chip;
 	struct dw_dma_slave *param = &lpss->dma_param;
 
 	if (!param->dma_dev)
 		return;
-	dw_dma_remove(&lpss->dma_chip);
+
+	dw_dma_remove(chip);
+
+	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
-- 
2.17.1

