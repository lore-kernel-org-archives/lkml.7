Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB99206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLWRbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:31:12 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:36899 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:31:10 -0500
Received: by mail-io1-f70.google.com with SMTP id t70so11924084iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eL67erF5b/D4o9JZa82w4s9J/Ia6904jypmJD84P8Jg=;
        b=gUuCWcDG3v6aq8MxnOEx83sJystdxKqK/YTKOz+hk7L2B+JI11pwVL3A1kKqvdS/Uz
         aLf8MNBZi2w18hxSRgS5ju5Quu1RnvDq3n3iLTLD4Oa2VTLyWfKFlzlVwBJN7SbvQSuZ
         Q46M+fZDt+JjxRZJql7f8IH0JjKPxzrSupy+/THi5WrNw0HfVIqete9Cyjj0Dh/2UzrO
         kt3C4L+m1z9/zm6zZJ65REg3xCDIX+8XyIHwiBm6lfNXn7D+qhmpVxj/h+3dFuzJXAki
         4v2nTuH0bu1zKrwP434lSqu0hqYC7ysB9lE3UC0EVB2XQ+3+THhDugwhmgFl4EoOLs9i
         SRrw==
X-Gm-Message-State: APjAAAXjjHqb3CXNZ5yJAmTc6ODyF1db7N6bWIKawom6QnmOMvVqQwAM
        lYlR/0ygSGqsamCUAK7ZXBi3damg+fATz8HbzWarBlmLqlBY
X-Google-Smtp-Source: APXvYqyw7HWsVjlNRl3b6jvlwBnjYKNCBnTeC9/e8Rn4SkGEtpYdMlCoAuseRdhyiOaw02WHTHfNhxxp3E3BL7UiWNpZZj/WrlaC
MIME-Version: 1.0
X-Received: by 2002:a92:d18a:: with SMTP id z10mr27277028ilz.48.1577122268478;
 Mon, 23 Dec 2019 09:31:08 -0800 (PST)
Date:   Mon, 23 Dec 2019 09:31:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009484f4059a6264f6@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in drm_fb_helper_dirty_work
From:   syzbot <syzbot+fd418471717e1e1aa783@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    62104694 Merge branch 'parisc-5.5-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1711b6c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b59a3066828ac4c
dashboard link: https://syzkaller.appspot.com/bug?extid=fd418471717e1e1aa783
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fd418471717e1e1aa783@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in memcpy include/linux/string.h:380  
[inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_blit_real  
drivers/gpu/drm/drm_fb_helper.c:399 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_work+0x44c/0x780  
drivers/gpu/drm/drm_fb_helper.c:428
Write of size 4064 at addr ffffc9000adea020 by task kworker/2:2/8685

CPU: 2 PID: 8685 Comm: kworker/2:2 Not tainted 5.5.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x38/0x50 mm/kasan/common.c:126
  memcpy include/linux/string.h:380 [inline]
  drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:399 [inline]
  drm_fb_helper_dirty_work+0x44c/0x780 drivers/gpu/drm/drm_fb_helper.c:428
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


Memory state around the buggy address:
  ffffc9000ade9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc9000ade9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffc9000adea000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                                ^
  ffffc9000adea080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc9000adea100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
