Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44637C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CF8208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049668;
	bh=Oot358UrS/hFIEs7qVrO8hZa29+fUQ0fJRWk9ZdfY3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RGg/DKnd4m+djpEA2YqZTKkViGHAhhfirCfx4Yk93UL1T1l5gl6qESRivFK0KPpdN
	 ja6LguwnZ7ZVN7xpQypQM3s5rvzZw9v8Tb0O0B5tv0sze6arCPO6aaTOKZzneUYwTe
	 Rjrdg3cJGwyz0j4WHmpzQN8+E/z2Y5lRr+P6j6mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCHMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfCHMyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590B220449;
        Fri,  8 Mar 2019 12:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049661;
        bh=Oot358UrS/hFIEs7qVrO8hZa29+fUQ0fJRWk9ZdfY3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hr8pBBflQSKPiaEf+I6tHidWgZptITuuELzyYwQbfR83myetIUWRM5OdRuZVL7WVD
         vSITahbIeoDnQtzJWY9d4gx86jwLlkjpVWtXnWhCrRkxCo0xPEbwdEukRXguySV95Z
         uRe9i9PAR8hLNa/xbb4WjU9wGuJ3iU+hnxfCMUv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 24/76] net-sysfs: Fix mem leak in netdev_register_kobject
Date:   Fri,  8 Mar 2019 13:49:36 +0100
Message-Id: <20190308124915.635165578@linuxfoundation.org>
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
 


