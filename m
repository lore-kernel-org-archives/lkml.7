Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6581C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85C621721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfK1XzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 18:55:08 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54415 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1XzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 18:55:08 -0500
Received: by mail-il1-f197.google.com with SMTP id t4so4720869ili.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 15:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0V/6lL9I0acfOSweWtVPvaIn/nUaZnoMveV6808kEXU=;
        b=BLgnKwzc9mmSZJk6Lms9SnbjcVMIsQ6K0Tn40gYXsbVBHB9VcQx3KobyeLaS0JZirN
         ItXAbLKwtM1FqWKNQbDR0xNkeX8jE8dE7l5lF8/wW9TGg1hz02BqWsdabhFGdHQj0ulK
         cMLiO1G4WRORiiONWwtpxQ18XLHgovC+hwrVnLLr2+G0G10Y5vh9tO+CaywAxBWKFOYI
         NzutCF/hwSLZiHq5CLvpUmoRsceuo6K8VX7Md4G/HgtcT+t2FKUAOyInfsZjhpLFn40P
         v6OxTvKmSv/BtuMlBFol69aujUpvNjyDmnl/cxPKcI5/S7+rUkpRhXfMgJk34KZRtA74
         REJQ==
X-Gm-Message-State: APjAAAUDQPEHq9P8G1IgynTVYXkbgZVFwMzGuMsI6Dw6RxtzRsUpUaOB
        b9r8/Bn9Z241Scl/OQwNbM6rttpmf/XCCfNUxR3p6rNLjLxu
X-Google-Smtp-Source: APXvYqx4SNpkxQrj/dGNZOwA8NsJn/R79A+jFWDOYwcgaU7e3l7RSATiB7YdL4DnwNqezaFDjZpEmP8Q1XG9aT6KXeNItGuwXriM
MIME-Version: 1.0
X-Received: by 2002:a02:a889:: with SMTP id l9mr3730808jam.1.1574985306385;
 Thu, 28 Nov 2019 15:55:06 -0800 (PST)
Date:   Thu, 28 Nov 2019 15:55:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6b450059870d703@google.com>
Subject: KASAN: global-out-of-bounds Read in precalculate_color
From:   syzbot <syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com>
To:     hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d7688697 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125118a2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=121b4285bac421fe
dashboard link: https://syzkaller.appspot.com/bug?extid=02d9172bf4c43104cd70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119c517ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in precalculate_color+0x2154/0x2480  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:942
Read of size 1 at addr ffffffff884787bf by task vivid-000-vid-c/8948

CPU: 1 PID: 8948 Comm: vivid-000-vid-c Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:129
  precalculate_color+0x2154/0x2480  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:942
  tpg_precalculate_colors drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:1093  
[inline]
  tpg_recalc+0x561/0x2850 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2118
  tpg_calc_text_basep+0xa1/0x290  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:2136
  vivid_fillbuff+0x1a5f/0x3af0  
drivers/media/platform/vivid/vivid-kthread-cap.c:466
  vivid_thread_vid_cap_tick+0x8cf/0x2210  
drivers/media/platform/vivid/vivid-kthread-cap.c:727
  vivid_thread_vid_cap+0x5d8/0xa60  
drivers/media/platform/vivid/vivid-kthread-cap.c:866
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the variable:
  sin+0x17f/0x280

Memory state around the buggy address:
  ffffffff88478680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffffff88478700: 00 00 00 00 00 00 00 00 01 fa fa fa fa fa fa fa
> ffffffff88478780: 00 00 06 fa fa fa fa fa 04 fa fa fa fa fa fa fa
                                         ^
  ffffffff88478800: 05 fa fa fa fa fa fa fa 05 fa fa fa fa fa fa fa
  ffffffff88478880: 00 00 fa fa fa fa fa fa 00 00 00 00 00 00 fa fa
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
