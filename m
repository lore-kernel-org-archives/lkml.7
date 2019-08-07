Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0754C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E6F21E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmwdpEnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfHGOia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:38:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41356 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387987AbfHGOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:38:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so40984592pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMsjImvk15rGU5K4/oqAPhe2wws+c5HRyaASvfXzRqo=;
        b=dmwdpEnQk09MKsR9mnrVQPNSW7+jNvOzyv3yN5luKEGQ4FUz7+8j8NsrN/WUCLp3IY
         9TWqAPWvuBJWBBEyA/0hzI/qOQ5e9rU8ULd0Tmz8jBvKTOhgcmoR6C76+i5ItnmQoTFQ
         c99OxI4fjjF9sazaslLwfGEgaRk68KFRinUA6BseVnzGihLDn2sJfGi3rEEoWQos0LVZ
         cCvIpNdYuIVQ8uQ+vt9LYzKNKUmDGyDFZ4RZdhDL60Ghnz7Xw5ojrdDHT/ofaSH8Pbbm
         Q4ryYzAbvqzaY9SwnEu3yPmyel9uFN5ozJ/u953ntjXyz6A56pntrVLhKErExwJKmIWY
         dXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMsjImvk15rGU5K4/oqAPhe2wws+c5HRyaASvfXzRqo=;
        b=XYUDMbwz4CWp0Hjj4w5MfVMFdV7HBw9q6htYQ5DRm4jygNNTzafMjiMV4M1ye00wR3
         O2Zu7A5rJQgJWTXHOgYumCz/Rxlna4FhKDmPjN+v8jTktCqkBVaYMdoAXr+LAPF70Hiu
         NYeZYsHL+DJWCR3e/AlokXyLrPOH7/aqe9jQC/T5VtnRS3/ffDq4ngvZfOWzf1VOos4p
         0WCHMNCPWrg1T/lM9AQ2DdiuaUyyTsseFCiT6l86CsgHugIqMun/+/EE7TWJq+SqhvTw
         DTp1xOCB5mTNRnxDxvKfow6H5PCtupnJs5bkdw6pINlr13Ly//Q/TyvjG3TyiWy+LFD+
         OrSw==
X-Gm-Message-State: APjAAAVFOYIWTkDFP6keEINZ6FWRsnBxczME4ULqpKKDdWsKh48WEo55
        Q05dC1+1dfNB+3MaI25I5oRWpQDAWETk1LX/8H2vzw==
X-Google-Smtp-Source: APXvYqxoraqX8e0vrNgin5hDiKl0we0jI5cMqwxUZV0VBfxRLdQcaNKpbrik0blFlvyOD13BolkVlp+TzI9Q5JeAm7Q=
X-Received: by 2002:a17:902:6a87:: with SMTP id n7mr8311508plk.336.1565188708900;
 Wed, 07 Aug 2019 07:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zLrYaE+Kt6AULPjKhBNknxPBWncfkTDmm3eFoLSpsffw@mail.gmail.com>
 <Pine.LNX.4.44L0.1908071000560.1514-100000@iolanthe.rowland.org>
 <CAAeHK+yAY_ov4yH7n-R8ppnxc1ux33A-SEdxx18ywU1SyLGwug@mail.gmail.com> <CAAeHK+xV3SgXvu7RsGLVtPH7scV9GZ0uwPzTu8N2bw1kt9i7aw@mail.gmail.com>
In-Reply-To: <CAAeHK+xV3SgXvu7RsGLVtPH7scV9GZ0uwPzTu8N2bw1kt9i7aw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Aug 2019 16:38:17 +0200
Message-ID: <CAAeHK+z7EiEaQ8VNfTTByyV9TnOvxc9NvxYg6NQu9B2c7FR3sA@mail.gmail.com>
Subject: Re: possible deadlock in open_rio
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Cesar Miquel <miquel@df.uba.ar>,
        rio500-users@lists.sourceforge.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 4:34 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 4:24 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 4:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Wed, 7 Aug 2019, Andrey Konovalov wrote:
