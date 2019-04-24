Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C0221904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127270;
	bh=Tk2dO4cq7j9zV/dJdbuVptjKXPFZtN+Ns56DDzEYzSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gc9FA+Th1ow/2c+Js0i/cWn0PnHfn+kinGXjzrZh6WxF0q5lv0yImOhx4egAA30MU
	 jdA/ZovLDHqNWsoUkzhd2jRnFXk/0pcObIxmc7T6HE1eTTFknj+27BMESNSKQK5QNM
	 ae5mtRPrtlXQ2mxXffGau9VAOe1FKlpr1zgHN7HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391720AbfDXRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391320AbfDXReY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D8D2054F;
        Wed, 24 Apr 2019 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127263;
        bh=Tk2dO4cq7j9zV/dJdbuVptjKXPFZtN+Ns56DDzEYzSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyFKhqdD6fZYDvlhPcTUFp6bO1yvAEhUZ1uNMRZcNhOL1j0UpwITBhm8cH6aiO+8g
         UDxyuEqVfUUZCFQg6zrz3Qy3Gyy2TOBY8ELRBXL9202sfg3hOB35+Vb0S6uLPxD3ju
         HtME+yJZipRE+HtzyMI/EcKIcavcvcp0QwgieT3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 008/115] net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv
Date:   Wed, 24 Apr 2019 19:09:04 +0200
Message-Id: <20190424170925.446032353@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 988dc4a9a3b66be75b30405a5494faf0dc7cffb6 ]

gue tunnels run iptunnel_pull_offloads on received skbs. This can
determine a possible use-after-free accessing guehdr pointer since
the packet will be 'uncloned' running pskb_expand_head if it is a
cloned gso skb (e.g if the packet has been sent though a veth device)

Fixes: a09a4c8dd1ec ("tunnels: Remove encapsulation offloads on decap")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fou.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -121,6 +121,7 @@ static int gue_udp_recv(struct sock *sk,
 	struct guehdr *guehdr;
 	void *data;
 	u16 doffset = 0;
+	u8 proto_ctype;
 
 	if (!fou)
 		return 1;
@@ -212,13 +213,14 @@ static int gue_udp_recv(struct sock *sk,
 	if (unlikely(guehdr->control))
 		return gue_control_message(skb, guehdr);
 
+	proto_ctype = guehdr->proto_ctype;
 	__skb_pull(skb, sizeof(struct udphdr) + hdrlen);
 	skb_reset_transport_header(skb);
 
 	if (iptunnel_pull_offloads(skb))
 		goto drop;
 
-	return -guehdr->proto_ctype;
+	return -proto_ctype;
 
 drop:
 	kfree_skb(skb);


