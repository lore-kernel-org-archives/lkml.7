Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892CFC010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E021E6F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbfKEMf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:28 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41928 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388612AbfKEMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:00 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C97020050C;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D3D22004F1;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DAA19205ED;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 08/12] staging: dpaa2-ethsw: handle Rx path on control interface
Date:   Tue,  5 Nov 2019 14:34:31 +0200
Message-Id: <1572957275-23383-9-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dpaa2-ethsw supports only one Rx queue that is shared by all switch
ports. This means that information about which port was the ingress port
for a specific frame needs to be passed in metadata. In our case, the
Flow Context (FLC) field from the frame descriptor holds this
information. Besides the interface ID of the ingress port we also
receive the virtual QDID of the port. Below is a visual description of
the 64 bits of FLC.

63           47           31           15           0
+---------------------------------------------------+
|            |            |            |            |
|  RESERVED  |    IF_ID   |  RESERVED  |  IF QDID   |
|            |            |            |            |
+---------------------------------------------------+

Because all switch ports share the same Rx and Tx conf queues, NAPI
management takes into consideration when there is at least one switch
interface open to enable the NAPI instance.

The Rx path is common, for the most part, for both Rx and Tx conf with
the mention that each of them has its own consume function of a frame
descriptor. Dequeueing from a FQ, consuming dequeued store and also the
NAPI poll function is common between both queues.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 311 +++++++++++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h |   4 +
 2 files changed, 312 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 53d651209feb..75e4b3b8c84c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -478,9 +478,51 @@ static int port_carrier_state_sync(struct net_device *netdev)
 	return 0;
 }
 
+/* Manage all NAPI instances for the control interface.
+ *
+ * We only have one RX queue and one Tx Conf queue for all
+ * switch ports. Therefore, we only need to enable the NAPI instance once, the
+ * first time one of the switch ports runs .dev_open().
+ */
+
+static void ethsw_enable_ctrl_if_napi(struct ethsw_core *ethsw)
+{
+	int i;
+
+	/* a new interface is using the NAPI instance */
+	ethsw->napi_users++;
+
+	/* if there is already a user of the instance, return */
+	if (ethsw->napi_users > 1)
+		return;
+
+	if (!ethsw_has_ctrl_if(ethsw))
+		return;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++)
+		napi_enable(&ethsw->fq[i].napi);
+}
+
+static void ethsw_disable_ctrl_if_napi(struct ethsw_core *ethsw)
+{
+	int i;
+
+	/* If we are not the last interface using the NAPI, return */
+	ethsw->napi_users--;
+	if (ethsw->napi_users)
+		return;
+
+	if (!ethsw_has_ctrl_if(ethsw))
+		return;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++)
+		napi_disable(&ethsw->fq[i].napi);
+}
+
 static int port_open(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	int err;
 
 	/* No need to allow Tx as control interface is disabled */
@@ -502,6 +544,8 @@ static int port_open(struct net_device *netdev)
 		goto err_carrier_sync;
 	}
 
+	ethsw_enable_ctrl_if_napi(ethsw);
+
 	return 0;
 
 err_carrier_sync:
@@ -514,6 +558,7 @@ static int port_open(struct net_device *netdev)
 static int port_stop(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	int err;
 
 	err = dpsw_if_disable(port_priv->ethsw_data->mc_io, 0,
@@ -524,6 +569,8 @@ static int port_stop(struct net_device *netdev)
 		return err;
 	}
 
+	ethsw_disable_ctrl_if_napi(ethsw);
+
 	return 0;
 }
 
@@ -690,6 +737,28 @@ static int port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	return err;
 }
 
+static void ethsw_free_fd(const struct ethsw_core *ethsw,
+			  const struct dpaa2_fd *fd)
+{
+	struct device *dev = ethsw->dev;
+	unsigned char *buffer_start;
+	struct sk_buff **skbh, *skb;
+	dma_addr_t fd_addr;
+
+	fd_addr = dpaa2_fd_get_addr(fd);
+	skbh = dpaa2_iova_to_virt(ethsw->iommu_domain, fd_addr);
+
+	skb = *skbh;
+	buffer_start = (unsigned char *)skbh;
+
+	dma_unmap_single(dev, fd_addr,
+			 skb_tail_pointer(skb) - buffer_start,
+			 DMA_TO_DEVICE);
+
+	/* Move on with skb release */
+	dev_kfree_skb(skb);
+}
+
 static const struct net_device_ops ethsw_port_ops = {
 	.ndo_open		= port_open,
 	.ndo_stop		= port_stop,
@@ -1368,6 +1437,104 @@ static int ethsw_register_notifier(struct device *dev)
 	return err;
 }
 