> > >
> > > > On Tue, Aug 6, 2019 at 9:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > >
> > > > > On Thu, 1 Aug 2019, syzbot wrote:
> > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    7f7867ff usb-fuzzer: main usb gadget fuzzer driver
> > > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=136b6aec600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7bbcbe9c9ff0cd49592a
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+7bbcbe9c9ff0cd49592a@syzkaller.appspotmail.com
> > > > > >
> > > > > > ======================================================
> > > > > > WARNING: possible circular locking dependency detected
> > > > > > 5.3.0-rc2+ #23 Not tainted
> > > > > > ------------------------------------------------------
> > > > >
> > > > > Andrey:
> > > > >
> > > > > This should be completely reproducible, since it's a simple ABBA
> > > > > locking violation.  Maybe just introducing a time delay (to avoid races
> > > > > and give the open() call time to run) between the gadget creation and
> > > > > gadget removal would be enough to do it.
> > > >
> > > > I've tried some simple approaches to reproducing this, but failed.
> > > > Should this require two rio500 devices to trigger?
> > >
> > > No, one device should be enough.  Just plug it in and then try to open
> > > the character device file.
> >
> > OK, I've reproduced it, so I can test a patch manually. The reason
> > syzbot couldn't do that, is because it doesn't open character devices.
> > Right now the USB fuzzing instance only opens /dev/input*,
> > /dev/hidraw* and /dev/usb/hiddev* (only the devices that are created
> > by USB HID devices as I've been working on adding USB HID targeted
> > fuzzing support lately).
> >
> > I guess we should open /dev/chr/* as well. The problem is that there
> > 300+ devices there even without connecting USB devices and opening
> > them blindly probably won't work. Is there a way to know which
> > character devices are created by USB devices? Maybe they are exposed
> > over /sys/bus/usb or via some other way?
>
> Ah, OK, I see that it's also exposed as /dev/rio500 for this
> particular driver. This doesn't really help, as these names will
> differ for different drivers, and this will require custom syzkaller
> descriptions for each driver. I'm planning to add them for some
> widely-used (i.e. enabled on Android) drivers at some point, but it's
> too much work to do it for all the drivers enabled on e.g. Ubuntu.

BTW, the deadlock report is actually followed by another one, which
looks like a different bug:

usercopy: Kernel memory exposure attempt detected from wrapped address
(offset 0, size 184466!
------------[ cut here ]------------
kernel BUG at mm/usercopy.c:98!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 2287 Comm: cat Not tainted 5.3.0-rc2+ #126
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:86
Code: e8 b1 f5 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7
c7 20 f4 cd 85 ff 74 24 1
RSP: 0018:ffff88806655fc60 EFLAGS: 00010282
RAX: 000000000000006d RBX: ffffffff85cdf140 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed100ccabf7e
RBP: ffffffff85cdf300 R08: 000000000000006d R09: ffffed100d965d60
R10: ffffed100d965d5f R11: ffff88806cb2eaff R12: ffffffff85cdf4a0
R13: ffffffff85cdf140 R14: ffff887feae14e00 R15: ffffffff85cdf140
FS:  00007f4ab703f700(0000) GS:ffff88806cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000008cd068 CR3: 0000000065ffa000 CR4: 00000000000006e0
Call Trace:
 check_bogus_address mm/usercopy.c:151
 __check_object_size mm/usercopy.c:260
 __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
 check_object_size ./include/linux/thread_info.h:119
 check_copy_size ./include/linux/thread_info.h:150
 copy_to_user ./include/linux/uaccess.h:151
 read_rio+0x223/0x480 drivers/usb/misc/rio500.c:423
 __vfs_read+0x76/0x100 fs/read_write.c:425
 vfs_read+0x1ea/0x430 fs/read_write.c:461
 ksys_read+0x127/0x250 fs/read_write.c:587
 do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x49/0xbe arch/x86/entry/entry_64.S:175
RIP: 0033:0x7f4ab6b6d310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8
ff eb ea 90 90 83 3d e5 4
RSP: 002b:00007fff2ba3e448 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000008000 RCX: 00007f4ab6b6d310
RDX: 0000000000008000 RSI: 00000000008c5000 RDI: 0000000000000003
RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000008c5000
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000008000
Modules linked in:
---[ end trace 01dee08b337d41c2 ]---
RIP: 0010:usercopy_abort+0xb9/0xbb mm/usercopy.c:86
Code: e8 b1 f5 d6 ff 49 89 d9 4d 89 e8 4c 89 e1 41 56 48 89 ee 48 c7
c7 20 f4 cd 85 ff 74 24 1
RSP: 0018:ffff88806655fc60 EFLAGS: 00010282
RAX: 000000000000006d RBX: ffffffff85cdf140 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed100ccabf7e
RBP: ffffffff85cdf300 R08: 000000000000006d R09: ffffed100d965d60
R10: ffffed100d965d5f R11: ffff88806cb2eaff R12: ffffffff85cdf4a0
R13: ffffffff85cdf140 R14: ffff887feae14e00 R15: ffffffff85cdf140
FS:  00007f4ab703f700(0000) GS:ffff88806cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000008cd068 CR3: 0000000065ffa000 CR4: 00000000000006e0
usb 1-1: USB disconnect, device number 3

>
> >
> > >
> > > Alan Stern
> > >
> > > > > Is there any way you can test this?
> > > >
> > > > Not yet.
> > > >
> > > > >
> > > > > Alan Stern
> > >
