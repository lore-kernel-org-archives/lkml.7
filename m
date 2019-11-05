Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23703C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC69C2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfKEMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:03 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41916 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388567AbfKEMe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:59 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9B7820050B;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBDD42004F1;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 961F1205ED;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 07/12] staging: dpaa2-ethsw: seed the buffer pool
Date:   Tue,  5 Nov 2019 14:34:30 +0200
Message-Id: <1572957275-23383-8-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seed the buffer pool associated with the control interface at switch
probe and drain it at unbind. We allocate PAGE_SIZE buffers and release
them in the pool for the Rx path to use.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 137 +++++++++++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |  14 ++++
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 72c6f6c6e66f..53d651209feb 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
+#include <linux/iommu.h>
 
 #include <linux/fsl/mc.h>
 
@@ -26,6 +27,16 @@
 
 #define DEFAULT_VLAN_ID			1
 
+static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
+				dma_addr_t iova_addr)
+{
+	phys_addr_t phys_addr;
+
+	phys_addr = domain ? iommu_iova_to_phys(domain, iova_addr) : iova_addr;
+
+	return phys_to_virt(phys_addr);
+}
+
 static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 {
 	int err;
@@ -1382,6 +1393,122 @@ static int ethsw_setup_fqs(struct ethsw_core *ethsw)
 	return 0;
 }
 
