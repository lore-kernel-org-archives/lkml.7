Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA6C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E962082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9cdcCHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDIN6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:58:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39577 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfDIN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:57:59 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so4999019ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnNblYSNAiB2DbIDnr9J/eQ0EiGpohJWQg05spCDaJ0=;
        b=p9cdcCHkQIDkseLfuGd2PpCDSeDsojmICQfEj4H59fgcBz6LSVwcAJ4NkOjKIx7ssV
         TiAS7/qCGmGfloxkG01wCauUqpNdjurM1U7AlCFd9M7wehQA2Yd5FmBUQmwjOY8OhaeA
         RJZNRcwcVgImrPaPIguqHFKgw/zf/eQyXAeMjkX6Bd6CQbDv8G+0ylixLQYVWUyuprei
         FXm/W4T3IhBQXgkN57IRaOkaVDJxPSaWTIBKqw+xgOZA5KSM+YPIVnxAWUDbsY2Pk58U
         ZAVoPW73Ej/ztqT6I69qV+Z/PebKHWUDK1oPDs6ei/GPNw5owrhDrbDZ+A+wBaW/GCc6
         6MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnNblYSNAiB2DbIDnr9J/eQ0EiGpohJWQg05spCDaJ0=;
        b=QRoVB2jEmiQfAC/EtjJnh+9deAWV/gYxkvOWzIqv0UMUausY7NY+1M7UETiHhnF9BC
         ipgk+RzpxyiWgt9zt7uMwATjR7cg8RAiEWPNOheS3wExn3VRICEPJUTqhcA00I312dF6
         48ME9cRkBUvgbDAyt1SZ/De3O0MLGYxQbC4+BNcw4wzi75YbFdyLRtqiY3SSqFXk2z94
         pfj5DIcBx8bsLacTe/nWc+IeZjqMB8XIiLetkD++tTbMySXoDjORk6KfVQtcnlYqHHit
         rOCFDMuAZEwUfY0WysPW0pIu63/25h1ASTpe909SSu+gkcgb1c9u+o+6Y5lPct/fiYro
         eAyA==
X-Gm-Message-State: APjAAAWXj9GZbu4J7JQjfeFcmaJSmvwD3GQ6Z1F9GtYyJGP5JgIfxOkR
        VBA09533JpE1abUoy39oN87qiLRAK3Jaj8a0GHyATQ==
X-Google-Smtp-Source: APXvYqzwpgwNKFknrbaasWqgRWV66JNiaeCalgpnCaWLJqq8cysV4VYp2z2yAD2tDsAkfQOumSR3G/kKBpQxlWK9Q3k=
X-Received: by 2002:a02:7654:: with SMTP id z81mr25646819jab.79.1554818278018;
 Tue, 09 Apr 2019 06:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000396c09057a17b6fd@google.com> <0000000000008a1687057acbb692@google.com>
In-Reply-To: <0000000000008a1687057acbb692@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Apr 2019 15:57:45 +0200
Message-ID: <CACT4Y+bLW_qunREOz6NN_0eN5B_4iw+Cu3Sg2vLxOK3ktekkqA@mail.gmail.com>
Subject: Re: general protection fault in rdma_listen (2)
To:     syzbot <syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com>,
        markb@mellanox.com
Cc:     danielj@mellanox.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        parav@mellanox.com, swise@opengridcomputing.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 6:44 PM syzbot
<syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    da5322e65940 Merge tag 'selinux-pr-20181115' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a06f7b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b46b135602a3f3ac99e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fa8a47400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com
>
> IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> 8021q: adding VLAN 0 to HW filter on device team0
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 6328 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #337
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:cma_bind_listen drivers/infiniband/core/cma.c:3355 [inline]
> RIP: 0010:rdma_listen+0x357/0x990 drivers/infiniband/core/cma.c:3469
> Code: 4c 8b ab c8 01 00 00 31 f6 48 c7 c7 60 3b db 89 e8 9e eb 25 02 48 b8
> 00 00 00 00 00 fc ff df 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 64 05 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff8881b266f970 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff8881ba9a6d80 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
> RBP: ffff8881b266fa10 R08: fffffbfff13b6775 R09: fffffbfff13b6774
> R10: ffff8881b266f960 R11: ffffffff89db3ba3 R12: 1ffff110364cdf31
> R13: 0000000000000000 R14: 0000000000000003 R15: ffff8881d908fa80
> FS:  00007f22f9e27700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004cef08 CR3: 00000001ba4b4000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ucma_listen+0x1a4/0x260 drivers/infiniband/core/ucma.c:1100
>   ucma_write+0x365/0x460 drivers/infiniband/core/ucma.c:1689
>   __vfs_write+0x119/0x9f0 fs/read_write.c:485
>   vfs_write+0x1fc/0x560 fs/read_write.c:549
>   ksys_write+0x101/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f22f9e26c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
> RDX: 0000000000000010 RSI: 00000000200000c0 RDI: 0000000000000005
> RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f22f9e276d4
> R13: 00000000004c571f R14: 00000000004d9360 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace ad276a0bcb316fb3 ]---
> RIP: 0010:cma_bind_listen drivers/infiniband/core/cma.c:3355 [inline]
> RIP: 0010:rdma_listen+0x357/0x990 drivers/infiniband/core/cma.c:3469
> Code: 4c 8b ab c8 01 00 00 31 f6 48 c7 c7 60 3b db 89 e8 9e eb 25 02 48 b8
> 00 00 00 00 00 fc ff df 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 64 05 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffff8881b266f970 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff8881ba9a6d80 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
> RBP: ffff8881b266fa10 R08: fffffbfff13b6775 R09: fffffbfff13b6774
> R10: ffff8881b266f960 R11: ffffffff89db3ba3 R12: 1ffff110364cdf31
> R13: 0000000000000000 R14: 0000000000000003 R15: ffff8881d908fa80
> FS:  00007f22f9e27700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 00000001ba4b4000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Hi Mark,

You tested some fixed for this bug. The latest tested patch did not
trigger crash. Bug syzbot never seen any fixes for this bug. If you
submitted the patch, please mark this bug as fixed.

Thanks
