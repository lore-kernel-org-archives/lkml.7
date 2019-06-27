Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8AEC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA982054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0QrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:47:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52709 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0QrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:47:05 -0400
Received: by mail-io1-f71.google.com with SMTP id p12so3196700iog.19
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kA5B5hPw8fOR1bAhlCj3+mj3jVuYHQxvzyz5nlx4Vvc=;
        b=oGYlXGh4vCrizTbM2f2n6q1+U6TBIJLl7ZcH1SvxgITFBFXKf4B32mlprQsVbPWS2j
         2CZYbeRewzqIsEOl8tPAvctgRTLhOS7WgSD7xGKWYC6Cmp2e5t9nZT1MEIaasloq9Jn2
         s0oMMH6x5n4hJ3bRg8+hkFfmzDAlilTbzjvhZC6dc4Lz3HEGrrSc61sb5owPoDMr7WT8
         dBK3a2KUG9EkreLMbR5i408I1CXfezrWgmsohDCNazkLfY/ze2rXBqIT8QZME/QieJ7f
         +8CAyZKq4LYkAfdJnyBO4SwBc+2iohHWfJAxcJiEzGJXVnnNZEuatzuRStzlqdvuJKjm
         VTlg==
X-Gm-Message-State: APjAAAX2qppQxkqdkZU1Vil93tnPIkI9qfN3zmYIkTevae+v9GzPsclL
        TICn8rSi/COJib8y1blIF4noN9fkUvHHNRiluFrwQ3feTiOH
X-Google-Smtp-Source: APXvYqyBxlSeXbrDdFNqT47S1wItj4v9P7FopjfV2TZlPVbuPST6L9OVLUQfsqUCk9WZ0mdOdYFzfKqbJskg+GE4ThQRl16x9Z3h
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr6029096jao.58.1561654025090;
 Thu, 27 Jun 2019 09:47:05 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:47:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d7e29058c50e94b@google.com>
Subject: KASAN: null-ptr-deref Write in submit_audio_out_urb (2)
From:   syzbot <syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com>
To:     allison@lohutok.net, alsa-devel@alsa-project.org,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12f335e9a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=219f00fb49874dcaea17
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1122b6f3a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127fc823a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com

snd_usb_toneport 1-1:0.49: write failed (error 0)
usb 1-1: send failed (error -110)
usb 1-1: send failed (error -110)
snd_usb_toneport 1-1:0.49: Line 6 POD Studio UX1 now attached
==================================================================
BUG: KASAN: null-ptr-deref in memset include/linux/string.h:344 [inline]
BUG: KASAN: null-ptr-deref in submit_audio_out_urb+0x919/0x1780  
sound/usb/line6/playback.c:242
Write of size 20 at addr 0000000000000010 by task kworker/1:0/17

CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events line6_startup_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x32 mm/kasan/report.c:321
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  memset+0x20/0x40 mm/kasan/common.c:107
  memset include/linux/string.h:344 [inline]
  submit_audio_out_urb+0x919/0x1780 sound/usb/line6/playback.c:242
  line6_submit_audio_out_all_urbs+0xc9/0x120 sound/usb/line6/playback.c:291
  line6_stream_start+0x156/0x1f0 sound/usb/line6/pcm.c:195
  line6_pcm_acquire+0x134/0x210 sound/usb/line6/pcm.c:318
  line6_startup_work+0x42/0x50 sound/usb/line6/driver.c:725
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17 Comm: kworker/1:0 Tainted: G    B             5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events line6_startup_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:219
  end_report+0x43/0x49 mm/kasan/report.c:95
  __kasan_report.cold+0xd/0x32 mm/kasan/report.c:324
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  memset+0x20/0x40 mm/kasan/common.c:107
  memset include/linux/string.h:344 [inline]
  submit_audio_out_urb+0x919/0x1780 sound/usb/line6/playback.c:242
  line6_submit_audio_out_all_urbs+0xc9/0x120 sound/usb/line6/playback.c:291
  line6_stream_start+0x156/0x1f0 sound/usb/line6/pcm.c:195
  line6_pcm_acquire+0x134/0x210 sound/usb/line6/pcm.c:318
  line6_startup_work+0x42/0x50 sound/usb/line6/driver.c:725
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
