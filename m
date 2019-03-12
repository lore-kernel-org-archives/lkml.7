Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7138DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CB6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411358;
	bh=Z3NwA8ZtwTzFBpVK2imb7wjYNVY7vQka9yMQCJ3eaYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1zkRsKUs4c9lrfz8iXOCv5b6ESmtp8DsWiAe5ad0Tn8UaprtM+MN2fWGSoKiSUPDu
	 Lvw8hda1GWnydAuyzt06NyP2qX83F2A/uGvxtDLsE+hiK9r34oKnJlkKWUO4Ajrlut
	 oRD7vrZoSkjBBgysA3C5zDVFtpckYG2kXQwXpdz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCLRSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbfCLRRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:17 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA9CF2171F;
        Tue, 12 Mar 2019 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411037;
        bh=Z3NwA8ZtwTzFBpVK2imb7wjYNVY7vQka9yMQCJ3eaYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHlLOOqLknFPYRs6ADNEYMO/kwBagOU+Gu2Yxr9Txeydf2vAvAzZpmO9DCogdMZVQ
         48gDKVX7r89YiZsT1+SB/lYF7IG/sSUf5+MSZTtSdjUa3cp3YBq/wabBVHfS94wDnS
         iCM5/golOuuA/N6U0B2zJkkffrKsUFaKLMPsaEIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 15/96] hv_netvsc: Fix IP header checksum for coalesced packets
Date:   Tue, 12 Mar 2019 10:09:33 -0700
Message-Id: <20190312171035.701747106@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -593,6 +593,14 @@ void netvsc_linkstatus_callback(struct h
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
 				struct hv_netvsc_packet *packet,
 				struct ndis_tcp_ip_checksum_info *csum_info,
@@ -616,9 +624,17 @@ static struct sk_buff *netvsc_alloc_recv
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


