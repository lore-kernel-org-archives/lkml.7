Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6FDC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5069C20645
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfE0P2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:28:06 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56119 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfE0P2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:28:06 -0400
Received: by mail-it1-f197.google.com with SMTP id o126so16089762itc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gsOsI1+w66XacgBQHklfTvf3k1T3GWu7vTDh59E4hxc=;
        b=NF8wU8boaGFBTo3isUT46x74MVSYTdFvHaetZC3wM698KTqUmORFZrPtBnuU6y+pgj
         +IDLfDo76NKNBBzTk9FOkR8bgz2eKfKZPyoKyUhW02R0qlQ/cxICtPu5ZGd3wqfz7U/f
         nyAMqpIjoFFdCfzvgcH2zA4RFk+37E80LcwMMe9F0snuZauoswFISPODsOvBiW6Lx6H1
         nKYDR3w7SNloncVhp7Cyd6wJ7XT7IlOTBlx5lrvHSGuDDY8dmIf5fownYMwaEnhLWTYS
         H7mer5+nlVJID8nc8jrgdDxoXTUdzU5rKEegscLKzW/AjSt59ULXXJ0h3CEhfBKagomI
         pRqg==
X-Gm-Message-State: APjAAAWdUAkv2YSHz9Q7iCx9nm0ByOgyjXzIn5kg4Nz6MY4e70LH35LG
        bW2pKUbaor9rrLwNPZ0kiIQWaM7iQ0NTKLoKaEi9k7f9hMm2
X-Google-Smtp-Source: APXvYqzrZ/O/RowFsG6ZfOGxTVMSpJEnTdIdvqo9mh8nH/jskALOZBEWIe3src5ReKrEgvJD6nnuwT0sQ2VSJ8lyZ9gIqurU+nPY
MIME-Version: 1.0
X-Received: by 2002:a24:81d4:: with SMTP id q203mr28497223itd.55.1558970885496;
 Mon, 27 May 2019 08:28:05 -0700 (PDT)
Date:   Mon, 27 May 2019 08:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d865de0589e0311f@google.com>
Subject: KASAN: null-ptr-deref Write in submit_audio_out_urb
From:   syzbot <syzbot+5255458d5e0a2b10bbb9@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, andreyknvl@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=118b0aa2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
dashboard link: https://syzkaller.appspot.com/bug?extid=5255458d5e0a2b10bbb9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f4064ca00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d51982a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5255458d5e0a2b10bbb9@syzkaller.appspotmail.com

snd_usb_toneport 1-1:0.0: read request failed (error -110)
snd_usb_toneport 1-1:0.0: read request failed (error -110)
snd_usb_toneport 1-1:0.0: write request failed (error -110)
usb 1-1: send failed (error -110)
usb 1-1: send failed (error -110)
snd_usb_toneport 1-1:0.0: Line 6 POD Studio UX2 now attached
==================================================================
BUG: KASAN: null-ptr-deref in memset include/linux/string.h:344 [inline]
BUG: KASAN: null-ptr-deref in submit_audio_out_urb+0x919/0x1780  
sound/usb/line6/playback.c:246
Write of size 20 at addr 0000000000000010 by task kworker/1:2/2466

CPU: 1 PID: 2466 Comm: kworker/1:2 Not tainted 5.2.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events toneport_start_pcm
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x32 mm/kasan/report.c:321
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  memset+0x20/0x40 mm/kasan/common.c:107
  memset include/linux/string.h:344 [inline]
  submit_audio_out_urb+0x919/0x1780 sound/usb/line6/playback.c:246
  line6_submit_audio_out_all_urbs+0xc9/0x120 sound/usb/line6/playback.c:295
  line6_stream_start+0x156/0x1f0 sound/usb/line6/pcm.c:199
  line6_pcm_acquire+0x134/0x210 sound/usb/line6/pcm.c:322
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30e/0x420 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2466 Comm: kworker/1:2 Tainted: G    B             5.2.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events toneport_start_pcm
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6df kernel/panic.c:218
  end_report+0x43/0x49 mm/kasan/report.c:95
  __kasan_report.cold+0xd/0x32 mm/kasan/report.c:324
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  memset+0x20/0x40 mm/kasan/common.c:107
  memset include/linux/string.h:344 [inline]
  submit_audio_out_urb+0x919/0x1780 sound/usb/line6/playback.c:246
  line6_submit_audio_out_all_urbs+0xc9/0x120 sound/usb/line6/playback.c:295
  line6_stream_start+0x156/0x1f0 sound/usb/line6/pcm.c:199
  line6_pcm_acquire+0x134/0x210 sound/usb/line6/pcm.c:322
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30e/0x420 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
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
