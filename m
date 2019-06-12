Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A38C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C2220B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="1kg41o7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439503AbfFLN6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:58:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42402 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437142AbfFLN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:58:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so12174915lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8cjTTzgU1BuZShGhluhUvn/gIuNeI/1dPftVzArlb4=;
        b=1kg41o7pejzEwVCQwmQNwlFRESAl+8p1OISMOEaRutDSKWF0OmWnucdVBgLy5cNaPm
         Duxft+y78Z23F1GezmhlxSNnXMXkwj0HuZpv9ygTeBRAH0uuTh2meepHu7Ln/o8UKeiS
         Z4YHQ7UFFrX/8KgqvS+Q2FRcBdmAKDNWdfkvrDbXBJbfmbyvYV2tOrzYVEj37KzRFvgc
         Sg/StziPXtatCa1MG/30Y92Ri/ffKeeMGDCyTxe2e9tSBa8l2Ae/Rk0jWCqcMfB22ebT
         AT8AvAinT//R4V/NHLyqgetXMfR43lqEice0HhFzu5QRm1LQx+U10ulfYw8n7NdoOA3u
         vgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8cjTTzgU1BuZShGhluhUvn/gIuNeI/1dPftVzArlb4=;
        b=sJjLCwZKsjMiYZrx2RUxE6eifza0WRuCLK67NGJLY8eBIcF4wdTRyFZWUwaHwRlsvw
         yo0pZ2ABOKudrqMbOFHt8SgOPIZ/8D7O23WMCGAlGIW8OUWaMbhzd0vwvAwXlW6DG+le
         q/gpodDrX2u7tXpvHOgXl6KJqjtk4XWDstqKsu+5FprvzS4kyE/YpC6ybaGZ4/mSHUD5
         UDhlDX6DfRAiukEbhgrL0kN1w7dMpKsCo1w2zNWcYrwxTpdNhKjxBXiRrfJtPjEgc8YQ
         XfDnHPQwrUtdoogi+c1uhPBv25sbtRrb6bpTibHAVmHbbWxjsUcLhGmNUj1hE2wHX4kU
         Fc2w==
X-Gm-Message-State: APjAAAUs+2CL4ZyfEN7JrerRo3RiTO75UBbI8MB1oh8r69KNP/LiNOwo
        1BTUNdZTwZNUTDbiDUBK3O1tKA==
X-Google-Smtp-Source: APXvYqyjJ7GiWqxfDesRDknJ+PtFKayBgD0Ui4A0cRPWAMtWNbCFAuxs5zr0e87/V0RWBVJTTGNKIA==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr28268495lfm.61.1560347927201;
        Wed, 12 Jun 2019 06:58:47 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x194sm2621999lfa.64.2019.06.12.06.58.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:58:46 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: kpc2000: improve label names in kp2000_pcie_probe
Date:   Wed, 12 Jun 2019 15:58:35 +0200
Message-Id: <20190612135836.23009-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610200535.31820-1-simon@nikanor.nu>
References: <20190610200535.31820-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use self-explanatory label names instead of the generic numbered ones,
to make it easier to follow and understand the code.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 42 ++++++++++++--------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 9b9b29ac90c5..ee6b9be7127d 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -327,7 +327,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	if (err < 0) {
 		dev_err(&pdev->dev, "probe: failed to get card number (%d)\n",
 			err);
-		goto out2;
+		goto err_free_pcard;
 	}
 	pcard->card_num = err;
 	scnprintf(pcard->name, 16, "kpcard%u", pcard->card_num);
@@ -346,7 +346,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		dev_err(&pcard->pdev->dev,
 			"probe: failed to enable PCIE2000 PCIe device (%d)\n",
 			err);
