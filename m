Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D61C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AF820989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jtstg2xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfDER3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56308 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfDER3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HSwBk130988;
        Fri, 5 Apr 2019 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485338;
        bh=UnBv29Cns/xkCQo9GEbugXSGHD3faoliySYfnz5T1Bg=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=jtstg2xelLLJP1N4WdYiZLWvA3uurkhCsxKQsHBT4moJYWapgVdrsc4IEbP9GJhg4
         LE6BeOgiwb3n5ZBLLRiPDvpdVUY8IGqumCG8o8bQ32tVMT1c4+ZrMkLHvka5gOUyvW
         NcxBgIL10TGedfiMcoYTxACfAn7yaN3YeHpD+4Es=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HSw1H050673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:28:58 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:28:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:28:58 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuT095744;
        Fri, 5 Apr 2019 12:28:57 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 06/14] net: hsr: fix NULL checks in the code
Date:   Fri, 5 Apr 2019 13:31:28 -0400
Message-ID: <20190405173136.18050-7-m-karicheri2@ti.com>
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

This patch replaces all instance of NULL checks such as
    if (foo == NULL) with if (!foo)
Also
    if (foo != NULL) with if (foo)

This is seen when ran checkpatch.pl -f on files under net/hsr
and suggestion is to replace as above.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c   |  2 +-
 net/hsr/hsr_forward.c  | 12 ++++++------
 net/hsr/hsr_framereg.c |  2 +-
 net/hsr/hsr_main.c     |  4 ++--
 net/hsr/hsr_slave.c    |  6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 567c890f08a5..245fc531d39f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -258,7 +258,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 			    sizeof(struct hsr_sup_tag) +
 			    sizeof(struct hsr_sup_payload) + hlen + tlen);
 
-	if (skb == NULL)
+	if (!skb)
 		return;
 
 	skb_reserve(skb, hlen);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index fdc191015208..68ca775d3be8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -97,7 +97,7 @@ static struct sk_buff *create_stripped_skb(struct sk_buff *skb_in,
 	skb_pull(skb_in, HSR_HLEN);
 	skb = __pskb_copy(skb_in, skb_headroom(skb_in) - HSR_HLEN, GFP_ATOMIC);
 	skb_push(skb_in, HSR_HLEN);
-	if (skb == NULL)
+	if (!skb)
 		return NULL;
 
 	skb_reset_mac_header(skb);
@@ -160,7 +160,7 @@ static struct sk_buff *create_tagged_skb(struct sk_buff *skb_o,
 
 	/* Create the new skb with enough headroom to fit the HSR tag */
 	skb = __pskb_copy(skb_o, skb_headroom(skb_o) + HSR_HLEN, GFP_ATOMIC);
-	if (skb == NULL)
+	if (!skb)
 		return NULL;
 	skb_reset_mac_header(skb);
 
@@ -277,7 +277,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 			skb = frame_get_tagged_skb(frame, port);
 		else
 			skb = frame_get_stripped_skb(frame, port);
-		if (skb == NULL) {
+		if (!skb) {
 			/* FIXME: Record the dropped frame? */
 			continue;
 		}
@@ -317,7 +317,7 @@ static int hsr_fill_frame_info(struct hsr_frame_info *frame,
 
 	frame->is_supervision = is_supervision_frame(port->hsr, skb);
 	frame->node_src = hsr_get_node(port, skb, frame->is_supervision);
-	if (frame->node_src == NULL)
+	if (!frame->node_src)
 		return -1; /* Unknown node and !is_supervision, or no mem */
 
 	ethhdr = (struct ethhdr *) skb_mac_header(skb);
@@ -364,9 +364,9 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
 	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 
-	if (frame.skb_hsr != NULL)
+	if (frame.skb_hsr)
 		kfree_skb(frame.skb_hsr);
-	if (frame.skb_std != NULL)
+	if (frame.skb_std)
 		kfree_skb(frame.skb_std);
 	return;
 
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 78fca38ffa9f..c1b0e62af0f1 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -405,7 +405,7 @@ void hsr_prune_nodes(struct timer_list *t)
 					msecs_to_jiffies(1.5*MAX_SLAVE_DIFF))) {
 			rcu_read_lock();
 			port = get_late_port(hsr, node);
-			if (port != NULL)
+			if (port)
 				hsr_nl_ringerror(hsr, node->MacAddressA, port);
 			rcu_read_unlock();
 		}
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 0d4ab8fc0aa1..84cacf8c1b0a 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -30,12 +30,12 @@ static int hsr_netdev_notify(struct notifier_block *nb, unsigned long event,
 
 	dev = netdev_notifier_info_to_dev(ptr);
 	port = hsr_port_get_rtnl(dev);
-	if (port == NULL) {
+	if (!port) {
 		if (!is_hsr_master(dev))
 			return NOTIFY_DONE;	/* Not an HSR device */
 		hsr = netdev_priv(dev);
 		port = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
-		if (port == NULL) {
+		if (!port) {
 			/* Resend of notification concerning removed device? */
 			return NOTIFY_DONE;
 		}
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d506c694ee25..07cbc2ead64d 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -140,11 +140,11 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	}
 
 	port = hsr_port_get_hsr(hsr, type);
-	if (port != NULL)
+	if (port)
 		return -EBUSY;	/* This port already exists */
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
-	if (port == NULL)
+	if (!port)
 		return -ENOMEM;
 
 	if (type != HSR_PT_MASTER) {
@@ -181,7 +181,7 @@ void hsr_del_port(struct hsr_port *port)
 	list_del_rcu(&port->port_list);
 
 	if (port != master) {
-		if (master != NULL) {
+		if (master) {
 			netdev_update_features(master->dev);
 			dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		}
-- 
2.17.0