+/* Build a linear skb based on a single-buffer frame descriptor */
+static struct sk_buff *ethsw_build_linear_skb(struct ethsw_core *ethsw,
+					      const struct dpaa2_fd *fd)
+{
+	u16 fd_offset = dpaa2_fd_get_offset(fd);
+	u32 fd_length = dpaa2_fd_get_len(fd);
+	struct device *dev = ethsw->dev;
+	struct sk_buff *skb = NULL;
+	dma_addr_t addr;
+	void *fd_vaddr;
+
+	addr = dpaa2_fd_get_addr(fd);
+	dma_unmap_single(dev, addr, DPAA2_ETHSW_RX_BUF_SIZE,
+			 DMA_FROM_DEVICE);
+	fd_vaddr = dpaa2_iova_to_virt(ethsw->iommu_domain, addr);
+	prefetch(fd_vaddr + fd_offset);
+
+	skb = build_skb(fd_vaddr, DPAA2_ETHSW_RX_BUF_SIZE +
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (unlikely(!skb)) {
+		dev_err(dev, "build_skb() failed\n");
+		return NULL;
+	}
+
+	skb_reserve(skb, fd_offset);
+	skb_put(skb, fd_length);
+
+	ethsw->buf_count--;
+
+	return skb;
+}
+
+static void ethsw_tx_conf(struct ethsw_fq *fq,
+			  const struct dpaa2_fd *fd)
+{
+	ethsw_free_fd(fq->ethsw, fd);
+}
+
+static void ethsw_rx(struct ethsw_fq *fq,
+		     const struct dpaa2_fd *fd)
+{
+	struct ethsw_core *ethsw = fq->ethsw;
+	struct ethsw_port_priv *port_priv;
+	struct net_device *netdev;
+	struct vlan_ethhdr *hdr;
+	struct sk_buff *skb;
+	u16 vlan_tci, vid;
+	int if_id = -1;
+	int err;
+
+	/* prefetch the frame descriptor */
+	prefetch(fd);
+
+	/* get switch ingress interface ID */
+	if_id = upper_32_bits(dpaa2_fd_get_flc(fd)) & 0x0000FFFF;
+
+	if (if_id < 0 || if_id >= ethsw->sw_attr.num_ifs) {
+		dev_err(ethsw->dev, "Frame received from unknown interface!\n");
+		goto err_free_fd;
+	}
+	port_priv = ethsw->ports[if_id];
+	netdev = port_priv->netdev;
+
+	/* build the SKB based on the FD received */
+	if (dpaa2_fd_get_format(fd) == dpaa2_fd_single) {
+		skb = ethsw_build_linear_skb(ethsw, fd);
+	} else {
+		netdev_err(netdev, "Received invalid frame format\n");
+		goto err_free_fd;
+	}
+
+	if (unlikely(!skb))
+		goto err_free_fd;
+
+	skb_reset_mac_header(skb);
+
+	/* Remove PVID from received frame */
+	hdr = vlan_eth_hdr(skb);
+	vid = ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK;
+	if (vid == port_priv->pvid) {
+		err = __skb_vlan_pop(skb, &vlan_tci);
+		if (err) {
+			dev_info(ethsw->dev, "skb_vlan_pop() failed %d", err);
+			goto err_free_fd;
+		}
+	}
+
+	skb->dev = netdev;
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	netif_receive_skb(skb);
+
+	return;
+
+err_free_fd:
+	ethsw_free_fd(ethsw, fd);
+}
+
 static int ethsw_setup_fqs(struct ethsw_core *ethsw)
 {
 	struct dpsw_ctrl_if_attr ctrl_if_attr;
@@ -1384,11 +1551,13 @@ static int ethsw_setup_fqs(struct ethsw_core *ethsw)
 
 	ethsw->fq[i].fqid = ctrl_if_attr.rx_fqid;
 	ethsw->fq[i].ethsw = ethsw;
-	ethsw->fq[i++].type = DPSW_QUEUE_RX;
+	ethsw->fq[i].type = DPSW_QUEUE_RX;
+	ethsw->fq[i++].consume = ethsw_rx;
 
 	ethsw->fq[i].fqid = ctrl_if_attr.tx_err_conf_fqid;
 	ethsw->fq[i].ethsw = ethsw;
-	ethsw->fq[i++].type = DPSW_QUEUE_TX_ERR_CONF;
+	ethsw->fq[i].type = DPSW_QUEUE_TX_ERR_CONF;
+	ethsw->fq[i++].consume = ethsw_tx_conf;
 
 	return 0;
 }
@@ -1476,6 +1645,31 @@ static int ethsw_add_bufs(struct ethsw_core *ethsw, u16 bpid)
 	return 0;
 }
 
