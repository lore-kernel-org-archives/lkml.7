Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F30AC43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C452073C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 15:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfLAPLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 10:11:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:46740 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfLAPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 10:11:10 -0500
Received: by mail-il1-f197.google.com with SMTP id i74so29553589ild.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 07:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5CLgl9PicPFQzTSO+Rj6AM4Crp6GMlB9i01lWqmMoZY=;
        b=LmRHh5H0FQrugPoxZgbnW7Lut/kxirGUzwTlrwqpfJDjimXQM2Gwn81hlVJsCtcrKZ
         l3vukDv+5zw6qP69RUQle9AxRm5ZHO3xpgEm4EQHh328mAN1jtbAShHnj/nHCVlAhATp
         HB93ukv9PD7MNEtuWZ/bEgJreFP1TmMGoJwIkggmVNYa+gLwJ7KWW506Af6YE3ShXFEo
         CJWpQQ/XsyB/NZkOV1ZYdC3gx7JHWDGKOJz6v9ogCEDoeBpW9hAcpcY58+yRoOpXS9yT
         sHn1pPXEo8GnwnKkT4vX9wcyuXP2Lfs9rNs1u+1UG7ygFPahbqCUbrc+Mmonz7DQchoI
         h2+w==
X-Gm-Message-State: APjAAAWwZL/rrZgy1z/8FTC6WYSKHZKxXB0T7F06tNV/RLSSmgxJcysc
        66uxlyH7JIcyhzMxtGz4geEdf1YgQoR7ZKkCaWEroKAR1vO+
X-Google-Smtp-Source: APXvYqzJG5WRqgZqLGJujrlSVHJgyb+ao7O8jckp/QFFKxX2gYzogONhOwET8xdun3BAPpWCmNoeLAsGqHkr+/MG5lUg0Mrn0Q90
MIME-Version: 1.0
X-Received: by 2002:a92:690c:: with SMTP id e12mr61025372ilc.153.1575213067870;
 Sun, 01 Dec 2019 07:11:07 -0800 (PST)
Date:   Sun, 01 Dec 2019 07:11:07 -0800
In-Reply-To: <000000000000c280ba05988b6242@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b28f90598a5df9c@google.com>
Subject: Re: BUG: sleeping function called from invalid context in __alloc_pages_nodemask
From:   syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, aryabinin@virtuozzo.com,
        christophe.leroy@c-s.fr, dja@axtens.net, dvyukov@google.com,
        glider@google.com, gor@linux.ibm.com, hdanton@sina.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com,
        penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    419593da Add linux-next specific files for 20191129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177a9712e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16148e9ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1f786e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9065, name:  
kworker/1:3
4 locks held by kworker/1:3/9065:
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: __write_once_size  
include/linux/compiler.h:247 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set  
arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:868 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: set_work_data  
kernel/workqueue.c:615 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
  #1: ffffc90002177dc0 (pcpu_balance_work){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
  #2: ffffffff8983ff20 (pcpu_alloc_mutex){+.+.}, at:  
pcpu_balance_workfn+0xb7/0x1310 mm/percpu.c:1845
  #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
  #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at:  
pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
Preemption disabled at:
[<ffffffff81a89ce7>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81a89ce7>] pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
CPU: 1 PID: 9065 Comm: kworker/1:3 Not tainted  
5.4.0-next-20191129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events pcpu_balance_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
  __alloc_pages_nodemask+0x523/0x910 mm/page_alloc.c:4730
  alloc_pages_current+0x107/0x210 mm/mempolicy.c:2211
  alloc_pages include/linux/gfp.h:532 [inline]
  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
  kasan_populate_vmalloc_pte+0x2f/0x1c0 mm/kasan/common.c:753
  apply_to_pte_range mm/memory.c:2041 [inline]
  apply_to_pmd_range mm/memory.c:2068 [inline]
  apply_to_pud_range mm/memory.c:2088 [inline]
  apply_to_p4d_range mm/memory.c:2108 [inline]
  apply_to_page_range+0x445/0x700 mm/memory.c:2133
  kasan_populate_vmalloc+0x68/0x90 mm/kasan/common.c:791
  pcpu_get_vm_areas+0x3c77/0x3f00 mm/vmalloc.c:3439
  pcpu_create_chunk+0x24e/0x7f0 mm/percpu-vm.c:340
  pcpu_balance_workfn+0xf1b/0x1310 mm/percpu.c:1934
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

