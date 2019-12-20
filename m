Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB712468C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTElM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:41:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36144 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:41:11 -0500
Received: by mail-il1-f197.google.com with SMTP id t2so2784448ilp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 20:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4uPXf7+5cmKfc17p96HCeqIMddSPnfeSwGfxcNcV1vs=;
        b=VY8ZPPZyeGrBlwMwRSVMMDca8a0t39hdwfN9y9kXLWCClq9Sg4HRB6afP8ZQyHGX3A
         gXzyh5Hp69cUksriFfLstzOzJa9fNKIXcYIfm2qZ60StvHRy9v1y44/GgiddYtx8bA7v
         3wC8OiQXdHwQh7Ind3Ut2ZH2dDrvm3JAlIad7hPaqzXt3UZMi5jv6sMR13Hbp52MiiWH
         4c7e83Xy34mkVFj1IST5sBg68154+wQ+dUb5TQZQcTst7pPc/x2IOAIIakVX07ZLOnjc
         ZOAg4lqKACJAHHhlFOSJq0nSrCVEoNMrFHMZsDN4kMlM3CDjmQ1aRvnDuMLSMwTeAiZ8
         Gjig==
X-Gm-Message-State: APjAAAWqt2ZF210KFHQpxdm2TPFhd76tkBU9/SZx80DgipkCNqFf0pij
        fU4xg5gHaIDdbAGGKsSH+7JDYYnlWGkiXvE96h1dhtv99MYm
X-Google-Smtp-Source: APXvYqwGL1EOWqCo952R7Tl2YpRQuyx8C7wZ/6pdyILMGCFvseoNbsMAmysSfaivn8KYDekccEYeUYcwi0tfdA7kCi4JZS+4yKIo
MIME-Version: 1.0
X-Received: by 2002:a6b:a0a:: with SMTP id z10mr8157848ioi.190.1576816869932;
 Thu, 19 Dec 2019 20:41:09 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:41:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000688674059a1b4925@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in drm_fb_helper_dirty_work
From:   syzbot <syzbot+5d11928e253121e6c196@syzkaller.appspotmail.com>
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

HEAD commit:    7e0165b2 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1619eb1ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b59a3066828ac4c
dashboard link: https://syzkaller.appspot.com/bug?extid=5d11928e253121e6c196
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5d11928e253121e6c196@syzkaller.appspotmail.com

BUG: KASAN: vmalloc-out-of-bounds in memcpy include/linux/string.h:380  
[inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_blit_real  
drivers/gpu/drm/drm_fb_helper.c:399 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_work+0x44c/0x780  
drivers/gpu/drm/drm_fb_helper.c:428
Read of size 4096 at addr ffffc90008bc1000 by task kworker/1:3/17225

CPU: 1 PID: 17225 Comm: kworker/1:3 Not tainted 5.5.0-rc2-syzkaller #0
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
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:380 [inline]
  drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:399 [inline]
  drm_fb_helper_dirty_work+0x44c/0x780 drivers/gpu/drm/drm_fb_helper.c:428
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


Memory state around the buggy address:
  ffffc90008bc0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc90008bc0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffc90008bc1000: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                    ^
  ffffc90008bc1080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90008bc1100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
