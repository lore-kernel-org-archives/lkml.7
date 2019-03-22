Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA674C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C4421916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254409;
	bh=Rp5yuYVwd9T95RpaFuqqezpiU7oPtVQGMPZyW3exo7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N3IwkMJNrDdesr2WVyt0iv15MPPm3RhYi0vG4/dVooly6CeUltB64/HbSrl60MPQf
	 i7oEuWAPaAWjnnJ85WJ/gkzjWEynQxFapDN3XBJmUUjqWzdCxARWMIc1JhmTKjp0UQ
	 Oh2BuHsw9vfL7WeWMdePb81GU6DXnjt7i6E/0FQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfCVLd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbfCVLdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE9121916;
        Fri, 22 Mar 2019 11:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254403;
        bh=Rp5yuYVwd9T95RpaFuqqezpiU7oPtVQGMPZyW3exo7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOcBR9f7x7DbwNBbvcmg9yeOmRX/dvatFTuL2ZKpfrcP3SjuwsGp6wtcs2/tbkto7
         l7MKyvbUoWGW3IBxKF1L8l2Zq99hxEhWn9rhmiPDWo+vkPaMb10KaMPh6I30W171cf
         TjlJUP+OZCQylo9HK0UIwum5GTali0GDa30i0Oyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 126/230] net: hsr: fix memory leak in hsr_dev_finalize()
Date:   Fri, 22 Mar 2019 12:14:24 +0100
Message-Id: <20190322111245.501450964@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 6caabe7f197d3466d238f70915d65301f1716626 ]

If hsr_add_port(hsr, hsr_dev, HSR_PT_MASTER) failed to
add port, it directly returns res and forgets to free the node
that allocated in hsr_create_self_node(), and forgets to delete
the node->mac_list linked in hsr->self_node_db.

BUG: memory leak
unreferenced object 0xffff8881cfa0c780 (size 64):
  comm "syz-executor.0", pid 2077, jiffies 4294717969 (age 2415.377s)
  hex dump (first 32 bytes):
    e0 c7 a0 cf 81 88 ff ff 00 02 00 00 00 00 ad de  ................
    00 e6 49 cd 81 88 ff ff c0 9b 87 d0 81 88 ff ff  ..I.............
  backtrace:
    [<00000000e2ff5070>] hsr_dev_finalize+0x736/0x960 [hsr]
    [<000000003ed2e597>] hsr_newlink+0x2b2/0x3e0 [hsr]
    [<000000003fa8c6b6>] __rtnl_newlink+0xf1f/0x1600 net/core/rtnetlink.c:3182
    [<000000001247a7ad>] rtnl_newlink+0x66/0x90 net/core/rtnetlink.c:3240
    [<00000000e7d1b61d>] rtnetlink_rcv_msg+0x54e/0xb90 net/core/rtnetlink.c:5130
    [<000000005556bd3a>] netlink_rcv_skb+0x129/0x340 net/netlink/af_netlink.c:2477
    [<00000000741d5ee6>] netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
    [<00000000741d5ee6>] netlink_unicast+0x49a/0x650 net/netlink/af_netlink.c:1336
    [<000000009d56f9b7>] netlink_sendmsg+0x88b/0xdf0 net/netlink/af_netlink.c:1917
    [<0000000046b35c59>] sock_sendmsg_nosec net/socket.c:621 [inline]
    [<0000000046b35c59>] sock_sendmsg+0xc3/0x100 net/socket.c:631
    [<00000000d208adc9>] __sys_sendto+0x33e/0x560 net/socket.c:1786
    [<00000000b582837a>] __do_sys_sendto net/socket.c:1798 [inline]
    [<00000000b582837a>] __se_sys_sendto net/socket.c:1794 [inline]
    [<00000000b582837a>] __x64_sys_sendto+0xdd/0x1b0 net/socket.c:1794
    [<00000000c866801d>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
    [<00000000fea382d9>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000e01dacb3>] 0xffffffffffffffff

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/hsr/hsr_device.c   |    4 +++-
 net/hsr/hsr_framereg.c |   12 ++++++++++++
 net/hsr/hsr_framereg.h |    1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -477,7 +477,7 @@ int hsr_dev_finalize(struct net_device *
 
 	res = hsr_add_port(hsr, hsr_dev, HSR_PT_MASTER);
 	if (res)
-		return res;
+		goto err_add_port;
 
 	res = register_netdevice(hsr_dev);
 	if (res)
@@ -498,6 +498,8 @@ int hsr_dev_finalize(struct net_device *
 fail:
 	hsr_for_each_port(hsr, port)
 		hsr_del_port(port);
+err_add_port:
+	hsr_del_node(&hsr->self_node_db);
 
 	return res;
 }
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -124,6 +124,18 @@ int hsr_create_self_node(struct list_hea
 	return 0;
 }
 
+void hsr_del_node(struct list_head *self_node_db)
+{
+	struct hsr_node *node;
+
+	rcu_read_lock();
+	node = list_first_or_null_rcu(self_node_db, struct hsr_node, mac_list);
+	rcu_read_unlock();
+	if (node) {
+		list_del_rcu(&node->mac_list);
+		kfree(node);
+	}
+}
 
 /* Allocate an hsr_node and add it to node_db. 'addr' is the node's AddressA;
  * seq_out is used to initialize filtering of outgoing duplicate frames
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -16,6 +16,7 @@
 
 struct hsr_node;
 
+void hsr_del_node(struct list_head *self_node_db);
 struct hsr_node *hsr_add_node(struct list_head *node_db, unsigned char addr[],
 			      u16 seq_out);
 struct hsr_node *hsr_get_node(struct list_head *node_db, struct sk_buff *skb,


