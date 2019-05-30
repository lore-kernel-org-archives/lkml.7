Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A9C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AD524668
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186223;
	bh=BVZeyU1/iVIaE/V2LIymSSwYBEsq99mennyrdoguKtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkbWii0f1NFpZR4iUHfz2xJIAenzjMBOPw8lpFwl8nQTollCNr6+cGuSgYDllgHXW
	 WsRrPXoVo5ABwgO1GvZ9KMC/R0RHcmL1iMkkdvaIY7INYSb4Q2h4010gzVyoqF9UqS
	 uV9CP1Spqwfn87ZCybr2xs5f2CjD74fzV4Rve53s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfE3DRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbfE3DNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:45 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8F124556;
        Thu, 30 May 2019 03:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186024;
        bh=BVZeyU1/iVIaE/V2LIymSSwYBEsq99mennyrdoguKtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pypddQQT9YHE7wdrxrf58/ID0duChRgcpuVFJbljI9S4CsqKQazG5OBXPgMH/9VOi
         76QLdqTalBNo/St8EUYLtYOScLRqmsLB+VFAkujxlSGSX02sdAz0Z79kQtCQOjPt4/
         v/Qr9L/diy1EriFtnqxW0+frnUN1cCWgbr4Tul6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 097/346] net: ethernet: ti: cpsw: fix allmulti cfg in dual_mac mode
Date:   Wed, 29 May 2019 20:02:50 -0700
Message-Id: <20190530030546.082055133@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 06095f34f8a0a2c4c83a19514c272699edd5f80b ]

Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
working in non dual_mac mode, but in dual_mac - it causes
enabling/disabling ALLMULTI flag for both ports.

Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
specify ALE port number for which ALLMULTI has to be enabled and check if
port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
 drivers/net/ethernet/ti/cpsw_ale.c | 19 ++++++++++---------
 drivers/net/ethernet/ti/cpsw_ale.h |  3 +--
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index a591583d120e1..dd12b73a88530 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -800,12 +800,17 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 
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
@@ -813,7 +818,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	}
 
 	/* Restore allmulti on vlans if necessary */
-	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
+	cpsw_ale_set_allmulti(cpsw->ale,
+			      ndev->flags & IFF_ALLMULTI, slave_port);
 
 	/* add/remove mcast address either for real netdev or for vlan */
 	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 798c989d5d934..b3d9591b4824a 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -482,24 +482,25 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 }
 EXPORT_SYMBOL_GPL(cpsw_ale_del_vlan);
 
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
index cd07a3e96d576..1fe196d8a5e42 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.h
+++ b/drivers/net/ethernet/ti/cpsw_ale.h
@@ -37,7 +37,6 @@ struct cpsw_ale {
 	struct cpsw_ale_params	params;
 	struct timer_list	timer;
 	unsigned long		ageout;
-	int			allmulti;
 	u32			version;
 	/* These bits are different on NetCP NU Switch ALE */
 	u32			port_mask_bits;
@@ -116,7 +115,7 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 			int reg_mcast, int unreg_mcast);
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port);
-void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti);
+void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti, int port);
 
 int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control);
 int cpsw_ale_control_set(struct cpsw_ale *ale, int port,
-- 
2.20.1



