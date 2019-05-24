Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD08C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2F20856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404139AbfEXOuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:50:02 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:28358 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403888AbfEXOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:50:02 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2019 10:50:02 EDT
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@MIAPEX02MSOL01.citrite.net
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=23.29.105.83; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 23.29.105.83 as permitted
  sender) identity=mailfrom; client-ip=23.29.105.83;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:23.29.105.83 ip4:162.221.156.83 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@MIAPEX02MSOL01.citrite.net) identity=helo;
  client-ip=23.29.105.83; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@MIAPEX02MSOL01.citrite.net";
  x-conformance=sidf_compatible
IronPort-SDR: L92NSaSjxlBdCrBZmCT7+KZG4Ypxl9hxObzcbTlTGj1ik8mZ/QurcPRcudyPz0wT7NEsSH7sP3
 MJXkDS/mgE6r+D8y+MZKfLXq0xyFTms518AlB8qdQXaw6+EL7Pe0M6+KaigzDGzS12uuU9pYHq
 Q+lrpr3VMvhzt24mGoUa15wMAbtzddgMkHVzVVor0dUXNW9kxpO4KKE0DN8R2SvfRDQELlhvBt
 48OfDLveutAj2VxKV7f4KrqfSNilCmX8emHh+m/YsH9zlv2Zw5LxMiRFE01CtKoNNfcn+c+UIS
 WFc=
X-SBRS: 2.7
X-MesageID: 860160
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 23.29.105.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.60,507,1549947600"; 
   d="scan'208";a="860160"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <iommu@lists.linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Sergey Dyasli <sergey.dyasli@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Paul Durrant <paul.durrant@citrix.com>
Subject: [PATCH v1] xen/swiotlb: rework early repeat code
Date:   Fri, 24 May 2019 15:42:50 +0100
Message-ID: <20190524144250.5102-1-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current repeat code is plain broken for the early=true case. Xen exchanges
all DMA (<4GB) pages that it can on the first xen_swiotlb_fixup() attempt.
All further attempts with a halved region will fail immediately because
all DMA pages already belong to Dom0.

Introduce contig_pages param for xen_swiotlb_fixup() to track the number
of pages that were made contiguous in MFN space and use the same bootmem
region while halving the memory requirements.

Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Paul Durrant <paul.durrant@citrix.com>
---
 drivers/xen/swiotlb-xen.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5dcb06fe9667..d2aba804d06c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -142,7 +142,8 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 static int max_dma_bits = 32;
 
 static int
-xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
+xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs,
+		  unsigned long *contig_pages)
 {
 	int i, rc;
 	int dma_bits;
@@ -156,10 +157,13 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 		int slabs = min(nslabs - i, (unsigned long)IO_TLB_SEGSIZE);
 
 		do {
+			unsigned int order = get_order(slabs << IO_TLB_SHIFT);
 			rc = xen_create_contiguous_region(
 				p + (i << IO_TLB_SHIFT),
-				get_order(slabs << IO_TLB_SHIFT),
+				order,
 				dma_bits, &dma_handle);
+			if (rc == 0)
+				*contig_pages += 1 << order;
 		} while (rc && dma_bits++ < max_dma_bits);
 		if (rc)
 			return rc;
@@ -202,7 +206,7 @@ static const char *xen_swiotlb_error(enum xen_swiotlb_err err)
 }
 int __ref xen_swiotlb_init(int verbose, bool early)
 {
-	unsigned long bytes, order;
+	unsigned long bytes, order, contig_pages;
 	int rc = -ENOMEM;
 	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
 	unsigned int repeat = 3;
@@ -244,13 +248,32 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	/*
 	 * And replace that memory with pages under 4GB.
 	 */
+	contig_pages = 0;
 	rc = xen_swiotlb_fixup(xen_io_tlb_start,
 			       bytes,
-			       xen_io_tlb_nslabs);
+			       xen_io_tlb_nslabs,
+			       &contig_pages);
 	if (rc) {
-		if (early)
+		if (early) {
+			unsigned long orig_bytes = bytes;
+			while (repeat-- > 0) {
+				xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
+						      (xen_io_tlb_nslabs >> 1));
+				pr_info("Lowering to %luMB\n",
+				     (xen_io_tlb_nslabs << IO_TLB_SHIFT) >> 20);
+				bytes = xen_set_nslabs(xen_io_tlb_nslabs);
+				order = get_order(xen_io_tlb_nslabs << IO_TLB_SHIFT);
+				xen_io_tlb_end = xen_io_tlb_start + bytes;
+				if (contig_pages >= (1ul << order)) {
+					/* Enough pages were made contiguous */
+					memblock_free(__pa(xen_io_tlb_start + bytes),
+						     PAGE_ALIGN(orig_bytes - bytes));
+					goto fixup_done;
+				}
+			}
 			memblock_free(__pa(xen_io_tlb_start),
 				      PAGE_ALIGN(bytes));
+		}
 		else {
 			free_pages((unsigned long)xen_io_tlb_start, order);
 			xen_io_tlb_start = NULL;
@@ -258,6 +281,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 		m_ret = XEN_SWIOTLB_EFIXUP;
 		goto error;
 	}
+fixup_done:
 	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
 	if (early) {
 		if (swiotlb_init_with_tbl(xen_io_tlb_start, xen_io_tlb_nslabs,
@@ -272,7 +296,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 
 	return rc;
 error:
-	if (repeat--) {
+	if (repeat-- > 0) {
 		xen_io_tlb_nslabs = max(1024UL, /* Min is 2MB */
 					(xen_io_tlb_nslabs >> 1));
 		pr_info("Lowering to %luMB\n",
-- 
2.17.1

