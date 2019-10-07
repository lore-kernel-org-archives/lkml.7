Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B507ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF64220835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DODjiraL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJGUu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:50:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36349 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfJGUu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:50:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so12967002oih.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fcK8OAMj1NXGHtsn+eBL0qYf9+gr3KEaFJ+KVKmEmZY=;
        b=DODjiraLf068HcX29CyMdrHKMVss5CMwF3IF6QSTNwHG3cxEEFKnCyo/jxIY41DmIY
         CUxftEANh/zrUwxvo8s71HTSMFLS2tpW2SYBhiKrCvzcLanFoeIN7fQTqCx0Zjdi3NeN
         pEGc6y6mnqrjKvNhBmRZQlzwohGgeioeQq4XNF73gro5w26vRZf5C8Fdo8pTu+pVY+HL
         A+PaUClT0zoSqUVw+J+ALCaB9CGOQGO87q+NpGkyue7bduAEU56SPVdETQz1UzPQSt/v
         hO8f1T4z45WWslhN6/d7dNJG3WqrwktpOGuuOSlXh0i0mYAw5e72r0uQllYsN8HBxgOq
         58Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=fcK8OAMj1NXGHtsn+eBL0qYf9+gr3KEaFJ+KVKmEmZY=;
        b=Q8RF3MxXxV1WKnYbrNYjUftxYb+jk8PPDI1otNeF/zox+hrkaXt59hVlJVqAmwUFAF
         7E2sW2lgNVFb6UqLyVvaDa9MP3ntR1lqsDucfZ/fM+BL2UDL+dk5L1ImYjJt7ggkLLFV
         xY/Ugr68L23qi0/wB+zLbIj5CfTwxpLYinOh/I0X2oQvkZpzEDyc/GvOhDSynT5XGWWR
         qiEtx5kkvZNWASbRLylKDylLKWYEMdvwkZreiloQ47389W3ab6wAz3bN0tuv/owgl2YW
         XgE8lcZyH7VqRc6064Qk9OmXWp3oXaPV+2B8hMKAiy+mgo4/GeJ+F2SPk+1Js1Ii9zbf
         BgBA==
X-Gm-Message-State: APjAAAVvz14hFrbsKWNFc9SHLcklpm7uW6F6og4UAQjblZJ05P4gn/77
        1pBoVfiA1eeVGk7qLFGytRMwYXFWG84jCy/MjxEZFQ==
X-Google-Smtp-Source: APXvYqxIHGh7mfNuVHXTLRJFNp9/uJzd7RruBHZ/ws9o8/h7q7R8934FeS+oWLKpbxCd5p43woxfMY4PUqH60G0l9qE=
X-Received: by 2002:aca:da41:: with SMTP id r62mr938855oig.47.1570481423969;
 Mon, 07 Oct 2019 13:50:23 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Oct 2019 22:49:57 +0200
Message-ID: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
Subject: UAF read in print_binder_transaction_log_entry() on ANDROID_BINDERFS kernels
To:     Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There is a use-after-free read in print_binder_transaction_log_entry()
on ANDROID_BINDERFS kernels because
print_binder_transaction_log_entry() prints the char* e->context_name
as string, and if the transaction occurred on a binder device from
binderfs, e->context_name belongs to the binder device and is freed
when the inode disappears.

Luckily this shouldn't have security implications, since:

a) reading the binder transaction log is already a pretty privileged operat=
ion
b) I can't find any actual users of ANDROID_BINDERFS

I guess there are three ways to fix it:
1) Create a new shared global spinlock for binderfs_evict_inode() and
binder_transaction_log_show(), and let binderfs_evict_inode() scan the
transaction log for pointers to its name and replace them with
pointers to a statically-allocated string "{DELETED}" or something
like that.
2) Let the transaction log contain non-reusable device identifiers
instead of name pointers, and let print_binder_transaction_log_entry()
look them up in something like a hashtable.
3) Just copy the name into the transaction log every time.

