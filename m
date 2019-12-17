Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F55206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613525;
	bh=4XayCgrupbpkIgjLQhxTcCQoGXb2GpoRYyfp/kiop2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qtZ67GAO4/PRlfL1+HetrrZsw3vBvIL+IKL37r0bahSi0GDA3EGrK3i9Y9mUVvov0
	 r8e5lxoz7P4ByOCyp6g4RIlT/76D6arzKwOXkfJX/52bGjEXRmkkBr7MhyWt0xBPj9
	 /Yt0w6qokaJCu7iPfl5ohyC6xZzdYJRWc/YBirCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfLQUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbfLQUKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:10:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD5A206D7;
        Tue, 17 Dec 2019 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613447;
        bh=4XayCgrupbpkIgjLQhxTcCQoGXb2GpoRYyfp/kiop2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhZBd2oF0l4bijFcqm1gFUw9hQbk9GFIkDTOPHZugqvTq+u9Z7xH3CX/AZ/l5pmbB
         vYcmyb6OO+zJNhx2GEYErC6WpNcGqf8hOXVG2C9kTkbKf7lAoFNut5SS324842lhm7
         FER2hSGPzg84kazDY5Za9gPWA6Iu/vCMKHdVLJRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Varghese <martin.varghese@nokia.com>,
        Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 24/37] Fixed updating of ethertype in function skb_mpls_pop
Date:   Tue, 17 Dec 2019 21:09:45 +0100
Message-Id: <20191217200729.869816826@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Varghese <martin.varghese@nokia.com>

[ Upstream commit 040b5cfbcefa263ccf2c118c4938308606bb7ed8 ]

The skb_mpls_pop was not updating ethertype of an ethernet packet if the
packet was originally received from a non ARPHRD_ETHER device.

In the below OVS data path flow, since the device corresponding to port 7
is an l3 device (ARPHRD_NONE) the skb_mpls_pop function does not update
the ethertype of the packet even though the previous push_eth action had
added an ethernet header to the packet.

recirc_id(0),in_port(7),eth_type(0x8847),
mpls(label=12/0xfffff,tc=0/0,ttl=0/0x0,bos=1/1),
actions:push_eth(src=00:00:00:00:00:00,dst=00:00:00:00:00:00),
pop_mpls(eth_type=0x800),4

Fixes: ed246cee09b9 ("net: core: move pop MPLS functionality from OvS to core helper")
Signed-off-by: Martin Varghese <martin.varghese@nokia.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h    |    3 ++-
 net/core/skbuff.c         |    6 ++++--
 net/openvswitch/actions.c |    3 ++-
 net/sched/act_mpls.c      |    4 +++-
 4 files changed, 11 insertions(+), 5 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3528,7 +3528,8 @@ int skb_vlan_pop(struct sk_buff *skb);
 int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci);
 int skb_mpls_push(struct sk_buff *skb, __be32 mpls_lse, __be16 mpls_proto,
 		  int mac_len);
-int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len);
+int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
+		 bool ethernet);
 int skb_mpls_update_lse(struct sk_buff *skb, __be32 mpls_lse);
 int skb_mpls_dec_ttl(struct sk_buff *skb);
 struct sk_buff *pskb_extract(struct sk_buff *skb, int off, int to_copy,
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5529,12 +5529,14 @@ EXPORT_SYMBOL_GPL(skb_mpls_push);
  * @skb: buffer
  * @next_proto: ethertype of header after popped MPLS header
  * @mac_len: length of the MAC header
+ * @ethernet: flag to indicate if ethernet header is present in packet
  *
  * Expects skb->data at mac header.
  *
  * Returns 0 on success, -errno otherwise.
  */
-int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len)
+int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
+		 bool ethernet)
 {
 	int err;
 
@@ -5553,7 +5555,7 @@ int skb_mpls_pop(struct sk_buff *skb, __
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, mac_len);
 
-	if (skb->dev && skb->dev->type == ARPHRD_ETHER) {
+	if (ethernet) {
 		struct ethhdr *hdr;
 
 		/* use mpls_hdr() to get ethertype to account for VLANs. */
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -179,7 +179,8 @@ static int pop_mpls(struct sk_buff *skb,
 {
 	int err;
 
-	err = skb_mpls_pop(skb, ethertype, skb->mac_len);
+	err = skb_mpls_pop(skb, ethertype, skb->mac_len,
+			   ovs_key_mac_proto(key) == MAC_PROTO_ETHERNET);
 	if (err)
 		return err;
 
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /* Copyright (C) 2019 Netronome Systems, Inc. */
 
+#include <linux/if_arp.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -76,7 +77,8 @@ static int tcf_mpls_act(struct sk_buff *
 
 	switch (p->tcfm_action) {
 	case TCA_MPLS_ACT_POP:
-		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len))
+		if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
+				 skb->dev && skb->dev->type == ARPHRD_ETHER))
 			goto drop;
 		break;
 	case TCA_MPLS_ACT_PUSH:


