Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D362084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDIOgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:36:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34408 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfDIOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:36:02 -0400
Received: by mail-io1-f70.google.com with SMTP id y13so14165959iol.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mEQkGT7iJSk6abWCfz2qxrwMGOPOmG8LOxSSomFQ5oI=;
        b=VrUghqDGihLkllizszivk1tjMRypjaaG2txsndoaVSLSxztVL6I8HypgZ2zSGScJt6
         9IDDhH+HPCb9oiWoYRxjJ5y7YWbcfYNJrSYiAGb3iNaILCXi70L3trJP+QaXhzP2b2Rp
         GcPkWz5blifnkTazEKWna6bayQKPxeNMFsshcVfQwjReNr2vWm43TVoppgG5ZsqDxHP/
         fHZjRc8AjdPgUWUA+YYk4a5B3/LUwsPlkdi1og3td9LSkIf62DwJnwRltYNvIcDopnlK
         gCG92ErUNHwn5js/R3b5fn+IoslpHJ5rqE+0SX4Tf2VFIrfkpoegQo/jyO8BXC1PZNeY
         QoXQ==
X-Gm-Message-State: APjAAAWJiyHKRv1vVxl+8EXaekeW1DdMbpjnx1Z0CdO0z9/GvdM1eqPb
        GBM5yNhTonIjeGNSkXWqDnyJCI4wiYYmMaEzebvuhFUFss5f
X-Google-Smtp-Source: APXvYqzDhvZKKItNzLO27hTXEzJtA1bL8CFh1mjrn1zPXEcBfvEbQ2R0MTxBiM9CKviHxHbM4SkBLe2LdSW11ZFiSD9O5u/Y6rHH
MIME-Version: 1.0
X-Received: by 2002:a5d:899a:: with SMTP id m26mr6128245iol.5.1554820560752;
 Tue, 09 Apr 2019 07:36:00 -0700 (PDT)
Date:   Tue, 09 Apr 2019 07:36:00 -0700
In-Reply-To: <00000000000051e9c2057d31a563@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036a4a9058619dff3@google.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, raven@themaw.net,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bisection is inconclusive: the first bad commit could be any of:

