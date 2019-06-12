Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95030C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617AC2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="VEZqKjqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439514AbfFLN6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:58:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46690 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437126AbfFLN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:58:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so9504616lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VrHMiNNbPTpWcXJEeQwNkvaq+Iwwq0qawqb4RHXlZg=;
        b=VEZqKjqwL6+iGHJMAO9xlj3d1SX01w/7pyFL9dXh8yuSKwAUYA37V51u/JS7ckbvMn
         eD/8yWhCsa2aQga2YnMxNvYlPMtH5otRHbBCy1h5zzF0Kmr8ONEx5w6sESk/AhoPdbiB
         dyWTPncbg48IX7710iugaLLcuBMPDaK0X7utC1sNJc2S/7V+FSpjBpEsF+K+gL0s70yv
         BzturJ1jvXB35VGtNQMFuKq1X9F+EhgpldO8dF5ZCgVwKPBArP0kHMuXUAmm0yzZgNgH
         8Kkku8YrFVIGbxkvaQfDm4uQ3HvssFNHU2B5TFTsEtE8q3bLulTUxZ8COEN51yBqc2HF
         bGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VrHMiNNbPTpWcXJEeQwNkvaq+Iwwq0qawqb4RHXlZg=;
        b=T28qCOVi5fRMizTE9EkM6zeGKc/YbF41Un/jluA9bUl2VKnSIJJIhNP42qu1JDTEuU
         of7xxIqQgwHFlxnhqQOj3uJmJ+l29nOvYDbdMjkkX6wQe16uP4d7B6N6Z3Gcx4lmr5e7
         OQ0mAx/0+DmnGe/0N4Whs+JybWh9t9wKVaJDx4tSQFz9SoHT5T7YEwv8lFs2nNj3Y4k0
         sAfhKVUWJnYKCH43TNCrQLBl6eiw6tRFgiCNgZwT/IlYsPRWq614DPWApdEQ4HabPMwZ
         psJtW6rsRrjKt3O7ew6Q/RdfUgsyBw+tLOhndi7NfvBo41IfpjkctSBg4Dk7ZE3CSybo
         3xKg==
X-Gm-Message-State: APjAAAVch8bMMz7Ot+8+aT90hpyesm4c9HB+yW1QN66EGBUh2oGWDcAy
        yEanHExLg1g6PewGRe2UpXfMJg==
X-Google-Smtp-Source: APXvYqzLqFzvEPkn8L8PgSefW0hP124LbXZGSbsWsOcTf6PCECAZ/sgmSq8nsRIpXj1UjsblJoYDcg==
X-Received: by 2002:a05:6512:4c5:: with SMTP id w5mr2277429lfq.171.1560347928315;
        Wed, 12 Jun 2019 06:58:48 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x194sm2621999lfa.64.2019.06.12.06.58.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:58:47 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] staging: kpc2000: remove unnecessary comments in kp2000_pcie_probe
Date:   Wed, 12 Jun 2019 15:58:36 +0200
Message-Id: <20190612135836.23009-3-simon@nikanor.nu>
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
index ee6b9be7127d..6a5999e8ff4e 100644
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
+	/* Setup the Register BAR */
 	reg_bar_phys_addr = pci_resource_start(pcard->pdev, REG_BAR);
 	reg_bar_phys_len = pci_resource_len(pcard->pdev, REG_BAR);
 
@@ -381,9 +370,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 					  reg_bar_phys_len - 1;
 	pcard->regs_base_resource.flags = IORESOURCE_MEM;
 
-	/*
-	 * Step 5: Setup the DMA BAR
-	 */
+	/* Setup the DMA BAR */
 	dma_bar_phys_addr = pci_resource_start(pcard->pdev, DMA_BAR);
 	dma_bar_phys_len = pci_resource_len(pcard->pdev, DMA_BAR);
 
@@ -415,9 +402,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 					 dma_bar_phys_len - 1;
 	pcard->dma_base_resource.flags = IORESOURCE_MEM;
 
-	/*
-	 * Step 6: System Regs
-	 */
+	/* Read System Regs */
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
+	/* Enable IRQs in HW */
 	writel(KPC_DMA_CARD_IRQ_ENABLE | KPC_DMA_CARD_USER_INTERRUPT_MODE,
 	       pcard->dma_common_regs);
 
-- 
2.20.1

