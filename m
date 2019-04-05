Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8048C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8719A20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TqBCU0y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfDER3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56302 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDER3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSvAW130979;
        Fri, 5 Apr 2019 12:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485337;
        bh=Go+RTAY3YFb+qNn6Zh50IK6AL60Gi3kZ57IgGK4r2lo=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=TqBCU0y1WSynWbrzX5WpoZD+5lE2lSwagya3cF9fBQ0sNYDNZVX8mF/ypYjFi5zdm
         6DDsoefEBZhUZaPOTydSjlxomAEqHOltUieiee1QJRWMA1UkzhLo0u/LHbXGVrI/+R
         dsdkKbu+X5PPDfLmnmmI80Ymwlemz1mrU7FRQCIo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSvjv096152
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:57 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:57 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuR095744;
        Fri, 5 Apr 2019 12:28:56 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 04/14] net: hsr: fix alignment issues in the code for functions
Date:   Fri, 5 Apr 2019 13:31:26 -0400
Message-ID: <20190405173136.18050-5-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes alignment issues in code for functions. This is
seen when ran checkpatch.pl -f option on files under net/hsr.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c   |  6 +++---
 net/hsr/hsr_framereg.c |  2 +-
 net/hsr/hsr_netlink.c  | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index cf5c3951d35a..0aea1bd09526 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -243,7 +243,7 @@ static const struct header_ops hsr_header_ops = {
 };
 
 static void send_hsr_supervision_frame(struct hsr_port *master,
-		u8 type, u8 hsrVer)
+				       u8 type, u8 hsrVer)
 {
 	struct sk_buff *skb;
 	int hlen, tlen;
@@ -331,13 +331,13 @@ static void hsr_announce(struct timer_list *t)
 
 	if (hsr->announce_count < 3 && hsr->protVersion == 0) {
 		send_hsr_supervision_frame(master, HSR_TLV_ANNOUNCE,
-				hsr->protVersion);
+					   hsr->protVersion);
 		hsr->announce_count++;
 
 		interval = msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL);
 	} else {
 		send_hsr_supervision_frame(master, HSR_TLV_LIFE_CHECK,
-				hsr->protVersion);
+					   hsr->protVersion);
 
 		interval = msecs_to_jiffies(HSR_LIFE_CHECK_INTERVAL);
 	}
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 47dbaf2faefa..78fca38ffa9f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -105,7 +105,7 @@ int hsr_create_self_node(struct list_head *self_node_db,
 
 	rcu_read_lock();
 	oldnode = list_first_or_null_rcu(self_node_db,
-						struct hsr_node, mac_list);
+					 struct hsr_node, mac_list);
 	if (oldnode) {
 		list_replace_rcu(&oldnode->mac_list, &node->mac_list);
 		rcu_read_unlock();
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 39768382be24..15d3dba229b9 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -270,8 +270,8 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 	}
 
 	msg_head = genlmsg_put(skb_out, NETLINK_CB(skb_in).portid,
-				info->snd_seq, &hsr_genl_family, 0,
-				HSR_C_SET_NODE_STATUS);
+			       info->snd_seq, &hsr_genl_family, 0,
+			       HSR_C_SET_NODE_STATUS);
 	if (!msg_head) {
 		res = -ENOMEM;
 		goto nla_put_failure;
@@ -295,7 +295,7 @@ static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
 		goto nla_put_failure;
 
 	res = nla_put(skb_out, HSR_A_NODE_ADDR, ETH_ALEN,
-					nla_data(info->attrs[HSR_A_NODE_ADDR]));
+		      nla_data(info->attrs[HSR_A_NODE_ADDR]));
 	if (res < 0)
 		goto nla_put_failure;
 
@@ -396,8 +396,8 @@ static int hsr_get_node_list(struct sk_buff *skb_in, struct genl_info *info)
 	}
 
 	msg_head = genlmsg_put(skb_out, NETLINK_CB(skb_in).portid,
-				info->snd_seq, &hsr_genl_family, 0,
-				HSR_C_SET_NODE_LIST);
+			       info->snd_seq, &hsr_genl_family, 0,
+			       HSR_C_SET_NODE_LIST);
 	if (!msg_head) {
 		res = -ENOMEM;
 		goto nla_put_failure;
-- 
2.17.0

