Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C33FC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E45620651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356587;
	bh=ac9SrPQJaLrNqPQEoarbVAkip/kfw5InzIam9jU00Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvwxstojthoRoJmKCFmHFgItlbGI7S7RS1kdw8AY/tCYvgIc8cSKjhrxYPTmpkJnN
	 MnTSJvU0FVNSfZGrZgsaghalHekig1lbdoY3ERtSprFpJSgqjfpsGSOws+Gs2nCg2P
	 Xwne06EUP35kmB7eaLiqJ5ll+/tq3LyOeh4vAtRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfDOT3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfDOTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB79C218EA;
        Mon, 15 Apr 2019 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354932;
        bh=ac9SrPQJaLrNqPQEoarbVAkip/kfw5InzIam9jU00Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlKuay4U593779hJzCPUqL0R9kKB4nfu3CTcP+M/0CnEjo2LM0GlMUc4fhtV+tePS
         gqfbCMr6Xrftx89QpoUIQwrC4koOrPP4IA1e5Gp0WzjZl01jTDQoKV9VTwORWdeg8W
         1GxO/BipMqnx3bk4XzIvsUpKuBaiAMr91ES0EMC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 19/69] net-gro: Fix GRO flush when receiving a GSO packet.
Date:   Mon, 15 Apr 2019 20:58:37 +0200
Message-Id: <20190415183730.179188730@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 0ab03f353d3613ea49d1f924faf98559003670a8 ]

Currently we may merge incorrectly a received GSO packet
or a packet with frag_list into a packet sitting in the
gro_hash list. skb_segment() may crash case because
the assumptions on the skb layout are not met.
The correct behaviour would be to flush the packet in the
gro_hash list and send the received GSO packet directly
afterwards. Commit d61d072e87c8e ("net-gro: avoid reorders")
sets NAPI_GRO_CB(skb)->flush in this case, but this is not
checked before merging. This patch makes sure to check this
flag and to not merge in that case.

Fixes: d61d072e87c8e ("net-gro: avoid reorders")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3808,7 +3808,7 @@ int skb_gro_receive(struct sk_buff **hea
 	struct sk_buff *lp, *p = *head;
 	unsigned int delta_truesize;
 
-	if (unlikely(p->len + len >= 65536))
+	if (unlikely(p->len + len >= 65536 || NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	lp = NAPI_GRO_CB(p)->last;


