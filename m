Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3FE218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbfCAOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:53:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388894AbfCAOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:53:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4157B8B77475910A7BD;
        Fri,  1 Mar 2019 22:53:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Mar 2019 22:53:32 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: sit: fix memory leak in sit_init_net()
Date:   Fri, 1 Mar 2019 23:06:40 +0800
Message-ID: <20190301150640.85941-1-maowenan@huawei.com>
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

If register_netdev() is failed to register sitn->fb_tunnel_dev,
it will go to err_reg_dev and forget to free netdev(sitn->fb_tunnel_dev).

BUG: memory leak
unreferenced object 0xffff888378daad00 (size 512):
  comm "syz-executor.1", pid 4006, jiffies 4295121142 (age 16.115s)
  hex dump (first 32 bytes):
    00 e6 ed c0 83 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
backtrace:
    [<00000000d6dcb63e>] kvmalloc include/linux/mm.h:577 [inline]
    [<00000000d6dcb63e>] kvzalloc include/linux/mm.h:585 [inline]
    [<00000000d6dcb63e>] netif_alloc_netdev_queues net/core/dev.c:8380 [inline]
    [<00000000d6dcb63e>] alloc_netdev_mqs+0x600/0xcc0 net/core/dev.c:8970
    [<00000000867e172f>] sit_init_net+0x295/0xa40 net/ipv6/sit.c:1848
    [<00000000871019fa>] ops_init+0xad/0x3e0 net/core/net_namespace.c:129
    [<00000000319507f6>] setup_net+0x2ba/0x690 net/core/net_namespace.c:314
    [<0000000087db4f96>] copy_net_ns+0x1dc/0x330 net/core/net_namespace.c:437
    [<0000000057efc651>] create_new_namespaces+0x382/0x730 kernel/nsproxy.c:107
    [<00000000676f83de>] copy_namespaces+0x2ed/0x3d0 kernel/nsproxy.c:165
    [<0000000030b74bac>] copy_process.part.27+0x231e/0x6db0 kernel/fork.c:1919
    [<00000000fff78746>] copy_process kernel/fork.c:1713 [inline]
    [<00000000fff78746>] _do_fork+0x1bc/0xe90 kernel/fork.c:2224
    [<000000001c2e0d1c>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<00000000ec48bd44>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<0000000039acff8a>] 0xffffffffffffffff

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/ipv6/sit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e8a1dabef803..09e440e8dfae 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1873,6 +1873,7 @@ static int __net_init sit_init_net(struct net *net)
 
 err_reg_dev:
 	ipip6_dev_free(sitn->fb_tunnel_dev);
+	free_netdev(sitn->fb_tunnel_dev);
 err_alloc_dev:
 	return err;
 }
-- 
2.20.1

