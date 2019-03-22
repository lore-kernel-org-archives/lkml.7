Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5339C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8070C20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255977;
	bh=UcRBShrrQ8aIxh1PO6BdCqjrngLK0CZtwB/xQpjtYIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5uXFIlZVvtF+M/J0zgNo6aGbpvMLiB1ZwfMV9JxOvmeMb6dmCOMpnZxgWzOqAtYk
	 0h1NAVnT6Pe7vriPMhHL4e+ovKc9NWLVhjWg65Or1FEX739w54ZXDiXZXEntOlhg8/
	 f9EgEk18OsJJs/6ph0NZQRVwMTHLul8Ad8BBWK/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfCVL7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387972AbfCVL7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:59:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA00C2192D;
        Fri, 22 Mar 2019 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255971;
        bh=UcRBShrrQ8aIxh1PO6BdCqjrngLK0CZtwB/xQpjtYIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u4tRGRo6IvTGbSTjG7tJGO68ldXJO55KlCEfu13UvMKR4ckHoEuI9bI7L7Htry+4
         e6b61YoY0oFb5e2q9YDnXeOoTohJNFAsib8TzR54DhOo0MXJragncV/1rf+aGA2UTk
         N8iHS2sqryVloX1kYJKDx1otHoS0lPZHUSemgocE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Willi <martin@strongswan.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/280] esp: Skip TX bytes accounting when sending from a request socket
Date:   Fri, 22 Mar 2019 12:13:43 +0100
Message-Id: <20190322111310.237871756@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

[ Upstream commit 09db51241118aeb06e1c8cd393b45879ce099b36 ]

On ESP output, sk_wmem_alloc is incremented for the added padding if a
socket is associated to the skb. When replying with TCP SYNACKs over
IPsec, the associated sk is a casted request socket, only. Increasing
sk_wmem_alloc on a request socket results in a write at an arbitrary
struct offset. In the best case, this produces the following WARNING:

WARNING: CPU: 1 PID: 0 at lib/refcount.c:102 esp_output_head+0x2e4/0x308 [esp4]
refcount_t: addition on 0; use-after-free.
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.0.0-rc3 #2
Hardware name: Marvell Armada 380/385 (Device Tree)
[...]
[<bf0ff354>] (esp_output_head [esp4]) from [<bf1006a4>] (esp_output+0xb8/0x180 [esp4])
[<bf1006a4>] (esp_output [esp4]) from [<c05dee64>] (xfrm_output_resume+0x558/0x664)
[<c05dee64>] (xfrm_output_resume) from [<c05d07b0>] (xfrm4_output+0x44/0xc4)
[<c05d07b0>] (xfrm4_output) from [<c05956bc>] (tcp_v4_send_synack+0xa8/0xe8)
[<c05956bc>] (tcp_v4_send_synack) from [<c0586ad8>] (tcp_conn_request+0x7f4/0x948)
[<c0586ad8>] (tcp_conn_request) from [<c058c404>] (tcp_rcv_state_process+0x2a0/0xe64)
[<c058c404>] (tcp_rcv_state_process) from [<c05958ac>] (tcp_v4_do_rcv+0xf0/0x1f4)
[<c05958ac>] (tcp_v4_do_rcv) from [<c0598a4c>] (tcp_v4_rcv+0xdb8/0xe20)
[<c0598a4c>] (tcp_v4_rcv) from [<c056eb74>] (ip_protocol_deliver_rcu+0x2c/0x2dc)
[<c056eb74>] (ip_protocol_deliver_rcu) from [<c056ee6c>] (ip_local_deliver_finish+0x48/0x54)
[<c056ee6c>] (ip_local_deliver_finish) from [<c056eecc>] (ip_local_deliver+0x54/0xec)
[<c056eecc>] (ip_local_deliver) from [<c056efac>] (ip_rcv+0x48/0xb8)
[<c056efac>] (ip_rcv) from [<c0519c2c>] (__netif_receive_skb_one_core+0x50/0x6c)
[...]

The issue triggers only when not using TCP syncookies, as for syncookies
no socket is associated.

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/esp4.c | 2 +-
 net/ipv6/esp6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 97689012b357..12a43a5369a5 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -325,7 +325,7 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			skb->len += tailen;
 			skb->data_len += tailen;
 			skb->truesize += tailen;
-			if (sk)
+			if (sk && sk_fullsock(sk))
 				refcount_add(tailen, &sk->sk_wmem_alloc);
 
 			goto out;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 88a7579c23bd..a7d996148eed 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -293,7 +293,7 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			skb->len += tailen;
 			skb->data_len += tailen;
 			skb->truesize += tailen;
-			if (sk)
+			if (sk && sk_fullsock(sk))
 				refcount_add(tailen, &sk->sk_wmem_alloc);
 
 			goto out;
-- 
2.19.1



