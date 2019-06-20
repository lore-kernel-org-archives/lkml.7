Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA43205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054925;
	bh=xh82Oq10IAg2tIgfkxQvYdcJPdGAQ7vUAQhGRQWV0jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFk9iNbCBQEQ20CDqwzsk684ceWhFsD/9zcZBaHksIIPuGclH02rxmKiwmposlh+X
	 iq0hjXweOWxdlWFJ0vTzZlH3GIEh/B4UwRdCGyPmtFd4EyBON8ZOvRO98fUQ3uvtFb
	 rxV5iVYmFI9ArXwopb3k7ACxB2e7ddz1sOiONt0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFTSWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfFTSLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:11:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852D921530;
        Thu, 20 Jun 2019 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054290;
        bh=xh82Oq10IAg2tIgfkxQvYdcJPdGAQ7vUAQhGRQWV0jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hasA8CGCVGeKRVsSAin8n4ng+SpeT46W4i+31yRncILLEt3C90gVBosa6rUIxuGMZ
         BRa3j6Ls2zyxkLwa8DO1aqwgILUjYRz1UoPcfr6pXA35tDK481tAjncUB/iIuuDMdA
         H9uqLjKe2r3P/XbdPpRgxV6lEyPA2+XqvA55i2X0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+78fbe679c8ca8d264a8d@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 12/61] tipc: purge deferredq list for each grp member in tipc_group_delete
Date:   Thu, 20 Jun 2019 19:57:07 +0200
Message-Id: <20190620174339.251440063@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 5cf02612b33f104fe1015b2dfaf1758ad3675588 ]

Syzbot reported a memleak caused by grp members' deferredq list not
purged when the grp is be deleted.

The issue occurs when more(msg_grp_bc_seqno(hdr), m->bc_rcv_nxt) in
tipc_group_filter_msg() and the skb will stay in deferredq.

So fix it by calling __skb_queue_purge for each member's deferredq
in tipc_group_delete() when a tipc sk leaves the grp.

Fixes: b87a5ea31c93 ("tipc: guarantee group unicast doesn't bypass group broadcast")
Reported-by: syzbot+78fbe679c8ca8d264a8d@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/group.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -218,6 +218,7 @@ void tipc_group_delete(struct net *net,
 
 	rbtree_postorder_for_each_entry_safe(m, tmp, tree, tree_node) {
 		tipc_group_proto_xmit(grp, m, GRP_LEAVE_MSG, &xmitq);
+		__skb_queue_purge(&m->deferredq);
 		list_del(&m->list);
 		kfree(m);
 	}