+static int ethsw_refill_bp(struct ethsw_core *ethsw)
+{
+	int *count = &ethsw->buf_count;
+	int new_count;
+	int err = 0;
+
+	if (unlikely(*count < DPAA2_ETHSW_REFILL_THRESH)) {
+		do {
+			new_count = ethsw_add_bufs(ethsw, ethsw->bpid);
+			if (unlikely(!new_count)) {
+				/* Out of memory; abort for now, we'll
+				 * try later on
+				 */
+				break;
+			}
+			*count += new_count;
+		} while (*count < DPAA2_ETHSW_NUM_BUFS);
+
+		if (unlikely(*count < DPAA2_ETHSW_NUM_BUFS))
+			err = -ENOMEM;
+	}
+
+	return err;
+}
+
 static int ethsw_seed_bp(struct ethsw_core *ethsw)
 {
 	int *count, i;
@@ -1613,6 +1807,106 @@ static void ethsw_destroy_rings(struct ethsw_core *ethsw)
 		dpaa2_io_store_destroy(ethsw->fq[i].store);
 }
 
+static int ethsw_pull_fq(struct ethsw_fq *fq)
+{
+	int err, retries = 0;
+
+	/* Try to pull from the FQ while the portal is busy and we didn't hit
+	 * the maximum number fo retries
+	 */
+	do {
+		err = dpaa2_io_service_pull_fq(NULL,
+					       fq->fqid,
+					       fq->store);
+		cpu_relax();
+	} while (err == -EBUSY && retries++ < DPAA2_ETHSW_SWP_BUSY_RETRIES);
+
+	if (unlikely(err))
+		dev_err(fq->ethsw->dev, "dpaa2_io_service_pull err %d", err);
+
+	return err;
+}
+
+/* Consume all frames pull-dequeued into the store */
+static int ethsw_store_consume(struct ethsw_fq *fq)
+{
+	struct ethsw_core *ethsw = fq->ethsw;
+	int cleaned = 0, is_last;
+	struct dpaa2_dq *dq;
+	int retries = 0;
+
+	do {
+		/* Get the next available FD from the store */
+		dq = dpaa2_io_store_next(fq->store, &is_last);
+		if (unlikely(!dq)) {
+			if (retries++ >= DPAA2_ETHSW_SWP_BUSY_RETRIES) {
+				dev_err_once(ethsw->dev,
+					     "No valid dequeue response\n");
+				return -ETIMEDOUT;
+			}
+			continue;
+		}
+
+		/* Process the FD */
+		fq->consume(fq, dpaa2_dq_fd(dq));
+		cleaned++;
+
+	} while (!is_last);
+
+	return cleaned;
+}
+
+/* NAPI poll routine */
+static int ethsw_poll(struct napi_struct *napi, int budget)
+{
+	int err, cleaned = 0, store_cleaned, work_done;
+	struct ethsw_fq *fq;
+	int retries = 0;
+
+	fq = container_of(napi, struct ethsw_fq, napi);
+
+	do {
+		err = ethsw_pull_fq(fq);
+		if (unlikely(err))
+			break;
+
+		/* Refill pool if appropriate */
+		ethsw_refill_bp(fq->ethsw);
+
+		store_cleaned = ethsw_store_consume(fq);
+		cleaned += store_cleaned;
+
+		if (cleaned >= budget) {
+			work_done = budget;
+			goto out;
+		}
+
+	} while (store_cleaned);
+
+	/* We didn't consume entire budget, so finish napi and
+	 * re-enable data availability notifications
+	 */
+	napi_complete_done(napi, cleaned);
+	do {
+		err = dpaa2_io_service_rearm(NULL, &fq->nctx);
+		cpu_relax();
+	} while (err == -EBUSY && retries++ < DPAA2_ETHSW_SWP_BUSY_RETRIES);
+
+	work_done = max(cleaned, 1);
+out:
+
+	return work_done;
+}
+
+static void ethsw_fqdan_cb(struct dpaa2_io_notification_ctx *nctx)
+{
+	struct ethsw_fq *fq;
+
+	fq = container_of(nctx, struct ethsw_fq, nctx);
+
+	napi_schedule_irqoff(&fq->napi);
+}
+
 static int ethsw_setup_dpio(struct ethsw_core *ethsw)
 {
 	struct dpsw_ctrl_if_queue_cfg queue_cfg;
@@ -1629,6 +1923,7 @@ static int ethsw_setup_dpio(struct ethsw_core *ethsw)
 		nctx->is_cdan = 0;
 		nctx->id = ethsw->fq[i].fqid;
 		nctx->desired_cpu = DPAA2_IO_ANY_CPU;
+		nctx->cb = ethsw_fqdan_cb;
 		err = dpaa2_io_service_register(NULL, nctx, ethsw->dev);
 		if (err) {
 			err = -EPROBE_DEFER;
@@ -1850,7 +2145,6 @@ static int ethsw_acl_mac_to_ctr_if(struct ethsw_port_priv *port_priv,
 	memset(&acl_entry_cfg, 0, sizeof(acl_entry_cfg));
 	acl_entry_cfg.precedence = port_priv->acl_cnt;
 	acl_entry_cfg.result.action = DPSW_ACL_ACTION_REDIRECT_TO_CTRL_IF;
-
 	acl_entry_cfg.key_iova = dma_map_single(dev, cmd_buff,
 						DPAA2_ETHSW_PORT_ACL_KEY_SIZE,
 						DMA_TO_DEVICE);
@@ -2147,6 +2441,17 @@ static int ethsw_probe(struct fsl_mc_device *sw_dev)
 			goto err_free_ports;
 	}
 
+	/* Add a NAPI instance for each of the Rx queues. The first port's
+	 * net_device will be associated with the instances since we do not have
+	 * different queues for each switch ports.
+	 */
+	if (ethsw_has_ctrl_if(ethsw)) {
+		for (i = 0; i < ETHSW_RX_NUM_FQS; i++)
+			netif_napi_add(ethsw->ports[0]->netdev,
+				       &ethsw->fq[i].napi, ethsw_poll,
+				       NAPI_POLL_WEIGHT);
+	}
+
 	err = dpsw_enable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 	if (err) {
 		dev_err(ethsw->dev, "dpsw_enable err %d\n", err);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index a118cb87b1c8..b585d06be105 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -57,6 +57,7 @@
 /* Buffer management */
 #define BUFS_PER_CMD			7
 #define DPAA2_ETHSW_NUM_BUFS		(1024 * BUFS_PER_CMD)
+#define DPAA2_ETHSW_REFILL_THRESH	(DPAA2_ETHSW_NUM_BUFS * 5 / 6)
 
 /* ACL related configuration points */
 #define DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES	16
@@ -76,10 +77,12 @@
 struct ethsw_core;
 
 struct ethsw_fq {
+	void (*consume)(struct ethsw_fq *fq, const struct dpaa2_fd *fd);
 	struct ethsw_core *ethsw;
 	enum dpsw_queue_type type;
 	struct dpaa2_io_notification_ctx nctx;
 	struct dpaa2_io_store *store;
+	struct napi_struct napi;
 	u32 fqid;
 };
 
@@ -116,6 +119,7 @@ struct ethsw_core {
 	struct fsl_mc_device		*dpbp_dev;
 	int				buf_count;
 	u16				bpid;
+	int				napi_users;
 };
 
 static inline bool ethsw_has_ctrl_if(struct ethsw_core *ethsw)
-- 
1.9.1

