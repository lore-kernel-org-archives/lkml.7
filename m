Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2EA2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049919;
	bh=kW8gyVYBminoXUZpfzTSQknurIBtFVYlu+2Pceudjqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CtuS6U41BR6HbcNYc+OLFXxcpKpXfaDSBk1ezwnIyN9d0JqUsJ5Tw3Cy+ZMmbgb12
	 jrQ22LPepagQHvhH7w69PzXZbhlXAeq+Znd2tkaoTgUjgEaqLYSELP0/a0J27yPWTE
	 ZS+DT5kwZuviI43ImIbi0et7j0ozEbbayHaRD2X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCHM6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfCHM6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC0F2085A;
        Fri,  8 Mar 2019 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049912;
        bh=kW8gyVYBminoXUZpfzTSQknurIBtFVYlu+2Pceudjqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDQTQzZidVxk6nGlDdg+cpeO1tak460dRt7CxBcGui9gDSADWiljAHhR+xE3FOqnk
         ASHN6NFGk0/1ilrLHfosYsRXmTH+1Qq/jPC2TTnFSXa1gnwI54R32bOrldHuWUNFNs
         SjLrCblRaHIZQriDqwqEV/k1BUfbdCrDUms0YMBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 25/68] hv_netvsc: Fix IP header checksum for coalesced packets
Date:   Fri,  8 Mar 2019 13:49:55 +0100
Message-Id: <20190308124912.050913323@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit bf48648d650db1146b75b9bd358502431e86cf4f ]

Incoming packets may have IP header checksum verified by the host.
They may not have IP header checksum computed after coalescing.
This patch re-compute the checksum when necessary, otherwise the
packets may be dropped, because Linux network stack always checks it.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -743,6 +743,14 @@ void netvsc_linkstatus_callback(struct n
 	schedule_delayed_work(&ndev_ctx->dwork, 0);
 }
 
+static void netvsc_comp_ipcsum(struct sk_buff *skb)
+{
+	struct iphdr *iph = (struct iphdr *)skb->data;
+
+	iph->check = 0;
+	iph->check = ip_fast_csum(iph, iph->ihl);
+}
+
 static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
 					     struct napi_struct *napi,
 					     const struct ndis_tcp_ip_checksum_info *csum_info,
@@ -766,9 +774,17 @@ static struct sk_buff *netvsc_alloc_recv
 	/* skb is already created with CHECKSUM_NONE */
 	skb_checksum_none_assert(skb);
 
-	/*
-	 * In Linux, the IP checksum is always checked.
-	 * Do L4 checksum offload if enabled and present.
+	/* Incoming packets may have IP header checksum verified by the host.
+	 * They may not have IP header checksum computed after coalescing.
+	 * We compute it here if the flags are set, because on Linux, the IP
+	 * checksum is always checked.
+	 */
+	if (csum_info && csum_info->receive.ip_checksum_value_invalid &&
+	    csum_info->receive.ip_checksum_succeeded &&
+	    skb->protocol == htons(ETH_P_IP))
+		netvsc_comp_ipcsum(skb);
+
+	/* Do L4 checksum offload if enabled and present.
 	 */
 	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
 		if (csum_info->receive.tcp_checksum_succeeded ||


