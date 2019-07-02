Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03577C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A974721479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfuzvIme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGBH64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36815 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfGBH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so7284081pgg.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TJxWLr+JPeWt+v1C/4n773RLK3SNUDYrCEkz4pOotic=;
        b=VfuzvImeNQGyrIcMRRE6ksqoplOrw+67N0W5eeOsrJQ5e/3x0ZhF9PTTHb7IyK1QVU
         O4oqXZv3BUkBzqGAdo/2uH6M+Nwad4i7aBIx/htJFvmyJ5jJR8JRDO7RNZJSxQrjL8ap
         HcF5nSCsIJojBDnpavGPtQW5OVbJBvASbsXnxisPVSw1cNP6h6JnjJPPoOpXqQe4Dk9N
         sVdXMqcumyHsGmLM8Fwuoy/JULNDfUoNvncK5By07UTOJ7XOS90JdH0HzAB4xfsPBLWX
         yYePWUjqvdvFqECjbGv+lJVtRTP+NZBG780y3y5KkmO1X0V23ASAxRQb78sjJRRvoDjd
         3jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJxWLr+JPeWt+v1C/4n773RLK3SNUDYrCEkz4pOotic=;
        b=D7HUtshWAgVn3Jr91Hr92jM1Q3aVfTp6Eoku0EedqgSIHPnXtIPKjZMndSdsKF4kGx
         F/WQn655HOMCsYzrmUxvoBsr3Km4qK7vdtoQZNXS/8Flh3BMTXDdH9fEz0rXlSID9pYi
         on7TtdxcSbWqWIo+Wx5kmRil0mtG6n85Dt7nrJYjzc27JYyYcpV7s8CqrNSZ+jfG5CJA
         TwiiobPf9QqM0d3Vg8W5lRyURetEUZGq+yxIHPKEqRntc3j7ahEnBU3jrfWgN9yvUNiq
         Jff67qfNDX36g7Q/xS4BlBENqGFsDHUnZ6JadIDmmY5OdCU07qNm5Up6hy2DK+SRpGks
         KhYQ==
X-Gm-Message-State: APjAAAVonEh0ywhXG5ucqjfqnzRSzr83xOrEM9MbknVowdVjNvY8/pch
        5c8DtZXAOP/8xv82pdWx3BNHuUsVvRM=
X-Google-Smtp-Source: APXvYqxx8pFpTvKV0pJ782QZ+e+J5xwUMrNWnDM8wzkZ6pHNE+5tqBMz/aCEZUYr4rkzv8volEqdQg==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr4092811pjv.86.1562054334886;
        Tue, 02 Jul 2019 00:58:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i7sm1530549pjk.24.2019.07.02.00.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 16/27] net: remove unneeded memset
Date:   Tue,  2 Jul 2019 15:58:49 +0800
Message-Id: <20190702075849.24259-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memset with 0 after zeroing allocator is unneeded.

pci_alloc_persistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So the memset after these functions is unneeded.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/net/ethernet/atheros/atlx/atl1.c                   | 2 --
 drivers/net/ethernet/atheros/atlx/atl2.c                   | 1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  | 2 --
 drivers/net/ethernet/chelsio/cxgb4/sched.c                 | 1 -
 drivers/net/ethernet/freescale/fec_main.c                  | 2 --
 drivers/net/ethernet/jme.c                                 | 5 -----
 drivers/net/ethernet/marvell/skge.c                        | 2 --
 drivers/net/ethernet/mellanox/mlx4/eq.c                    | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 --
 drivers/net/ethernet/mellanox/mlxsw/pci.c                  | 1 -
 drivers/net/ethernet/neterion/s2io.c                       | 1 -
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c        | 3 ---
 drivers/net/ethernet/ti/tlan.c                             | 1 -
 drivers/net/hippi/rrunner.c                                | 2 --
 drivers/net/vmxnet3/vmxnet3_drv.c                          | 1 -
 drivers/net/wireless/ath/ath10k/ce.c                       | 5 -----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 2 --
 drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   | 2 --
 drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   | 2 --
 20 files changed, 40 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 7c767ce9aafa..b5c6dc914720 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1060,8 +1060,6 @@ static s32 atl1_setup_ring_resources(struct atl1_adapter *adapter)
 		goto err_nomem;
 	}
 
-	memset(ring_header->desc, 0, ring_header->size);
-
 	/* init TPD ring */
 	tpd_ring->dma = ring_header->dma;
 	offset = (tpd_ring->dma & 0x7) ? (8 - (ring_header->dma & 0x7)) : 0;
diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 3a3fb5ce0fee..3aba38322717 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -291,7 +291,6 @@ static s32 atl2_setup_ring_resources(struct atl2_adapter *adapter)
 		&adapter->ring_dma);
 	if (!adapter->ring_vir_addr)
 		return -ENOMEM;
