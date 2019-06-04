Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0362EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C601C20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 21:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfFDVTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 17:19:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47217 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:19:06 -0400
Received: by mail-io1-f70.google.com with SMTP id r27so17404880iob.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 14:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0iJ/CisaeAFt6kjSxf0PDnzBYqaLMd8GZ6ICt72+F8c=;
        b=MUDtg/boKAwpVXe0inh9RNYAulAUO+vafYeIe6qxiSPK+Y8l74rV50d0O5+hejbZt8
         REG+qLihFlFmeAavKF78OJ91M1unWVuGAUOHsXlOTjvovsIfg61xctvDtLAMdN9csOTq
         u9tnIbmDSmKbyRAjEO9QxdUpMcAXI5ZWWlMQUPXhqdS7RIVrYVymI9sJe+JiUn1xOJIH
         4ej6+ysJGdk94HKswqe5SjleIqpW7jvwjprn0p4JJh5CdEulKaesoEhH7jqK9hc2B0nk
         oDaxtfUrrVpd2LHNc1qk1a7pZ8Upa6UmCzmb8Zi0JzbzsplaKK9VETw5wDGbHSvjEmHA
         AE2g==
X-Gm-Message-State: APjAAAX+E50wnUzKs/wLTWChowz4pedy6vQ7ju8fMaG5TDb/IQNjSUyD
        o4LbdXUY7S3vU4+MhT/fgLijnnxlvn4e9U3CWfB2umonUZl/
X-Google-Smtp-Source: APXvYqww+IWWlnUeKm2m4DZKJtmvDhFfbtTotLDezLfaqhvRpapQUBIBo5TiP0EjNwhcIykXfggRbGqXtXWEOZsR5RvhIHP9g4NH
MIME-Version: 1.0
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr22747234ioc.257.1559683145579;
 Tue, 04 Jun 2019 14:19:05 -0700 (PDT)
Date:   Tue, 04 Jun 2019 14:19:05 -0700
In-Reply-To: <000000000000543e45058a3cf40b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dac5a0058a860712@google.com>
Subject: Re: possible deadlock in get_user_pages_unlocked (2)
From:   syzbot <syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com, jhubbard@nvidia.com,
        keith.busch@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@linux.ibm.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13241716a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=e1374b2ec8f6a25ab2e5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165757eea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd3e86a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc3-next-20190604 #8 Not tainted
------------------------------------------------------
syz-executor842/8767 is trying to acquire lock:
00000000badb3a6d (&mm->mmap_sem#2){++++}, at:  
get_user_pages_unlocked+0xfc/0x4a0 mm/gup.c:1174

but task is already holding lock:
0000000052562d44 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_trylock  
include/linux/fs.h:798 [inline]
0000000052562d44 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#10){+.+.}:
        down_write+0x38/0xa0 kernel/locking/rwsem.c:66
        inode_lock include/linux/fs.h:778 [inline]
        process_measurement+0x15ae/0x15e0  
security/integrity/ima/ima_main.c:228
        ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
        security_file_mprotect+0xd5/0x100 security/security.c:1426
        do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
        __do_sys_mprotect mm/mprotect.c:582 [inline]
        __se_sys_mprotect mm/mprotect.c:579 [inline]
        __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:579
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&mm->mmap_sem#2){++++}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
        down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
        get_user_pages_unlocked+0xfc/0x4a0 mm/gup.c:1174
        __gup_longterm_unlocked mm/gup.c:2193 [inline]
        get_user_pages_fast+0x43f/0x530 mm/gup.c:2245
        iov_iter_get_pages+0x2c2/0xf80 lib/iov_iter.c:1287
        dio_refill_pages fs/direct-io.c:171 [inline]
        dio_get_page fs/direct-io.c:215 [inline]
        do_direct_IO fs/direct-io.c:983 [inline]
        do_blockdev_direct_IO+0x3f7b/0x8e00 fs/direct-io.c:1336
        __blockdev_direct_IO+0xa1/0xca fs/direct-io.c:1422
        ext4_direct_IO_write fs/ext4/inode.c:3782 [inline]
        ext4_direct_IO+0xaa7/0x1bb0 fs/ext4/inode.c:3909
        generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3110
        __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3293
        ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1870 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        vfs_write+0x268/0x5d0 fs/read_write.c:558
        ksys_write+0x14f/0x290 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sb->s_type->i_mutex_key#10);
                                lock(&mm->mmap_sem#2);
                                lock(&sb->s_type->i_mutex_key#10);
   lock(&mm->mmap_sem#2);

  *** DEADLOCK ***

2 locks held by syz-executor842/8767:
  #0: 0000000065e8e19a (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2836 [inline]
  #0: 0000000065e8e19a (sb_writers#3){.+.+}, at: vfs_write+0x485/0x5d0  
fs/read_write.c:557
  #1: 0000000052562d44 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
inode_trylock include/linux/fs.h:798 [inline]
  #1: 0000000052562d44 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

stack backtrace:
CPU: 0 PID: 8767 Comm: syz-executor842 Not tainted 5.2.0-rc3-next-20190604  
#8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.cold+0x1cc/0x28f kernel/locking/lockdep.c:1566
  check_prev_add kernel/locking/lockdep.c:2311 [inline]
  check_prevs_add kernel/locking/lockdep.c:2419 [inline]
  validate_chain kernel/locking/lockdep.c:2801 [inline]
  __lock_acquire+0x3755/0x5490 kernel/locking/lockdep.c:3790
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
  down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
  get_user_pages_unlocked+0xfc/0x4a0 mm/gup.c:1174
  __gup_longterm_unlocked mm/gup.c:2193 [inline]
  get_user_pages_fast+0x43f/0x530 mm/gup.c:2245
  iov_iter_get_pages+0x2c2/0xf80 lib/iov_iter.c:1287
  dio_refill_pages fs/direct-io.c:171 [inline]
  dio_get_page fs/direct-io.c:215 [inline]
  do_direct_IO fs/direct-io.c:983 [inline]
  do_blockdev_direct_IO+0x3f7b/0x8e00 fs/direct-io.c:1336
  ? 0xffffffff81000000
  __blockdev_direct_IO+0xa1/0xca fs/direct-io.c:1422
  ext4_direct_IO_write fs/ext4/inode.c:3782 [inline]
  ext4_direct_IO+0xaa7/0x1bb0 fs/ext4/inode.c:3909
  generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3110
  __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3293
  ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440a49
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc18e28968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004a22e0 RCX: 0000000000440a49
RDX: 0000000020000012 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000004a2370 R08: 0000000000000012 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f90
R13: 0000000000402020 R14: 0000000000000000 R15: 0000000000000000

