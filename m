Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F7C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6A52190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbfGYJoO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:44:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41049 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfGYJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:44:14 -0400
Received: from marcel-macbook.fritz.box (p5B3D2BA7.dip0.t-ipconnect.de [91.61.43.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 596F3CED29;
        Thu, 25 Jul 2019 11:52:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: KASAN: use-after-free Read in h5_rx_3wire_hdr
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACT4Y+YLqSt34ka5kQQNBeo+GvGZ0dzNFL3Rb8_1Cid_C75_2w@mail.gmail.com>
Date:   Thu, 25 Jul 2019 11:44:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <500EB100-0253-4934-80FD-689C32ED310C@holtmann.org>
References: <0000000000003fd4ab058e46951f@google.com>
 <CACT4Y+YLqSt34ka5kQQNBeo+GvGZ0dzNFL3Rb8_1Cid_C75_2w@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

>> syzbot found the following crash on:
>> 
>> HEAD commit:    6d21a41b Add linux-next specific files for 20190718
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1377958fa00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
>> dashboard link: https://syzkaller.appspot.com/bug?extid=0abbda0523882250a97a
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e2bb7a00000
> 
> +drivers/bluetooth/hci_h5.c maintainers
> 
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+0abbda0523882250a97a@syzkaller.appspotmail.com
>> 
>> ==================================================================
>> BUG: KASAN: use-after-free in h5_rx_3wire_hdr+0x35d/0x3c0
>> /drivers/bluetooth/hci_h5.c:438
>> Read of size 1 at addr ffff8880a161d1c8 by task syz-executor.4/12040
>> 
>> CPU: 1 PID: 12040 Comm: syz-executor.4 Not tainted 5.2.0-next-20190718 #41
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack /lib/dump_stack.c:77 [inline]
>>  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
>>  print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
>>  __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
>>  kasan_report+0x12/0x17 /mm/kasan/common.c:612
>>  __asan_report_load1_noabort+0x14/0x20 /mm/kasan/generic_report.c:129
>>  h5_rx_3wire_hdr+0x35d/0x3c0 /drivers/bluetooth/hci_h5.c:438
>>  h5_recv+0x32f/0x500 /drivers/bluetooth/hci_h5.c:563
>>  hci_uart_tty_receive+0x279/0x790 /drivers/bluetooth/hci_ldisc.c:600
>>  tiocsti /drivers/tty/tty_io.c:2197 [inline]
>>  tty_ioctl+0x949/0x14f0 /drivers/tty/tty_io.c:2573
>>  vfs_ioctl /fs/ioctl.c:46 [inline]
>>  file_ioctl /fs/ioctl.c:509 [inline]
>>  do_vfs_ioctl+0xdb6/0x13e0 /fs/ioctl.c:696
>>  ksys_ioctl+0xab/0xd0 /fs/ioctl.c:713
>>  __do_sys_ioctl /fs/ioctl.c:720 [inline]
>>  __se_sys_ioctl /fs/ioctl.c:718 [inline]
>>  __x64_sys_ioctl+0x73/0xb0 /fs/ioctl.c:718
>>  do_syscall_64+0xfd/0x6a0 /arch/x86/entry/common.c:296
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x459819
>> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007f7a3b459c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459819
>> RDX: 0000000020000080 RSI: 0000000000005412 RDI: 0000000000000003
>> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7a3b45a6d4
>> R13: 00000000004c408a R14: 00000000004d7ff0 R15: 00000000ffffffff

Is this happening on specific hardware?

Regards

Marcel

