Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B3C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6492D20659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLFQeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:34:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:55827 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:34:10 -0500
Received: by mail-il1-f199.google.com with SMTP id d14so5605458ild.22
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rqCputwRcsxKt2PlVXuw5MtF3XLiOp9UpYUuXc2aLgA=;
        b=QOCA1/CJkB2vnTBnnFtIRP03Yjyz9BA+VBjGh0A2f+yA36QqAFkYox0nPoDtXsPByK
         YRbM/9SZx373mSH3tmzTo+jYlTbjo08aI3zqATgtO3q2Bfj0cvuRDK7ijp7Z3LBP5nIG
         gcS3REGW+E4H/sFVXU1Rh8MO4I+5Losar/xz3Z2qoxP+NPofLkUmGyMpvHijCO9xODnJ
         lGGBXJ9u+mikcYlCbZwykwhnCPygJr4D1eHz7fG1JaEzOfq4GfGY5RCmpjuW6wIFlL+J
         jcx+ndFhBJDOsmVqFbZeP9ACDh0nVWS2fMMD9WZme9Cqigx4+R+0C89LgDRi8PZQpxtO
         rAxQ==
X-Gm-Message-State: APjAAAUnwHeP2d/vcLRLHXWDaGXS8fg1sZmc6ZLknhjyhjxGpp00e0ZR
        lg9/PuHLhk2DcY86ioN8hWR0QyKJgCFLPQOGkOrsYz1FADdX
X-Google-Smtp-Source: APXvYqyByNLCVhQAXljCtTGdKG18t+bHUjiYlyEo7ulRihXdvs7rvToSmnxN1Bisrh0fnPxXMOEIw2rvuFKa3NROGJCVAOQ5gtng
MIME-Version: 1.0
X-Received: by 2002:a05:6602:187:: with SMTP id m7mr11405177ioo.16.1575650049916;
 Fri, 06 Dec 2019 08:34:09 -0800 (PST)
Date:   Fri, 06 Dec 2019 08:34:09 -0800
In-Reply-To: <0000000000007b17010598f7aa1f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008409aa05990b9d8a@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in bit_putcs
From:   syzbot <syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1015a90ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=38a3699c7eaf165b97a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1795d941e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer  
include/linux/fb.h:655 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs_aligned  
drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs+0xd5d/0xf10  
drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffffffff88726a41 by task syz-executor.5/9415

CPU: 1 PID: 9415 Comm: syz-executor.5 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __fb_pad_aligned_buffer include/linux/fb.h:655 [inline]
  bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
  bit_putcs+0xd5d/0xf10 drivers/video/fbdev/core/bitblit.c:185
  fbcon_putcs+0x33c/0x3e0 drivers/video/fbdev/core/fbcon.c:1353
  do_update_region+0x42b/0x6f0 drivers/tty/vt/vt.c:677
  redraw_screen+0x676/0x7d0 drivers/tty/vt/vt.c:1011
  fbcon_do_set_font+0x829/0x960 drivers/video/fbdev/core/fbcon.c:2605
  fbcon_copy_font+0x12c/0x190 drivers/video/fbdev/core/fbcon.c:2620
  con_font_copy drivers/tty/vt/vt.c:4594 [inline]
  con_font_op+0x6b2/0x1270 drivers/tty/vt/vt.c:4609
  vt_ioctl+0x181a/0x26d0 drivers/tty/vt/vt_ioctl.c:965
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5b74dffc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000020000000 RSI: 0000000000004b72 RDI: 0000000000000005
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5b74e006d4
R13: 00000000004c37ab R14: 00000000004d8c38 R15: 00000000ffffffff

The buggy address belongs to the variable:
  oid_index+0xb01/0xb80

Memory state around the buggy address:
  ffffffff88726900: 00 00 02 fa fa fa fa fa 00 00 00 05 fa fa fa fa
  ffffffff88726980: 00 00 00 fa fa fa fa fa 00 00 00 00 00 01 fa fa
> ffffffff88726a00: fa fa fa fa 00 00 00 00 01 fa fa fa fa fa fa fa
                                            ^
  ffffffff88726a80: 00 00 00 00 fa fa fa fa 00 03 fa fa fa fa fa fa
  ffffffff88726b00: 04 fa fa fa fa fa fa fa 00 00 01 fa fa fa fa fa
==================================================================

