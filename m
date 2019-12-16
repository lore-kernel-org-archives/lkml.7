Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DCC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D2720700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLPIZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:25:09 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:57336 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLPIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:25:09 -0500
Received: by mail-il1-f197.google.com with SMTP id 12so5850056iln.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VB+SUGuC0Cxur0Zbj+ZX0/RbFVdQs4vKPprMrLUqHHw=;
        b=NiorNmGxCazp+EMEyeh/UgDL8c8hazTpzrPesjQWYDx5MSBVh5zscJcPr3Ep+Z9yDJ
         s75F3S9vJEe9HI3Sp7lUi9mu9/YCJUMUYnBLRq8PLfHA9AbKutI7LLETSr9+bPkEtmLF
         JZ4Q6GVuHK2Au05g94V7qCLlGbXhIJPamFvkMhdfrVEVWX0QbV/3NYOhAJoSmIgXU9uZ
         32QUFKpNChLmPZbGWUl2X2EkLarnmSvohFClpppyNA5zAYMYLXvQLYtgTyespZx6EAdc
         NB8kYMBigi34LhbRwmMArvEhsWXvQbUbhwUUXNQeLTgLw01PXGAKHF09stdQuCh/idCv
         tj5w==
X-Gm-Message-State: APjAAAVLzXkNdj5+cW7KHF/+9dyZ7K2LQj8QNdpLCr1sBmRJ+WUCIjwH
        FyXiivtdfF9CUmUIRcmz2MJm9GYg7F6LqRxEp33Fi7IQQdWo
X-Google-Smtp-Source: APXvYqy1n7xSzv4gIh6uIxRJReBP3P2yMVXvElVrNazRNMA5VJbfAmWHkpDIDiNKG2f/us0i5Hd9wR9X3MohfeMASfHQHT2O7mhi
MIME-Version: 1.0
X-Received: by 2002:a92:1f16:: with SMTP id i22mr11467433ile.206.1576484708100;
 Mon, 16 Dec 2019 00:25:08 -0800 (PST)
Date:   Mon, 16 Dec 2019 00:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005324a0599cdf320@google.com>
Subject: WARNING in azx_rirb_get_response
From:   syzbot <syzbot+b3028ac3933f5c466389@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com, yung-chuan.liao@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    37d4e84f Merge tag 'ceph-for-5.5-rc2' of git://github.com/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bbc9a6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=b3028ac3933f5c466389
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b3028ac3933f5c466389@syzkaller.appspotmail.com

snd_hda_intel 0000:00:06.0: No response from codec, disabling MSI: last  
cmd=0x004a0000
------------[ cut here ]------------
snd_hda_intel 0000:00:06.0: azx_get_response timeout, switching to  
single_cmd mode: last cmd=0x004a0000
WARNING: CPU: 2 PID: 8020 at sound/pci/hda/hda_controller.c:886  
azx_rirb_get_response+0x5d6/0x720 sound/pci/hda/hda_controller.c:886
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 8020 Comm: syz-executor.1 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:azx_rirb_get_response+0x5d6/0x720  
sound/pci/hda/hda_controller.c:886
Code: f6 00 00 00 49 8b 5d 00 e8 27 75 7a fb 4c 89 ef e8 ef 21 5a fe 44 89  
f9 48 89 da 48 c7 c7 80 07 ce 88 48 89 c6 e8 d9 1e 4b fb <0f> 0b 48 b8 00  
00 00 00 00 fc ff df 48 8b 4d 88 48 89 ca 48 c1 ea
RSP: 0018:ffffc9000236f708 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888078f64240 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e88f6 RDI: fffff5200046ded3
RBP: ffffc9000236f780 R08: ffff8880673d0140 R09: ffffed1005a46621
R10: ffffed1005a46620 R11: ffff88802d233107 R12: ffff888029ef0000
R13: ffff88802759a0b0 R14: dffffc0000000000 R15: 00000000004a0000
  azx_get_response sound/pci/hda/hda_controller.c:994 [inline]
  azx_get_response+0x14c/0x180 sound/pci/hda/hda_controller.c:984
  snd_hdac_bus_exec_verb_unlocked+0x4b5/0x950 sound/hda/hdac_bus.c:115
  codec_exec_verb+0x13d/0x340 sound/pci/hda/hda_codec.c:52
  snd_hdac_exec_verb+0x65/0x110 sound/hda/hdac_device.c:257
  codec_read+0xa2/0x100 sound/hda/hdac_device.c:986
  snd_hdac_codec_read+0x34/0x40 sound/hda/hdac_device.c:1015
  snd_hda_codec_read include/sound/hda_codec.h:318 [inline]
  update_pcm_format.part.0+0x36/0xc0 sound/pci/hda/hda_codec.c:1057
  update_pcm_format sound/pci/hda/hda_codec.c:1056 [inline]
  snd_hda_codec_setup_stream.part.0+0x355/0xa40  
sound/pci/hda/hda_codec.c:1102
  snd_hda_codec_setup_stream+0x47/0x60 sound/pci/hda/hda_codec.c:1086
  capture_pcm_prepare+0x63/0x100 sound/pci/hda/hda_generic.c:5376
  snd_hda_codec_prepare+0xa5/0x420 sound/pci/hda/hda_codec.c:3160
  azx_pcm_prepare+0x53f/0x950 sound/pci/hda/hda_controller.c:195
  snd_pcm_do_prepare+0x61/0xa0 sound/core/pcm_native.c:1729
  snd_pcm_action_single+0x7a/0x130 sound/core/pcm_native.c:1111
  snd_pcm_action_nonatomic+0x9c/0xb0 sound/core/pcm_native.c:1227
  snd_pcm_prepare+0x121/0x1b0 sound/core/pcm_native.c:1776
  snd_pcm_kernel_ioctl+0x117/0x1f0 sound/core/pcm_native.c:3068
  snd_pcm_oss_prepare+0x49/0x150 sound/core/oss/pcm_oss.c:1125
  snd_pcm_oss_make_ready+0x12b/0x170 sound/core/oss/pcm_oss.c:1153
  snd_pcm_oss_sync.isra.0+0x1c4/0x7e0 sound/core/oss/pcm_oss.c:1707
  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2545
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_32_irqs_on arch/x86/entry/common.c:352 [inline]
  do_fast_syscall_32+0xbbd/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7faea39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffadef9c EFLAGS: 00000293 ORIG_RAX: 0000000000000006
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 000000000812b000 RSI: 0000000000000005 RDI: 000000000815b660
RBP: 000000000815b660 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