-	memset(adapter->ring_vir_addr, 0, adapter->ring_size);
 
 	/* Init TXD Ring */
 	adapter->txd_dma = adapter->ring_dma ;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f758b2e0591f..1a51edb7de37 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2622,8 +2622,6 @@ static int bnxt_alloc_tx_rings(struct bnxt *bp)
 			mapping = txr->tx_push_mapping +
 				sizeof(struct tx_push_bd);
 			txr->data_mapping = cpu_to_le64(mapping);
-
-			memset(txr->tx_push, 0, sizeof(struct tx_push_bd));
 		}
 		qidx = bp->tc_to_qidx[j];
 		ring->queue_id = bp->q_info[qidx].queue_id;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sched.c b/drivers/net/ethernet/chelsio/cxgb4/sched.c
index ba6c153ee45c..60218dc676a8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sched.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sched.c
@@ -207,7 +207,6 @@ static int t4_sched_queue_bind(struct port_info *pi, struct ch_sched_queue *p)
 		goto out_err;
 
 	/* Bind queue to specified class */
-	memset(qe, 0, sizeof(*qe));
 	qe->cntxt_id = qid;
 	memcpy(&qe->param, p, sizeof(qe->param));
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 38f10f7dcbc3..ec87b8b78d21 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3143,8 +3143,6 @@ static int fec_enet_init(struct net_device *ndev)
 		return -ENOMEM;
 	}
 
-	memset(cbd_base, 0, bd_size);
-
 	/* Get the Ethernet address */
 	fec_get_mac(ndev);
 	/* make sure MAC we just acquired is programmed into the hw */
diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index 76b7b7b85e35..0b668357db4d 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -582,11 +582,6 @@ jme_setup_tx_resources(struct jme_adapter *jme)
 	if (unlikely(!(txring->bufinf)))
 		goto err_free_txring;
 
-	/*
-	 * Initialize Transmit Descriptors
-	 */
-	memset(txring->alloc, 0, TX_RING_ALLOC_SIZE(jme->tx_ring_size));
-
 	return 0;
 
 err_free_txring:
diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 35a92fd2cf39..9ac854c2b371 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -2558,8 +2558,6 @@ static int skge_up(struct net_device *dev)
 		goto free_pci_mem;
 	}
 
-	memset(skge->mem, 0, skge->mem_size);
-
 	err = skge_ring_alloc(&skge->rx_ring, skge->mem, skge->dma);
 	if (err)
 		goto free_pci_mem;
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index a5be27772b8e..c790a5fcea73 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -1013,8 +1013,6 @@ static int mlx4_create_eq(struct mlx4_dev *dev, int nent,
 
 		dma_list[i] = t;
 		eq->page_list[i].map = t;
-
-		memset(eq->page_list[i].buf, 0, PAGE_SIZE);
 	}
 
 	eq->eqn = mlx4_bitmap_alloc(&priv->eq_table.bitmap);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 6a921e24cd5e..587c51fa3985 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2391,7 +2391,6 @@ int mlx5_eswitch_get_vport_stats(struct mlx5_eswitch *esw,
 	MLX5_SET(query_vport_counter_in, in, vport_number, vport->vport);
 	MLX5_SET(query_vport_counter_in, in, other_vport, 1);
 
-	memset(out, 0, outlen);
 	err = mlx5_cmd_exec(esw->dev, in, sizeof(in), out, outlen);
 	if (err)
 		goto free_out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 47b446d30f71..ef5fe3bd95f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -993,7 +993,6 @@ static int esw_create_offloads_fdb_tables(struct mlx5_eswitch *esw, int nvports)
 	}
 
 	/* create send-to-vport group */
-	memset(flow_group_in, 0, inlen);
 	MLX5_SET(create_flow_group_in, flow_group_in, match_criteria_enable,
 		 MLX5_MATCH_MISC_PARAMETERS);
 
@@ -1151,7 +1150,6 @@ static int esw_create_vport_rx_group(struct mlx5_eswitch *esw, int nvports)
 		return -ENOMEM;
 
 	/* create vport rx group */
-	memset(flow_group_in, 0, inlen);
 	MLX5_SET(create_flow_group_in, flow_group_in, match_criteria_enable,
 		 MLX5_MATCH_MISC_PARAMETERS);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index b40455f8293d..be310ac0883a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -835,7 +835,6 @@ static int mlxsw_pci_queue_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 					     &mem_item->mapaddr);
 	if (!mem_item->buf)
 		return -ENOMEM;
-	memset(mem_item->buf, 0, mem_item->size);
 
 	q->elem_info = kcalloc(q->count, sizeof(*q->elem_info), GFP_KERNEL);
 	if (!q->elem_info) {
diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 3b2ae1a21678..e0b2bf327905 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -747,7 +747,6 @@ static int init_shared_mem(struct s2io_nic *nic)
 				return -ENOMEM;
 			}
 			mem_allocated += size;
