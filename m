Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8688C32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB083217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfI0KPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:15:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:57056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfI0KPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1937DAFFE;
        Fri, 27 Sep 2019 10:15:05 +0000 (UTC)
From:   Benjamin Poirier <bpoirier@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/17] staging: qlge: Remove bq_desc.maplen
Date:   Fri, 27 Sep 2019 19:11:59 +0900
Message-Id: <20190927101210.23856-6-bpoirier@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190927101210.23856-1-bpoirier@suse.com>
References: <20190927101210.23856-1-bpoirier@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the mapping is known statically in all cases, there's no need
to save it at runtime. Remove this member.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Manish Chopra <manishc@marvell.com>
---
 drivers/staging/qlge/qlge.h      |  1 -
 drivers/staging/qlge/qlge_main.c | 43 +++++++++++---------------------
 2 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index ba61b4559dd6..f32da8c7679f 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -1373,7 +1373,6 @@ struct bq_desc {
 	__le64 *addr;
 	u32 index;
 	DEFINE_DMA_UNMAP_ADDR(mapaddr);
-	DEFINE_DMA_UNMAP_LEN(maplen);
 };
 
 #define QL_TXQ_IDX(qdev, skb) (smp_processor_id()%(qdev->tx_ring_count))
diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
index 2b1cc4b29bed..34bc1d9560ce 100644
--- a/drivers/staging/qlge/qlge_main.c
+++ b/drivers/staging/qlge/qlge_main.c
@@ -1108,8 +1108,6 @@ static void ql_update_lbq(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 			map = lbq_desc->p.pg_chunk.map +
 				lbq_desc->p.pg_chunk.offset;
 			dma_unmap_addr_set(lbq_desc, mapaddr, map);
-			dma_unmap_len_set(lbq_desc, maplen,
-					  qdev->lbq_buf_size);
 			*lbq_desc->addr = cpu_to_le64(map);
 
 			pci_dma_sync_single_for_device(qdev->pdev, map,
@@ -1177,8 +1175,6 @@ static void ql_update_sbq(struct ql_adapter *qdev, struct rx_ring *rx_ring)
 					return;
 				}
 				dma_unmap_addr_set(sbq_desc, mapaddr, map);
-				dma_unmap_len_set(sbq_desc, maplen,
-						  rx_ring->sbq_buf_size);
 				*sbq_desc->addr = cpu_to_le64(map);
 			}
 
@@ -1598,14 +1594,14 @@ static void ql_process_mac_rx_skb(struct ql_adapter *qdev,
 
 	pci_dma_sync_single_for_cpu(qdev->pdev,
 				    dma_unmap_addr(sbq_desc, mapaddr),
-				    dma_unmap_len(sbq_desc, maplen),
+				    rx_ring->sbq_buf_size,
 				    PCI_DMA_FROMDEVICE);
 
 	skb_put_data(new_skb, skb->data, length);
 
 	pci_dma_sync_single_for_device(qdev->pdev,
 				       dma_unmap_addr(sbq_desc, mapaddr),
-				       dma_unmap_len(sbq_desc, maplen),
+				       rx_ring->sbq_buf_size,
 				       PCI_DMA_FROMDEVICE);
 	skb = new_skb;
 
@@ -1727,8 +1723,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 		sbq_desc = ql_get_curr_sbuf(rx_ring);
 		pci_unmap_single(qdev->pdev,
 				dma_unmap_addr(sbq_desc, mapaddr),
-				dma_unmap_len(sbq_desc, maplen),
-				PCI_DMA_FROMDEVICE);
+				rx_ring->sbq_buf_size, PCI_DMA_FROMDEVICE);
 		skb = sbq_desc->p.skb;
 		ql_realign_skb(skb, hdr_len);
 		skb_put(skb, hdr_len);
@@ -1758,19 +1753,15 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			 */
 			sbq_desc = ql_get_curr_sbuf(rx_ring);
 			pci_dma_sync_single_for_cpu(qdev->pdev,
-						    dma_unmap_addr
-						    (sbq_desc, mapaddr),
-						    dma_unmap_len
-						    (sbq_desc, maplen),
+						    dma_unmap_addr(sbq_desc,
+								   mapaddr),
+						    rx_ring->sbq_buf_size,
 						    PCI_DMA_FROMDEVICE);
 			skb_put_data(skb, sbq_desc->p.skb->data, length);
 			pci_dma_sync_single_for_device(qdev->pdev,
-						       dma_unmap_addr
-						       (sbq_desc,
-							mapaddr),
-						       dma_unmap_len
-						       (sbq_desc,
-							maplen),
+						       dma_unmap_addr(sbq_desc,
+								      mapaddr),
+						       rx_ring->sbq_buf_size,
 						       PCI_DMA_FROMDEVICE);
 		} else {
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
@@ -1781,10 +1772,8 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 			ql_realign_skb(skb, length);
 			skb_put(skb, length);
 			pci_unmap_single(qdev->pdev,
-					 dma_unmap_addr(sbq_desc,
-							mapaddr),
-					 dma_unmap_len(sbq_desc,
-						       maplen),
+					 dma_unmap_addr(sbq_desc, mapaddr),
+					 rx_ring->sbq_buf_size,
 					 PCI_DMA_FROMDEVICE);
 			sbq_desc->p.skb = NULL;
 		}
@@ -1822,9 +1811,8 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 				return NULL;
 			}
 			pci_unmap_page(qdev->pdev,
-				       dma_unmap_addr(lbq_desc,
-						      mapaddr),
-				       dma_unmap_len(lbq_desc, maplen),
+				       dma_unmap_addr(lbq_desc, mapaddr),
+				       qdev->lbq_buf_size,
 				       PCI_DMA_FROMDEVICE);
 			skb_reserve(skb, NET_IP_ALIGN);
 			netif_printk(qdev, rx_status, KERN_DEBUG, qdev->ndev,
@@ -1858,8 +1846,7 @@ static struct sk_buff *ql_build_rx_skb(struct ql_adapter *qdev,
 		sbq_desc = ql_get_curr_sbuf(rx_ring);
 		pci_unmap_single(qdev->pdev,
 				 dma_unmap_addr(sbq_desc, mapaddr),
-				 dma_unmap_len(sbq_desc, maplen),
-				 PCI_DMA_FROMDEVICE);
+				 rx_ring->sbq_buf_size, PCI_DMA_FROMDEVICE);
 		if (!(ib_mac_rsp->flags4 & IB_MAC_IOCB_RSP_HS)) {
 			/*
 			 * This is an non TCP/UDP IP frame, so
@@ -2820,7 +2807,7 @@ static void ql_free_sbq_buffers(struct ql_adapter *qdev, struct rx_ring *rx_ring
 		if (sbq_desc->p.skb) {
 			pci_unmap_single(qdev->pdev,
 					 dma_unmap_addr(sbq_desc, mapaddr),
-					 dma_unmap_len(sbq_desc, maplen),
+					 rx_ring->sbq_buf_size,
 					 PCI_DMA_FROMDEVICE);
 			dev_kfree_skb(sbq_desc->p.skb);
 			sbq_desc->p.skb = NULL;
-- 
2.23.0

