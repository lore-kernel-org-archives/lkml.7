Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCE020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049889;
	bh=lim4Oj3ZY5dUMUEAG0MvNIfe82k9BuYrwzTE80Crq+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dony2PYtvVQiC2tQKCHHM1wzY8zTzsFsIECqetVoUSBQLBLq/wFXMz11WpB7MQ7Zl
	 9GPLTwPJWhHagKvIDbaq9iT/Q6DWA1orJaQQHuKtLCi1uB1gzxpghqUPCSiLQtgW8H
	 ZAocKQKBj9edalqvipb0NBMqZzgDDJqLc+LC2AYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfCHM6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfCHM6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E6A20449;
        Fri,  8 Mar 2019 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049883;
        bh=lim4Oj3ZY5dUMUEAG0MvNIfe82k9BuYrwzTE80Crq+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j87qgSvAlWW9z3ytM0JzIk4IVh8cWhm+9VUgD3hSmieSi5n6f05ncbQIIVmsT+N+q
         X3YGcnYUg1De90/5isXXgnh7u52vhP70/jXgywr4g4eLSg7uGu8DaUScQCbOcj+1c5
         lFO4mLvqr32b1wrY0MYU3ARaoEZkABnVw+gC/iIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 17/68] net-sysfs: Fix mem leak in netdev_register_kobject
Date:   Fri,  8 Mar 2019 13:49:47 +0100
Message-Id: <20190308124911.690040226@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 895a5e96dbd6386c8e78e5b78e067dcc67b7f0ab ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net-sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1547,6 +1547,9 @@ static int register_queue_kobjects(struc
 error:
 	netdev_queue_update_kobjects(dev, txq, 0);
 	net_rx_queue_update_kobjects(dev, rxq, 0);
+#ifdef CONFIG_SYSFS
+	kset_unregister(dev->queues_kset);
+#endif
 	return error;
 }
 