-			memset(tmp_v_addr, 0, size);
 
 			size = sizeof(struct rxd_info) *
 				rxd_count[nic->rxd_mode];
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index 433052f734ed..5e9f8ee99800 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -442,10 +442,8 @@ nx_fw_cmd_create_tx_ctx(struct netxen_adapter *adapter)
 		goto out_free_rq;
 	}
 
-	memset(rq_addr, 0, rq_size);
 	prq = rq_addr;
 
-	memset(rsp_addr, 0, rsp_size);
 	prsp = rsp_addr;
 
 	prq->host_rsp_dma_addr = cpu_to_le64(rsp_phys_addr);
@@ -755,7 +753,6 @@ int netxen_alloc_hw_resources(struct netxen_adapter *adapter)
 		return -ENOMEM;
 	}
 
-	memset(addr, 0, sizeof(struct netxen_ring_ctx));
 	recv_ctx->hwctx = addr;
 	recv_ctx->hwctx->ctx_id = cpu_to_le32(port);
 	recv_ctx->hwctx->cmd_consumer_offset =
diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index b4ab1a5f6cd0..78f0f2d59e22 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -855,7 +855,6 @@ static int tlan_init(struct net_device *dev)
 		       dev->name);
 		return -ENOMEM;
 	}
-	memset(priv->dma_storage, 0, dma_size);
 	priv->rx_list = (struct tlan_list *)
 		ALIGN((unsigned long)priv->dma_storage, 8);
 	priv->rx_list_dma = ALIGN(priv->dma_storage_dma, 8);
diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index 7b9350dbebdd..2a6ec5394966 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1196,7 +1196,6 @@ static int rr_open(struct net_device *dev)
 		goto error;
 	}
 	rrpriv->rx_ctrl_dma = dma_addr;
-	memset(rrpriv->rx_ctrl, 0, 256*sizeof(struct ring_ctrl));
 
 	rrpriv->info = pci_alloc_consistent(pdev, sizeof(struct rr_info),
 					    &dma_addr);
@@ -1205,7 +1204,6 @@ static int rr_open(struct net_device *dev)
 		goto error;
 	}
 	rrpriv->info_dma = dma_addr;
-	memset(rrpriv->info, 0, sizeof(struct rr_info));
 	wmb();
 
 	spin_lock_irqsave(&rrpriv->lock, flags);
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 89984fcab01e..a5ba7ed07e9c 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3429,7 +3429,6 @@ vmxnet3_probe_device(struct pci_dev *pdev,
 			err = -ENOMEM;
 			goto err_ver;
 		}
-		memset(adapter->coal_conf, 0, sizeof(*adapter->coal_conf));
 		adapter->coal_conf->coalMode = VMXNET3_COALESCE_DISABLED;
 		adapter->default_coal_mode = true;
 	}
diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index eca87f7c5b6c..294fbc1e89ab 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1704,9 +1704,6 @@ ath10k_ce_alloc_dest_ring_64(struct ath10k *ar, unsigned int ce_id,
 	/* Correctly initialize memory to 0 to prevent garbage
 	 * data crashing system when download firmware
 	 */
-	memset(dest_ring->base_addr_owner_space_unaligned, 0,
-	       nentries * sizeof(struct ce_desc_64) + CE_DESC_RING_ALIGN);
-
 	dest_ring->base_addr_owner_space =
 			PTR_ALIGN(dest_ring->base_addr_owner_space_unaligned,
 				  CE_DESC_RING_ALIGN);
@@ -2019,8 +2016,6 @@ void ath10k_ce_alloc_rri(struct ath10k *ar)
 		value |= ar->hw_ce_regs->upd->mask;
 		ath10k_ce_write32(ar, ce_base_addr + ctrl1_regs, value);
 	}
-
-	memset(ce->vaddr_rri, 0, CE_COUNT * sizeof(u32));
 }
 EXPORT_SYMBOL(ath10k_ce_alloc_rri);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 83e4938527f4..3fc08fe7c3a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1033,8 +1033,6 @@ brcmf_pcie_init_dmabuffer_for_device(struct brcmf_pciedev_info *devinfo,
 			       address & 0xffffffff);
 	brcmf_pcie_write_tcm32(devinfo, tcm_dma_phys_addr + 4, address >> 32);
 
-	memset(ring, 0, size);
-
 	return (ring);
 }
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 3aa3714d4dfd..5ec1c9bc1612 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -244,8 +244,6 @@ static int pearl_alloc_bd_table(struct qtnf_pcie_pearl_state *ps)
 
 	/* tx bd */
 
-	memset(vaddr, 0, len);
-
 	ps->bd_table_vaddr = vaddr;
 	ps->bd_table_paddr = paddr;
 	ps->bd_table_len = len;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index 9a4380ed7f1b..1f91088e3dff 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -199,8 +199,6 @@ static int topaz_alloc_bd_table(struct qtnf_pcie_topaz_state *ts,
 	if (!vaddr)
 		return -ENOMEM;
 
-	memset(vaddr, 0, len);
-
 	/* tx bd */
 
 	ts->tx_bd_vbase = vaddr;
-- 
2.11.0

