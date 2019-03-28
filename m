Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE389C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5B92054F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnzhH1wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfC1IX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:23:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37368 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfC1IX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:23:58 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so4675901itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1rOXQSSlfEBZ/4K596p074WBf2SRpvMHjSn1MzoOt4=;
        b=lnzhH1wDZnJLIW2IPoZ+XN3ezLdm7STlfuB0IJgMAXSnm0zPhOukoulkWWTEAzdy2I
         uaWHQfgq3b67Tg6p7p3x2UaIUU/iqMTIP33P4qK2GyDzG6mg9TdIuj0QySo5DDGJCAdi
         Li0a1HSgMPz0Nuf6qyjWEycQjcjq9rTKGBFuhzCpsGiKRiYujhdlyJq5Vc2zjpz+XSLa
         AXeAWDL2moVClF94C313/CCFV6UEkiHN480VHo1p2qnx9xFLcmqLjr3TB1u3nJESV2FW
         tev7GFtlMqdNaojnSz1ADzvWo90lX3De6Y16hUs5MI4CAOWZJ1mS4Q6haVXq6egSt888
         eAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1rOXQSSlfEBZ/4K596p074WBf2SRpvMHjSn1MzoOt4=;
        b=S2pff+REsQx3Ft7YeCheSmt/FoP25WsTGNUm/ERQHHdjnRaC/acGLwHqh8wKEJG8RJ
         J0xOa0RMzSONANLfI94NpV7dO2VUP8bt55QZEzNvD5S3ANz+HG6H3LLtHCtzy0OjIJzH
         LqwHAvyTHVhXL6r+Sx2TkOsBsr6UIzPXnK34Co+hfnkSv6ltgXg7IHtxGnK80R8NQRZ5
         9m/ygXYyoD8ey+J9wKAW/lrithamJA+vSxESMJ6eq5IfVGdJEfY8gP1VwdW/eiqwgHBF
         qFOjUtlxWKbguc0MGrrIJX8gjCDFx75iH0DuKfh2cJD86A/HCjMzVEeFwGRHv2mlo/xZ
         mp4w==
X-Gm-Message-State: APjAAAXHjYjKV1auLO5+s7DAfNw1k3NNs1M1Sl/z93vyKUexplS/QLmv
        OVQe//7Q7ZDDLrUBhbKP3rjm95aH2gXRl/uMNpRJpQ==
X-Google-Smtp-Source: APXvYqxm9YMVHa1uudHDdp0/+xjYiwRxoN/1ZQYS6v+kHekt4ZD1C7DQ91UX4Kcfsj5iSTCyV79+pH720Z1AfuFb4Bg=
X-Received: by 2002:a24:3281:: with SMTP id j123mr6499256ita.166.1553761436473;
 Thu, 28 Mar 2019 01:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007dedf00576dd53eb@google.com> <000000000000c51f7505850b5f3e@google.com>
 <CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX+g@mail.gmail.com>
In-Reply-To: <CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX+g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Mar 2019 09:23:45 +0100
Message-ID: <CACT4Y+bXB06ZAdvwsdgsNvscOUBemH7C_G-ojKirGVeGefCWpQ@mail.gmail.com>
Subject: Re: possible deadlock in acct_pin_kill
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:16 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Mar 27, 2019 at 5:53 AM syzbot
> <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit e950564b97fd0f541b02eb207685d0746f5ecf29
> > Author: Miklos Szeredi <mszeredi@redhat.com>
> > Date:   Tue Jul 24 13:01:55 2018 +0000
> >
> >      vfs: don't evict uninitialized inode
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12123143200000
> > start commit:   da5322e6 Merge tag 'selinux-pr-20181115' of git://git.kern..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11123143200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16123143200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12298533400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff545d400000
> >
> > Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
> > Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> The repro seems fine for catching the subject bug, but I can't get it
> to reproduce on my system. I have written a simpler reliable repro.
> Its in the commit message of the patch to test below:
>
> #syz test: https://github.com/amir73il/linux.git acct_pin_kill_deadlock
>
> I have been pinging Al about the fix above for a while, but no response:
>
> https://marc.info/?l=linux-fsdevel&m=155119096826039&w=2

I would ping it as well, but I can't find it in my inbox. Is it on LKML?

> However! the bisection did not lead the subject bug, it lead to another
> and IMO the bisected commit has nothing to do with the subject bug:

Agree. I've included it into the big bisection analysis as "inference
of other kernel bugs" case:
https://lkml.org/lkml/2019/3/27/788


> [   95.294877] list_add double add: new=ffff8801b47ebbd0,
> prev=ffff8801b99ad438, next=ffff8801b47ebbd0.
> [   95.304706] ------------[ cut here ]------------
> [   95.309467] kernel BUG at lib/list_debug.c:31!
> [   95.314361] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [   95.319735] CPU: 0 PID: 7172 Comm: syz-executor0 Not tainted 4.18.0-rc1+ #1
> [   95.326823] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 01/01/2011
> [   95.336194] RIP: 0010:__list_add_valid+0xaa/0xb0
> [   95.340942] Code: e8 eb a9 48 89 f7 48 89 75 e8 e8 91 9a 4c fe 48
> 8b 75 e8 eb bb 48 89 f2 48 89 d9 4c 89 e6 48 c7 c7 00 70 fd 87 e8 55
> ff f7 fd <0f> 0b 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5
> 41 55
> [   95.360083] RSP: 0018:ffff8801b9407188 EFLAGS: 00010282
> [   95.365438] RAX: 0000000000000058 RBX: ffff8801b47ebbd0 RCX: 0000000000000000
> [   95.372717] RDX: 0000000000000000 RSI: ffffffff87fd6dc0 RDI: ffffffff8a9fc860
> [   95.380010] RBP: ffff8801b94071a0 R08: ffffed003b584f99 R09: ffffed003b584f98
> [   95.387275] R10: ffffed003b584f98 R11: ffff8801dac27cc7 R12: ffff8801b47ebbd0
> [   95.394536] R13: ffff8801b47ebbd0 R14: ffff8801b47eba48 R15: ffff8801b9407228
> [   95.401813] FS:  00007f81e0a32700(0000) GS:ffff8801dac00000(0000)
> knlGS:0000000000000000
> [   95.410029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   95.415910] CR2: 00000000004cc248 CR3: 00000001bf3dd000 CR4: 00000000001406f0
> [   95.423171] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   95.430519] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   95.437781] Call Trace:
> [   95.440363]  ? _raw_spin_lock+0x35/0x40
> [   95.444330]  inode_sb_list_add+0xff/0x380
> [   95.448470]  ? evict_inodes+0x560/0x560
> [   95.452448]  ? kasan_check_write+0x14/0x20
> [   95.456755]  ? do_raw_spin_lock+0xc1/0x200
> [   95.460984]  inode_insert5+0x305/0x540
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX%2Bg%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.
