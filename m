Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD7CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B18208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGtMdNR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfEMK1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:27:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42038 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMK1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:27:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so6965096pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dmV4ggQ7W7lM8+6XPZ1q23MzEW8/8dON1mFDhZTSIyM=;
        b=uGtMdNR/mizCSyQd71n0e9TO4F9GKTlQH8YDQCd6DsNtC/++Nv/JAwNvryFrU3sRa7
         oUd/Cs5J7kqrpQ3+iE69Xs2e2ynxUL1/R/jlgxp0RgsnQr9YP/3i+5U1n7PCU9jQKiID
         xgFsPe8vMwjNuE4LbpjNGDS2Y69hwNv503UH1kipV0fQiVB9JV1ptdb1zwhXFNoDFQbr
         o6AC0QmP6EsbnwtPy87lDTfLmdwU7NvhaTr8+okVNLqrc7md5GD68yw2ddPsVtqZgGNX
         iIH+KlG7h5/BYP/+THhJyYDkWzWwLWCiY030zhKIsuy6R6Y8H/uDJpBIPlprtu3F2Hk7
         H6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dmV4ggQ7W7lM8+6XPZ1q23MzEW8/8dON1mFDhZTSIyM=;
        b=YLGwG63fx3vqZias/S1MYGjteOIPnFSYv6VwnAgHExUNncaD842wJrUi4RUI4u0C6D
         GhT2SkbAqrNIogosCbSyvkOM20r/mq+gxzH+JQN3oZWz/pgZwudik9g70IFwiRDWRTFq
         6THBSn21IBB2jAILz7HuBQ+/n18lG3B5pBRGrrGkuhAhmxISsefJQbEObJ+zzGziTD/f
         L8EZjXP2yi6aw6TTMan79KqOfOptl8r53srx/wcngGjDKrLDl2kYxz+q3neGkf9kpYq4
         Jo5uouOHzbXXZtoeAjZ0ygbiVOGSpNZbXEDbr64GV3xJHzI1D/0qrsfkjM/WWxDiIjPG
         oYtg==
X-Gm-Message-State: APjAAAWaqID+Nk8k0pCC8/ZknQL6l7Doc3nQAvLmjlMhIPKngSUgGVcC
        Mw1qDRbi3jY2cd/c6cm2lKc=
X-Google-Smtp-Source: APXvYqxoCLKUo6fxTzqylO38lt5Zq38Quy07a9RuAXOMBWumu4BxUXmZKiTwsM/srDRKNJyLwx2dbg==
X-Received: by 2002:a63:144e:: with SMTP id 14mr12962867pgu.304.1557743227095;
        Mon, 13 May 2019 03:27:07 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id r124sm11773487pgr.91.2019.05.13.03.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:27:06 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v3 3/8] Staging: kpc2000: kpc_dma: Resolve checkpatch space errors around brace '{','!' and open paranthesis '('.
Date:   Mon, 13 May 2019 15:56:17 +0530
Message-Id: <20190513102622.22398-3-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102622.22398-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves below errors reported by checkpath
ERROR: space required before the open brace '{'
ERROR: space prohibited after that '!' (ctx:BxW)
ERROR: space prohibited after that open parenthesis '('
---
v2 - split changes to multiple patches
v3 - edit commit message
---

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/dma.c         | 28 +++++-----
 drivers/staging/kpc2000/kpc_dma/fileops.c     | 56 +++++++++----------
 .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  | 20 +++----
 3 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index 488b9b81debc..2053316009bc 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -41,7 +41,7 @@ void  ndd_irq_worker(struct work_struct *ws)
 		dev_dbg(&eng->pldev->dev, "Handling completed descriptor %p (acd = %p)\n", cur, cur->acd);
 		BUG_ON(cur == eng->desc_next); // Ordering failure.
 
