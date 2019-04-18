Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF38C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE42214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611139;
	bh=S04JJA1KQFXYRH7qSYZ8rRyKzbcITZdXAkZXutItqzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1djyXGFRbQQ/ueQoXKvLUl4BqXccIaiIRKiQqqpB3y6sw1etswnLV3dY5gQ7aKZl
	 c7ib2gR/+bUW5J/VAIS/cQwnh5t1ZtiHgMn1zpXNPMiigd0zzd7C/WEGTHohgbAzI8
	 F+zGrpYHcFlgRhMpZqTCmu4tWYW/CW4STkFDfjD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbfDRSMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404034AbfDRSMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B00720675;
        Thu, 18 Apr 2019 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611133;
        bh=S04JJA1KQFXYRH7qSYZ8rRyKzbcITZdXAkZXutItqzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MACvnmTKXABDMvr8Dq1zWlwB2CtbVyllFEcEIabksiQkZjrKWpR33GF7milgf4pBl
         a1+dsoyJEF2cxnjInXwezM/5AQDCLhohE+xA+sfm0tKVQ1MZKRl+yD6lwiur1kfTvZ
         MzCcNigRbr60OMgbX/5h9jCiGCwP0XqWffMZ6h90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 72/93] net: hns3: Fix NULL deref when unloading driver
Date:   Thu, 18 Apr 2019 19:57:50 +0200
Message-Id: <20190418160444.475520459@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c8a8045b2d0a974149d65bbe6a7acbcde93cf85b ]

When the driver is unloading, if there is a calling of ndo_open occurs
between phy_disconnect() and unregister_netdev(), it will end up
causing the kernel to eventually hit a NULL deref:

[14942.417828] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
[14942.529878] Mem abort info:
[14942.551166]   ESR = 0x96000006
[14942.567070]   Exception class = DABT (current EL), IL = 32 bits
[14942.623081]   SET = 0, FnV = 0
[14942.639112]   EA = 0, S1PTW = 0
[14942.643628] Data abort info:
[14942.659227]   ISV = 0, ISS = 0x00000006
[14942.674870]   CM = 0, WnR = 0
[14942.679449] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000224ad6ad
[14942.695595] [0000000000000048] pgd=00000021e6673003, pud=00000021dbf01003, pmd=0000000000000000
[14942.723163] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[14942.729358] Modules linked in: hns3(O) hclge(O) pv680_mii(O) hnae3(O) [last unloaded: hclge]
[14942.738907] CPU: 1 PID: 26629 Comm: kworker/u4:13 Tainted: G           O      4.18.0-rc1-12928-ga960791-dirty #145
[14942.749491] Hardware name: Huawei Technologies Co., Ltd. D05/D05, BIOS Hi1620 FPGA TB BOOT BIOS B763 08/17/2018
[14942.760392] Workqueue: events_power_efficient phy_state_machine
[14942.766644] pstate: 80c00009 (Nzcv daif +PAN +UAO)
[14942.771918] pc : test_and_set_bit+0x18/0x38
[14942.776589] lr : netif_carrier_off+0x24/0x70
[14942.781033] sp : ffff0000121abd20
[14942.784518] x29: ffff0000121abd20 x28: 0000000000000000
[14942.790208] x27: ffff0000164d3cd8 x26: ffff8021da68b7b8
[14942.795832] x25: 0000000000000000 x24: ffff8021eb407800
[14942.801445] x23: 0000000000000000 x22: 0000000000000000
[14942.807046] x21: 0000000000000001 x20: 0000000000000000
[14942.812672] x19: 0000000000000000 x18: ffff000009781708
[14942.818284] x17: 00000000004970e8 x16: ffff00000816ad48
[14942.823900] x15: 0000000000000000 x14: 0000000000000008
[14942.829528] x13: 0000000000000000 x12: 0000000000000f65
[14942.835149] x11: 0000000000000001 x10: 00000000000009d0
[14942.840753] x9 : ffff0000121abaa0 x8 : 0000000000000000
[14942.846360] x7 : ffff000009781708 x6 : 0000000000000003
[14942.851970] x5 : 0000000000000020 x4 : 0000000000000004
[14942.857575] x3 : 0000000000000002 x2 : 0000000000000001
[14942.863180] x1 : 0000000000000048 x0 : 0000000000000000
[14942.868875] Process kworker/u4:13 (pid: 26629, stack limit = 0x00000000c909dbf3)
[14942.876464] Call trace:
[14942.879200]  test_and_set_bit+0x18/0x38
[14942.883376]  phy_link_change+0x38/0x78
[14942.887378]  phy_state_machine+0x3dc/0x4f8
[14942.891968]  process_one_work+0x158/0x470
[14942.896223]  worker_thread+0x50/0x470
[14942.900219]  kthread+0x104/0x130
[14942.903905]  ret_from_fork+0x10/0x1c
[14942.907755] Code: d2800022 8b400c21 f9800031 9ac32044 (c85f7c22)
[14942.914185] ---[ end trace 968c9e12eb740b23 ]---

So this patch fixes it by modifying the timing to do phy_connect_direct()
and phy_disconnect().

