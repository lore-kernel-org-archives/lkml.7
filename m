Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2F5C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126999;
	bh=B9iZMpWju9Y9ei2xE33LIsTj7fYgP4CcfWfUNxBJBhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G802DsrikLdVMPP/sPzpcz1ACxJxFCax2ZXHGWoCawiYt4vG9l2RQEwAO3sQK42D+
	 fJKcuMSEoZJBhEq16I6Rfo9OP8+mH2Npu+KIjD2FNmrBeto1GaVPWi+3dUeyEr4emq
	 jKy1uwGtlIrFiqihoGOmiSoPtPYSgjuW4/MRiG0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbfDXR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfDXR3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C202B218B0;
        Wed, 24 Apr 2019 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126994;
        bh=B9iZMpWju9Y9ei2xE33LIsTj7fYgP4CcfWfUNxBJBhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb3nvVma+6wmKR8KvldKW3ym1ElRlZ89etZR70aVTyWwm+RzWst5UFVac5jy/padM
         leTSvyE/JQu3fzJWbYVvkTWuD0mrVQyncsplPDfiO2raFCThSB8/l8ZvscP77rq+MB
         frb1w66k/+N9X7Qnf5mqvYAV3h4uKKS5GmWhHIOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kevin Darbyshire-Bryant <kevin@darbyshire-bryant.me.uk>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 4.19 21/96] sch_cake: Make sure we can write the IP header before changing DSCP bits
Date:   Wed, 24 Apr 2019 19:09:26 +0200
Message-Id: <20190424170921.282123909@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit c87b4ecdbe8db27867a7b7f840291cd843406bd7 ]

There is not actually any guarantee that the IP headers are valid before we
access the DSCP bits of the packets. Fix this using the same approach taken
in sch_dsmark.

Reported-by: Kevin Darbyshire-Bryant <kevin@darbyshire-bryant.me.uk>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cake.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1524,16 +1524,27 @@ static void cake_wash_diffserv(struct sk
 
 static u8 cake_handle_diffserv(struct sk_buff *skb, u16 wash)
 {
+	int wlen = skb_network_offset(skb);
 	u8 dscp;
 
 	switch (tc_skb_protocol(skb)) {
 	case htons(ETH_P_IP):
+		wlen += sizeof(struct iphdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			return 0;
+
 		dscp = ipv4_get_dsfield(ip_hdr(skb)) >> 2;
 		if (wash && dscp)
 			ipv4_change_dsfield(ip_hdr(skb), INET_ECN_MASK, 0);
 		return dscp;
 
 	case htons(ETH_P_IPV6):
+		wlen += sizeof(struct ipv6hdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			return 0;
+
 		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> 2;
 		if (wash && dscp)
 			ipv6_change_dsfield(ipv6_hdr(skb), INET_ECN_MASK, 0);