I'm not sure which one is better, or whether there's a nicer fourth
option, so I'm leaving writing a patch for this to y'all.


Trigger instructions (requires you to have some helpers that can
register a context manager and send some transaction to it):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@test:/home/user# mkdir /tmp/binder
root@test:/home/user# mount -t binder -o stats=3Dglobal /dev/null /tmp/bind=
er
root@test:/home/user# ls -l /tmp/binder
total 0
crw------- 1 root root 248, 1 Oct  7 20:34 binder
crw------- 1 root root 248, 0 Oct  7 20:34 binder-control
drwxr-xr-x 3 root root      0 Oct  7 20:34 binder_logs
crw------- 1 root root 248, 2 Oct  7 20:34 hwbinder
crw------- 1 root root 248, 3 Oct  7 20:34 vndbinder
root@test:/home/user# ln -s /tmp/binder/binder /dev/binder
[run some simple binder demo code to temporarily register a context
manager and send a binder transaction]
root@test:/home/user# rm /tmp/binder/binder
root@test:/home/user# cat /tmp/binder/binder_logs/transaction_log
2: call  from 2277:2277 to 2273:0 context @=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD node 1 handle 0
size 24:8 ret 0/0 l=3D0
5: call  from 2273:2273 to 2277:2277 context @=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD node 3 handle 1
size 0:0 ret 0/0 l=3D0
6: reply from 2277:2277 to 2273:2273 context @=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD node 0 handle 0
size 4:0 ret 0/0 l=3D0
7: reply from 2273:2273 to 2277:2277 context @=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD node 0 handle 0
size 4:0 ret 0/0 l=3D0
root@test:/home/user#
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ASAN splat:
[  333.300753] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  333.303197] BUG: KASAN: use-after-free in string_nocheck+0x9d/0x160
[  333.305081] Read of size 1 at addr ffff8880b0981258 by task cat/2279

[  333.307415] CPU: 1 PID: 2279 Comm: cat Not tainted 5.4.0-rc1+ #513
[  333.309304] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[  333.310987] Call Trace:
[  333.312032]  dump_stack+0x7c/0xc0
[  333.312581]  ? string_nocheck+0x9d/0x160
[  333.313157]  print_address_description.constprop.7+0x36/0x50
[  333.314030]  ? string_nocheck+0x9d/0x160
[  333.314603]  ? string_nocheck+0x9d/0x160
[  333.315236]  __kasan_report.cold.10+0x1a/0x35
[  333.315972]  ? string_nocheck+0x9d/0x160
[  333.316545]  kasan_report+0xe/0x20
[  333.317104]  string_nocheck+0x9d/0x160
[  333.317652]  ? widen_string+0x160/0x160
[  333.318270]  ? string_nocheck+0x160/0x160
[  333.318857]  ? unwind_get_return_address+0x2a/0x40
[  333.319636]  ? profile_setup.cold.9+0x96/0x96
[  333.320359]  string+0xb6/0xc0
[  333.320800]  ? hex_string+0x280/0x280
[  333.321398]  vsnprintf+0x20c/0x780
[  333.321898]  ? num_to_str+0x180/0x180
[  333.322503]  ? __kasan_kmalloc.constprop.6+0xc1/0xd0
[  333.323235]  ? vfs_read+0xbc/0x1e0
[  333.323814]  ? ksys_read+0xb5/0x150
[  333.324323]  ? do_syscall_64+0xb9/0x3b0
[  333.324948]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  333.325756]  seq_vprintf+0x78/0xb0
[  333.326253]  seq_printf+0x96/0xc0
[  333.327132]  ? seq_vprintf+0xb0/0xb0
[  333.327678]  ? match_held_lock+0x2e/0x240
[  333.328450]  binder_transaction_log_show+0x237/0x2d0
[  333.329163]  seq_read+0x266/0x690
[  333.329705]  vfs_read+0xbc/0x1e0
[  333.330178]  ksys_read+0xb5/0x150
[  333.330724]  ? kernel_write+0xb0/0xb0
[  333.331257]  ? trace_hardirqs_off_caller+0x57/0x130
[  333.332045]  ? mark_held_locks+0x29/0xa0
[  333.332678]  ? do_syscall_64+0x6b/0x3b0
[  333.333235]  do_syscall_64+0xb9/0x3b0
[  333.333856]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  333.334635] RIP: 0033:0x7fbbb95d4461
[  333.335153] Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00
66 0f 1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31
c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4
55 48
[  333.337950] RSP: 002b:00007ffcbe6438e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  333.339072] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fbbb95=
d4461
[  333.340157] RDX: 0000000000020000 RSI: 00007fbbb9324000 RDI: 00000000000=
00003
[  333.341320] RBP: 00007fbbb9324000 R08: 00000000ffffffff R09: 00000000000=
00000
[  333.342454] R10: fffffffffffffb9c R11: 0000000000000246 R12: 00007fbbb93=
24000
[  333.343550] R13: 0000000000000003 R14: 0000000000000fff R15: 00000000000=
20000

