Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C585C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F80620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="1auTgZY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfFSGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:36:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44154 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730791AbfFSGgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:36:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so11163028lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tw9Y/vwN/nARE1RA9Z2C9HCqwYacrU1B+FDIn0dtVZQ=;
        b=1auTgZY3XXASfEB5dbWR7cin7TUrizNMayAe8EJtU+g2xVhoj90JKlrRoa7NhUs96r
         cIZ/6gso0BtyhVAysHmSYMPB53TJC9qwJmi2HuUwAlhqGILlA7rWM+u+ORxfRfEDUzUM
         ztcLvl6IiYfLhcWUpgDogw0rmQqBRURhPoNLV7/bfnWNBWkpHZ3t/N1WmRC3ZUBYajib
         96vS8sUYOsSzRsNui60qrgQMlRkkcu5fLtYt9vvU3b/pXUqS0P1DRDEOuIVwtkr3pvSc
         AXU4YluwYPU6RJ1/Vyd5SVa4fJIHhTMzdl1pOPPu7EfPSxyeuOzQ7VYGRNnIMOWLfHHe
         Jhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tw9Y/vwN/nARE1RA9Z2C9HCqwYacrU1B+FDIn0dtVZQ=;
        b=CP0hM7ORw70XQs0ntBres9oHK7NqY1XcCvNmWa54Ak6nzQRw96b7lGelhJnUzL+qtt
         dx1ty6oM+qAMpww6Ywc2s6pbSI0MZYjC0xj4bW65dWpWDHaPqBWoMoZYHWq3pyVF99Bm
         2Twd2CA2Nq8mhtqUPmGDXRa1fFPvrLwlWUx2b7whsqQ+mDRmEAgZ84DBF6y8J3DJ9Ykk
         RrP3H+7YwmheiL8Ko7/384fQr2Lmu/1fmAxALuMYlTxOQ9HRsAcfOMf8uk/Wy6Xbbos6
         MI+B9xxTSfF4+YgGlMHgmWBBGP1pyA8+uefwkZsPV67i1b+NR8bnQlgfPl75HeI2pzbD
         cjww==
X-Gm-Message-State: APjAAAU20wDaJlS64OFOae35SMDGKAdTaLojxFKUcEqW7jp3opQT+pCs
        MHcKISS+bZbpvEvJWY4XyzCwrw==
X-Google-Smtp-Source: APXvYqy+AzgrU3SgLVZV/xfKl7uw0PejMMFf2xkI77ypcplvwpkZ2YdESYQkxrOcTs8eRRvafxeqPg==
X-Received: by 2002:ac2:5189:: with SMTP id u9mr60649520lfi.189.1560926173626;
        Tue, 18 Jun 2019 23:36:13 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id k82sm2933092ljb.84.2019.06.18.23.36.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 23:36:13 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH] staging: kpc2000: simplify error handling in kp2000_pcie_probe
Date:   Wed, 19 Jun 2019 08:36:07 +0200
Message-Id: <20190619063607.20722-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get rid of a few iounmaps in the middle of the function by
re-ordering the error handling labels and adding two new labels.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---

This change has not been tested besides by compiling. It might be good
took take an extra look to make sure that I got everything right.

Also, this change was proposed by Dan Carpenter. Should I add anything
in the commit message to show this?

- Simon

 drivers/staging/kpc2000/kpc2000/core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 610ea549d240..cb05cca687e1 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -351,12 +351,11 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 
 	err = pci_request_region(pcard->pdev, REG_BAR, KP_DRIVER_NAME_KP2000);
 	if (err) {
-		iounmap(pcard->regs_bar_base);
 		dev_err(&pcard->pdev->dev,
 			"probe: failed to acquire PCI region (%d)\n",
 			err);
 		err = -ENODEV;
-		goto err_disable_device;
+		goto err_unmap_regs;
 	}
 
 	pcard->regs_base_resource.start = reg_bar_phys_addr;
@@ -374,7 +373,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		dev_err(&pcard->pdev->dev,
 			"probe: DMA_BAR could not remap memory to virtual space\n");
 		err = -ENODEV;
-		goto err_unmap_regs;
+		goto err_release_regs;
 	}
 	dev_dbg(&pcard->pdev->dev,
 		"probe: DMA_BAR virt hardware address start [%p]\n",
@@ -384,11 +383,10 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 
 	err = pci_request_region(pcard->pdev, DMA_BAR, "kp2000_pcie");
 	if (err) {
-		iounmap(pcard->dma_bar_base);
 		dev_err(&pcard->pdev->dev,
 			"probe: failed to acquire PCI region (%d)\n", err);
 		err = -ENODEV;
-		goto err_unmap_regs;
+		goto err_unmap_dma;
 	}
 
 	pcard->dma_base_resource.start = dma_bar_phys_addr;
@@ -400,7 +398,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	pcard->sysinfo_regs_base = pcard->regs_bar_base;
 	err = read_system_regs(pcard);
 	if (err)
-		goto err_unmap_dma;
+		goto err_release_dma;
 
 	// Disable all "user" interrupts because they're not used yet.
 	writeq(0xFFFFFFFFFFFFFFFF,
@@ -438,14 +436,14 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	if (err) {
 		dev_err(&pcard->pdev->dev,
 			"CANNOT use DMA mask %0llx\n", DMA_BIT_MASK(64));
-		goto err_unmap_dma;
+		goto err_release_dma;
 	}
 	dev_dbg(&pcard->pdev->dev,
 		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
 
 	err = pci_enable_msi(pcard->pdev);
 	if (err < 0)
-		goto err_unmap_dma;
+		goto err_release_dma;
 
 	rv = request_irq(pcard->pdev->irq, kp2000_irq_handler, IRQF_SHARED,
 			 pcard->name, pcard);
@@ -478,14 +476,14 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	free_irq(pcard->pdev->irq, pcard);
 err_disable_msi:
 	pci_disable_msi(pcard->pdev);
+err_release_dma:
+	pci_release_region(pdev, DMA_BAR);
 err_unmap_dma:
 	iounmap(pcard->dma_bar_base);
-	pci_release_region(pdev, DMA_BAR);
-	pcard->dma_bar_base = NULL;
+err_release_regs:
+	pci_release_region(pdev, REG_BAR);
 err_unmap_regs:
 	iounmap(pcard->regs_bar_base);
-	pci_release_region(pdev, REG_BAR);
-	pcard->regs_bar_base = NULL;
 err_disable_device:
 	pci_disable_device(pcard->pdev);
 err_remove_ida:
-- 
2.20.1

