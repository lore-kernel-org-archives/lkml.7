Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACCA2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049723;
	bh=E93aChJlTgxlKNZlKxwrG0y+LaXLDVu8i9E4LKqev74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snf5YqRVO/bGZAIH/jUizJyWwzcuxMnaIpWd9s8J7Pf2+dRAkd+DfHLjedVzOO4uo
	 E6Y3fy7ZLpHsXqiO8C4+OuMfaRBAfcQ0z7Yt2FW9GEgYyFtFd92IOBFl0JRJ7yGiNl
	 6lMZua5FZ/T9DafgnmffwOtKy/r+MFi11W030lAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCHMzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfCHMzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:55:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDB32085A;
        Fri,  8 Mar 2019 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049716;
        bh=E93aChJlTgxlKNZlKxwrG0y+LaXLDVu8i9E4LKqev74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2COVQm+F4GQ8HWVcueEUhwaq1nbX5EerinU8h4/UZsyOZgorBXOWvhzbvkHRx21/O
         KBTGWjRnggob5LflIyBT2TVNsgd6lYWsDe2OyEWsf1RWATwpTqzoqXmsQXXFhiiw6F
         TyWsLLZyfaoOSI/viiP/FJkqQE37nzJcjXGeR3e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 42/76] net: sit: fix memory leak in sit_init_net()
Date:   Fri,  8 Mar 2019 13:49:54 +0100
Message-Id: <20190308124916.307231587@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 07f12b26e21ab359261bf75cfcb424fdc7daeb6d ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1873,6 +1873,7 @@ static int __net_init sit_init_net(struc
 
 err_reg_dev:
 	ipip6_dev_free(sitn->fb_tunnel_dev);
+	free_netdev(sitn->fb_tunnel_dev);
 err_alloc_dev:
 	return err;
 }


