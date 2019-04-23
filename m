Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3C2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C083206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RRUtw+V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfDWNJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:09:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50004 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfDWNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:09:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9WDh023163;
        Tue, 23 Apr 2019 08:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556024972;
        bh=hta9GhaPluM9fjd73h2oN8Xx7kdbrlYa7Vd+T3ltXO0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RRUtw+V0FZkBp0SEsSLtfgu++kPsUjLm4y2qjW1ziZJJkEdmkC+Oc88W1X8N3Lbpd
         K8V/XlNhPRAS6dL5QZgBkegvtHkQOnCxcIQVZohRVXz24J0HkFtGtcA0d6/3GN4a8e
         jibJK2/RDYaBgFhvFYpdxm9cqfScRd+2WQ4SxfuI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ND9WwR126154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 08:09:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 08:09:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 08:09:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9VTe126243;
        Tue, 23 Apr 2019 08:09:31 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg in dual_mac mode
Date:   Tue, 23 Apr 2019 16:09:02 +0300
Message-ID: <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
working in non dual_mac mode, but in dual_mac - it causes
enabling/disabling ALLMULTI flag for both ports.

Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
specify ALE port number for which ALLMULTI has to be enabled and check if
port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
 drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
 drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index fe3d145846d2..c497992f01f7 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -793,12 +793,17 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 
 static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 {
-	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int slave_port = -1;
+
+	if (cpsw->data.dual_emac)
+		slave_port = priv->emac_port + 1;
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
 		cpsw_set_promiscious(ndev, true);
-		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI);
+		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, slave_port);
 		return;
 	} else {
 		/* Disable promiscuous mode */
@@ -806,7 +811,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	}
 
 	/* Restore allmulti on vlans if necessary */
-	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
+	cpsw_ale_set_allmulti(cpsw->ale,
+			      ndev->flags & IFF_ALLMULTI, slave_port);
 
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 83ccb422dddd..f7369982ae33 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -468,11 +468,11 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 	return 0;
 }
 
-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS];
-	int type, idx;
 	int unreg_mcast = 0;
+	int type, idx;
 
 	/* Only bother doing the work if the setting is actually changing */
 	if (ale->allmulti == allmulti)
@@ -482,10 +482,18 @@ void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
 	ale->allmulti = allmulti;
 
 	for (idx = 0; idx < ale->params.ale_entries; idx++) {
+		int vlan_members;
+
 		cpsw_ale_read(ale, idx, ale_entry);
 		type = cpsw_ale_get_entry_type(ale_entry);
 		if (type != ALE_TYPE_VLAN)
 			continue;
+		vlan_members =
+			cpsw_ale_get_vlan_member_list(ale_entry,
+						      ale->vlan_field_bits);
+
+		if (port != -1 && !(vlan_members & BIT(port)))
+			continue;
 
 		unreg_mcast =
 			cpsw_ale_get_vlan_unreg_mcast(ale_entry,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.h b/drivers/net/ethernet/ti/cpsw_ale.h
index 4777d626fac8..8a0d25950dc1 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -109,7 +109,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 			int reg_mcast, int unreg_mcast);
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port);
-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti);
+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port);
 
 int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control);
 int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
-- 
2.17.1