cd4f2a66 lib/genalloc.c: fix allocation of aligned buffer from non-aligned  
chunk
df3f18d3 fls: change parameter to unsigned int
9067c8d5 lib/find_bit_benchmark.c: align test_find_next_and_bit with others
c2824829 include/linux/printk.h: drop silly "static inline asmlinkage" from  
dump_stack()
26e88a47 checkpatch: warn on const char foo[] = "bar"; declarations
e98eceb8 drivers/dma-buf/udmabuf.c: convert to use vm_fault_t
5b6bf71d build_bug.h: remove most of dummy BUILD_BUG_ON stubs for Sparse
f34c9474 fs/epoll: remove max_nests argument from ep_call_nested()
56f6c16e build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
cd2f11e6 fs/epoll: simplify ep_send_events_proc() ready-list loop
74a37b90 Documentation/process/coding-style.rst: don't use "extern" with  
function prototypes
ab1909a8 fs/epoll: drop ovflist branch prediction
499aeb57 proc/sysctl: fix return error for proc_doulongvec_minmax()
b7fa8017 fs/epoll: robustify ep->mtx held checks
d877fd09 fs/proc/base.c: slightly faster /proc/*/limits
f2c37862 fs/epoll: reduce the scope of wq lock in epoll_wait()
860705c8 fs-epoll-reduce-the-scope-of-wq-lock-in-epoll_wait-fix
c62975fb fs/proc/inode.c: delete unnecessary variable in proc_alloc_inode()
9460069d fs/proc/util.c: include fs/proc/internal.h for name_to_int()
ea5f967a fs/epoll: avoid barrier after an epoll_wait(2) timeout
b61909d2 fs-epoll-avoid-barrier-after-an-epoll_wait2-timeout-fix
c768eca0 fs/proc/base.c: use ns_capable instead of capable for timerslack_ns
81553cde fs/epoll: rename check_events label to send_events
b6af7800 fs/buffer.c: add debug print for __getblk_gfp() stall problem
11193e16 mm/page_owner: align with pageblock_nr pages
349afd96 fs/epoll: deal with wait_queue only once
393af37c fs-epoll-deal-with-wait_queue-only-once-fix
c20187bf mm/page_owner: align with pageblock_nr_pages
20fbef31 mm: don't expose page to fast gup before it's ready
ad4f37b8 init/main.c: make "initcall_level_names[]" const char *
0bcbe611 autofs: improve ioctl sbi checks
69ab6b14 mm: fix race between swapoff and mincore
b783d261 autofs-improve-ioctl-sbi-checks-fix
de44564f mm, swap: fix race between swapoff and some swap operations
010a80ff mm, swap: fix race between swapoff and some swap operations
9c82e3b8 autofs: fix possible inode leak in autofs_fill_super()
855b7de1 mm/page_alloc.c: remove software prefetching in __free_pages_core()
cd4d5fa9 autofs: simplify parse_options() function call
e8fed666 memory_hotplug-free-pages-as-higher-order-fix-fix
f7aa1250 autofs: change catatonic setting to a bit flag
578f6458 autofs: add strictexpire mount option
71e7f022 memory_hotplug-free-pages-as-higher-order-fix
8286148b mm/page_alloc.c: memory hotplug: free pages as higher order
e5d8e894 hfsplus: return file attributes on statx
728804fa include/uapi/linux/msdos_fs.h: use MSDOS_NAME for volume label size
e93a0c0d include/linux/memory_hotplug.h: remove duplicate declaration of  
offline_pages()
3d991a59 ptrace: take into account saved_sigmask in PTRACE_{GET,SET}SIGMASK
a7b16608 mm/mmu_notifier: contextual information for event triggering  
invalidation v2
302092c9  
mm-mmu_notifier-use-structure-for-invalidate_range_start-end-calls-v2-checkpatch-fixes
cdd7a0aa fork: fix some -Wmissing-prototypes warnings
137d92bd mm/mmu_notifier: use structure for invalidate_range_start/end  
calls v2
b89cf731 exec: load_script: don't blindly truncate shebang string
42905641  
mm-mmu_notifier-use-structure-for-invalidate_range_start-end-callback-fix-fix
ad2539c7 exec: increase BINPRM_BUF_SIZE to 256
0db734c6 mm/mmu_notifier: use structure for invalidate_range_start/end  
callback
c09b6daf exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
37ba86cc hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined
dc98b124 exec-separate-mm_anonpages-and-rlimit_stack-accounting-fix
28286054  
exec-separate-mm_anonpages-and-rlimit_stack-accounting-checkpatch-fixes
b08acb20 mm-kmemleak-little-optimization-while-scanning-fix
27faeb70 bfs: extra sanity checking and static inode bitmap
79d0fd91 mm, kmemleak: little optimization while scanning
232619fc lib/ioremap: ensure break-before-make is used for huge p4d mappings
7a489f5d panic: add options to print system info when panic happens
784bedb5 kernel/sysctl: add panic_print into sysctl
e5dfd59e lib/ioremap: ensure phys_addr actually corresponds to a physical  
address
5f8d4992 kernel/kcov.c: mark write_comp_data() as notrace
7bdcb055 x86/pgtable: drop pXd_none() checks from pXd_free_pYd_table()
0aa19fc1 arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()
7ab8b68a scripts/gdb: fix lx-version string output
b2581b70 initramfs: cleanup incomplete rootfs
ee095458 ioremap: rework pXd_free_pYd_page() API
ce10bcf4 mm/page_alloc.c: calculate first_deferred_pfn directly
efae8091 ipc: allow boot time extension of IPCMNI from 32k to 8M
ab7db927  
ipc-allow-boot-time-extension-of-ipcmni-from-32k-to-8m-checkpatch-fixes
f163b82f mm/filemap.c: remove useless check in pagecache_get_page()
399e0a80 mm/page_io.c: fix polled swap page in
d04978ca ipc: conserve sequence numbers in extended IPCMNI mode
07365469 Merge branch 'akpm-current/current'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e1fc2b200000
start commit:   [unknown
git tree:       linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=5399ed0832693e29f392
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101032b3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16534063400000

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
