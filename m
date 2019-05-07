Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB289C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B90205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208703;
	bh=+agNTwg/jhZpl+avmXspwR4Lh16PJZ5+3wdGOLlFBWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=agDCv3iIjqcztTWx+Gaollh6JKGKzcgXD+PrEP5Vfy64E6rboQCqkAZbRDpp/WP2F
	 8w/8LpujGd8g5vtF2UDAz/g1Tg6ZlgxbQBnuMMpc2kWJsjfWdCv1fJYm9m4eT1dIms
	 2KgBszPxSfs5o9rOfi4FsPkuh5mYyVka/pzB2PQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfEGF6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbfEGFhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:37:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3071120675;
        Tue,  7 May 2019 05:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207432;
        bh=+agNTwg/jhZpl+avmXspwR4Lh16PJZ5+3wdGOLlFBWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZy0O64BUqy6PTXM3J9JOGlF4rNbyFckqR62lMgY0AsudP+COVdEFoJ3O04WQo/gN
         1EcsW/e8P6bMTmKfTd5Edjje4/VNUtWx/+Nz4r7JBWy1sBX+xhTPXzHtAJKQSHTZ0I
         bqTJQrRh8SCJ5jUdZZtF0vBRSofeMQWBz+JmdSJ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Whitehead <tedheadster@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/81] scsi: aic7xxx: fix EISA support
Date:   Tue,  7 May 2019 01:35:11 -0400
Message-Id: <20190507053554.30848-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053554.30848-1-sashal@kernel.org>
References: <20190507053554.30848-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 144ec97493af34efdb77c5aba146e9c7de8d0a06 ]

Instead of relying on the now removed NULL argument to
pci_alloc_consistent, switch to the generic DMA API, and store the struct
device so that we can pass it.

Fixes: 4167b2ad5182 ("PCI: Remove NULL device handling from PCI DMA API")
Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aic7xxx/aic7770_osm.c     |  1 +
 drivers/scsi/aic7xxx/aic7xxx.h         |  1 +
 drivers/scsi/aic7xxx/aic7xxx_osm.c     | 10 ++++------
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |  1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
index 3d401d02c019..bdd177e3d762 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -91,6 +91,7 @@ aic7770_probe(struct device *dev)
 	ahc = ahc_alloc(&aic7xxx_driver_template, name);
 	if (ahc == NULL)
 		return (ENOMEM);
+	ahc->dev = dev;
 	error = aic7770_config(ahc, aic7770_ident_table + edev->id.driver_data,
 			       eisaBase);
 	if (error != 0) {
diff --git a/drivers/scsi/aic7xxx/aic7xxx.h b/drivers/scsi/aic7xxx/aic7xxx.h
index 4ce4e903a759..7f6e83296dfa 100644
--- a/drivers/scsi/aic7xxx/aic7xxx.h
+++ b/drivers/scsi/aic7xxx/aic7xxx.h
@@ -949,6 +949,7 @@ struct ahc_softc {
 	 * Platform specific device information.
 	 */
 	ahc_dev_softc_t		  dev_softc;
+	struct device		  *dev;
 
 	/*
 	 * Bus specific device information.
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index c6be3aeb302b..306d0bf33478 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -861,8 +861,8 @@ int
 ahc_dmamem_alloc(struct ahc_softc *ahc, bus_dma_tag_t dmat, void** vaddr,
 		 int flags, bus_dmamap_t *mapp)
 {
-	*vaddr = pci_alloc_consistent(ahc->dev_softc,
-				      dmat->maxsize, mapp);
+	/* XXX: check if we really need the GFP_ATOMIC and unwind this mess! */
+	*vaddr = dma_alloc_coherent(ahc->dev, dmat->maxsize, mapp, GFP_ATOMIC);
 	if (*vaddr == NULL)
 		return ENOMEM;
 	return 0;
@@ -872,8 +872,7 @@ void
 ahc_dmamem_free(struct ahc_softc *ahc, bus_dma_tag_t dmat,
 		void* vaddr, bus_dmamap_t map)
 {
-	pci_free_consistent(ahc->dev_softc, dmat->maxsize,
-			    vaddr, map);
+	dma_free_coherent(ahc->dev, dmat->maxsize, vaddr, map);
 }
 
 int
@@ -1124,8 +1123,7 @@ ahc_linux_register_host(struct ahc_softc *ahc, struct scsi_host_template *templa
 
 	host->transportt = ahc_linux_transport_template;
 
-	retval = scsi_add_host(host,
-			(ahc->dev_softc ? &ahc->dev_softc->dev : NULL));
+	retval = scsi_add_host(host, ahc->dev);
 	if (retval) {
 		printk(KERN_WARNING "aic7xxx: scsi_add_host failed\n");
 		scsi_host_put(host);
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index 0fc14dac7070..717d8d1082ce 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -250,6 +250,7 @@ ahc_linux_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 	ahc->dev_softc = pci;
+	ahc->dev = &pci->dev;
 	error = ahc_pci_config(ahc, entry);
 	if (error != 0) {
 		ahc_free(ahc);
-- 
2.20.1

