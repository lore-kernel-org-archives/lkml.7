Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B09C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EFE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3J/Eshk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfC0HQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:16:58 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44388 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0HQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:16:58 -0400
Received: by mail-yw1-f67.google.com with SMTP id c4so11737682ywa.11;
        Wed, 27 Mar 2019 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0jhnaae4SF4uhAFZzVW53Bwcx/p2H/AczuOHSK34OA=;
        b=Z3J/EshkaWMC6hn/dBoxNhbLkEksTbsuBHgdvJNGjKWK8+hu/3xAMMMvEePyO/FTqC
         /1iFH+h8jf57ux4IY6fGUXEUoCWG91c/5M+mJnOTJEqBWCGyOL867oO2I9zxoBp7O0Ar
         /opL94anX0VEq2EK4szG2LWnL9RET/FX4p5NdzZ/R/VXnoMmXmI1N/5zoDLcOFIWNKHR
         rgAqlzm/krX/kRgSDx83WMjpJ0OWlIPcRfTaMj+ld7LpA+H0qrw+btu/RFgjJ4EdzSRe
         hGYXlnhgjQoNY3iPE/dW0igBJpcdIJkct1WWGdHCbMWVIJyughYc4SrnnN1aAfzWSpzs
         5vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0jhnaae4SF4uhAFZzVW53Bwcx/p2H/AczuOHSK34OA=;
        b=mgc+GcHZ6XuRxVlI2n+pC3D1itMKqh6zlW5marSYdREqRWFcpXnwPqTg+fFRmfDqaz
         HNIWSYPv0oT5T13cdUiqQFL89fSaCDyc71fC6P57TQp66M7FQNPkS0DVoxiUphal7cRQ
         qJueJ+hOc9t0tFfXfL5dJibm0seU+RjApATYl5grWb5sizlhNyRlfBATJQ3L/wbNQ5qR
         EUaJI3S16rlNkgSO8YTlFGZS317ytQO6iqqOs9EPKp29eOB1ooyDs/v903KAbJ9h7fF3
         MVHWuBKnH0F12UMhxZ3qwSwbG1741n7d9+TNLzPM+Qb2JacIKebbzV2aBFSbiUgk3jM2
         m5Kg==
X-Gm-Message-State: APjAAAV50hxhaXKbo5QQMg2Vpqe7X2Xd0clzxANEW8ClwquHWR0Fc4kt
        kDiUctPvv9hGOLsLFTnVutZvuqRQE6JSm1v8k1E=
X-Google-Smtp-Source: APXvYqz98OApVTD53gRgX0o7c9EbvRxYNJw1FCtt8+hxEvmwC7i3BA57LtjclzZU9rDSwfd333gBozxubqcWQzcv0eE=
X-Received: by 2002:a81:1150:: with SMTP id 77mr16411615ywr.241.1553671016885;
 Wed, 27 Mar 2019 00:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007dedf00576dd53eb@google.com> <000000000000c51f7505850b5f3e@google.com>
In-Reply-To: <000000000000c51f7505850b5f3e@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Mar 2019 09:16:45 +0200
Message-ID: <CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX+g@mail.gmail.com>
Subject: Re: possible deadlock in acct_pin_kill
To:     syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mark.rutland@arm.com, Miklos Szeredi <mszeredi@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, paulmck@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 5:53 AM syzbot
<syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit e950564b97fd0f541b02eb207685d0746f5ecf29
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Tue Jul 24 13:01:55 2018 +0000
>
>      vfs: don't evict uninitialized inode
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12123143200000
> start commit:   da5322e6 Merge tag 'selinux-pr-20181115' of git://git.kern..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11123143200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16123143200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12298533400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff545d400000
>
> Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
> Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The repro seems fine for catching the subject bug, but I can't get it
to reproduce on my system. I have written a simpler reliable repro.
Its in the commit message of the patch to test below:

#syz test: https://github.com/amir73il/linux.git acct_pin_kill_deadlock

I have been pinging Al about the fix above for a while, but no response:

https://marc.info/?l=linux-fsdevel&m=155119096826039&w=2

However! the bisection did not lead the subject bug, it lead to another
and IMO the bisected commit has nothing to do with the subject bug:

[   95.294877] list_add double add: new=ffff8801b47ebbd0,
prev=ffff8801b99ad438, next=ffff8801b47ebbd0.
[   95.304706] ------------[ cut here ]------------
[   95.309467] kernel BUG at lib/list_debug.c:31!
[   95.314361] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[   95.319735] CPU: 0 PID: 7172 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #1
[   95.326823] Hardware name: Google Google Compute Engine/Google
Compute Engine, BIOS Google 01/01/2011
[   95.336194] RIP: 0010:__list_add_valid+0xaa/0xb0
[   95.340942] Code: e8 eb a9 48 89 f7 48 89 75 e8 e8 91 9a 4c fe 48
8b 75 e8 eb bb 48 89 f2 48 89 d9 4c 89 e6 48 c7 c7 00 70 fd 87 e8 55
ff f7 fd <0f> 0b 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5
41 55
[   95.360083] RSP: 0018:ffff8801b9407188 EFLAGS: 00010282
[   95.365438] RAX: 0000000000000058 RBX: ffff8801b47ebbd0 RCX: 0000000000000000
[   95.372717] RDX: 0000000000000000 RSI: ffffffff87fd6dc0 RDI: ffffffff8a9fc860
[   95.380010] RBP: ffff8801b94071a0 R08: ffffed003b584f99 R09: ffffed003b584f98
[   95.387275] R10: ffffed003b584f98 R11: ffff8801dac27cc7 R12: ffff8801b47ebbd0
[   95.394536] R13: ffff8801b47ebbd0 R14: ffff8801b47eba48 R15: ffff8801b9407228
[   95.401813] FS:  00007f81e0a32700(0000) GS:ffff8801dac00000(0000)
knlGS:0000000000000000
[   95.410029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.415910] CR2: 00000000004cc248 CR3: 00000001bf3dd000 CR4: 00000000001406f0
[   95.423171] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   95.430519] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   95.437781] Call Trace:
[   95.440363]  ? _raw_spin_lock+0x35/0x40
[   95.444330]  inode_sb_list_add+0xff/0x380
[   95.448470]  ? evict_inodes+0x560/0x560
[   95.452448]  ? kasan_check_write+0x14/0x20
[   95.456755]  ? do_raw_spin_lock+0xc1/0x200
[   95.460984]  inode_insert5+0x305/0x540
