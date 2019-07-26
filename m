Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F218C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2548F218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/frdd0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbfGZTyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:54:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45575 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGZTyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:54:10 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so107184020ioc.12;
        Fri, 26 Jul 2019 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ezA9Ps8nViOZ8mYc2cpbVmIgOKvkwYtjIOsIWc7EGfk=;
        b=o/frdd0+nm23NHcNjEQzvT7T63nqe9YJq0v0DG10vP3KavmGlCZjE8mATEDvzhoMof
         TEAeKoMewMBC6uv1o/gjU/EddEU1giUApMNd8J7MWWstqdl/uAfn3/qomm1TwsDcKBWd
         NDe3idrW1+SaSYCads/JWYwLLD8zlxzK6XrRZWSGm5dFK4r+n8vhmBB/Eqt4o6AvbfvO
         A3iI3mZTNImMASwb8mL4FQ4/zkfgbSzk+WPW0qg2bsy6NdCk3EEm1sCrOSNUNSueO0RE
         OBl2tELHV9RLJW4kV/dnoDarQTa1BAF+vJPplu9pVDuQHMRfGkiO+H6d/yBBnKaN+aW8
         h7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ezA9Ps8nViOZ8mYc2cpbVmIgOKvkwYtjIOsIWc7EGfk=;
        b=uEV5Hr0i0JYURL43CGR6k2XZuQraKramllIkDJonCe7fj+1AYPawdg2Jv/Ib/cb90E
         KpPx2VDfrEI98TpdVYiXqo5bKSmel1zB0hj4JBiMOBDlmL0OKh/UeodVLdo9UzoVW2ZK
         2Ge1eaD6QqpWgQ++5vnDfqGVxxm9iHxYh11j0qornKP+csRwqGRuKucnIlo1t+WBriEV
         PsdOGwDTWHVAuE47cc4MGHqvlgVJWpTEYSylTj41F1gffvemhNM6J6JVycPzxU+Y3wyI
         QKtTTC+XBAc8CrEyoA3+pTjKpzdrg+/BpWZfi0oJmHvuTDKnukjWMfWTR36Flfam2Tz7
         bSnA==
X-Gm-Message-State: APjAAAUAkc6fHP0Xq2adDPIFdvA9vnTp+y7r5c2W4i+DcJMLzy2zbD6/
        V634qkIg1yXR1kpCpn1rfZ8=
X-Google-Smtp-Source: APXvYqyj8frAH6Ich5+1VmdLT/Oqx5Wnz5zjLFYXtxxLYRg/h6/e/fn1rms9PPtqe+gFa/65cULO9w==
X-Received: by 2002:a6b:bc42:: with SMTP id m63mr73942380iof.189.1564170849575;
        Fri, 26 Jul 2019 12:54:09 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id c17sm40157359ioo.82.2019.07.26.12.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 12:54:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     emamd001@umn.edu, kjlu@umn.edu, b.zolnierkie@samsung.com,
        gregkh@linuxfoundation.org, smccaman@umn.edu, secalert@redhat.com,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] 8250_lpss: check null return when calling pci_ioremap_bar
Date:   Fri, 26 Jul 2019 14:53:43 -0500
Message-Id: <20190726195345.30294-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726115746.GT9224@smile.fi.intel.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_ioremap_bar may return null. This is eventually de-referenced at
drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check
is needed to prevent null de-reference. I am adding the check and in case
 of failure. Thanks to Andy Shevchenko for the hint on the necessity of
pci_iounmap when exiting.
Update: also covered the dw_dma_probe() failure.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..19b356119ef6 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -169,15 +169,20 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
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
-	if (ret)
+	if (ret) {
+		dw_dma_remove(chip);
+		pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 		return;
+	}
 
 	pci_try_set_mwi(pdev);
 
@@ -195,11 +200,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 
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

