Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DDFC2D0BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22354206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NimrcfFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLMKkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:40:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38875 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfLMKkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:40:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so1315004qki.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 02:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJUdZqZKeqQJbAvsVBmOFEt3AerDHRogW4otpQi9Fh8=;
        b=NimrcfFp+WQJJdiCViGLq6nnvHNkdSPHTY3az5QCrIBK+cXNl1YzAC9iBIqU/+tx7D
         UpACVM7kK3shJ7kVjhiYbcgLHO3cCM6oaZQKzpwZF44JT9IhjttnWmpd4am367Jj5BxL
         isf4ASn4iVJYBqh3hv8f6d7N6kp0C6kEoUG8HzHDVkGtdZOeByzqi7PiCkv6ET2NUZse
         uGh8lJ0HD0nAeeQNiGLc8X7ugz/0ftOUM3KgNwszwZjn27efkx8JOSB0tEJzdjsdEU6z
         fB0JHmg1WUnlGryhoifNFZ/m4AwYa3Ok65fwIXbfxsehZaXrrXGmM0SShloRvuhmQZjO
         D9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJUdZqZKeqQJbAvsVBmOFEt3AerDHRogW4otpQi9Fh8=;
        b=SfSTDs5ZzfUFbXfjHuKvm/XGiwPAaPCuQDjI6xRICId0sbGhURN6U78eJEXIBwkrZ6
         jQIg9O3IGXYI5v7Ohok5svYt+n6eHmYF8E7V9VGjF8ZVIuV9GJi11vtI9aWC2BvUsXoH
         EOdfb7jOahdBRSIfdF0A+FDw09ctBDD7W00jJISHws/DHpQaTvF7SP4pwBjx0vfavLaR
         GNNvd7e9LWfzc/BICxYj4THWkAXoHS8EsA05xIg1yKzMv5hCpyGwY0aKvf6GG+rUbm0Q
         toaphJwaWesQDzihUMfZMyZOMWGBUYZYFW3KaAVNJUzxh7w9FXGLkjLN6pcy01MbtIxL
         3R4g==
X-Gm-Message-State: APjAAAVwm/ZPpVHTHRKlUKjGkixvhf3igiRh9Z5CL8E5UeIO06SSa/by
        8+agmzeLCl/zZ0LyX3fbrOaWkuZL5hd+RVn+ZdKFc8F/6eg=
X-Google-Smtp-Source: APXvYqwz2g37YbccpAotY/MYyFV9bdHIxBz7FLgdenJhHmA1ZOvpXz8810xphFInFWxTG8RbS5lid2Bx0IoQE32r1/s=
X-Received: by 2002:a05:620a:1136:: with SMTP id p22mr11816020qkk.8.1576233605735;
 Fri, 13 Dec 2019 02:40:05 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053539a0599173973@google.com> <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com> <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <20191213101021.GA2141429@kroah.com>