-		goto out3;
+		goto err_remove_ida;
 	}
 
 	/*
@@ -360,7 +360,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		dev_err(&pcard->pdev->dev,
 			"probe: REG_BAR could not remap memory to virtual space\n");
 		err = -ENODEV;
-		goto out4;
+		goto err_disable_device;
 	}
 	dev_dbg(&pcard->pdev->dev,
 		"probe: REG_BAR virt hardware address start [%p]\n",
@@ -373,7 +373,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 			"probe: failed to acquire PCI region (%d)\n",
 			err);
 		err = -ENODEV;
-		goto out4;
+		goto err_disable_device;
 	}
 
 	pcard->regs_base_resource.start = reg_bar_phys_addr;
@@ -393,7 +393,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		dev_err(&pcard->pdev->dev,
 			"probe: DMA_BAR could not remap memory to virtual space\n");
 		err = -ENODEV;
-		goto out5;
+		goto err_unmap_regs;
 	}
 	dev_dbg(&pcard->pdev->dev,
 		"probe: DMA_BAR virt hardware address start [%p]\n",
@@ -407,7 +407,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		dev_err(&pcard->pdev->dev,
 			"probe: failed to acquire PCI region (%d)\n", err);
 		err = -ENODEV;
-		goto out5;
+		goto err_unmap_regs;
 	}
 
 	pcard->dma_base_resource.start = dma_bar_phys_addr;
@@ -421,7 +421,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	pcard->sysinfo_regs_base = pcard->regs_bar_base;
 	err = read_system_regs(pcard);
 	if (err)
-		goto out6;
+		goto err_unmap_dma;
 
 	// Disable all "user" interrupts because they're not used yet.
 	writeq(0xFFFFFFFFFFFFFFFF,
@@ -461,7 +461,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	if (err) {
 		dev_err(&pcard->pdev->dev,
 			"CANNOT use DMA mask %0llx\n", DMA_BIT_MASK(64));
-		goto out7;
+		goto err_unmap_dma;
 	}
 	dev_dbg(&pcard->pdev->dev,
 		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
@@ -471,14 +471,14 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	 */
 	err = pci_enable_msi(pcard->pdev);
 	if (err < 0)
-		goto out8a;
+		goto err_unmap_dma;
 
 	rv = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
 			 pcard->name, pcard);
 	if (rv) {
 		dev_err(&pcard->pdev->dev,
 			"%s: failed to request_irq: %d\n", __func__, rv);
-		goto out8b;
+		goto err_disable_msi;
 	}
 
 	/*
@@ -487,7 +487,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	err = sysfs_create_files(&pdev->dev.kobj, kp_attr_list);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add sysfs files: %d\n", err);
-		goto out9;
+		goto err_free_irq;
 	}
 
 	/*
@@ -495,7 +495,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	 */
 	err = kp2000_probe_cores(pcard);
 	if (err)
-		goto out10;
+		goto err_remove_sysfs;
 
 	/*
 	 * Step 11: Enable IRQs in HW
@@ -506,28 +506,26 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	mutex_unlock(&pcard->sem);
 	return 0;
 
-out10:
+err_remove_sysfs:
 	sysfs_remove_files(&pdev->dev.kobj, kp_attr_list);
-out9:
+err_free_irq:
 	free_irq(pcard->pdev->irq, pcard);
-out8b:
+err_disable_msi:
 	pci_disable_msi(pcard->pdev);
-out8a:
-out7:
-out6:
+err_unmap_dma:
 	iounmap(pcard->dma_bar_base);
 	pci_release_region(pdev, DMA_BAR);
 	pcard->dma_bar_base = NULL;
-out5:
+err_unmap_regs:
 	iounmap(pcard->regs_bar_base);
 	pci_release_region(pdev, REG_BAR);
 	pcard->regs_bar_base = NULL;
-out4:
+err_disable_device:
 	pci_disable_device(pcard->pdev);
-out3:
+err_remove_ida:
 	mutex_unlock(&pcard->sem);
 	ida_simple_remove(&card_num_ida, pcard->card_num);
-out2:
+err_free_pcard:
 	kfree(pcard);
 	return err;
 }
-- 
2.20.1

