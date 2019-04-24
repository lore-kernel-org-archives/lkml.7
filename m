Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA33C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD27F218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127308;
	bh=B9iZMpWju9Y9ei2xE33LIsTj7fYgP4CcfWfUNxBJBhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ml5qcRSSouWoccsvpGg1t7z3MUHVXa/ROduFpPW2P22xJirfDXkr8/9Wtnx504d7I
	 8DMRYd/wErdtWjMTxUchKzmfOaNEHmr+08XuY3wq1d98w0TFxYP5iA1gbHKT1F0OOY
	 pHOerqc6GzSgPiGAlSy8b33CKBk55e5IlmP5MmeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391829AbfDXRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391190AbfDXRfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:35:01 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8518820675;
        Wed, 24 Apr 2019 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127301;
        bh=B9iZMpWju9Y9ei2xE33LIsTj7fYgP4CcfWfUNxBJBhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egSmT1E3wOnNlW+mlUL03+qOQLH7XGY4z3+Rp51Wc+npUvlbid3zr309D0FSPqbFZ
         takqx7KLz1IeN0z/71jFy57qWOZZ/oAvwsECPHWdvcgTschg8gb6zxQvQK9zfAxs5O
         CDuK9fC/T209jFyU/iB4Bs0ySO6YI/mGpg0CiLSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kevin Darbyshire-Bryant <kevin@darbyshire-bryant.me.uk>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 5.0 040/115] sch_cake: Make sure we can write the IP header before changing DSCP bits
Date:   Wed, 24 Apr 2019 19:09:36 +0200
Message-Id: <20190424170927.393636942@linuxfoundation.org>
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


