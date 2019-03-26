Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADCDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493F12070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582074;
	bh=k9YLOZZJdChMAYf5tvNnBJDxxUvJz09/vbH+8OEpmCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q7yAuX0FSTL8F8+UjvfHbyR7bFNMTXXBQwThwwJ1WqDpI8Dgm937weZ+WVA1ZTUIq
	 6EAtAOibHTcXBDVEnYAqiHeC6S3u5rc2t183AkE5RM0usljYdP+X4UFE495N3QNHgT
	 z9EBo9Pc4Me0Vkeu05N7S3ZYPbLUAfKG1I5MEo/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfCZGed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfCZGeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:31 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A84F2070B;
        Tue, 26 Mar 2019 06:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582070;
        bh=k9YLOZZJdChMAYf5tvNnBJDxxUvJz09/vbH+8OEpmCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zINAdVvukawfv/ageZFXKpMkrjPqbjGGkSl8gwgjbKD2LubXODtdSKlIAtiSvO5e6
         qBEr8ustbRC0gpHoxacYQG9lyxEto729042bSeDTU+hGyaxYmjvgQ1txliFSOOgGi6
         Jbv3NMRur3G2oClR/ilXHhnojBnsQah0qnMCkN+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 36/41] PCI: endpoint: Use EPCs device in dma_alloc_coherent()/dma_free_coherent()
Date:   Tue, 26 Mar 2019 15:30:13 +0900
Message-Id: <20190326042651.858512780@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>

commit b330104fa76df3eae6e199a23791fed5d35f06b4 upstream.

After commit 723288836628 ("of: restrict DMA configuration"),
of_dma_configure() doesn't configure the coherent_dma_mask/dma_mask
of endpoint function device (since it doesn't have a DT node associated
with and hence no dma-ranges property), resulting in
dma_alloc_coherent() (used in pci_epf_alloc_space()) to fail.

Fix it by making dma_alloc_coherent() use EPC's device for allocating
memory address.

Link: http://lkml.kernel.org/r/64d63468-d28f-8fcd-a6f3-cf2a6401c8cb@ti.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[lorenzo.pieralisi@arm.com: tweaked commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/endpoint/pci-epc-core.c |   10 ----------
 drivers/pci/endpoint/pci-epf-core.c |    4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -18,7 +18,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -371,7 +370,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
 int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
-	struct device *dev = epc->dev.parent;
 
 	if (epf->epc)
 		return -EBUSY;
@@ -383,12 +381,6 @@ int pci_epc_add_epf(struct pci_epc *epc,
 		return -EINVAL;
 
 	epf->epc = epc;
-	if (dev->of_node) {
-		of_dma_configure(&epf->dev, dev->of_node);
-	} else {
-		dma_set_coherent_mask(&epf->dev, epc->dev.coherent_dma_mask);
-		epf->dev.dma_mask = epc->dev.dma_mask;
-	}
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_add_tail(&epf->list, &epc->pci_epf);
@@ -503,9 +495,7 @@ __pci_epc_create(struct device *dev, con
 	INIT_LIST_HEAD(&epc->pci_epf);
 
 	device_initialize(&epc->dev);
-	dma_set_coherent_mask(&epc->dev, dev->coherent_dma_mask);
 	epc->dev.class = pci_epc_class;
-	epc->dev.dma_mask = dev->dma_mask;
 	epc->dev.parent = dev;
 	epc->ops = ops;
 
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -99,7 +99,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
  */
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar)
 {
-	struct device *dev = &epf->dev;
+	struct device *dev = epf->epc->dev.parent;
 
 	if (!addr)
 		return;
@@ -122,7 +122,7 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
 {
 	void *space;
-	struct device *dev = &epf->dev;
+	struct device *dev = epf->epc->dev.parent;
 	dma_addr_t phys_addr;
 
 	if (size < 128)


