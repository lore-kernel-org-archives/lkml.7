Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F2820684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408606AbfJXHaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:30:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:54350 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbfJXHaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:30:07 -0400
Received: by mail-io1-f72.google.com with SMTP id d11so10122145ioc.21
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bG9AfwGQyHCYq71fTKJXTFrNumlZlH8tez4WRY0shAM=;
        b=gRyqy3JqvAjz2UGHeKMF/xJyaJqWl1OmEpPNbSgpD2eir8tI92CWwD8J71PvdJa/1t
         gSzLgeSydfvbddXMbiT8TU6W45Mc/iBm/jF8mV7xVdl6YWQfURT4iq59xiHel8FR7PfL
         eaEXYk6d964hdO5vXsn0GqXLzrkI/BhkJk5gnhWTIAb58RDYKlawwNV1LUtRACWMrTV0
         iFwAv0qL7RES1e39CBs52iIdcz1Zq4iye718xUcg1N54wMiV3k0b9/xL5sCwMstMXIsk
         XCS5woM71kOPrdhgxDKXesHQaOb8oHOkAjTZjay1Il8NnZRHIprtX5QfZUmmVrNhDYPB
         jpRg==
X-Gm-Message-State: APjAAAUmv+9soOHIEMUa2IUUDRAag0mfZkpNpkYA6Zgl+Qu5UiOLrsJG
        pFz12juzBN7v6SHBgIUU/KMteaC9HQqzaVOPMX3kTAlGUYh3
X-Google-Smtp-Source: APXvYqwsfIGrEWu10ZmmgfjvCeOiGt6WOq+be5EYAmWm5Asd9EHCWoejSzEj21h8XYtEDFWQrHZZH5mbW5mxthpsq7lUTb1qGXH3
MIME-Version: 1.0
X-Received: by 2002:a6b:7a04:: with SMTP id h4mr7488106iom.210.1571902206601;
 Thu, 24 Oct 2019 00:30:06 -0700 (PDT)
Date:   Thu, 24 Oct 2019 00:30:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5727f0595a30026@google.com>
Subject: KCSAN: data-race in common_perm_cond / task_dump_owner
From:   syzbot <syzbot+109584edb0b8511d7dad@syzkaller.appspotmail.com>
To:     elver@google.com, jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=155db950e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=109584edb0b8511d7dad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+109584edb0b8511d7dad@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in common_perm_cond / task_dump_owner

read to 0xffff888124ca931c of 4 bytes by task 7605 on cpu 0:
  common_perm_cond+0x65/0x110 security/apparmor/lsm.c:217
  apparmor_inode_getattr+0x2b/0x40 security/apparmor/lsm.c:389
  security_inode_getattr+0x9b/0xd0 security/security.c:1222
  vfs_getattr+0x2e/0x70 fs/stat.c:115
  vfs_statx+0x102/0x190 fs/stat.c:191
  vfs_stat include/linux/fs.h:3242 [inline]
  __do_sys_newstat+0x51/0xb0 fs/stat.c:341
  __se_sys_newstat fs/stat.c:337 [inline]
  __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff888124ca931c of 4 bytes by task 7608 on cpu 1:
  task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
  pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
  pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
  d_revalidate fs/namei.c:758 [inline]
  d_revalidate fs/namei.c:755 [inline]
  lookup_fast+0x6f2/0x700 fs/namei.c:1607
  walk_component+0x6d/0xe80 fs/namei.c:1796
  link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2131
  link_path_walk fs/namei.c:2062 [inline]
  path_openat+0x14f/0x36e0 fs/namei.c:3524
  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7608 Comm: ps Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
