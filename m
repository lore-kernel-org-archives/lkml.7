Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CFBC010C6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4B21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfKELtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:49:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37025 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbfKELtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:49:09 -0500
Received: by mail-io1-f69.google.com with SMTP id u13so8635748iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7ZZrgNYqJIcz9203YVjUBSmOD61O6tx3rapg2b0VLNU=;
        b=XZy+fptnV7N2wofBNV9CO5PZl4bCcnef6tuMiRhgwq9b1HAsw1K6cABd7rESRL8Ulq
         QezWhIQPEBnfxglmR73wPpcLDcbVWxsqgqZk3oXGNcNyJ/pGIVCtklM0rgsmBBSjtW3c
         qZkLChh0NiqnOSrv0CEMsyh3F9d/7wt5ghIfBA8zood/jnfIhNVoxe2VVLoKqNEaEwOk
         expSCEcVXnwptau0QtdgU1cFbBWcFCxYQaqd4CHAKO63UqWfUe4ZIwgV+obb41uT9LQ6
         rPeIEaLVcA23soX/eYRxg8hzqu03CTkYkY8cVFAlXIFWA6iPK9jyrG+9aneaJSPYgfoz
         3iOw==
X-Gm-Message-State: APjAAAXS04v86jq8w/fCXqMnLo1kG2HzUcQqc7iOVp0mxuGMqwybYEBj
        lwmi7uiKeC9Mz8N7lAYMvjqei5nky1ymMoe4HlDeZdiSV8+z
X-Google-Smtp-Source: APXvYqw33Q5IVxSI5ZQAjzSMtpWG5MhFfC4e8zwpXxFZO5BZKYPRJbiLkRA57zHHcohbRWYYHOuGxJKTnKVPgQ5eJMzyakePQuha
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2496:: with SMTP id g22mr4713011ioe.246.1572954548115;
 Tue, 05 Nov 2019 03:49:08 -0800 (PST)
Date:   Tue, 05 Nov 2019 03:49:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016a19d0596980568@google.com>
Subject: KCSAN: data-race in fat16_ent_put / fat_search_long
From:   syzbot <syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com>
To:     elver@google.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=14ccaac8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=11010f0000e50c63c2cc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+11010f0000e50c63c2cc@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fat16_ent_put / fat_search_long

write to 0xffff8880a209c96a of 2 bytes by task 11985 on cpu 0:
  fat16_ent_put+0x5b/0x90 fs/fat/fatent.c:181
  fat_ent_write+0x6d/0xf0 fs/fat/fatent.c:415
  fat_chain_add+0x34e/0x400 fs/fat/misc.c:130
  fat_add_cluster+0x92/0xd0 fs/fat/inode.c:112
  __fat_get_block fs/fat/inode.c:154 [inline]
  fat_get_block+0x3ae/0x4e0 fs/fat/inode.c:189
  __block_write_begin_int+0x2ea/0xf20 fs/buffer.c:1968
  __block_write_begin fs/buffer.c:2018 [inline]
  block_write_begin+0x77/0x160 fs/buffer.c:2077
  cont_write_begin+0x3d6/0x670 fs/buffer.c:2426
  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
  cont_expand_zero fs/buffer.c:2353 [inline]
  cont_write_begin+0x17a/0x670 fs/buffer.c:2416
  fat_write_begin+0x72/0xc0 fs/fat/inode.c:235
  pagecache_write_begin+0x6b/0x90 mm/filemap.c:3148
  generic_cont_expand_simple+0xb0/0x120 fs/buffer.c:2317

read to 0xffff8880a209c96b of 1 bytes by task 11990 on cpu 1:
  fat_search_long+0x20a/0xc60 fs/fat/dir.c:484
  vfat_find+0xc1/0xd0 fs/fat/namei_vfat.c:698
  vfat_lookup+0x75/0x350 fs/fat/namei_vfat.c:712
  lookup_open fs/namei.c:3203 [inline]
  do_last fs/namei.c:3314 [inline]
  path_openat+0x15b6/0x36e0 fs/namei.c:3525
  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 11990 Comm: syz-executor.2 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
