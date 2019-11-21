Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86160C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFD4206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfKUCcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:32:33 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:8218 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfKUCcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:32:33 -0500
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id xAL2SwVD032826;
        Thu, 21 Nov 2019 10:28:58 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id xAL2SroJ088303;
        Thu, 21 Nov 2019 10:28:53 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from ubuntu.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 21 Nov
 2019 10:28:56 +0800
From:   Jiasen Lin <linjiasen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>, <logang@deltatee.com>,
        <linjiasen@hygon.cn>
Subject: [PATCH v3] NTB: ntb_perf: Fix address err in perf_copy_chunk
Date:   Wed, 20 Nov 2019 18:28:44 -0800
Message-ID: <1574303324-4763-1-git-send-email-linjiasen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn xAL2SwVD032826
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peer->outbuf is a virtual address which is get by ioremap, it can not
be converted to a physical address by virt_to_page and page_to_phys.
This conversion will result in DMA error, because the destination address
which is converted by page_to_phys is invalid.

This patch save the MMIO address of NTB BARx in perf_setup_peer_mw,
and map the BAR space to DMA address after we assign the DMA channel.
Then fill the destination address of DMA descriptor with this DMA address
to guarantee that the address of memory write requests fall into
memory window of NBT BARx with IOMMU enabled and disabled.

Changes on v3:
  * Remove the redundant check for bnd_dma_addr.
  * Reduce an input argument for perf_copy_chunk, calculate the
    destination address by the offset and dma base address.
  * Add Reviewed-by: Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Changes on v2:
  * Map NTB BARx MMIO address to DMA address after assign the DMA channel,
    to ensure the destination address in valid. (per suggestion from Logan)

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 57 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..972f6d9 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -149,7 +149,8 @@ struct perf_peer {
 	u64 outbuf_xlat;
 	resource_size_t outbuf_size;
 	void __iomem *outbuf;
-
+	phys_addr_t out_phys_addr;
+	dma_addr_t dma_dst_addr;
 	/* Inbound MW params */
 	dma_addr_t inbuf_xlat;
 	resource_size_t inbuf_size;
@@ -782,6 +783,10 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	struct dmaengine_unmap_data *unmap;
 	struct device *dma_dev;
 	int try = 0, ret = 0;
+	struct perf_peer *peer = pthr->perf->test_peer;
+	void __iomem *vbase;
+	void __iomem *dst_vaddr;
+	dma_addr_t dst_dma_addr;
 
 	if (!use_dma) {
 		memcpy_toio(dst, src, len);
@@ -794,6 +799,10 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 				 offset_in_page(dst), len))
 		return -EIO;
 
+	vbase = peer->outbuf;
+	dst_vaddr = dst;
+	dst_dma_addr = peer->dma_dst_addr + (dst_vaddr - vbase);
+
 	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
 	if (!unmap)
 		return -ENOMEM;
@@ -807,8 +816,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
-		offset_in_page(dst), len, DMA_FROM_DEVICE);
+	unmap->addr[1] = dst_dma_addr;
 	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
 		ret = -EIO;
 		goto err_free_resource;
@@ -865,6 +873,7 @@ static int perf_init_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
 	dma_cap_mask_t dma_mask;
+	struct perf_peer *peer = pthr->perf->test_peer;
 
 	pthr->src = kmalloc_node(perf->test_peer->outbuf_size, GFP_KERNEL,
 				 dev_to_node(&perf->ntb->dev));
@@ -882,15 +891,33 @@ static int perf_init_test(struct perf_thread *pthr)
 	if (!pthr->dma_chan) {
 		dev_err(&perf->ntb->dev, "%d: Failed to get DMA channel\n",
 			pthr->tidx);
-		atomic_dec(&perf->tsync);
-		wake_up(&perf->twait);
-		kfree(pthr->src);
-		return -ENODEV;
+		goto err_free;
 	}
+	peer->dma_dst_addr =
+		dma_map_resource(pthr->dma_chan->device->dev,
+				 peer->out_phys_addr, peer->outbuf_size,
+				 DMA_FROM_DEVICE, 0);
+	if (dma_mapping_error(pthr->dma_chan->device->dev,
+			      peer->dma_dst_addr)) {
+		dev_err(pthr->dma_chan->device->dev, "%d: Failed to map DMA addr\n",
+			pthr->tidx);
+		peer->dma_dst_addr = 0;
+		dma_release_channel(pthr->dma_chan);
+		goto err_free;
+	}
+	dev_dbg(pthr->dma_chan->device->dev, "%d: Map MMIO %pa to DMA addr %pad\n",
+			pthr->tidx,
+			&peer->out_phys_addr,
+			&peer->dma_dst_addr);
 
 	atomic_set(&pthr->dma_sync, 0);
-
 	return 0;
+
+err_free:
+	atomic_dec(&perf->tsync);
+	wake_up(&perf->twait);
+	kfree(pthr->src);
+	return -ENODEV;
 }
 
 static int perf_run_test(struct perf_thread *pthr)
@@ -978,8 +1005,13 @@ static void perf_clear_test(struct perf_thread *pthr)
 	 * We call it anyway just to be sure of the transfers completion.
 	 */
 	(void)dmaengine_terminate_sync(pthr->dma_chan);
-
-	dma_release_channel(pthr->dma_chan);
+	if (pthr->perf->test_peer->dma_dst_addr)
+		dma_unmap_resource(pthr->dma_chan->device->dev,
+				   pthr->perf->test_peer->dma_dst_addr,
+				   pthr->perf->test_peer->outbuf_size,
+				   DMA_FROM_DEVICE, 0);
+	if (pthr->dma_chan)
+		dma_release_channel(pthr->dma_chan);
 
 no_dma_notify:
 	atomic_dec(&perf->tsync);
@@ -1195,6 +1227,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
+			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+
+		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
@@ -1388,6 +1423,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (!peer->outbuf)
 		return -ENOMEM;
 
+	peer->out_phys_addr = phys_addr;
+
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
 		dev_warn(&peer->perf->ntb->dev,
-- 
2.7.4

