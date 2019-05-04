Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D51220862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556965553;
	bh=aMmom8i1CZXrKAwiIbaXBCIae3WEMKTSqa+RADeoR24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cm3x26P6G+IUdTc8RQ60L0KarxIvTXp+hid27FU4lzU7YT53CjvrAEkbRe9gxDJgM
	 GLoHdRboeBZ5knCbpRQAyZpexX3DCKkXz1vjkRHG2qkxKoRowUNStZ5cVnjAn07A9Z
	 YnNkxt0gduSEARefB4Kmp79xWFzBnhW4dPY81B18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfEDKZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfEDKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:25:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA42420862;
        Sat,  4 May 2019 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556965548;
        bh=aMmom8i1CZXrKAwiIbaXBCIae3WEMKTSqa+RADeoR24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rua72Zg9vlSU2azwIS/1kYGYpViqhkCdCQiBx6i0fN0bupgsrXkgZ3CKobu7L5dLS
         5up7alZirgOtzb7yt3eD5Ye/jVlvOIkdD0mfJ49gP6UwWmKFBtg3+mPKPDO7OupA5H
         RVr51i4Cga0a39PAfDnJUFkAecafjkgfNMIPyG+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <David.Laight@aculab.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 14/32] packet: validate msg_namelen in send directly
Date:   Sat,  4 May 2019 12:24:59 +0200
Message-Id: <20190504102452.965271933@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504102452.523724210@linuxfoundation.org>
References: <20190504102452.523724210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 486efdc8f6ce802b27e15921d2353cc740c55451 ]

Packet sockets in datagram mode take a destination address. Verify its
length before passing to dev_hard_header.

Prior to 2.6.14-rc3, the send code ignored sll_halen. This is
established behavior. Directly compare msg_namelen to dev->addr_len.

Change v1->v2: initialize addr in all paths

Fixes: 6b8d95f1795c4 ("packet: validate address length if non-zero")
Suggested-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2603,8 +2603,8 @@ static int tpacket_snd(struct packet_soc
 	void *ph;
 	DECLARE_SOCKADDR(struct sockaddr_ll *, saddr, msg->msg_name);
 	bool need_wait = !(msg->msg_flags & MSG_DONTWAIT);
+	unsigned char *addr = NULL;
 	int tp_len, size_max;
-	unsigned char *addr;
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
@@ -2615,7 +2615,6 @@ static int tpacket_snd(struct packet_soc
 	if (likely(saddr == NULL)) {
 		dev	= packet_cached_dev_get(po);
 		proto	= po->num;
-		addr	= NULL;
 	} else {
 		err = -EINVAL;
 		if (msg->msg_namelen < sizeof(struct sockaddr_ll))
@@ -2625,10 +2624,13 @@ static int tpacket_snd(struct packet_soc
 						sll_addr)))
 			goto out;
 		proto	= saddr->sll_protocol;
-		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(&po->sk), saddr->sll_ifindex);
-		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out_put;
+		if (po->sk.sk_socket->type == SOCK_DGRAM) {
+			if (dev && msg->msg_namelen < dev->addr_len +
+				   offsetof(struct sockaddr_ll, sll_addr))
+				goto out_put;
+			addr = saddr->sll_addr;
+		}
 	}
 
 	err = -ENXIO;
@@ -2800,7 +2802,7 @@ static int packet_snd(struct socket *soc
 	struct sk_buff *skb;
 	struct net_device *dev;
 	__be16 proto;
-	unsigned char *addr;
+	unsigned char *addr = NULL;
 	int err, reserve = 0;
 	struct sockcm_cookie sockc;
 	struct virtio_net_hdr vnet_hdr = { 0 };
@@ -2817,7 +2819,6 @@ static int packet_snd(struct socket *soc
 	if (likely(saddr == NULL)) {
 		dev	= packet_cached_dev_get(po);
 		proto	= po->num;
-		addr	= NULL;
 	} else {
 		err = -EINVAL;
 		if (msg->msg_namelen < sizeof(struct sockaddr_ll))
@@ -2825,10 +2826,13 @@ static int packet_snd(struct socket *soc
 		if (msg->msg_namelen < (saddr->sll_halen + offsetof(struct sockaddr_ll, sll_addr)))
 			goto out;
 		proto	= saddr->sll_protocol;
-		addr	= saddr->sll_halen ? saddr->sll_addr : NULL;
 		dev = dev_get_by_index(sock_net(sk), saddr->sll_ifindex);
-		if (addr && dev && saddr->sll_halen < dev->addr_len)
-			goto out_unlock;
+		if (sock->type == SOCK_DGRAM) {
+			if (dev && msg->msg_namelen < dev->addr_len +
+				   offsetof(struct sockaddr_ll, sll_addr))
+				goto out_unlock;
+			addr = saddr->sll_addr;
+		}
 	}
 
 	err = -ENXIO;


