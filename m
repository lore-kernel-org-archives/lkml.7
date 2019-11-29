Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3CEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A967217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJJJYOkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfK2Mpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:45:46 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36030 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfK2Mpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:45:46 -0500
Received: by mail-vs1-f67.google.com with SMTP id m5so14756469vsj.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx7NQBMKWHI+Zpf0YKVppXTB13KFXEE9ItlHNJ/fMPA=;
        b=CJJJYOkM2+2YYOV4fdRlxMOkH379NhKZ7+jQYoc/ASnT2B+IrH6RANV/bq5SF+BG4r
         JGDNy3eUSNOR2rOzFwsh0uwlAUc1TPumfUIZX9GAfT3ZE+Zr+sokqBXd+HnxbKCbulNU
         5Deh+g5+NP8QHPHo60BRhC4hE1TXANuSFrECqCYgwPzB0D3YMG4axkZFWEPbsePNKPuZ
         4uhh2coEtkBGOr+loUUw40tBUo392JFvQnXZeJStGycB7WZvjilxmrBnP328Qs9hY+5P
         OrbQ5Zv4yere7oZMMVG47oMp2IYFEqLAm+2j4hoxoOYAZ/xFsM5x1McEVbVWqGjxKL/m
         t8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx7NQBMKWHI+Zpf0YKVppXTB13KFXEE9ItlHNJ/fMPA=;
        b=RoWkJaAUjzia6mra/11JfLDnfCWL80gbobRgd7J4lvh84IO0cMBhz0hXdJtpfCiZD+
         4SfkDglWXc1OfFvUlSCAjZk1eEYPCctwNclpSF9UhoiGGZnjuyVBMVgmJrG+4k0AKXcG
         tSRbeTQQQlnSKAlBBq/7prfDjARBRxs0lP1rlAExXN+5Px1ICzcS3swc++OBhqKEcyun
         wkCuODY4MxeYJUpy8IgXBAvn7dRCkXD100KIrCGALyXvidInbOViaqErafyHMJT/Aunm
         0yg/HsGYvKbdLYnySKyR1njbvOJv9GK8ptfVegSAePJjEO9Q4Dd4WtGl2TTCuF574oAQ
         W45g==
X-Gm-Message-State: APjAAAWN6gfmTDnKdfkGCkA6ioMgD/rIMtesKE8U/1bi1A615bdqPAcB
        lsNHpNTgcNf66fywuguAexlrFIqGi4T5WDwvNUHofA==
X-Google-Smtp-Source: APXvYqyo0bHa2SLxouh8P1KDxrAj0MvFE92SaV5vMig1ICXRab6UKLpefnp4wSjd44KdJbfTLRT52EHuR+Vno4bYXJI=
X-Received: by 2002:a67:5f81:: with SMTP id t123mr33094560vsb.240.1575031542911;
 Fri, 29 Nov 2019 04:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20191031093909.9228-1-dja@axtens.net> <20191031093909.9228-2-dja@axtens.net>
 <1573835765.5937.130.camel@lca.pw> <871ru5hnfh.fsf@dja-thinkpad.axtens.net>
 <952ec26a-9492-6f71-bab1-c1def887e528@virtuozzo.com> <CACT4Y+ZGO8b88fUyFe-WtV3Ubr11ChLY2mqk8YKWN9o0meNtXA@mail.gmail.com>
 <CACT4Y+Z+VhfVpkfg-WFq_kFMY=DE+9b_DCi-mCSPK-udaf_Arg@mail.gmail.com>
 <CACT4Y+Yog=PHF1SsLuoehr2rcbmfvLUW+dv7Vo+1RfdTOx7AUA@mail.gmail.com>
 <2297c356-0863-69ce-85b6-8608081295ed@virtuozzo.com> <CACT4Y+ZNAfkrE0M=eCHcmy2LhPG_kKbg4mOh54YN6Bgb4b3F5w@mail.gmail.com>
 <56cf8aab-c61b-156c-f681-d2354aed22bb@virtuozzo.com> <871rtqg91q.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <871rtqg91q.fsf@dja-thinkpad.axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 29 Nov 2019 13:45:30 +0100
Message-ID: <CACT4Y+axv26RvEUYkhnOkt+0pgdxkSiMVKYNvswSXaGsQLxg7g@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] kasan: support backing vmalloc space with real
 shadow memory
To:     Daniel Axtens <dja@axtens.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, Qian Cai <cai@lca.pw>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 1:29 PM Daniel Axtens <dja@axtens.net> wrote:
> >>> Nope, it's vm_map_ram() not being handled
> >> Another suspicious one. Related to kasan/vmalloc?
> > Very likely the same as with ion:
> >
> > # git grep vm_map_ram|grep xfs
> > fs/xfs/xfs_buf.c:                * vm_map_ram() will allocate auxiliary structures (e.g.
> > fs/xfs/xfs_buf.c:                       bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
>
> Aaargh, that's an embarassing miss.
>
> It's a bit intricate because kasan_vmalloc_populate function is
> currently set up to take a vm_struct not a vmap_area, but I'll see if I
> can get something simple out this evening - I'm away for the first part
> of next week.
>
> Do you have to do anything interesting to get it to explode with xfs? Is
> it as simple as mounting a drive and doing some I/O? Or do you need to
> do something more involved?

As simple as running syzkaller :)
with this config
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config

