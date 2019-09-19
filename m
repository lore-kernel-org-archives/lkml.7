Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F2EC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE5320640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932009;
	bh=n42OO6feoB2TlHlu0xT/q7tx7pWAn08ren5fWL62ZvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QGzTkpFWMi8BqAulaMiIRxYi0z9e0FwnO+sl8UefmFJvCAyRsQVx8aIV8FtvxMPiP
	 KUKHzboaB4CcsTtEtCQ4jFxHKclNiBjaLih5hP7ykLFrEOngXqXSOi8fI+BwVzinNQ
	 MBGH2+Iag5xNPXZx8d3lcA/uLgQuFhJOjVXvz2SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394215AbfISW0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393070AbfISWVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3005E21D7C;
        Thu, 19 Sep 2019 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931705;
        bh=n42OO6feoB2TlHlu0xT/q7tx7pWAn08ren5fWL62ZvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccbwiqcX9KsozYuTNSmD7YNDsfxeY3wM3JMZW0PVyX1B8wUc83Au93Uk21qIlmdpS
         h6GRcFenQm99CAX5aw3BhWj/L4uGdmG+SrAC+wrTGkO4405V7boXl6fytnP5nUehLd
         ldZ6pB75t5ISiVd7F4CxKgvUsgaTOngvUNeiFAo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 10/56] tipc: add NULL pointer check before calling kfree_rcu
Date:   Fri, 20 Sep 2019 00:03:51 +0200
Message-Id: <20190919214749.244237236@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 42dec1dbe38239cf91cc1f4df7830c66276ced37 ]

Unlike kfree(p), kfree_rcu(p, rcu) won't do NULL pointer check. When
tipc_nametbl_remove_publ returns NULL, the panic below happens:

   BUG: unable to handle kernel NULL pointer dereference at 0000000000000068
   RIP: 0010:__call_rcu+0x1d/0x290
   Call Trace:
    <IRQ>
    tipc_publ_notify+0xa9/0x170 [tipc]
    tipc_node_write_unlock+0x8d/0x100 [tipc]
    tipc_node_link_down+0xae/0x1d0 [tipc]
    tipc_node_check_dest+0x3ea/0x8f0 [tipc]
    ? tipc_disc_rcv+0x2c7/0x430 [tipc]
    tipc_disc_rcv+0x2c7/0x430 [tipc]
    ? tipc_rcv+0x6bb/0xf20 [tipc]
    tipc_rcv+0x6bb/0xf20 [tipc]
    ? ip_route_input_slow+0x9cf/0xb10
    tipc_udp_recv+0x195/0x1e0 [tipc]
    ? tipc_udp_is_known_peer+0x80/0x80 [tipc]
    udp_queue_rcv_skb+0x180/0x460
    udp_unicast_rcv_skb.isra.56+0x75/0x90
    __udp4_lib_rcv+0x4ce/0xb90
    ip_local_deliver_finish+0x11c/0x210
    ip_local_deliver+0x6b/0xe0
    ? ip_rcv_finish+0xa9/0x410
    ip_rcv+0x273/0x362

Fixes: 97ede29e80ee ("tipc: convert name table read-write lock to RCU")
Reported-by: Li Shuang <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/name_distr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -284,7 +284,8 @@ static void tipc_publ_purge(struct net *
 		       publ->key);
 	}
 
-	kfree_rcu(p, rcu);
+	if (p)
+		kfree_rcu(p, rcu);
 }
 
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list, u32 addr)