-		if (cur->DescControlFlags & DMA_DESC_CTL_SOP){
+		if (cur->DescControlFlags & DMA_DESC_CTL_SOP) {
 			eng->accumulated_bytes = 0;
 			eng->accumulated_flags = 0;
 		}
@@ -53,7 +53,7 @@ void  ndd_irq_worker(struct work_struct *ws)
 		if (cur->DescStatusFlags & DMA_DESC_STS_SHORT)
 			eng->accumulated_flags |= ACD_FLAG_ENG_ACCUM_SHORT;
 
-		if (cur->DescControlFlags & DMA_DESC_CTL_EOP){
+		if (cur->DescControlFlags & DMA_DESC_CTL_EOP) {
 			if (cur->acd)
 				transfer_complete_cb(cur->acd, eng->accumulated_bytes, eng->accumulated_flags | ACD_FLAG_DONE);
 		}
@@ -98,7 +98,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	if (WARN(!(caps & ENG_CAP_PRESENT), "setup_dma_engine() called for DMA Engine at %p which isn't present in hardware!\n", eng))
 		return -ENXIO;
 
-	if (caps & ENG_CAP_DIRECTION){
+	if (caps & ENG_CAP_DIRECTION) {
 		eng->dir = DMA_FROM_DEVICE;
 	} else {
 		eng->dir = DMA_TO_DEVICE;
@@ -108,7 +108,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	eng->desc_pool = dma_pool_create("KPC DMA Descriptors", &eng->pldev->dev, sizeof(struct kpc_dma_descriptor), DMA_DESC_ALIGNMENT, 4096);
 
 	eng->desc_pool_first = dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &head_handle);
-	if (!eng->desc_pool_first){
+	if (!eng->desc_pool_first) {
 		dev_err(&eng->pldev->dev, "setup_dma_engine: couldn't allocate desc_pool_first!\n");
 		dma_pool_destroy(eng->desc_pool);
 		return -ENOMEM;
@@ -118,7 +118,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	clear_desc(eng->desc_pool_first);
 
 	cur = eng->desc_pool_first;
-	for (i = 1 ; i < eng->desc_pool_cnt ; i++){
+	for (i = 1 ; i < eng->desc_pool_cnt ; i++) {
 		next = dma_pool_alloc(eng->desc_pool, GFP_KERNEL | GFP_DMA, &next_handle);
 		if (next == NULL)
 			goto done_alloc;
@@ -144,7 +144,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 
 	// Grab IRQ line
 	rv = request_irq(eng->irq, ndd_irq_handler, IRQF_SHARED, KP_DRIVER_NAME_DMA_CONTROLLER, eng);
-	if (rv){
+	if (rv) {
 		dev_err(&eng->pldev->dev, "setup_dma_engine: failed to request_irq: %d\n", rv);
 		return rv;
 	}
@@ -166,8 +166,8 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 
 	// Wait for descriptor engine to finish current operaion
 	timeout = jiffies + (HZ / 2);
-	while (GetEngineControl(eng) & ENG_CTL_DMA_RUNNING){
-		if (time_after(jiffies, timeout)){
+	while (GetEngineControl(eng) & ENG_CTL_DMA_RUNNING) {
+		if (time_after(jiffies, timeout)) {
 			dev_crit(&eng->pldev->dev, "DMA_RUNNING still asserted!\n");
 			break;
 		}
@@ -178,8 +178,8 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 
 	// Wait for reset request to be processed
 	timeout = jiffies + (HZ / 2);
-	while (GetEngineControl(eng) & (ENG_CTL_DMA_RUNNING | ENG_CTL_DMA_RESET_REQUEST)){
-		if (time_after(jiffies, timeout)){
+	while (GetEngineControl(eng) & (ENG_CTL_DMA_RUNNING | ENG_CTL_DMA_RESET_REQUEST)) {
+		if (time_after(jiffies, timeout)) {
 			dev_crit(&eng->pldev->dev, "ENG_CTL_DMA_RESET_REQUEST still asserted!\n");
 			break;
 		}
@@ -190,8 +190,8 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 
 	// And wait for reset to complete
 	timeout = jiffies + (HZ / 2);
-	while (GetEngineControl(eng) & ENG_CTL_DMA_RESET){
-		if (time_after(jiffies, timeout)){
+	while (GetEngineControl(eng) & ENG_CTL_DMA_RESET) {
+		if (time_after(jiffies, timeout)) {
 			dev_crit(&eng->pldev->dev, "DMA_RESET still asserted!\n");
 			break;
 		}
@@ -217,7 +217,7 @@ void  destroy_dma_engine(struct kpc_dma_device *eng)
 	cur = eng->desc_pool_first;
 	cur_handle = eng->desc_pool_first->MyDMAAddr;
 
-	for (i = 0 ; i < eng->desc_pool_cnt ; i++){
+	for (i = 0 ; i < eng->desc_pool_cnt ; i++) {
 		struct kpc_dma_descriptor *next = cur->Next;
 		dma_addr_t next_handle = cur->DescNextDescPtr;
 		dma_pool_free(eng->desc_pool, cur, cur_handle);
@@ -237,7 +237,7 @@ int  count_descriptors_available(struct kpc_dma_device *eng)
 {
 	u32 count = 0;
 	struct kpc_dma_descriptor *cur = eng->desc_next;
-	while (cur != eng->desc_completed){
+	while (cur != eng->desc_completed) {
 		BUG_ON(cur == NULL);
 		count++;
 		cur = cur->Next;
diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 61927b313a26..8dd948ef455f 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -58,7 +58,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_transfer(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %ld) ldev = [%p]\n", priv, kcb, (void *)iov_base, iov_len, ldev);
 
 	acd = (struct aio_cb_data *) kzalloc(sizeof(struct aio_cb_data), GFP_KERNEL);
-	if (!acd){
+	if (!acd) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
 		return -ENOMEM;
 	}
@@ -74,7 +74,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 
 	// Allocate an array of page pointers
 	acd->user_pages = kzalloc(sizeof(struct page *) * acd->page_count, GFP_KERNEL);
-	if (!acd->user_pages){
+	if (!acd->user_pages) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the page pointers\n");
 		rv = -ENOMEM;
 		goto err_alloc_userpages;
@@ -84,27 +84,27 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	down_read(&current->mm->mmap_sem);      /*  get memory map semaphore */
 	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
 	up_read(&current->mm->mmap_sem);        /*  release the semaphore */
-	if (rv != acd->page_count){
+	if (rv != acd->page_count) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
 		goto err_get_user_pages;
 	}
 
 	// Allocate and setup the sg_table (scatterlist entries)
 	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE-1), iov_len, GFP_KERNEL);
-	if (rv){
+	if (rv) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%ld)\n", rv);
 		goto err_alloc_sg_table;
 	}
 
 	// Setup the DMA mapping for all the sg entries
 	acd->mapped_entry_count = dma_map_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
-	if (acd->mapped_entry_count <= 0){
+	if (acd->mapped_entry_count <= 0) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't dma_map_sg (%d)\n", acd->mapped_entry_count);
 		goto err_dma_map_sg;
 	}
 
 	// Calculate how many descriptors are actually needed for this transfer.
-	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i){
+	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i) {
 		desc_needed += count_parts_for_sge(sg);
 	}
 
@@ -113,13 +113,13 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	// Figoure out how many descriptors are available and return an error if there aren't enough
 	num_descrs_avail = count_descriptors_available(ldev);
 	dev_dbg(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
-	if (desc_needed >= ldev->desc_pool_cnt){
+	if (desc_needed >= ldev->desc_pool_cnt) {
 		dev_warn(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d    TOO MANY to ever complete!\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
 		rv = -EAGAIN;
 		unlock_engine(ldev);
 		goto err_descr_too_many;
 	}
-	if (desc_needed > num_descrs_avail){
+	if (desc_needed > num_descrs_avail) {
 		dev_warn(&priv->ldev->pldev->dev, "    mapped_entry_count = %d    num_descrs_needed = %d    num_descrs_avail = %d    Too many to complete right now.\n", acd->mapped_entry_count, desc_needed, num_descrs_avail);
 		rv = -EMSGSIZE;
 		unlock_engine(ldev);
@@ -129,13 +129,13 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	// Loop through all the sg table entries and fill out a descriptor for each one.
 	desc = ldev->desc_next;
 	card_addr = acd->priv->card_addr;
-	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i){
+	for_each_sg(acd->sgt.sgl, sg, acd->mapped_entry_count, i) {
 		pcnt = count_parts_for_sge(sg);
-		for (p = 0 ; p < pcnt ; p++){
+		for (p = 0 ; p < pcnt ; p++) {
 			// Fill out the descriptor
 			BUG_ON(desc == NULL);
 			clear_desc(desc);
-			if (p != pcnt-1){
+			if (p != pcnt-1) {
 				desc->DescByteCount = 0x80000;
 			} else {
 				desc->DescByteCount = sg_dma_len(sg) - (p * 0x80000);
@@ -157,7 +157,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 			desc->DescSystemAddrMS = (dma_addr & 0xFFFFFFFF00000000) >> 32;
 
 			user_ctl = acd->priv->user_ctl;
-			if (i == acd->mapped_entry_count-1 && p == pcnt-1){
+			if (i == acd->mapped_entry_count-1 && p == pcnt-1) {
 				user_ctl = acd->priv->user_ctl_last;
 			}
 			desc->DescUserControlLS = (user_ctl & 0x00000000FFFFFFFF) >>  0;
@@ -179,13 +179,13 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	unlock_engine(ldev);
 
 	// If this is a synchronous kiocb, we need to put the calling process to sleep until the transfer is complete
-	if (kcb == NULL || is_sync_kiocb(kcb)){
+	if (kcb == NULL || is_sync_kiocb(kcb)) {
 		rv = wait_for_completion_interruptible(&done);
 		// If the user aborted (rv == -ERESTARTSYS), we're no longer responsible for cleaning up the acd
-		if (rv == -ERESTARTSYS){
+		if (rv == -ERESTARTSYS) {
 			acd->cpl = NULL;
 		}
-		if (rv == 0){
+		if (rv == 0) {
 			rv = acd->len;
 			kfree(acd);
 		}
@@ -200,7 +200,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++){
+	for (i = 0 ; i < acd->page_count ; i++) {
 		put_page(acd->user_pages[i]);
 	}
  err_get_user_pages:
@@ -223,15 +223,15 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 
 	dev_dbg(&acd->ldev->pldev->dev, "transfer_complete_cb(acd = [%p])\n", acd);
 
-	for (i = 0 ; i < acd->page_count ; i++){
-		if (!PageReserved(acd->user_pages[i])){
+	for (i = 0 ; i < acd->page_count ; i++) {
+		if (!PageReserved(acd->user_pages[i])) {
 			set_page_dirty(acd->user_pages[i]);
 		}
 	}
 
 	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
 
-	for (i = 0 ; i < acd->page_count ; i++){
+	for (i = 0 ; i < acd->page_count ; i++) {
 		put_page(acd->user_pages[i]);
 	}
 
@@ -241,8 +241,8 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 
 	acd->flags = flags;
 
-	if (acd->kcb == NULL || is_sync_kiocb(acd->kcb)){
-		if (acd->cpl){
+	if (acd->kcb == NULL || is_sync_kiocb(acd->kcb)) {
+		if (acd->cpl) {
 			complete(acd->cpl);
 		} else {
 			// There's no completion, so we're responsible for cleaning up the acd
@@ -265,7 +265,7 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 	if (ldev == NULL)
 		return -ENODEV;
 
-	if (! atomic_dec_and_test(&ldev->open_count)){
+	if (!atomic_dec_and_test(&ldev->open_count)) {
 		atomic_inc(&ldev->open_count);
 		return -EBUSY; /* already open */
 	}
@@ -294,9 +294,9 @@ int  kpc_dma_close(struct inode *inode, struct file *filp)
 	stop_dma_engine(eng);
 
 	cur = eng->desc_completed->Next;
-	while (cur != eng->desc_next){
+	while (cur != eng->desc_next) {
 		dev_dbg(&eng->pldev->dev, "Aborting descriptor %p (acd = %p)\n", cur, cur->acd);
-		if (cur->DescControlFlags & DMA_DESC_CTL_EOP){
+		if (cur->DescControlFlags & DMA_DESC_CTL_EOP) {
 			if (cur->acd)
 				transfer_complete_cb(cur->acd, 0, ACD_FLAG_ABORT);
 		}
@@ -334,7 +334,7 @@ ssize_t   kpc_dma_aio_read(struct kiocb *kcb, const struct iovec *iov, unsigned
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
 		return -EMEDIUMTYPE;
 
-	if (iov_count != 1){
+	if (iov_count != 1) {
 		dev_err(&priv->ldev->pldev->dev, "kpc_dma_aio_read() called with iov_count > 1!\n");
 		return -EFAULT;
 	}
@@ -353,7 +353,7 @@ ssize_t  kpc_dma_aio_write(struct kiocb *kcb, const struct iovec *iov, unsigned
 	if (priv->ldev->dir != DMA_TO_DEVICE)
 		return -EMEDIUMTYPE;
 
-	if (iov_count != 1){
+	if (iov_count != 1) {
 		dev_err(&priv->ldev->pldev->dev, "kpc_dma_aio_write() called with iov_count > 1!\n");
 		return -EFAULT;
 	}
@@ -365,7 +365,7 @@ ssize_t  kpc_dma_aio_write(struct kiocb *kcb, const struct iovec *iov, unsigned
 #endif
 
 static
-ssize_t  kpc_dma_read( struct file *filp,       char __user *user_buf, size_t count, loff_t *ppos)
+ssize_t  kpc_dma_read(struct file *filp,       char __user *user_buf, size_t count, loff_t *ppos)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_read(filp = [%p], user_buf = [%p], count = %zu, ppos = [%p]) priv = [%p], ldev = [%p]\n", filp, user_buf, count, ppos, priv, priv->ldev);
@@ -394,7 +394,7 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_ioctl(filp = [%p], ioctl_num = 0x%x, ioctl_param = 0x%lx) priv = [%p], ldev = [%p]\n", filp, ioctl_num, ioctl_param, priv, priv->ldev);
 
-	switch (ioctl_num){
+	switch (ioctl_num) {
 		case KND_IOCTL_SET_CARD_ADDR:           priv->card_addr  = ioctl_param; return priv->card_addr;
 		case KND_IOCTL_SET_USER_CTL:            priv->user_ctl   = ioctl_param; return priv->user_ctl;
 		case KND_IOCTL_SET_USER_CTL_LAST:       priv->user_ctl_last = ioctl_param; return priv->user_ctl_last;
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 004d91b5ad00..0b8dcf046136 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -97,7 +97,7 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	dev_t dev;
 
 	struct kpc_dma_device *ldev = kzalloc(sizeof(struct kpc_dma_device), GFP_KERNEL);
-	if (!ldev){
+	if (!ldev) {
 		dev_err(&pldev->dev, "kpc_dma_probe: unable to kzalloc space for kpc_dma_device\n");
 		rv = -ENOMEM;
 		goto err_rv;
@@ -116,20 +116,20 @@ int  kpc_dma_probe(struct platform_device *pldev)
 
 	// Get Engine regs resource
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
-	if (!r){
+	if (!r) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: didn't get the engine regs resource!\n");
 		rv = -ENXIO;
 		goto err_kfree;
 	}
 	ldev->eng_regs = ioremap_nocache(r->start, resource_size(r));
-	if (!ldev->eng_regs){
+	if (!ldev->eng_regs) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: failed to ioremap engine regs!\n");
 		rv = -ENXIO;
 		goto err_kfree;
 	}
 
 	r = platform_get_resource(pldev, IORESOURCE_IRQ, 0);
-	if (!r){
+	if (!r) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: didn't get the IRQ resource!\n");
 		rv = -ENXIO;
 		goto err_kfree;
@@ -139,21 +139,21 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	// Setup miscdev struct
 	dev = MKDEV(assigned_major_num, pldev->id);
 	ldev->kpc_dma_dev = device_create(kpc_dma_class, &pldev->dev, dev, ldev, "kpc_dma%d", pldev->id);
-	if (IS_ERR(ldev->kpc_dma_dev)){
+	if (IS_ERR(ldev->kpc_dma_dev)) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: device_create failed: %d\n", rv);
 		goto err_kfree;
 	}
 
 	// Setup the DMA engine
 	rv = setup_dma_engine(ldev, 30);
-	if (rv){
+	if (rv) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: failed to setup_dma_engine: %d\n", rv);
 		goto err_misc_dereg;
 	}
 
 	// Setup the sysfs files
 	rv = sysfs_create_files(&(ldev->pldev->dev.kobj), ndd_attr_list);
-	if (rv){
+	if (rv) {
 		dev_err(&ldev->pldev->dev, "kpc_dma_probe: Failed to add sysfs files: %d\n", rv);
 		goto err_destroy_eng;
 	}
@@ -208,7 +208,7 @@ int __init kpc_dma_driver_init(void)
 	int err;
 
 	err = __register_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS, "kpc_dma", &kpc_dma_fops);
-	if (err < 0){
+	if (err < 0) {
 		pr_err("Can't allocate a major number (%d) for kpc_dma (err = %d)\n", KPC_DMA_CHAR_MAJOR, err);
 		goto fail_chrdev_register;
 	}
@@ -216,13 +216,13 @@ int __init kpc_dma_driver_init(void)
 
 	kpc_dma_class = class_create(THIS_MODULE, "kpc_dma");
 	err = PTR_ERR(kpc_dma_class);
-	if (IS_ERR(kpc_dma_class)){
+	if (IS_ERR(kpc_dma_class)) {
 		pr_err("Can't create class kpc_dma (err = %d)\n", err);
 		goto fail_class_create;
 	}
 
 	err = platform_driver_register(&kpc_dma_plat_driver_i);
-	if (err){
+	if (err) {
 		pr_err("Can't register platform driver for kpc_dma (err = %d)\n", err);
 		goto fail_platdriver_register;
 	}
-- 
2.17.1

