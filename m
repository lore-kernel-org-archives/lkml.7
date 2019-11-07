Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E608C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00D72178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfKGDmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:42:38 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:46345 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733028AbfKGDmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:42:37 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id xA73ckpw000963;
        Thu, 7 Nov 2019 11:38:46 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xA73cf1v094565;
        Thu, 7 Nov 2019 11:38:41 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from ubuntu.localdomain (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 7 Nov 2019
 11:38:42 +0800
From:   Jiasen Lin <linjiasen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <jdmason@kudzu.us>
CC:     <allenbh@gmail.com>, <dave.jiang@intel.com>, <linjiasen@hygon.cn>
Subject: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
Date:   Wed, 6 Nov 2019 19:38:33 -0800
Message-ID: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn xA73ckpw000963
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peer->outbuf is a virtual address which is get by ioremap, it can not
be converted to a physical address by virt_to_page and page_to_phys.
This conversion will result in DMA error, because the destination address
which is converted by page_to_phys is invalid.

We Save the physical address in perf_setup_peer_mw, it is MMIO address
of NTB BARx. Then fill the destination address of DMA descriptor with
this physical address to guarantee that the address of memory write
requests fall in memory window of NBT BARx.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/test/ntb_perf.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index e9b7c2d..1c2fd1a 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -149,6 +149,7 @@ struct perf_peer {
 	u64 outbuf_xlat;
 	resource_size_t outbuf_size;
 	void __iomem *outbuf;
+	phys_addr_t out_phys_addr;
 
 	/* Inbound MW params */
 	dma_addr_t inbuf_xlat;
@@ -776,7 +777,8 @@ static void perf_dma_copy_callback(void *data)
 }
 
 static int perf_copy_chunk(struct perf_thread *pthr,
-			   void __iomem *dst, void *src, size_t len)
+			   void __iomem *dst, void *src, size_t len,
+			   phys_addr_t dst_phys_addr)
 {
 	struct dma_async_tx_descriptor *tx;
 	struct dmaengine_unmap_data *unmap;
@@ -807,8 +809,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	}
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
-		offset_in_page(dst), len, DMA_FROM_DEVICE);
+	unmap->addr[1] = dst_phys_addr;
 	if (dma_mapping_error(dma_dev, unmap->addr[1])) {
 		ret = -EIO;
 		goto err_free_resource;
@@ -901,6 +902,8 @@ static int perf_run_test(struct perf_thread *pthr)
 	u64 total_size, chunk_size;
 	void *flt_src;
 	int ret = 0;
+	phys_addr_t flt_phys_addr;
+	phys_addr_t bnd_phys_addr;
 
 	total_size = 1ULL << total_order;
 	chunk_size = 1ULL << chunk_order;
@@ -909,12 +912,15 @@ static int perf_run_test(struct perf_thread *pthr)
 	flt_src = pthr->src;
 	bnd_dst = peer->outbuf + peer->outbuf_size;
 	flt_dst = peer->outbuf;
+	bnd_phys_addr = peer->out_phys_addr + peer->outbuf_size;
+	flt_phys_addr = peer->out_phys_addr;
 
 	pthr->duration = ktime_get();
 
 	/* Copied field is cleared on test launch stage */
 	while (pthr->copied < total_size) {
-		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
+		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size,
+				flt_phys_addr);
 		if (ret) {
 			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
 				pthr->tidx, ret);
@@ -925,8 +931,15 @@ static int perf_run_test(struct perf_thread *pthr)
 
 		flt_dst += chunk_size;
 		flt_src += chunk_size;
-		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
+		flt_phys_addr += chunk_size;
+
+		if (flt_dst >= bnd_dst ||
+		    flt_dst < peer->outbuf ||
+		    flt_phys_addr >= bnd_phys_addr ||
+		    flt_phys_addr < peer->out_phys_addr) {
+
 			flt_dst = peer->outbuf;
+			flt_phys_addr = peer->out_phys_addr;
 			flt_src = pthr->src;
 		}
 
@@ -1195,6 +1208,9 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
+			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+
+		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
@@ -1388,6 +1404,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
 	if (!peer->outbuf)
 		return -ENOMEM;
 
+	peer->out_phys_addr = phys_addr;
+
 	if (max_mw_size && peer->outbuf_size > max_mw_size) {
 		peer->outbuf_size = max_mw_size;
 		dev_warn(&peer->perf->ntb->dev,
-- 
2.7.4

