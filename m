Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7CC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C7024195
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="DhaQnSuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFCW3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:29:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33053 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFCW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:29:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so14851104lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BH9FichXxL+rVylSY90H19dLcsYWaCyFQpGIdwFhPgI=;
        b=DhaQnSuBhmhxnY8bZTi10h2KLowVNKRl26Y+A+2/AR3/ArSy1srERye6QR3F+1e/ud
         dKsmMkIawwDNrbstXC2MU0GjHFh9mJUj9H5u/yw23AkaDDdW7qXDVb3XFj8UhKqBPVV2
         y3CmwuVbOGxNwDb3MXRIDB3uuwdwNrBeuqJFpXJ5HHAK6xIg62OERS9XFCrRLgDBk+y0
         QkxhV4p+G7FG7OZd1shfbrl4Y81+lZI/rakFijcAM6p0+N/+ajCV12BMduDQIYPcqL+K
         JT4wcf5VwpqZ/5ylzNgemKBkCmNSJJ9EEl2YaMoTUH7AO0XcriLLC7/buTPTn/CJN0JK
         fRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BH9FichXxL+rVylSY90H19dLcsYWaCyFQpGIdwFhPgI=;
        b=tvTyDnUf0ZiPJQu/3WqiC6lY82pPrhC2+8JZ19CJunVM/JXbMcSxQIQPA3UdAqCWw+
         hTbzMVaSOVF9grpZC5IpZDQkt9hC0II9fBYGotyYp9lAx+RmXEKzwje8KV90Px/okDjX
         i3rgJ7o0z3n0IHaPDR+oSvKbQVYe8PkhDfl+C1g1Z6lWBsCyEadVPksFKNLAqHkIIuco
         Adql5EewSuZrLc+zipkEHUNqJwLHwXxEfGF9OyWy5Rdec4zvjIplxgDAWRrxA+zqqpkv
         l4CpUWejDvUwxpIphNq9C0miua5h1L6Xoa9t3Cjp9QFAoPiNuEQrjnZOlzFGHEHAthnn
         e91Q==
X-Gm-Message-State: APjAAAWu4ScPSwHuQm4bRPEFDUX2eAC/RDXNSlRXTH+KHCruK0FszSWw
        zBumXQz8GXNlq7epC2q4MSmMuQ==
X-Google-Smtp-Source: APXvYqxdLz7Zar6/3D06FTw0PHYT9px9YJQH/Yc4u6Vmmn2DRJmsUWiHtXFROsbHEFNsym2PD72b9g==
X-Received: by 2002:a19:9f84:: with SMTP id i126mr14839014lfe.142.1559600960788;
        Mon, 03 Jun 2019 15:29:20 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x20sm2175874ljj.14.2019.06.03.15.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 15:29:20 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: kpc2000: simplify comparisons to NULL in core.c
Date:   Tue,  4 Jun 2019 00:29:10 +0200
Message-Id: <20190603222916.20698-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603222916.20698-1-simon@nikanor.nu>
References: <20190603222916.20698-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warnings "Comparison to NULL could be written [...]"
and "Comparisons should place the constant on the right side of the
test".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
index 7f257c21e0cc..356a272c0b9c 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -319,7 +319,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	 * Step 1: Allocate a struct for the pcard
 	 */
 	pcard = kzalloc(sizeof(struct kp2000_device), GFP_KERNEL);
-	if (NULL == pcard) {
+	if (!pcard) {
 		dev_err(&pdev->dev,
 			"probe: failed to allocate private card data\n");
 		return -ENOMEM;
@@ -363,7 +363,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	reg_bar_phys_len = pci_resource_len(pcard->pdev, REG_BAR);
 
 	pcard->regs_bar_base = ioremap_nocache(reg_bar_phys_addr, PAGE_SIZE);
-	if (NULL == pcard->regs_bar_base) {
+	if (!pcard->regs_bar_base) {
 		dev_err(&pcard->pdev->dev,
 			"probe: REG_BAR could not remap memory to virtual space\n");
 		err = -ENODEV;
@@ -396,7 +396,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 
 	pcard->dma_bar_base = ioremap_nocache(dma_bar_phys_addr,
 					      dma_bar_phys_len);
-	if (NULL == pcard->dma_bar_base) {
+	if (!pcard->dma_bar_base) {
 		dev_err(&pcard->pdev->dev,
 			"probe: DMA_BAR could not remap memory to virtual space\n");
 		err = -ENODEV;
@@ -546,7 +546,7 @@ static void kp2000_pcie_remove(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "kp2000_pcie_remove(pdev=%p)\n", pdev);
 
-	if (pcard == NULL)
+	if (!pcard)
 		return;
 
 	mutex_lock(&pcard->sem);
@@ -555,12 +555,12 @@ static void kp2000_pcie_remove(struct pci_dev *pdev)
 	sysfs_remove_files(&(pdev->dev.kobj), kp_attr_list);
 	free_irq(pcard->pdev->irq, pcard);
 	pci_disable_msi(pcard->pdev);
-	if (pcard->dma_bar_base != NULL) {
+	if (pcard->dma_bar_base) {
 		iounmap(pcard->dma_bar_base);
 		pci_release_region(pdev, DMA_BAR);
 		pcard->dma_bar_base = NULL;
 	}
-	if (pcard->regs_bar_base != NULL) {
+	if (pcard->regs_bar_base) {
 		iounmap(pcard->regs_bar_base);
 		pci_release_region(pdev, REG_BAR);
 		pcard->regs_bar_base = NULL;
-- 
2.20.1

