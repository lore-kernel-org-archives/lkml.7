Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C5C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83120838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLZS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:59:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:38660 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:59:09 -0500
Received: by mail-il1-f200.google.com with SMTP id i67so21406398ilf.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 10:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TNo0QHyIeHdI/8GLONj6hbWPDE88TILb9xkj6RUQsSU=;
        b=a5ezhKRRxu9OtR8f85G6auD4KhKDvOmRm08C49LEc2cp64vOIiXouiUrboGG41S9cC
         cEWXof6NPMUrL0UcC+w3/6cyuvFtDNtTUylYZZ3T8bU2J0eoIDdaJd+EAY5UOUHiDLbE
         2IfvyFJ2Vh0YHZv0ylmO/LZtmsEnbFWda32s7GPYkd227HPaSIGDrossE0TUyS31/SeL
         Z8nyrJreou3S/BogcL0B3i7wzDfg6RWjVTJ0EA5NRmniuOMCAA/r+bQxw5TneQ968sMo
         oaKO/X+77HRZpm+mwDD0VMZa4hIzpnzNfrqvRXonrqHlF1dshauBKq0dUvUL35VkSL6Z
         Ty0A==
X-Gm-Message-State: APjAAAXwbIH+WSwDWl/SR9LS2TKFpcXNF2rjyOEE3OO8Pk9si8OycY5i
        T5CtIwA3ajphUvjmo6YnA4NXW5+aUlad6+mPGiFIvx5bDStv
X-Google-Smtp-Source: APXvYqwLsoPbnZNDL141I7xVT62mvkZcF8D3gKtHxDqMdO+g8VRSHXkHzrX3fgjNRU3y1dP84SMEw9ukIxpeSESgakL8a0gBWPJ+
MIME-Version: 1.0
X-Received: by 2002:a92:d805:: with SMTP id y5mr39807073ilm.194.1577386748390;
 Thu, 26 Dec 2019 10:59:08 -0800 (PST)
Date:   Thu, 26 Dec 2019 10:59:08 -0800
In-Reply-To: <000000000000b6b450059870d703@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfb39e059a9ff822@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in precalculate_color
From:   syzbot <syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        lucho@ionkov.net, mchehab@kernel.org, netdev@vger.kernel.org,
        rminnich@sandia.gov, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11932ce1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=02d9172bf4c43104cd70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14861a49e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1794423ee00000

The bug was bisected to:

commit 7594bf37ae9ffc434da425120c576909eb33b0bc
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Jul 17 02:53:08 2017 +0000

     9p: untangle ->poll() mess

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e323a6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e323a6e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+02d9172bf4c43104cd70@syzkaller.appspotmail.com
Fixes: 7594bf37ae9f ("9p: untangle ->poll() mess")

==================================================================
BUG: KASAN: global-out-of-bounds in precalculate_color+0x2154/0x2480  
drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:942
Read of size 1 at addr ffffffff88b3d3f9 by task vivid-000-vid-c/9278

CPU: 0 PID: 9278 Comm: vivid-000-vid-c Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
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
  kbd_keycodes+0x119/0x760

Memory state around the buggy address:
  ffffffff88b3d280: fa fa fa fa 00 00 04 fa fa fa fa fa 00 00 00 00
  ffffffff88b3d300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffffffff88b3d380: 00 00 00 00 00 00 00 00 00 00 00 00 fa fa fa fa
                                                                 ^
  ffffffff88b3d400: 00 00 00 00 07 fa fa fa fa fa fa fa 00 00 00 00
  ffffffff88b3d480: 00 fa fa fa fa fa fa fa 02 fa fa fa fa fa fa fa
==================================================================