[  333.344845] Allocated by task 2259:
[  333.345416]  save_stack+0x19/0x80
[  333.345899]  __kasan_kmalloc.constprop.6+0xc1/0xd0
[  333.346636]  __kmalloc_track_caller+0xf4/0x2e0
[  333.347271]  kmemdup+0x17/0x40
[  333.347796]  binderfs_binder_device_create.isra.6+0x217/0x530
[  333.348674]  binderfs_fill_super+0x486/0x81e
[  333.349309]  mount_nodev+0x41/0xb0
[  333.349860]  legacy_get_tree+0x7b/0xc0
[  333.350398]  vfs_get_tree+0x40/0x130
[  333.350970]  do_mount+0xacb/0xea0
[  333.351449]  ksys_mount+0xb1/0xd0
[  333.352007]  __x64_sys_mount+0x5d/0x70
[  333.352545]  do_syscall_64+0xb9/0x3b0
[  333.353144]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  333.354144] Freed by task 2278:
[  333.354598]  save_stack+0x19/0x80
[  333.355135]  __kasan_slab_free+0x12e/0x180
[  333.355734]  kfree+0xe6/0x310
[  333.356234]  binderfs_evict_inode+0xb8/0xd0
[  333.356831]  evict+0x16f/0x290
[  333.358081]  do_unlinkat+0x2f6/0x420
[  333.358593]  do_syscall_64+0xb9/0x3b0
[  333.359176]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  333.360196] The buggy address belongs to the object at ffff8880b0981258
                which belongs to the cache kmalloc-8 of size 8
[  333.361991] The buggy address is located 0 bytes inside of
                8-byte region [ffff8880b0981258, ffff8880b0981260)
[  333.363796] The buggy address belongs to the page:
[  333.364538] page:ffffea0002c26040 refcount:1 mapcount:0
mapping:ffff8880b6c03c80 index:0x0
[  333.365765] flags: 0x1fffc0000000200(slab)
[  333.366402] raw: 01fffc0000000200 ffffea0002cb1d80 0000001400000014
ffff8880b6c03c80
[  333.367546] raw: 0000000000000000 0000000000aa00aa 00000001ffffffff
0000000000000000
[  333.369030] page dumped because: kasan: bad access detected

[  333.370095] Memory state around the buggy address:
[  333.370824]  ffff8880b0981100: fc fb fc fc fb fc fc fb fc fc fb fc
fc fb fc fc
[  333.371907]  ffff8880b0981180: fb fc fc fb fc fc fb fc fc fb fc fc
fb fc fc fb
[  333.372969] >ffff8880b0981200: fc fc fb fc fc fb fc fc fb fc fc fb
fc fc fb fc
[  333.374033]                                                     ^
[  333.374884]  ffff8880b0981280: fc fb fc fc fb fc fc fb fc fc fb fc
fc fb fc fc
[  333.375957]  ffff8880b0981300: fb fc fc fb fc fc fb fc fc fb fc fc
fb fc fc fb
[  333.377013] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