In-Reply-To: <20191213101021.GA2141429@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 13 Dec 2019 11:39:54 +0100
Message-ID: <CACT4Y+ZW8oLfupDbQuk-Q-J=WtsXPEXTsqeZAPGhXXPu4gGrmg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Dec 13, 2019 at 11:00:35AM +0100, Dmitry Vyukov wrote:
> > On Fri, Dec 13, 2019 at 10:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Dec 13, 2019 at 10:02:33AM +0100, Dmitry Vyukov wrote:
> > > > On Thu, Dec 12, 2019 at 11:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2019 at 10:25:08PM -0800, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    7ada90eb Merge tag 'drm-next-2019-12-06' of git://anongit...
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=123ec282e00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=f4f1e871965064ae689e
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ab090ee00000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f127f2e00000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com
> > > > > >
> > > > > > BUG: kernel NULL pointer dereference, address: 0000000000000002
> > > > > > #PF: supervisor write access in kernel mode
> > > > > > #PF: error_code(0x0002) - not-present page
> > > > > > PGD 9764a067 P4D 9764a067 PUD 9f995067 PMD 0
> > > > > > Oops: 0002 [#1] PREEMPT SMP KASAN
> > > > > > CPU: 0 PID: 9687 Comm: syz-executor433 Not tainted 5.4.0-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
> > > > > > RIP: 0010:mem_serial_out+0x70/0x90 drivers/tty/serial/8250/8250_port.c:408
> > > > > > Code: e9 00 00 00 49 8d 7c 24 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
> > > > > > c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5c 24 40 <44> 88 2b 5b 41 5c
> > > > > > 41 5d 5d c3 e8 81 ed cf fd eb c0 e8 da ed cf fd
> > > > > > RSP: 0018:ffffc90001de78e8 EFLAGS: 00010202
> > > > > > RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
> > > > > > RDX: 1ffffffff181f40e RSI: ffffffff83e28776 RDI: ffffffff8c0fa070
> > > > > > RBP: ffffc90001de7900 R08: ffff8880919dc340 R09: ffffed10431ee1c6
> > > > > > R10: ffffed10431ee1c5 R11: ffff888218f70e2b R12: ffffffff8c0fa030
> > > > > > R13: 0000000000000001 R14: ffffc90001de7a40 R15: ffffffff8c0fa188
> > > > > > FS:  0000000001060880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000000000002 CR3: 000000009e6b8000 CR4: 00000000001406f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  serial_out drivers/tty/serial/8250/8250.h:118 [inline]
> > > > > >  serial8250_clear_fifos.part.0+0x3a/0xb0
> > > > > > drivers/tty/serial/8250/8250_port.c:557
> > > > > >  serial8250_clear_fifos drivers/tty/serial/8250/8250_port.c:556 [inline]
> > > > > >  serial8250_do_startup+0x426/0x1cf0 drivers/tty/serial/8250/8250_port.c:2121
> > > > > >  serial8250_startup+0x62/0x80 drivers/tty/serial/8250/8250_port.c:2329
> > > > > >  uart_port_startup drivers/tty/serial/serial_core.c:219 [inline]
> > > > > >  uart_startup drivers/tty/serial/serial_core.c:258 [inline]
> > > > > >  uart_startup+0x452/0x980 drivers/tty/serial/serial_core.c:249
> > > > > >  uart_set_info drivers/tty/serial/serial_core.c:998 [inline]
> > > > > >  uart_set_info_user+0x13b4/0x1cf0 drivers/tty/serial/serial_core.c:1023
> > > > > >  tty_tiocsserial drivers/tty/tty_io.c:2506 [inline]
> > > > > >  tty_ioctl+0xf60/0x14f0 drivers/tty/tty_io.c:2648
> > > > > >  vfs_ioctl fs/ioctl.c:47 [inline]
> > > > > >  file_ioctl fs/ioctl.c:545 [inline]
> > > > > >  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
> > > > > >  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
> > > > > >  __do_sys_ioctl fs/ioctl.c:756 [inline]
> > > > > >  __se_sys_ioctl fs/ioctl.c:754 [inline]
> > > > > >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
> > > > > >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> > > > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > > > RIP: 0033:0x440219
> > > > > > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> > > > > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> > > > > > 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > > > RSP: 002b:00007ffced648c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > > > > RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440219
> > > > > > RDX: 0000000020000240 RSI: 000000000000541f RDI: 0000000000000003
> > > > > > RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
> > > > > > R10: 0000000000401b30 R11: 0000000000000246 R12: 0000000000401aa0
> > > > > > R13: 0000000000401b30 R14: 0000000000000000 R15: 0000000000000000
> > > > > > Modules linked in:
> > > > > > CR2: 0000000000000002
> > > > > > ---[ end trace eaa11ffe82f3a763 ]---
> > > > > > RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
> > > > > > RIP: 0010:mem_serial_out+0x70/0x90 drivers/tty/serial/8250/8250_port.c:408
> > > > > > Code: e9 00 00 00 49 8d 7c 24 40 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
> > > > > > c1 ea 03 d3 e3 80 3c 02 00 75 19 48 63 db 49 03 5c 24 40 <44> 88 2b 5b 41 5c
> > > > > > 41 5d 5d c3 e8 81 ed cf fd eb c0 e8 da ed cf fd
> > > > > > RSP: 0018:ffffc90001de78e8 EFLAGS: 00010202
> > > > > > RAX: dffffc0000000000 RBX: 0000000000000002 RCX: 0000000000000000
> > > > > > RDX: 1ffffffff181f40e RSI: ffffffff83e28776 RDI: ffffffff8c0fa070
> > > > > > RBP: ffffc90001de7900 R08: ffff8880919dc340 R09: ffffed10431ee1c6
> > > > > > R10: ffffed10431ee1c5 R11: ffff888218f70e2b R12: ffffffff8c0fa030
> > > > > > R13: 0000000000000001 R14: ffffc90001de7a40 R15: ffffffff8c0fa188
> > > > > > FS:  0000000001060880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000000000000002 CR3: 000000009e6b8000 CR4: 00000000001406f0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > >
> > > > >
> > > > > You set up a dubious memory base for your uart and then get upset when
> > > > > you write to that location.
> > > > >
> > > > > I don't know what to really do about this, this is a root-only operation
> > > > > and you are expected to know what you are doing when you attempt this.
> > > >
> > > > Hi Greg,
> > > >
> > > > Thanks for looking into this!
> > > > Should we restrict the fuzzer from accessing /dev/ttyS* entirely?
> > >
> > > No, not at all.
> > >
> > > > Or only restrict TIOCSSERIAL on them? Something else?
> > >
> > > Try running not as root.  if you have CAP_SYS_ADMIN you can do a lot of
> > > pretty bad things with tty ports, as you see here.  There's a reason the
> > > LOCKDOWN_TIOCSSERIAL "security lockdown" check was added :)
> > >
> > > The TIOCSSERIAL ioctl is a nice one for a lot of things that are able to
> > > be done as a normal user (baud rate changes, etc.), but there are also
> > > things like setting io port memory locations that can cause random
> > > hardware accesses and kernel crashes, as you instantly found out here :)
> > >
> > > So restrict the fuzzer to only run as a "normal" user of the serial
> > > port, and if you find problems there, I'll be glad to look at them.
> >
> > Easier said than done. "normal user of the serial port" is not really
> > a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
> > not per-device...
>
> Not true, there's lots of users of serial port devices that do not have
> CAP_SYS_ADMIN set.  That's why we have groups :)
>
> You can change the baud rate of your usb-serial device without root
> permissions, right?  That's a "normal" user right there.

