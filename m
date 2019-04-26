Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA246C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779FB212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n+dEDOlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDZRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:13:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37444 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfDZRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHD63f105202;
        Fri, 26 Apr 2019 12:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298786;
        bh=7rI6SndVhvITT/xLdnccMBQvzRRik+s0KN23uYB5P7U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n+dEDOlkLie2r66a4yRA6/3r8jfeVvksGA+JJSdvioPzsbjtR+jgMtLcGHFlFKiKk
         nSwV38lc3jAZsyUdA4l7UVHWjrkHOaOKdzy/Z4trDh/LJENztk4FZQshj0RmHibYMT
         IpQEmtXwqfdX0SKD9CC3htJKrow8o/U/XlyG7S40=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHD6Jt030325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:13:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:13:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:13:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHD5eS114165;
        Fri, 26 Apr 2019 12:13:05 -0500
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
Subject: [PATCH net-next v2 11/20] net: ethernet: ti: cpsw: fix allmulti cfg in dual_mac mode
Date:   Fri, 26 Apr 2019 20:12:33 +0300
Message-ID: <1556298762-8632-12-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
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
changes in v2:
 - dropped allmulti field from ALE context

 drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
 drivers/net/ethernet/ti/cpsw_ale.c | 19 ++++++++++---------
 drivers/net/ethernet/ti/cpsw_ale.h |  3 +--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 4a26c72be0cc..071c8aeee2ce 100644
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
index 67dc769441ce..f77b5884c8db 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -468,24 +468,25 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 	return 0;
 }
 
-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port)
 {
 	u32 ale_entry[ALE_ENTRY_WORDS];
-	int type, idx;
 	int unreg_mcast = 0;
-
-	/* Only bother doing the work if the setting is actually changing */
-	if (ale->allmulti == allmulti)
-		return;
-
-	/* Remember the new setting to check against next time */
-	ale->allmulti = allmulti;
+	int type, idx;
 
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
index 4777d626fac8..370df254eb12 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -30,7 +30,6 @@ struct cpsw_ale {
 	struct cpsw_ale_params	params;
 	struct timer_list	timer;
 	unsigned long		ageout;
-	int			allmulti;
 	u32			version;
 	/* These bits are different on NetCP NU Switch ALE */
 	u32			port_mask_bits;
@@ -109,7 +108,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 			int reg_mcast, int unreg_mcast);
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port);
-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti);
+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port);
 
 int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control);
 int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
-- 
2.17.1