Fixes: 256727da7395 ("net: hns3: Add MDIO support to HNS3 Ethernet driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 ++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 28 +++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 20 ++-----------
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  8 ++++--
 .../hisilicon/hns3/hns3pf/hclge_mdio.h        |  4 +--
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 09c774fe8853..854a55d4332a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -463,6 +463,8 @@ struct hnae3_ae_ops {
 	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
 	u16 (*get_global_queue_id)(struct hnae3_handle *handle, u16 queue_id);
 	void (*set_timer_task)(struct hnae3_handle *handle, bool enable);
+	int (*mac_connect_phy)(struct hnae3_handle *handle);
+	void (*mac_disconnect_phy)(struct hnae3_handle *handle);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d84c50068f66..40b69eaf2cb3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3519,6 +3519,25 @@ static int hns3_init_mac_addr(struct net_device *netdev, bool init)
 	return ret;
 }
 
+static int hns3_init_phy(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+	int ret = 0;
+
+	if (h->ae_algo->ops->mac_connect_phy)
+		ret = h->ae_algo->ops->mac_connect_phy(h);
+
+	return ret;
+}
+
+static void hns3_uninit_phy(struct net_device *netdev)
+{
+	struct hnae3_handle *h = hns3_get_handle(netdev);
+
+	if (h->ae_algo->ops->mac_disconnect_phy)
+		h->ae_algo->ops->mac_disconnect_phy(h);
+}
+
 static int hns3_restore_fd_rules(struct net_device *netdev)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -3627,6 +3646,10 @@ static int hns3_client_init(struct hnae3_handle *handle)
 		goto out_init_ring_data;
 	}
 
+	ret = hns3_init_phy(netdev);
+	if (ret)
+		goto out_init_phy;
+
 	ret = register_netdev(netdev);
 	if (ret) {
 		dev_err(priv->dev, "probe register netdev fail!\n");
@@ -3651,6 +3674,9 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	return ret;
 
 out_reg_netdev_fail:
+	hns3_uninit_phy(netdev);
+out_init_phy:
+	hns3_uninit_all_ring(priv);
 out_init_ring_data:
 	(void)hns3_nic_uninit_vector_data(priv);
 out_init_vector_data:
@@ -3685,6 +3711,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_force_clear_all_rx_ring(handle);
 
+	hns3_uninit_phy(netdev);
+
 	ret = hns3_nic_uninit_vector_data(priv);
 	if (ret)
 		netdev_err(netdev, "uninit vector error\n");
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f7637c08bb3a..cb7571747af7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6959,16 +6959,6 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 		*tp_mdix = ETH_TP_MDI;
 }
 
-static int hclge_init_instance_hw(struct hclge_dev *hdev)
-{
-	return hclge_mac_connect_phy(hdev);
-}
-
-static void hclge_uninit_instance_hw(struct hclge_dev *hdev)
-{
-	hclge_mac_disconnect_phy(hdev);
-}
-
 static int hclge_init_client_instance(struct hnae3_client *client,
 				      struct hnae3_ae_dev *ae_dev)
 {
@@ -6988,13 +6978,6 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (ret)
 				goto clear_nic;
 
-			ret = hclge_init_instance_hw(hdev);
-			if (ret) {
-			        client->ops->uninit_instance(&vport->nic,
-			                                     0);
-				goto clear_nic;
-			}
-
 			hnae3_set_client_init_flag(client, ae_dev, 1);
 
 			if (hdev->roce_client &&
@@ -7079,7 +7062,6 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 		if (client->type == HNAE3_CLIENT_ROCE)
 			return;
 		if (hdev->nic_client && client->ops->uninit_instance) {
-			hclge_uninit_instance_hw(hdev);
 			client->ops->uninit_instance(&vport->nic, 0);
 			hdev->nic_client = NULL;
 			vport->nic.client = NULL;
@@ -8012,6 +7994,8 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.set_gro_en = hclge_gro_en,
 	.get_global_queue_id = hclge_covert_handle_qid_global,
 	.set_timer_task = hclge_set_timer_task,
+	.mac_connect_phy = hclge_mac_connect_phy,
+	.mac_disconnect_phy = hclge_mac_disconnect_phy,
 };
 
 static struct hnae3_ae_algo ae_algo = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index dabb8437f8dc..84f28785ba28 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -195,8 +195,10 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 		netdev_err(netdev, "failed to configure flow control.\n");
 }
 
-int hclge_mac_connect_phy(struct hclge_dev *hdev)
+int hclge_mac_connect_phy(struct hnae3_handle *handle)
 {
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
@@ -229,8 +231,10 @@ int hclge_mac_connect_phy(struct hclge_dev *hdev)
 	return 0;
 }
 
-void hclge_mac_disconnect_phy(struct hclge_dev *hdev)
+void hclge_mac_disconnect_phy(struct hnae3_handle *handle)
 {
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 
 	if (!phydev)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index 5fbf7dddb5d9..ef095d9c566f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -5,8 +5,8 @@
 #define __HCLGE_MDIO_H
 
 int hclge_mac_mdio_config(struct hclge_dev *hdev);
-int hclge_mac_connect_phy(struct hclge_dev *hdev);
-void hclge_mac_disconnect_phy(struct hclge_dev *hdev);
+int hclge_mac_connect_phy(struct hnae3_handle *handle);
+void hclge_mac_disconnect_phy(struct hnae3_handle *handle);
 void hclge_mac_start_phy(struct hclge_dev *hdev);
 void hclge_mac_stop_phy(struct hclge_dev *hdev);
 
-- 
2.19.1



