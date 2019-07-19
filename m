Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5F6C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF842173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 02:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBYn8ZXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfGSCzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 22:55:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34863 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:55:03 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so55436626ioo.2;
        Thu, 18 Jul 2019 19:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crPNB/o3Q9ur97XTicpVaP0d8OKmA3gf/e7Gr0NtXVI=;
        b=RBYn8ZXdbWHoXyzyA8XGm7rnVL7fXfGksdzm0gEBYDzQuaaJTKc6kcuSwReTACcBxa
         9S9P77ppW22THYr1tNjKxvaZwNJ+xvRgh5S1wRH2HgyTEIj+KXx2+yypqjvzEk3F7T97
         sBrSVU6TBSGAMf9BmPpwtfC8UmEiSldTGl7BNPqPVwZybjStdjmayXr4YZz/UKl9A/I6
         eTDh8KJbRW7/EoKBmuvtkkiR208r5RyvgBNYm15/qnd3ABFR09Czg36BigCcQBYMiOiv
         2lv5b0eYUFFnHK57EnLyhZi6vbaobAgDVapbsqVSachfLtliiLYYVQ4SfgqgI4HtAMgx
         z74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crPNB/o3Q9ur97XTicpVaP0d8OKmA3gf/e7Gr0NtXVI=;
        b=TZKBJlRtYwnFQvX4RDJX5dMotXRNydg99BFF6yMBJjdx8NOIS5RQ2t7JO2el3KcAZX
         y5vn80aTKugyBcyPqGEiocavJO83ObCbexP143pw4l3WA4ky+xwTVlcxgYntaMlFefL+
         1+U1BgWHiZRTGfCqvOXyo2MlsARAbxAoRSmLGBB4de/pvi3dcxORtGv4f5bbn8lbof9S
         YyoPPODoLy8uFzWq0+apxJQ3tzjQeub6twvNAR3JuvS1rOJtoU0UC2RMr9iuL29oOjIm
         dpqAnvPzNBUEle2u+ftHf0lDehRxiFLKrNDIorxVn8gpw8fHPSG9EYrC/++nCtNvCaWF
         UX3A==
X-Gm-Message-State: APjAAAW4inz/am7bgYk9f4ZJIxm3Dt303sS5Ms406swpFGf1Z0ri4rjX
        yu8+yRpW9LMHPT+gLJ3qlMEeY40K5KI=
X-Google-Smtp-Source: APXvYqyOAUD6nqXzJRaSa0pX5RuWRnq7cn+ko1UHXJSLfWzgmz8O2awrjhkTbLF/bcietJ/DEKPgAQ==
X-Received: by 2002:a5e:a708:: with SMTP id b8mr48249316iod.25.1563504902411;
        Thu, 18 Jul 2019 19:55:02 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id u17sm25277038iob.57.2019.07.18.19.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 19:55:01 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 8250_lpss: check null return when calling pci_ioremap_bar
Date:   Thu, 18 Jul 2019 21:54:42 -0500
Message-Id: <20190719025443.2368-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar may return null. This is eventually de-referenced at 
drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check is
 needed to prevent null de-reference. I am adding the check and in case of
 failure returning -ENOMEM (I am not sure this is the best errno, you may 
consider it as a placeholder), and subsequently changing the caller’s 
return type, and propagating the error.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..5954b2e09b76 100644
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
+		return -ENOMEM;
 	chip->pdata = &qrk_serial_dma_pdata;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
 	if (ret)
-		return;
+		return 0;
 
 	pci_try_set_mwi(pdev);
 
@@ -191,6 +193,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	param->hs_polarity = true;
 
 	lpss->dma_maxburst = 8;
+	return 0;
 }
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
@@ -219,7 +222,9 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 	port->irq = pci_irq_vector(pdev, 0);
 
-	qrk_serial_setup_dma(lpss, port);
+	ret = qrk_serial_setup_dma(lpss, port);
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 
-- 
2.17.1

