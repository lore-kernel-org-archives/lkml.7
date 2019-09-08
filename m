Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1235C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE8220693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947100;
	bh=EKv6XyVe0mPNfXO66aMLd1sxG49UjF/mGSVb5T1EkjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nE+BmwSV7VyeRT9fT2O+WAQ0PWe7pqT+s+S/CCBDYd9qVZYp6Kpnd9QdhfAhy6FhR
	 F9q1X9eF4g+TXGUXOUM3OkX/fepO6cQd93gaP07NeaWSAAVzv7XWUXfaX+MdXb47YY
	 vtjANfxJz3wVz/Mh7B3LV2vooF9M+PNZmhqVMg4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfIHMvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfIHMvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:51:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD8052082C;
        Sun,  8 Sep 2019 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947092;
        bh=EKv6XyVe0mPNfXO66aMLd1sxG49UjF/mGSVb5T1EkjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2DuaSDv96LZQk8A+VLP7fJfnhTFqycHFlurhO0AizDNbn76rlyjitDjTQucluh5Bl
         VVZ+MhGouml0qB03y+6JGf1fr8tA6XAEX0gkb+zAcixMlfVjQunCWwmFqnI+V9ULdO
         AznkKHRU2hTsKaHB2glwx/ihXI5xbe/QKrLnS/Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 06/94] tcp: inherit timestamp on mtu probe
Date:   Sun,  8 Sep 2019 13:41:02 +0100
Message-Id: <20190908121150.614563401@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 888a5c53c0d8be6e98bc85b677f179f77a647873 ]

TCP associates tx timestamp requests with a byte in the bytestream.
If merging skbs in tcp_mtu_probe, migrate the tstamp request.

Similar to MSG_EOR, do not allow moving a timestamp from any segment
in the probe but the last. This to avoid merging multiple timestamps.

Tested with the packetdrill script at
https://github.com/wdebruij/packetdrill/commits/mtu_probe-1

Link: http://patchwork.ozlabs.org/patch/1143278/#2232897
Fixes: 4ed2d765dfac ("net-timestamp: TCP timestamping")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2051,7 +2051,7 @@ static bool tcp_can_coalesce_send_queue_
 		if (len <= skb->len)
 			break;
 
-		if (unlikely(TCP_SKB_CB(skb)->eor))
+		if (unlikely(TCP_SKB_CB(skb)->eor) || tcp_has_tx_tstamp(skb))
 			return false;
 
 		len -= skb->len;
@@ -2168,6 +2168,7 @@ static int tcp_mtu_probe(struct sock *sk
 			 * we need to propagate it to the new skb.
 			 */
 			TCP_SKB_CB(nskb)->eor = TCP_SKB_CB(skb)->eor;
+			tcp_skb_collapse_tstamp(nskb, skb);
 			tcp_unlink_write_queue(skb, sk);
 			sk_wmem_free_skb(sk, skb);
 		} else {


