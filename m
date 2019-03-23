Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E6C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FBC218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfCWRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:16:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:52771 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfCWRQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:16:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Mar 2019 10:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="143231430"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2019 10:16:22 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h7kFp-0000dF-7T; Sat, 23 Mar 2019 19:16:21 +0200
Date:   Sat, 23 Mar 2019 19:16:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com>
Cc:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        f.fainelli@gmail.com, idosch@mellanox.com, joe@perches.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stephen@networkplumber.org, syzkaller-bugs@googlegroups.com,
        tyhicks@canonical.com, wanghai26@huawei.com, yuehaibing@huawei.com
Subject: Re: kernel BUG at net/core/net-sysfs.c:LINE!
Message-ID: <20190323171621.GF9224@smile.fi.intel.com>
References: <000000000000e644ba0584bdf7e8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e644ba0584bdf7e8@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 12:32:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e382d91f Add linux-next specific files for 20190322
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1737671b200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d850e8b394c7a19
> dashboard link: https://syzkaller.appspot.com/bug?extid=6024817a931b2830bc93
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1795613b200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f5a437200000
> 
> The bug was bisected to:
> 
> commit 6b70fc94afd165342876e53fc4b2f7d085009945
> Author: Wang Hai <wanghai26@huawei.com>
> Date:   Wed Mar 20 18:25:05 2019 +0000
> 
>     net-sysfs: Fix memory leak in netdev_register_kobject

Nice.

I looked briefly in the flow of this report and it looks like the patch above
should be reverted.

The problem is not so easy to fix. One approach is to initialize device
(and thus kobject) somewhere in alloc_netdev() and put device in free_netdev()
respectively, but this might produce more interesting regressions.

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1522556d200000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1722556d200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1322556d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6024817a931b2830bc93@syzkaller.appspotmail.com
> Fixes: 6b70fc94afd1 ("net-sysfs: Fix memory leak in
> netdev_register_kobject")
> 
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441399
> RDX: 0000000020000080 RSI: 00000000000089f1 RDI: 0000000000000006
> RBP: 00007ffcd20666d0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000007 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> kernel BUG at net/core/net-sysfs.c:1631!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 8035 Comm: syz-executor344 Not tainted 5.1.0-rc1-next-20190322
> #9
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:netdev_release net/core/net-sysfs.c:1631 [inline]
> RIP: 0010:netdev_release+0x92/0xb0 net/core/net-sysfs.c:1627
> Code: 48 c1 ea 03 80 3c 02 00 75 29 48 8b bb 80 fa ff ff e8 12 77 20 fc 4c
> 89 ef e8 7a cc f5 ff 5b 41 5c 41 5d 5d c3 e8 9e 9b e8 fb <0f> 0b e8 27 b1 20
> fc eb 9c e8 80 b1 20 fc eb d0 0f 1f 40 00 66 2e
> RSP: 0018:ffff88808d6af718 EFLAGS: 00010293
> RAX: ffff8880a87902c0 RBX: ffff88808e3612a0 RCX: ffffffff8587fc89
> RDX: 0000000000000000 RSI: ffffffff8587fcd2 RDI: 0000000000000001
> RBP: ffff88808d6af730 R08: ffff8880a87902c0 R09: ffff8880a8790b60
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff88808e360d00 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000001752880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000098da2000 CR4: 00000000001406e0
> Call Trace:
>  device_release+0x7d/0x210 drivers/base/core.c:1064
>  kobject_cleanup lib/kobject.c:662 [inline]
>  kobject_release lib/kobject.c:691 [inline]
>  kref_put include/linux/kref.h:67 [inline]
>  kobject_put.cold+0x28f/0x2ec lib/kobject.c:708
>  put_device+0x20/0x30 drivers/base/core.c:2205
>  netdev_register_kobject+0x1a1/0x3c0 net/core/net-sysfs.c:1763
>  register_netdevice+0x878/0xff0 net/core/dev.c:8709
>  ip6_tnl_create2+0x1c2/0x350 net/ipv6/ip6_tunnel.c:269
>  ip6_tnl_create net/ipv6/ip6_tunnel.c:320 [inline]
>  ip6_tnl_locate+0x63f/0x8d0 net/ipv6/ip6_tunnel.c:368
>  ip6_tnl_ioctl+0x490/0xab0 net/ipv6/ip6_tunnel.c:1634
>  dev_ifsioc+0x257/0x990 net/core/dev_ioctl.c:322
>  dev_ioctl+0x286/0xc90 net/core/dev_ioctl.c:513
>  sock_ioctl+0x48b/0x610 net/socket.c:1102
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:509 [inline]
>  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
>  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
>  __do_sys_ioctl fs/ioctl.c:720 [inline]
>  __se_sys_ioctl fs/ioctl.c:718 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x441399
> Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcd20666b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441399
> RDX: 0000000020000080 RSI: 00000000000089f1 RDI: 0000000000000006
> RBP: 00007ffcd20666d0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000007 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 0dbf190846958075 ]---
> RIP: 0010:netdev_release net/core/net-sysfs.c:1631 [inline]
> RIP: 0010:netdev_release+0x92/0xb0 net/core/net-sysfs.c:1627
> Code: 48 c1 ea 03 80 3c 02 00 75 29 48 8b bb 80 fa ff ff e8 12 77 20 fc 4c
> 89 ef e8 7a cc f5 ff 5b 41 5c 41 5d 5d c3 e8 9e 9b e8 fb <0f> 0b e8 27 b1 20
> fc eb 9c e8 80 b1 20 fc eb d0 0f 1f 40 00 66 2e
> RSP: 0018:ffff88808d6af718 EFLAGS: 00010293
> RAX: ffff8880a87902c0 RBX: ffff88808e3612a0 RCX: ffffffff8587fc89
> RDX: 0000000000000000 RSI: ffffffff8587fcd2 RDI: 0000000000000001
> RBP: ffff88808d6af730 R08: ffff8880a87902c0 R09: ffff8880a8790b60
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff88808e360d00 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000001752880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000098da2000 CR4: 00000000001406e0
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

-- 
With Best Regards,
Andy Shevchenko


