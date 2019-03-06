Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B758C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0099820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCFOiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:38:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbfCFOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:38:15 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D1A673482E4A166F3B9;
        Wed,  6 Mar 2019 22:32:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 22:32:12 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>
Subject: [PATCH net] net: hsr: fix memory leak in hsr_dev_finalize()
Date:   Wed, 6 Mar 2019 22:45:01 +0800
Message-ID: <20190306144501.77976-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: c5a759117210("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/hsr/hsr_device.c   |  4 +++-
 net/hsr/hsr_framereg.c | 12 ++++++++++++
 net/hsr/hsr_framereg.h |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b8cd43c9ed5b..c4676bacb8db 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -486,7 +486,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 
 	res = hsr_add_port(hsr, hsr_dev, HSR_PT_MASTER);
 	if (res)
-		return res;
+		goto err_add_port;
 
 	res = register_netdevice(hsr_dev);
 	if (res)
@@ -506,6 +506,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 fail:
 	hsr_for_each_port(hsr, port)
 		hsr_del_port(port);
+err_add_port:
+	hsr_del_node(&hsr->self_node_db);
 
 	return res;
 }
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 286ceb41ac0c..9af16cb68f76 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -124,6 +124,18 @@ int hsr_create_self_node(struct list_head *self_node_db,
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
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 370b45998121..531fd3dfcac1 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -16,6 +16,7 @@
 
 struct hsr_node;
 
+void hsr_del_node(struct list_head *self_node_db);
 struct hsr_node *hsr_add_node(struct list_head *node_db, unsigned char addr[],
 			      u16 seq_out);
 struct hsr_node *hsr_get_node(struct hsr_port *port, struct sk_buff *skb,
-- 
2.20.1