Yes, but this requires dropping CAP_SYS_ADMIN. And one can't drop
CAP_SYS_ADMIN only for ttyS. If it would be a separate capability, we
could drop just that, but not CAP_SYS_ADMIN.

> > As far as I remember +Tetsuo proposed a config along the lines of
> > "restrict only things that legitimately cause damage under a fuzzer
> > workload", e.g. freezing filesystems, disabling console output, etc.
> > This may be another candidate. But I can't find where that proposal is
> > now.
> >
> > A simpler option that I see is as follows. syzkaller has several
> > sandboxing modes, one of them is "namespace" which uses a user ns, in
> > that more fuzzer is still uid=0 in the init namespace, so has access
> > to all /dev nodes, but it does not have CAP_SYS_ADMIN in the init
> > namespace. We could enable /dev/ttyS* only on instance that use
> > sandbox=namesace, and disable on the rest. Does it make sense?
>
> Maybe, I don't know.  Why do you have to run the fuzzer with uid=0 in
> the first place?

There is a number of reasons.
1. Lots of kernel functionalities are protected by CAP_SYS_ADMIN for
unclear reasons. Changing global resources would be reasonable to
protect by root (e.g. changing hostname or eth0). But say if I am
mounting local image file in my local directory, or applying bpf
filter to my socket that should be nobody's business because it does
not affect anybody else. But these things require CAP_SYS_ADMIN in
Linux. As a result users use sudo left and right, which leads to a
mismatch between what users expect and what kernel provides. If you
mount a USB stick or image downloaded from internet, there is no way
you can verify each and every byte of it manually (and it's not work
for humans, it's work for machines), so you just sudo mount it
assuming kernel will handle any bad data. But kernel assumes it's
protected by root, so no particular guarantees, all responsibility is
on you. The only way to shake out bugs in mount/bpf/etc is to test
them, but it requires CAP_SYS_ADMIN.
2. Kernel should not crash on invalid inputs in most cases even if
they are provided by root. Root can make mistakes, programs that root
uses can contain bugs. Useful diagnostics are always better than
silently corrupting memory.
3. On Android/with lockdown/security modules root is not necessary
completely trusted entity. Using a memory corruption root can e.g.
unlock lockdown.
4. Last but not least, using root functionalities may be required to
find critical non-root provoked bugs. Consider you (root) setup
bpf/mount something/setup a socket in a particular, but totally normal
way, but then a memory corruption is caused by a malicious packet
arriving on network (but it requires that root-only setup done on the
host). But giving the fuzzer root we can find such bugs.

We get this far with uid=0. Things were worse initially, then we did
lots of sandbox tuning (e.g. we still do new net ns now even if under
root), some syscall refinements (e.g. no FIFREEZE), disabled
/dev/mem/kmem/ports. There are no major problems now, except for very
rare and isolated cases like this one. I would very much not like to
abandon uid=0 wholesale at this point.
