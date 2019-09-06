Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AD5C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB4207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405045AbfIFXEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:04:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390944AbfIFXEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:04:34 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE125C04BD48
        for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2019 23:04:33 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id p15so1727031lfc.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oxoH+WSworCrDFgeDCI681cyvPIJ/tnGjW05hqdt5DA=;
        b=DlZJZlZNWXbmFAuvbIQyYKeeFdP74iTY43WZFVcBHh1R4KMjLfYKhoEOfliLqBOn15
         clHdH4DZKcJdcaKzkpfQ1DLV4nDGP9mhGgEAOOy4VHb+PxXSPHHAxYjUpGdi1eMNkFjV
         DOzMTTXwctNdY2jj3VrZtuah0HQzK+zB6C70GUfq7NCUlYtkfvXhJ3ERrcG8qcOUf9lA
         FiJRCTwHbwSLta/aijZ44OHyuD/U2g3NY2ZSKikrLX0oE6TlDD9neKtn5w1uCdpBPb3g
         G6HYF8d+Z+gLVIhViIjSGDzu476P3EvSd8y4xRZeJUExsQK3mI4afWmiuDgvwWpjMHo1
         4fsg==
X-Gm-Message-State: APjAAAUyBWm+Xn+/MwWGDdXC9IpMjBuK7INXxTVYVUARW0XZDnxh9OZB
        u8o4bqlrsUWm0WOK6mYyEJlv+iRfDlAhkUiH/zsQv+oey1PNfV00X9OgYebmb5vQBBCCPzDEVVw
        HvlPWldyZJeyovyr/FM5Ls0Xp
X-Received: by 2002:a2e:884d:: with SMTP id z13mr6924655ljj.62.1567811070516;
        Fri, 06 Sep 2019 16:04:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwsCIFvk5JgnR0MRQXhHrD2Joc0ZFQ3Mmb520dfURv4Nwe7K1X8zUHWhWYRqWew2CEQyRERqw==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr6924642ljj.62.1567811070259;
        Fri, 06 Sep 2019 16:04:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id k28sm1375984lfj.33.2019.09.06.16.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 16:04:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1D5D18061B; Sat,  7 Sep 2019 00:04:27 +0100 (WEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     syzbot <syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in dev_map_hash_update_elem
In-Reply-To: <20190906145408.05406b0f@carbon>
References: <0000000000005091a70591d3e1d9@google.com> <CAADnVQK94boXD8Y=g1LsBtNG4wrYQ0Jnjxhq7hdxvyBKZuPwXw@mail.gmail.com> <20190906145408.05406b0f@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 07 Sep 2019 00:04:27 +0100
Message-ID: <87woelxc04.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On Thu, 5 Sep 2019 14:44:37 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> On Thu, Sep 5, 2019 at 1:08 PM syzbot
>> <syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com> wrote:
>> >
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    6d028043 Add linux-next specific files for 20190830
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=135c1a92600000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=82a6bec43ab0cb69
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=4e7a85b1432052e8d6f8
>> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109124e1600000
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com
>> >
>> > kasan: CONFIG_KASAN_INLINE enabled
>> > kasan: GPF could be caused by NULL-ptr deref or user memory access
>> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
>> > CPU: 1 PID: 10235 Comm: syz-executor.0 Not tainted 5.3.0-rc6-next-20190830
>> > #75
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > RIP: 0010:__write_once_size include/linux/compiler.h:203 [inline]
>> > RIP: 0010:__hlist_del include/linux/list.h:795 [inline]
>> > RIP: 0010:hlist_del_rcu include/linux/rculist.h:475 [inline]
>> > RIP: 0010:__dev_map_hash_update_elem kernel/bpf/devmap.c:668 [inline]
>> > RIP: 0010:dev_map_hash_update_elem+0x3c8/0x6e0 kernel/bpf/devmap.c:691
>> > Code: 48 89 f1 48 89 75 c8 48 c1 e9 03 80 3c 11 00 0f 85 d3 02 00 00 48 b9
>> > 00 00 00 00 00 fc ff df 48 8b 53 10 48 89 d6 48 c1 ee 03 <80> 3c 0e 00 0f
>> > 85 97 02 00 00 48 85 c0 48 89 02 74 38 48 89 55 b8
>> > RSP: 0018:ffff88808d607c30 EFLAGS: 00010046
>> > RAX: 0000000000000000 RBX: ffff8880a7f14580 RCX: dffffc0000000000
>> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a7f14588
>> > RBP: ffff88808d607c78 R08: 0000000000000004 R09: ffffed1011ac0f73
>> > R10: ffffed1011ac0f72 R11: 0000000000000003 R12: ffff88809f4e9400
>> > R13: ffff88809b06ba00 R14: 0000000000000000 R15: ffff88809f4e9528
>> > FS:  00007f3a3d50c700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
>> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > CR2: 00007feb3fcd0000 CR3: 00000000986b9000 CR4: 00000000001406e0
>> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> > Call Trace:
>> >   map_update_elem+0xc82/0x10b0 kernel/bpf/syscall.c:966
>> >   __do_sys_bpf+0x8b5/0x3350 kernel/bpf/syscall.c:2854
>> >   __se_sys_bpf kernel/bpf/syscall.c:2825 [inline]
>> >   __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:2825
>> >   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > RIP: 0033:0x459879
>> > Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>> > ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> > RSP: 002b:00007f3a3d50bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459879
>> > RDX: 0000000000000020 RSI: 0000000020000040 RDI: 0000000000000002
>> > RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3a3d50c6d4
>> > R13: 00000000004bfc86 R14: 00000000004d1960 R15: 00000000ffffffff
>> > Modules linked in:
>> > ---[ end trace 083223e21dbd0ae5 ]---
>> > RIP: 0010:__write_once_size include/linux/compiler.h:203 [inline]
>> > RIP: 0010:__hlist_del include/linux/list.h:795 [inline]
>> > RIP: 0010:hlist_del_rcu include/linux/rculist.h:475 [inline]
>> > RIP: 0010:__dev_map_hash_update_elem kernel/bpf/devmap.c:668 [inline]
>> > RIP: 0010:dev_map_hash_update_elem+0x3c8/0x6e0 kernel/bpf/devmap.c:691  
>> 
>> Toke,
>> please take a look.
>> Thanks!
>
> Hi Toke,
>
> I think the problem is that you read:
>  old_dev = __dev_map_hash_lookup_elem(map, idx);
>
> Before holding the lock dtab->index_lock... 
>
> I'm not sure this is the correct fix, but I think below change should
> solve the issue (not even compile tested):
>
> [bpf-next]$ git diff
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 9af048a932b5..c41854a68e9e 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -664,6 +664,9 @@ static int __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
>  
>         spin_lock_irqsave(&dtab->index_lock, flags);
>  
> +       /* Re-read old_dev while holding lock*/
> +       old_dev = __dev_map_hash_lookup_elem(map, idx);
> +
>         if (old_dev) {
>                 hlist_del_rcu(&old_dev->index_hlist);
>         } else {

I think you're right that it's a race between reading the old_dev ptr
and the removal, leading to attempts to remove the same element twice.

Your patch would be one way to fix it, another would be to check the
pointer for list poison before removing it. Let me run both approaches
by the bot to make sure it actually fixes the bug; I'll submit a proper
fix that.

-Toke