> Regards,
> Daniel
>
> >
> >>
> >> BUG: unable to handle page fault for address: fffff52005b80000
> >> #PF: supervisor read access in kernel mode
> >> #PF: error_code(0x0000) - not-present page
> >> PGD 7ffcd067 P4D 7ffcd067 PUD 2cd10067 PMD 66d76067 PTE 0
> >> Oops: 0000 [#1] PREEMPT SMP KASAN
> >> CPU: 2 PID: 9211 Comm: syz-executor.2 Not tainted 5.4.0-next-20191129+ #6
> >> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> >> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> >> RIP: 0010:xfs_sb_read_verify+0xe9/0x540 fs/xfs/libxfs/xfs_sb.c:691
> >> Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1e 04 00 00 4d 8b ac 24
> >> 30 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6
> >> 04 02 84 c0 74 08 3c 03 0f 8e ad 03 00 00 41 8b 45 00 bf 58
> >> RSP: 0018:ffffc9000a58f8d0 EFLAGS: 00010a06
> >> RAX: dffffc0000000000 RBX: 1ffff920014b1f1d RCX: ffffc9000af42000
> >> RDX: 1ffff92005b80000 RSI: ffffffff82914404 RDI: ffff88805cdb1460
> >> RBP: ffffc9000a58fab0 R08: ffff8880610cd380 R09: ffffed1005a87045
> >> R10: ffffed1005a87044 R11: ffff88802d438223 R12: ffff88805cdb1340
> >> R13: ffffc9002dc00000 R14: ffffc9000a58fa88 R15: ffff888061b5c000
> >> FS:  00007fb49bda9700(0000) GS:ffff88802d400000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: fffff52005b80000 CR3: 0000000060769006 CR4: 0000000000760ee0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> PKRU: 55555554
> >> Call Trace:
> >>  xfs_buf_ioend+0x228/0xdc0 fs/xfs/xfs_buf.c:1162
> >>  __xfs_buf_submit+0x38b/0xe50 fs/xfs/xfs_buf.c:1485
> >>  xfs_buf_submit fs/xfs/xfs_buf.h:268 [inline]
> >>  xfs_buf_read_uncached+0x15c/0x560 fs/xfs/xfs_buf.c:897
> >>  xfs_readsb+0x2d0/0x540 fs/xfs/xfs_mount.c:298
> >>  xfs_fc_fill_super+0x3e6/0x11f0 fs/xfs/xfs_super.c:1415
> >>  get_tree_bdev+0x444/0x620 fs/super.c:1340
> >>  xfs_fc_get_tree+0x1c/0x20 fs/xfs/xfs_super.c:1550
> >>  vfs_get_tree+0x8e/0x300 fs/super.c:1545
> >>  do_new_mount fs/namespace.c:2822 [inline]
> >>  do_mount+0x152d/0x1b50 fs/namespace.c:3142
> >>  ksys_mount+0x114/0x130 fs/namespace.c:3351
> >>  __do_sys_mount fs/namespace.c:3365 [inline]
> >>  __se_sys_mount fs/namespace.c:3362 [inline]
> >>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3362
> >>  do_syscall_64+0xfa/0x780 arch/x86/entry/common.c:294
> >>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> RIP: 0033:0x46736a
> >> Code: 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> >> 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> >> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007fb49bda8a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> >> RAX: ffffffffffffffda RBX: 00007fb49bda8af0 RCX: 000000000046736a
> >> RDX: 00007fb49bda8ad0 RSI: 0000000020000140 RDI: 00007fb49bda8af0
> >> RBP: 00007fb49bda8ad0 R08: 00007fb49bda8b30 R09: 00007fb49bda8ad0
> >> R10: 0000000000000000 R11: 0000000000000202 R12: 00007fb49bda8b30
> >> R13: 00000000004b1c60 R14: 00000000004b006d R15: 00007fb49bda96bc
> >> Modules linked in:
> >> Dumping ftrace buffer:
> >>    (ftrace buffer empty)
> >> CR2: fffff52005b80000
> >> ---[ end trace eddd8949d4c898df ]---
> >> RIP: 0010:xfs_sb_read_verify+0xe9/0x540 fs/xfs/libxfs/xfs_sb.c:691
> >> Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 1e 04 00 00 4d 8b ac 24
> >> 30 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <0f> b6
> >> 04 02 84 c0 74 08 3c 03 0f 8e ad 03 00 00 41 8b 45 00 bf 58
> >> RSP: 0018:ffffc9000a58f8d0 EFLAGS: 00010a06
> >> RAX: dffffc0000000000 RBX: 1ffff920014b1f1d RCX: ffffc9000af42000
> >> RDX: 1ffff92005b80000 RSI: ffffffff82914404 RDI: ffff88805cdb1460
> >> RBP: ffffc9000a58fab0 R08: ffff8880610cd380 R09: ffffed1005a87045
> >> R10: ffffed1005a87044 R11: ffff88802d438223 R12: ffff88805cdb1340
> >> R13: ffffc9002dc00000 R14: ffffc9000a58fa88 R15: ffff888061b5c000
> >> FS:  00007fb49bda9700(0000) GS:ffff88802d400000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: fffff52005b80000 CR3: 0000000060769006 CR4: 0000000000760ee0
> >> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >> PKRU: 55555554
> >>
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/56cf8aab-c61b-156c-f681-d2354aed22bb%40virtuozzo.com.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/871rtqg91q.fsf%40dja-thinkpad.axtens.net.
