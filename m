Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD4C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A920859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Znj2Qxth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbfFJUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:05:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45529 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbfFJUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:05:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so7530990lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6UkWvo4qq2S7jvlAE/FczQO1KKUKp1r92y98A8Zr/M=;
        b=Znj2QxthCaqhx2VzkvaSBldO9070FFKsP8Lrjh49lv0fApSK0SSmG2G4Wl6u9Bj8iF
         8BacG46hWoaMEn45oK8f8Tt41+NDAG/g5zItX2RpfNdcBRIQRBoqqRTIPnS5wUCp6rFl
         vs1SYcZE1DBaVD57jRLJRUT/8xuojXC0pqdBcolpmQsVDQC5xzxIGPHNq83ZyXachO3S
         uX60Q4hBTUswiyxwSMx6PaZ67kVLoLGGN4Ahb7Rp7peDw7ODk2GBYDaxZkqJb52pRA1+
         K8AtYwbwfgZ3Y+90D3DGbfy+h3K6w64/llOoP0UFRFlKW8sqPpYqXxnsTfbeVgL0DQnp
         nvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6UkWvo4qq2S7jvlAE/FczQO1KKUKp1r92y98A8Zr/M=;
        b=J1pzbtn/hMtlpAlfmYgi4OnHhQoHaUFM36p4i+PMi9g7h6yhsWr19SHklKHO2j0YSX
         fWrbHPHoop4XrqNI7ZcvRUFySlucGhdZUkP8kjUa2T6/3FMZGjJnzb+md1ABkD4ZP2HM
         RcsjRgEv54lO+fY16P9wmUPChRljiy33r/lSv63ttazOGYgt7ImDSg9Hvr6ctrFvC0yd
         pgYlW6cWuvli0MbNHUlsEFDiouCXks43m3WXEyBL01YeEvxxplRcRp9CiR5HK515ZsVp
         vXi459avcSWXSK8CSVzMUhnXq2TxCLKDhwQcMpgtdME1faaU8AaCvu5F7y0iXMcNNlA/
         nV0w==
X-Gm-Message-State: APjAAAUj86tTNjknetE6SEff/qZsHpW/vSdV1ofOBKa/NJJr7yBvyLIb
        LsITIUqmhFxzscvFj+fR1/nqsA==
X-Google-Smtp-Source: APXvYqzQIxOij8YtCeQyxWmmN4zIsdheTPbvXAXy+kz0iu2Y/0pPD6WsSW/VrTL8VdW9SXfaxbpqoQ==
X-Received: by 2002:ac2:5ec6:: with SMTP id d6mr38496513lfq.131.1560197152962;
        Mon, 10 Jun 2019 13:05:52 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id f4sm2157079ljm.13.2019.06.10.13.05.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 13:05:52 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 2/2] staging: kpc2000: remove unnecessary comments in kp2000_pcie_probe
Date:   Mon, 10 Jun 2019 22:05:35 +0200
Message-Id: <20190610200535.31820-3-simon@nikanor.nu>
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

Much of the code comments in kp2000_pcie_probe just repeats the code and
does not add any additional information. Delete them and make sure that
comments still left in the function all use the same style.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 38 ++++----------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index ee6b9be7127d..7ec54b672c20 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -311,18 +311,12 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	unsigned long dma_bar_phys_len;
 	u16 regval;
 
-	/*
-	 * Step 1: Allocate a struct for the pcard
-	 */
 	pcard = kzalloc(sizeof(*pcard), GFP_KERNEL);
 	if (!pcard)
 		return -ENOMEM;
 	dev_dbg(&pdev->dev, "probe: allocated struct kp2000_device @ %p\n",
 		pcard);
 
-	/*
-	 * Step 2: Initialize trivial pcard elements
-	 */
 	err = ida_simple_get(&card_num_ida, 1, INT_MAX, GFP_KERNEL);
 	if (err < 0) {
 		dev_err(&pdev->dev, "probe: failed to get card number (%d)\n",
@@ -338,9 +332,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	pcard->pdev = pdev;
 	pci_set_drvdata(pdev, pcard);
 
-	/*
-	 * Step 3: Enable PCI device
-	 */
 	err = pci_enable_device(pcard->pdev);
 	if (err) {
 		dev_err(&pcard->pdev->dev,
@@ -349,9 +340,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		goto err_remove_ida;
 	}
 
-	/*
-	 * Step 4: Setup the Register BAR
-	 */
+	// Setup the Register BAR
 	reg_bar_phys_addr = pci_resource_start(pcard->pdev, REG_BAR);
 	reg_bar_phys_len = pci_resource_len(pcard->pdev, REG_BAR);
 
@@ -381,9 +370,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 					  reg_bar_phys_len - 1;
 	pcard->regs_base_resource.flags = IORESOURCE_MEM;
 
-	/*
-	 * Step 5: Setup the DMA BAR
-	 */
+	// Setup the DMA BAR
 	dma_bar_phys_addr = pci_resource_start(pcard->pdev, DMA_BAR);
 	dma_bar_phys_len = pci_resource_len(pcard->pdev, DMA_BAR);
 
@@ -415,9 +402,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 					 dma_bar_phys_len - 1;
 	pcard->dma_base_resource.flags = IORESOURCE_MEM;
 
-	/*
-	 * Step 6: System Regs
-	 */
+	// Read System Regs
 	pcard->sysinfo_regs_base = pcard->regs_bar_base;
 	err = read_system_regs(pcard);
 	if (err)
@@ -427,11 +412,9 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	writeq(0xFFFFFFFFFFFFFFFF,
 	       pcard->sysinfo_regs_base + REG_INTERRUPT_MASK);
 
-	/*
-	 * Step 7: Configure PCI thingies
-	 */
 	// let the card master PCIe
 	pci_set_master(pcard->pdev);
+
 	// enable IO and mem if not already done
 	pci_read_config_word(pcard->pdev, PCI_COMMAND, &regval);
 	regval |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
@@ -466,9 +449,6 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	dev_dbg(&pcard->pdev->dev,
 		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
 
-	/*
-	 * Step 8: Configure IRQs
-	 */
 	err = pci_enable_msi(pcard->pdev);
 	if (err < 0)
 		goto err_unmap_dma;
@@ -481,25 +461,17 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 		goto err_disable_msi;
 	}
 
-	/*
-	 * Step 9: Setup sysfs attributes
-	 */
 	err = sysfs_create_files(&pdev->dev.kobj, kp_attr_list);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add sysfs files: %d\n", err);
 		goto err_free_irq;
 	}
 
-	/*
-	 * Step 10: Probe cores
-	 */
 	err = kp2000_probe_cores(pcard);
 	if (err)
 		goto err_remove_sysfs;
 
-	/*
-	 * Step 11: Enable IRQs in HW
-	 */
+	// Enable IRQs in HW
 	writel(KPC_DMA_CARD_IRQ_ENABLE | KPC_DMA_CARD_USER_INTERRUPT_MODE,
 	       pcard->dma_common_regs);
 
-- 
2.20.1

