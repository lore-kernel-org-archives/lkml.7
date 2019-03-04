Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9285C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B10920863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 05:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCDFLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 00:11:40 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDFLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 00:11:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E3F5E14D08EAE;
        Sun,  3 Mar 2019 21:11:38 -0800 (PST)
Date:   Sun, 03 Mar 2019 21:11:38 -0800 (PST)
Message-Id: <20190303.211138.716041126888537580.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     idosch@mellanox.com, alexander.h.duyck@intel.com,
        tyhicks@canonical.com, f.fainelli@gmail.com, therbert@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net-sysfs: Fix mem leak in netdev_register_kobject
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190302023455.27732-1-yuehaibing@huawei.com>
References: <20190302023455.27732-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Mar 2019 21:11:39 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>
Date: Sat, 2 Mar 2019 10:34:55 +0800

> From: YueHaibing <yuehaibing@huawei.com>
> 
> syzkaller report this:
> BUG: memory leak
> unreferenced object 0xffff88837a71a500 (size 256):
>   comm "syz-executor.2", pid 9770, jiffies 4297825125 (age 17.843s)
>   hex dump (first 32 bytes):
>     00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>     ff ff ff ff ff ff ff ff 20 c0 ef 86 ff ff ff ff  ........ .......
>   backtrace:
>     [<00000000db12624b>] netdev_register_kobject+0x124/0x2e0 net/core/net-sysfs.c:1751
>     [<00000000dc49a994>] register_netdevice+0xcc1/0x1270 net/core/dev.c:8516
>     [<00000000e5f3fea0>] tun_set_iff drivers/net/tun.c:2649 [inline]
>     [<00000000e5f3fea0>] __tun_chr_ioctl+0x2218/0x3d20 drivers/net/tun.c:2883
>     [<000000001b8ac127>] vfs_ioctl fs/ioctl.c:46 [inline]
>     [<000000001b8ac127>] do_vfs_ioctl+0x1a5/0x10e0 fs/ioctl.c:690
>     [<0000000079b269f8>] ksys_ioctl+0x89/0xa0 fs/ioctl.c:705
>     [<00000000de649beb>] __do_sys_ioctl fs/ioctl.c:712 [inline]
>     [<00000000de649beb>] __se_sys_ioctl fs/ioctl.c:710 [inline]
>     [<00000000de649beb>] __x64_sys_ioctl+0x74/0xb0 fs/ioctl.c:710
>     [<000000007ebded1e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
>     [<00000000db315d36>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<00000000115be9bb>] 0xffffffffffffffff
> 
> It should call kset_unregister to free 'dev->queues_kset'
> in error path of register_queue_kobjects, otherwise will cause a mem leak.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1d24eb4815d1 ("xps: Transmit Packet Steering")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Wow, what an ancient bug.

Applied and queued up for -stable, thanks.
