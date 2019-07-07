Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90348C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272720651
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfGGTmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:42:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57722 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727628AbfGGTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:13 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz9-0006kM-FW; Sun, 07 Jul 2019 20:38:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz7-0005e2-AN; Sun, 07 Jul 2019 20:38:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hulk Robot" <hulkci@huawei.com>,
        "YueHaibing" <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.642678239@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 096/129] net-sysfs: Fix mem leak in netdev_register_kobject
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit 895a5e96dbd6386c8e78e5b78e067dcc67b7f0ab upstream.

syzkaller report this:
BUG: memory leak
unreferenced object 0xffff88837a71a500 (size 256):
  comm "syz-executor.2", pid 9770, jiffies 4297825125 (age 17.843s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 20 c0 ef 86 ff ff ff ff  ........ .......
  backtrace:
    [<00000000db12624b>] netdev_register_kobject+0x124/0x2e0 net/core/net-sysfs.c:1751
    [<00000000dc49a994>] register_netdevice+0xcc1/0x1270 net/core/dev.c:8516
    [<00000000e5f3fea0>] tun_set_iff drivers/net/tun.c:2649 [inline]
    [<00000000e5f3fea0>] __tun_chr_ioctl+0x2218/0x3d20 drivers/net/tun.c:2883
    [<000000001b8ac127>] vfs_ioctl fs/ioctl.c:46 [inline]
    [<000000001b8ac127>] do_vfs_ioctl+0x1a5/0x10e0 fs/ioctl.c:690
    [<0000000079b269f8>] ksys_ioctl+0x89/0xa0 fs/ioctl.c:705
    [<00000000de649beb>] __do_sys_ioctl fs/ioctl.c:712 [inline]
    [<00000000de649beb>] __se_sys_ioctl fs/ioctl.c:710 [inline]
    [<00000000de649beb>] __x64_sys_ioctl+0x74/0xb0 fs/ioctl.c:710
    [<000000007ebded1e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<00000000db315d36>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000115be9bb>] 0xffffffffffffffff

It should call kset_unregister to free 'dev->queues_kset'
in error path of register_queue_kobjects, otherwise will cause a mem leak.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: net_device pointer is called "net", confusingly]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/net-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1219,6 +1219,9 @@ static int register_queue_kobjects(struc
 error:
 	netdev_queue_update_kobjects(net, txq, 0);
 	net_rx_queue_update_kobjects(net, rxq, 0);
+#ifdef CONFIG_SYSFS
+	kset_unregister(net->queues_kset);
+#endif
 	return error;
 }
 

