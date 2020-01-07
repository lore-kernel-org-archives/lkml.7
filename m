Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93520C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9AF207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgAGIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:17:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41797 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgAGIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:17:10 -0500
Received: by mail-io1-f69.google.com with SMTP id m12so12007457ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 00:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sWRGtZyhrTa5cnofeyFrm2ZXt4tjqGK52iR9mR6FDmI=;
        b=NMqqJqvr9ER35RYTKpU84KnxFUogn64ZvmercIwd90FQ/jcZUYqz8IMzfgjVyVdLJS
         BpVcFHcN0jGcc6eXWpbZIYWTmkoMjI+Kqd8oJLtvo2HK5vDw4ihmyAcyfRPXu3poOvtM
         K7bgAGmIMA8AzX12RnyWG5zJ6b9Jcj7gk3wwINWlW7EN1/K2lICcT5Tw0aOXpiTZLAA5
         mBy872fhTc8g0joErHY9Gp88giYwoeKK4X1yBC2CoxrWyLS1b6X/GZ9IPcVnEEeK+ujQ
         EnVgi4H07p9lz+hNYZWZoifN4yq9/VDUGy1dmCOWyE71K7FV9GHrgASEgqLjR+bYdH+z
         LNvg==
X-Gm-Message-State: APjAAAUFbCvEEh5MrTwSOobA5y0peejkPY7NxckImIjUULvu1emEZ4Fj
        k/upHATd/R0In1Z8A038D9agT1EzpjsLVmr1bsU4oL11i6Qn
X-Google-Smtp-Source: APXvYqwpyHHTx23AZtUaH6jgl3Hngv/FxRQRXeeujJMl1paZJYC6e68a5gAwAV6Dx4tz0KPVHYkW0QxYTL+D4DaFRAzSbfjuyAhZ
MIME-Version: 1.0
X-Received: by 2002:a5e:cb4b:: with SMTP id h11mr66105785iok.302.1578385029481;
 Tue, 07 Jan 2020 00:17:09 -0800 (PST)
Date:   Tue, 07 Jan 2020 00:17:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000004d9d059b88678a@google.com>
Subject: KCSAN: data-race in pid_update_inode / pid_update_inode
From:   syzbot <syzbot+41a393c8d33874c463e9@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io, elver@google.com,
        keescook@chromium.org, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=123776e1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a38292766f8efdaa
dashboard link: https://syzkaller.appspot.com/bug?extid=41a393c8d33874c463e9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+41a393c8d33874c463e9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in pid_update_inode / pid_update_inode

read to 0xffff88812b806828 of 2 bytes by task 11180 on cpu 1:
  pid_update_inode+0x25/0x70 fs/proc/base.c:1818
  pid_revalidate+0x91/0x120 fs/proc/base.c:1841
  d_revalidate fs/namei.c:758 [inline]
  d_revalidate fs/namei.c:755 [inline]
  lookup_fast+0x612/0x6c0 fs/namei.c:1618
  do_last fs/namei.c:3291 [inline]
  path_openat+0x2ac/0x3580 fs/namei.c:3537
  do_filp_open+0x11e/0x1b0 fs/namei.c:3567
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff88812b806828 of 2 bytes by task 11178 on cpu 0:
  pid_update_inode+0x51/0x70 fs/proc/base.c:1820
  pid_revalidate+0x91/0x120 fs/proc/base.c:1841
  d_revalidate fs/namei.c:758 [inline]
  d_revalidate fs/namei.c:755 [inline]
  lookup_fast+0x612/0x6c0 fs/namei.c:1618
  do_last fs/namei.c:3291 [inline]
  path_openat+0x2ac/0x3580 fs/namei.c:3537
  do_filp_open+0x11e/0x1b0 fs/namei.c:3567
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 11178 Comm: ps Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
