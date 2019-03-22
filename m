Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C30C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDFA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254507;
	bh=e/8o4GHAaTWKznl0OA9ApGk9R9yq5ESvmkeaOBrxqNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VaO8PuHMsNE0qIodY6gW+q/oOPI+bi979koWgJOlbziyrkeEZPafQM4EF2mA2oFLM
	 l9oVGoqR5xoy/J/5HQt9nlx9kl27La+1YFXK7LepNrWyEL+2Q+XAOoRlEIJPZKM4CR
	 nq0Wntq0AslsSYzlg/oiyCStRSbJkWpWvYoKsAuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfCVLfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbfCVLfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF792183E;
        Fri, 22 Mar 2019 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254501;
        bh=e/8o4GHAaTWKznl0OA9ApGk9R9yq5ESvmkeaOBrxqNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=my9FrRfaCV8ZPs9HakM5Nyu3O9GxeXe6zTJkqateoONh0+zBa/uZv4OBC71wK72L1
         qZAG75zuRLMOc8cT57wuphF52D3Z5BCMHdgqnCqAeQLD1HdyqJ0X+s3RbHHp26Xchr
         lz7MC0OqI0o8LIb1tWJmvec+W+MRf9l2hqnhLXWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 137/230] mdio_bus: Fix use-after-free on device_register fails
Date:   Fri, 22 Mar 2019 12:14:35 +0100
Message-Id: <20190322111246.288595535@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 6ff7b060535e87c2ae14dd8548512abfdda528fb ]

KASAN has found use-after-free in fixed_mdio_bus_init,
commit 0c692d07842a ("drivers/net/phy/mdio_bus.c: call
put_device on device_register() failure") call put_device()
while device_register() fails,give up the last reference
to the device and allow mdiobus_release to be executed
,kfreeing the bus. However in most drives, mdiobus_free
be called to free the bus while mdiobus_register fails.
use-after-free occurs when access bus again, this patch
revert it to let mdiobus_free free the bus.

KASAN report details as below:

BUG: KASAN: use-after-free in mdiobus_free+0x85/0x90 drivers/net/phy/mdio_bus.c:482
Read of size 4 at addr ffff8881dc824d78 by task syz-executor.0/3524

CPU: 1 PID: 3524 Comm: syz-executor.0 Not tainted 5.0.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xfa/0x1ce lib/dump_stack.c:113
 print_address_description+0x65/0x270 mm/kasan/report.c:187
 kasan_report+0x149/0x18d mm/kasan/report.c:317
 mdiobus_free+0x85/0x90 drivers/net/phy/mdio_bus.c:482
 fixed_mdio_bus_init+0x283/0x1000 [fixed_phy]
 ? 0xffffffffc0e40000
 ? 0xffffffffc0e40000
 ? 0xffffffffc0e40000
 do_one_initcall+0xfa/0x5ca init/main.c:887
 do_init_module+0x204/0x5f6 kernel/module.c:3460
 load_module+0x66b2/0x8570 kernel/module.c:3808
 __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
 do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6215c19c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f6215c19c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6215c1a6bc
R13: 00000000004bcefb R14: 00000000006f7030 R15: 0000000000000004

Allocated by task 3524:
 set_track mm/kasan/common.c:85 [inline]
 __kasan_kmalloc.constprop.3+0xa0/0xd0 mm/kasan/common.c:496
 kmalloc include/linux/slab.h:545 [inline]
 kzalloc include/linux/slab.h:740 [inline]
 mdiobus_alloc_size+0x54/0x1b0 drivers/net/phy/mdio_bus.c:143
 fixed_mdio_bus_init+0x163/0x1000 [fixed_phy]
 do_one_initcall+0xfa/0x5ca init/main.c:887
 do_init_module+0x204/0x5f6 kernel/module.c:3460
 load_module+0x66b2/0x8570 kernel/module.c:3808
 __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
 do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 3524:
 set_track mm/kasan/common.c:85 [inline]
 __kasan_slab_free+0x130/0x180 mm/kasan/common.c:458
 slab_free_hook mm/slub.c:1409 [inline]
 slab_free_freelist_hook mm/slub.c:1436 [inline]
 slab_free mm/slub.c:2986 [inline]
 kfree+0xe1/0x270 mm/slub.c:3938
 device_release+0x78/0x200 drivers/base/core.c:919
 kobject_cleanup lib/kobject.c:662 [inline]
 kobject_release lib/kobject.c:691 [inline]
 kref_put include/linux/kref.h:67 [inline]
 kobject_put+0x146/0x240 lib/kobject.c:708
 put_device+0x1c/0x30 drivers/base/core.c:2060
 __mdiobus_register+0x483/0x560 drivers/net/phy/mdio_bus.c:382
 fixed_mdio_bus_init+0x26b/0x1000 [fixed_phy]
 do_one_initcall+0xfa/0x5ca init/main.c:887
 do_init_module+0x204/0x5f6 kernel/module.c:3460
 load_module+0x66b2/0x8570 kernel/module.c:3808
 __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
 do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881dc824c80
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 248 bytes inside of
 2048-byte region [ffff8881dc824c80, ffff8881dc825480)
The buggy address belongs to the page:
page:ffffea0007720800 count:1 mapcount:0 mapping:ffff8881f6c02800 index:0x0 compound_mapcount: 0
flags: 0x2fffc0000010200(slab|head)
raw: 02fffc0000010200 0000000000000000 0000000500000001 ffff8881f6c02800
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881dc824c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881dc824c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8881dc824d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff8881dc824d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881dc824e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: 0c692d07842a ("drivers/net/phy/mdio_bus.c: call put_device on device_register() failure")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio_bus.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -267,7 +267,6 @@ int __mdiobus_register(struct mii_bus *b
 	err = device_register(&bus->dev);
 	if (err) {
 		pr_err("mii_bus %s failed to register\n", bus->id);
-		put_device(&bus->dev);
 		return -EINVAL;
 	}
 