+/* Free buffers acquired from the buffer pool or which were meant to
+ * be released in the pool
+ */
+static void ethsw_free_bufs(struct ethsw_core *ethsw, u64 *buf_array, int count)
+{
+	struct device *dev = ethsw->dev;
+	void *vaddr;
+	int i;
+
+	for (i = 0; i < count; i++) {
+		vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, buf_array[i]);
+		dma_unmap_page(dev, buf_array[i], DPAA2_ETHSW_RX_BUF_SIZE,
+			       DMA_BIDIRECTIONAL);
+		free_pages((unsigned long)vaddr, 0);
+	}
+}
+
+/* Perform a single release command to add buffers
+ * to the specified buffer pool
+ */
+static int ethsw_add_bufs(struct ethsw_core *ethsw, u16 bpid)
+{
+	struct device *dev = ethsw->dev;
+	u64 buf_array[BUFS_PER_CMD];
+	struct page *page;
+	int retries = 0;
+	dma_addr_t addr;
+	int err;
+	int i;
+
+	for (i = 0; i < BUFS_PER_CMD; i++) {
+		/* Allocate one page for each Rx buffer. WRIOP sees
+		 * the entire page except for a tailroom reserved for
+		 * skb shared info
+		 */
+		page = dev_alloc_pages(0);
+		if (!page) {
+			dev_err(dev, "buffer allocation failed\n");
+			goto err_alloc;
+		}
+
+		addr = dma_map_page(dev, page, 0, DPAA2_ETHSW_RX_BUF_SIZE,
+				    DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, addr)) {
+			dev_err(dev, "dma_map_single() failed\n");
+			goto err_map;
+		}
+		buf_array[i] = addr;
+	}
+
+release_bufs:
+	/* In case the portal is busy, retry until successful or
+	 * max retries hit.
+	 */
+	while ((err = dpaa2_io_service_release(NULL, bpid,
+					       buf_array, i)) == -EBUSY) {
+		if (retries++ >= DPAA2_ETHSW_SWP_BUSY_RETRIES)
+			break;
+
+		cpu_relax();
+	}
+
+	/* If release command failed, clean up and bail out.
+	 */
+	if (err) {
+		ethsw_free_bufs(ethsw, buf_array, i);
+		return 0;
+	}
+
+	return i;
+
+err_map:
+	__free_pages(page, 0);
+err_alloc:
+	/* If we managed to allocate at least some buffers,
+	 * release them to hardware
+	 */
+	if (i)
+		goto release_bufs;
+
+	return 0;
+}
+
+static int ethsw_seed_bp(struct ethsw_core *ethsw)
+{
+	int *count, i;
+
+	for (i = 0; i < DPAA2_ETHSW_NUM_BUFS; i += BUFS_PER_CMD) {
+		count = &ethsw->buf_count;
+		*count += ethsw_add_bufs(ethsw, ethsw->bpid);
+
+		if (unlikely(*count < BUFS_PER_CMD))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ethsw_drain_bp(struct ethsw_core *ethsw)
+{
+	u64 buf_array[BUFS_PER_CMD];
+	int ret;
+
+	do {
+		ret = dpaa2_io_service_acquire(NULL, ethsw->bpid,
+					       buf_array, BUFS_PER_CMD);
+		if (ret < 0) {
+			dev_err(ethsw->dev,
+				"dpaa2_io_service_acquire() = %d\n", ret);
+			return;
+		}
+		ethsw_free_bufs(ethsw, buf_array, ret);
+
+	} while (ret);
+}
+
 static int ethsw_setup_dpbp(struct ethsw_core *ethsw)
 {
 	struct dpsw_ctrl_if_pools_cfg dpsw_ctrl_if_pools_cfg = { 0 };
@@ -1558,10 +1685,14 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	if (err)
 		return err;
 
-	err = ethsw_alloc_rings(ethsw);
+	err = ethsw_seed_bp(ethsw);
 	if (err)
 		goto err_free_dpbp;
 
+	err = ethsw_alloc_rings(ethsw);
+	if (err)
+		goto err_drain_dpbp;
+
 	err = ethsw_setup_dpio(ethsw);
 	if (err)
 		goto err_destroy_rings;
@@ -1570,6 +1701,8 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 
 err_destroy_rings:
 	ethsw_destroy_rings(ethsw);
+err_drain_dpbp:
+	ethsw_drain_bp(ethsw);
 err_free_dpbp:
 	ethsw_free_dpbp(ethsw);
 
@@ -1858,6 +1991,7 @@ static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
 {
 	ethsw_free_dpio(ethsw);
 	ethsw_destroy_rings(ethsw);
+	ethsw_drain_bp(ethsw);
 	ethsw_free_dpbp(ethsw);
 }
 
@@ -1977,6 +2111,7 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 		return -ENOMEM;
 
 	ethsw->dev = dev;
+	ethsw->iommu_domain = iommu_get_domain_for_dev(dev);
 	dev_set_drvdata(dev, ethsw);
 
 	err = fsl_mc_portal_allocate(sw_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index dfb8ce905250..a118cb87b1c8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -54,11 +54,23 @@
 /* Dequeue store size */
 #define DPAA2_ETHSW_STORE_SIZE		16
 
+/* Buffer management */
+#define BUFS_PER_CMD			7
+#define DPAA2_ETHSW_NUM_BUFS		(1024 * BUFS_PER_CMD)
+
 /* ACL related configuration points */
 #define DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES	16
 #define DPAA2_ETHSW_PORT_ACL_KEY_SIZE \
 	sizeof(struct dpsw_prep_acl_entry)
 
+/* Number of times to retry DPIO portal operations while waiting
+ * for portal to finish executing current command and become
+ * available. We want to avoid being stuck in a while loop in case
+ * hardware becomes unresponsive, but not give up too easily if
+ * the portal really is busy for valid reasons
+ */
+#define DPAA2_ETHSW_SWP_BUSY_RETRIES	1000
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
@@ -95,12 +107,14 @@ struct ethsw_core {
 	struct dpsw_attr		sw_attr;
 	int				dev_id;
 	struct ethsw_port_priv		**ports;
+	struct iommu_domain		*iommu_domain;
 
 	u8				vlans[VLAN_VID_MASK + 1];
 	bool				learning;
 
 	struct ethsw_fq			fq[ETHSW_RX_NUM_FQS];
 	struct fsl_mc_device		*dpbp_dev;
+	int				buf_count;
 	u16				bpid;
 };
 
-- 
1.9.1

